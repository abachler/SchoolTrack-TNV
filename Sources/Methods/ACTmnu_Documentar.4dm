//%attributes = {}
  //ACTmnu_Documentar

If (USR_GetMethodAcces (Current method name:C684))
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible ingresar pagos en este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intentelo de nuevo más tarde."))
		$tempACTisRunning:=<>bAccountTrackIsRunning
		If (<>lACT_Documentar#0)
			<>bAccountTrackIsRunning:=False:C215
			POST OUTSIDE CALL:C329(<>lACT_Documentar)
			DELAY PROCESS:C323(Current process:C322;15)
			<>bAccountTrackIsRunning:=$tempACTisRunning
		End if 
	Else 
		READ ONLY:C145([ACT_Boletas:181])
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_Terceros:138])
		  //20120724 RCH Soporta ingreso a ventana de pagos desde pagares
		READ ONLY:C145([ACT_Pagares:184])
		
		xBlob:=PREF_fGetBlob (0;"SelIngPagos";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
		BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas;->cb_noPagosConFechasAnteriores)  //179864 
		If (cb_PermitePorCta=0)
			cbDatosApdo:=1  //Solo por precaucion
		End if 
		$RNApdo:=-1
		$RNCta:=-1
		$RNTercero:=-1
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				If (Size of array:C274(abrSelect)>0)
					If (cbDatosApdo=1)
						$RNApdo:=alBWR_RecordNumber{abrSelect{1}}
					Else 
						KRL_GotoRecord (->[Personas:7];alBWR_RecordNumber{abrSelect{1}})
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
						SET AUTOMATIC RELATIONS:C310(True:C214)
						ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>)
						Case of 
							: (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
								$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
							: (Records in selection:C76([ACT_CuentasCorrientes:175])>1)
								ARRAY LONGINT:C221(al_idsCtas;0)
								ARRAY TEXT:C222(at_nombreAlumnos;0)
								ARRAY TEXT:C222($at_cursoAlumnos;0)
								SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;al_idsCtas;[Alumnos:2]apellidos_y_nombres:40;at_nombreAlumnos;[Alumnos:2]curso:20;$at_cursoAlumnos)
								For ($i;1;Size of array:C274($at_cursoAlumnos))
									at_nombreAlumnos{$i}:=at_nombreAlumnos{$i}+" - "+$at_cursoAlumnos{$i}
								End for 
								ARRAY POINTER:C280(<>aChoicePtrs;0)
								ARRAY POINTER:C280(<>aChoicePtrs;2)
								C_POINTER:C301($ptr)
								<>aChoicePtrs{1}:=->at_nombreAlumnos
								<>aChoicePtrs{2}:=->al_idsCtas
								TBL_ShowChoiceList (1;"Seleccione el alumno para el ingreso de pago";0)
								If (choiceIdx>0)
									QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=al_idsCtas{choiceIdx})
									$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
								End if 
								AT_Initialize (->at_nombreAlumnos;->al_idsCtas)
						End case 
						SET AUTOMATIC RELATIONS:C310(False:C215)
					End if 
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				If (Size of array:C274(abrSelect)>0)
					If (cbDatosApdo=1)
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_RecordNumber{abrSelect{1}})
						QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
						QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1)
						If (Records in selection:C76([ACT_Apoderados_de_Cuenta:107])>0)
							CREATE SET:C116([Personas:7];"ApdoCta")
							CREATE EMPTY SET:C140([Personas:7];"Ex")
							FIRST RECORD:C50([ACT_Apoderados_de_Cuenta:107])
							While (Not:C34(End selection:C36([ACT_Apoderados_de_Cuenta:107])))
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1)
								If (Records in selection:C76([Personas:7])=1)
									ADD TO SET:C119([Personas:7];"Ex")
								End if 
								NEXT RECORD:C51([ACT_Apoderados_de_Cuenta:107])
							End while 
							ARRAY TEXT:C222(aNombresApdoCta;0)
							ARRAY REAL:C219(aAdeudadoApdoCta;0)
							ARRAY BOOLEAN:C223(aEsApdoCta;0)
							ARRAY LONGINT:C221(aRNApdo;0)
							USE SET:C118("ApdoCta")
							For ($i;1;Records in set:C195("ApdoCta"))
								AT_Insert (1;1;->aNombresApdoCta;->aAdeudadoApdoCta;->aEsApdoCta;->aRNApdo)
								aNombresApdoCta{1}:=[Personas:7]Apellidos_y_nombres:30
								aEsApdoCta{1}:=True:C214
								aRNApdo{1}:=Record number:C243([Personas:7])
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
								KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
								KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
								$saldo:=Sum:C1([ACT_Cargos:173]Saldo:23)
								QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
								$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
								aAdeudadoApdoCta{1}:=$saldo+$pagosconSaldo
							End for 
							USE SET:C118("Ex")
							FIRST RECORD:C50([Personas:7])
							For ($i;1;Records in set:C195("Ex"))
								AT_Insert (1;1;->aNombresApdoCta;->aAdeudadoApdoCta;->aEsApdoCta;->aRNApdo)
								aNombresApdoCta{1}:=[Personas:7]Apellidos_y_nombres:30
								aEsApdoCta{1}:=False:C215
								aRNApdo{1}:=Record number:C243([Personas:7])
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
								KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
								KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
								$saldo:=Sum:C1([ACT_Cargos:173]Saldo:23)
								QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
								$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
								aAdeudadoApdoCta{1}:=($saldo+$pagosconSaldo)*-1
								NEXT RECORD:C51([Personas:7])
							End for 
							SET_ClearSets ("ApdoCta";"Ex")
							SORT ARRAY:C229(aRNApdo;aNombresApdoCta;aAdeudadoApdoCta;aEsApdoCta;>)
							WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTpgs_SelectApdo";0;4;__ ("Selección de Apoderado");"WDW_CloseDlog")
							DIALOG:C40([xxSTR_Constants:1];"ACTpgs_SelectApdo")
							CLOSE WINDOW:C154
							If (OK=1)
								$RNApdo:=RNApdo
							End if 
							AT_Initialize (->aNombresApdoCta;->aAdeudadoApdoCta;->aEsApdoCta;->aRNApdo)
						Else 
							If (Records in selection:C76([Personas:7])=1)
								$RNApdo:=Record number:C243([Personas:7])
							End if 
						End if 
					Else 
						$RNCta:=alBWR_RecordNumber{abrSelect{1}}
					End if 
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				If (Size of array:C274(abrSelect)>0)
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];alBWR_RecordNumber{abrSelect{1}})
					QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
					If (Records in selection:C76([ACT_Terceros:138])=1)
						$RNTercero:=Record number:C243([ACT_Terceros:138])
					Else 
						If (cbDatosApdo=1)
							QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
							If (Records in selection:C76([Personas:7])=1)
								$RNApdo:=Record number:C243([Personas:7])
							End if 
						Else 
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
							If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
								$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
							End if 
						End if 
					End if 
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				If (Size of array:C274(abrSelect)>0)
					GOTO RECORD:C242([ACT_Boletas:181];alBWR_RecordNumber{abrSelect{1}})
					SET QUERY LIMIT:C395(1)
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
					SET QUERY LIMIT:C395(0)
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Transacciones:178]ID_Apoderado:11)
					If (Records in selection:C76([Personas:7])=1)
						If (cbDatosApdo=1)
							$RNApdo:=alBWR_RecordNumber{abrSelect{1}}
						Else 
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
							KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
							SET AUTOMATIC RELATIONS:C310(True:C214)
							ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>)
							Case of 
								: (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
									$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
								: (Records in selection:C76([ACT_CuentasCorrientes:175])>1)
									ARRAY LONGINT:C221(al_idsCtas;0)
									ARRAY TEXT:C222(at_nombreAlumnos;0)
									ARRAY TEXT:C222($at_cursoAlumnos;0)
									SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;al_idsCtas;[Alumnos:2]apellidos_y_nombres:40;at_nombreAlumnos;[Alumnos:2]curso:20;$at_cursoAlumnos)
									For ($i;1;Size of array:C274($at_cursoAlumnos))
										at_nombreAlumnos{$i}:=at_nombreAlumnos{$i}+" - "+$at_cursoAlumnos{$i}
									End for 
									ARRAY POINTER:C280(<>aChoicePtrs;0)
									ARRAY POINTER:C280(<>aChoicePtrs;2)
									C_POINTER:C301($ptr)
									<>aChoicePtrs{1}:=->at_nombreAlumnos
									<>aChoicePtrs{2}:=->al_idsCtas
									TBL_ShowChoiceList (1;"Seleccione el alumno para el ingreso de pago";0)
									If (choiceIdx>0)
										QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=al_idsCtas{choiceIdx})
										$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
									End if 
									AT_Initialize (->at_nombreAlumnos;->al_idsCtas)
							End case 
							SET AUTOMATIC RELATIONS:C310(False:C215)
						End if 
					End if 
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
				If (Size of array:C274(abrSelect)>0)
					$RNTercero:=alBWR_RecordNumber{abrSelect{1}}
				End if 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagares:184]))
				  //20120724 RCH Soporta ingreso a ventana de pagos desde pagares
				If (Size of array:C274(abrSelect)>0)
					GOTO RECORD:C242([ACT_Pagares:184];alBWR_RecordNumber{abrSelect{1}})
					QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Pagares:184]ID_Tercero:22)
					If (Records in selection:C76([ACT_Terceros:138])=1)
						$RNTercero:=Record number:C243([ACT_Terceros:138])
					Else 
						If (cbDatosApdo=1)
							QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagares:184]ID_Apdo:17)
							If (Records in selection:C76([Personas:7])=1)
								$RNApdo:=Record number:C243([Personas:7])
							End if 
						Else 
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Pagares:184]ID_Cta:18)
							If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
								$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
							End if 
						End if 
					End if 
				End if 
				
		End case 
		<>bAccountTrackIsRunning:=True:C214
		If (<>lACT_Documentar=0)
			
			  //  Modificado por: Saúl Ponce (01-07-2017)- Ticket 179864, validación sobre la fecha de ingreso para interrumpir la documentación de deuda.
			C_TEXT:C284($vt_fechaValida)
			C_BOOLEAN:C305($b_continuar)  //20170802 RCH
			C_DATE:C307($vd_fechaIngreso)
			
			$vd_fechaIngreso:=Current date:C33(*)
			If (cb_noPagosConFechasAnteriores=1)
				$vt_fechaValida:=ACTpgs_validaFechaPago ("DocumentarDeudas";$vd_fechaIngreso)
				If ($vt_fechaValida="ok")
					$b_continuar:=True:C214
				Else 
					CD_Dlog (0;__ ($vt_fechaValida))
				End if 
			Else 
				$b_continuar:=True:C214
			End if 
			
			If ($b_continuar)
				<>lACT_Documentar:=New process:C317("ACTcc_Documentar";Pila_256K;"Documentar Deudas";$RNApdo;$RNCta;$RNTercero;vpXS_IconModule;vsBWR_CurrentModule)
			End if 
			
			
			  //el nombre del proceso ("Documentar Deudas") es utilizado en ACTcfg_LeeConfEnNuevoProc
			  //<>lACT_Documentar:=New process("ACTcc_Documentar";128*1024;"Documentar Deudas";$RNApdo;$RNCta;$RNTercero;vpXS_IconModule;vsBWR_CurrentModule)
			
			  //  Modificado por: Saúl Ponce (01-07-2017)- Ticket 179864, para interrumpir la documentación de deuda.
			  //<>lACT_Documentar:=New process("ACTcc_Documentar";Pila_256K;"Documentar Deudas";$RNApdo;$RNCta;$RNTercero;vpXS_IconModule;vsBWR_CurrentModule)  //ASM 20141007
			
			
		Else 
			BRING TO FRONT:C326(<>lACT_Documentar)
		End if 
	End if 
End if 