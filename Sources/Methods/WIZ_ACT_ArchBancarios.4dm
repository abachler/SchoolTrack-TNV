//%attributes = {}
  //WIZ_ACT_ArchBancarios

If (USR_GetMethodAcces (Current method name:C684))
	C_BOOLEAN:C305(vb_utilizarRecSelected)
	C_DATE:C307(vdACT_Fecha1;vdACT_Fecha2)
	C_TEXT:C284($fileName)
	
	C_TEXT:C284(vFechaPAT;vFechaPAC;vFechaCUP)
	C_TEXT:C284(vnumTransPAT;vtotalPAT;vnumTransPAC;vtotalPAC;vnumTransCUP;vtotalCUP)
	ARRAY TEXT:C222($at_dummy;0)
	ARRAY LONGINT:C221($al_dummy;0)
	C_BOOLEAN:C305($b_subir)
	
	vb_utilizarRecSelected:=False:C215
	If (Count parameters:C259=1)
		vb_utilizarRecSelected:=True:C214
	End if 
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_AsistenteArchBancos";-1;4;__ ("Asistentes"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_AsistenteArchBancos")
	CLOSE WINDOW:C154
	
	If (ok=1)
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		
		$vt_modoPago:=atACT_formas_de_pago{Find in array:C230(alACT_FormasdePagoID;vlACT_id_modo_pago)}
		
		If (vb_utilizarRecSelected)
			$found:=BWR_SearchRecords 
			If ($found=-1)
				REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
			End if 
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisosExploradorSel")
		End if 
		
		If (vlACT_Exportador#0)
			If (vb_utilizarRecSelected)
				If (vl_ExportXCuentas=1)
					KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32=vlACT_id_modo_pago)
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
				Else 
					KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
					  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago="Cargo a Tarjeta de Crédito")
					QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=vlACT_id_modo_pago)
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1;"")
				End if 
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisosApdo")
				INTERSECTION:C121("setAvisosExploradorSel";"setAvisosApdo";"setAvisosExploradorSel")
				USE SET:C118("setAvisosExploradorSel")
				SET_ClearSets ("setAvisosExploradorSel";"setAvisosApdo")
			Else 
				If (vl_ExportXCuentas=1)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32=vlACT_id_modo_pago)
					Case of 
						: (btn_Internacional=1)
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_tarjeta_internacional:43=True:C214)
						: (btn_Nacional=1)
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]PAT_tarjeta_internacional:43=False:C215)
					End case 
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10)
				Else 
					  //QUERY([Personas];[Personas]ACT_Modo_de_pago="Cargo a Tarjeta de Crédito")
					QUERY:C277([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=vlACT_id_modo_pago)
					Case of 
						: (btn_Internacional=1)
							QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_TCEsInternacional:86=True:C214)
						: (btn_Nacional=1)
							QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_TCEsInternacional:86=False:C215)
					End case 
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1)
				End if 
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0)
			End if 
			If (cbMontoAPagar=1)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
			Else 
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_Neto:11>0)
			End if 
			Case of 
				: (b1=1)
					$year:=Year of:C25(Current date:C33(*))
					$month:=Month of:C24(Current date:C33(*))
					$day:=Day of:C23(Current date:C33(*))
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4=Current date:C33(*))
					$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
					vdACT_Fecha1:=Current date:C33(*)
					vdACT_Fecha2:=Current date:C33(*)
				: (b2=1)
					$year:=viAño
					$dateIni:=DT_GetDateFromDayMonthYear (1;vi_SelectedMonth;$year)
					$lastDay:=DT_GetLastDay (vi_SelectedMonth;$year)
					$dateEnd:=DT_GetDateFromDayMonthYear ($lastDay;vi_SelectedMonth;$year)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=$dateIni;*)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=$dateEnd)
					$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
					vdACT_Fecha1:=$dateIni
					vdACT_Fecha2:=$dateEnd
				: (b3=1)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=vd_Fecha1;*)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=vd_Fecha2)
					$vt_Fecha1:=Replace string:C233(Replace string:C233(vt_Fecha1;"-";"");"/";"")
					$vt_Fecha2:=Replace string:C233(Replace string:C233(vt_Fecha2;"-";"");"/";"")
					$fileName:=$vt_Fecha1+"al"+$vt_Fecha2
					vdACT_Fecha1:=vd_Fecha1
					vdACT_Fecha2:=vd_Fecha2
				: (b4=1)
					$year:=viAño2
					$dateIni:=DT_GetDateFromDayMonthYear (1;1;$year)
					$dateEnd:=DT_GetDateFromDayMonthYear (31;12;$year)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=$dateIni;*)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=$dateEnd)
					$fileName:=String:C10($year)
					vdACT_Fecha1:=$dateIni
					vdACT_Fecha2:=$dateEnd
			End case 
			
			  //20121210 RCH Se cambia nombre de archivo de validacion
			$file:=$vt_modoPago
			If (vlACT_id_modo_pago=-9)
				Case of 
					: (btn_Internacional=1)
						$file:=$file+"_Int"
					: (btn_Nacional=1)
						$file:=$file+"_Nac"
				End case 
			End if 
			$fileName:=$file+$fileName
			$file:=$fileName
			
			  // MOD Ticket N° 196415 20180203 Patricio Aliaga
			QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=vlACT_Exportador)
			$fileName:=ACTabc_NombreArchivoBancario ($fileName)
			  //If (SYS_IsWindows )
			  //$fileName:=$fileName+".txt"
			  //End if 
			
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"SetAvisos")
				  //20140527 ASM para verificar si se ingreso el IPC , ticket 132120  
				  // ASM 20151027 Modifico la validación.
				C_BOOLEAN:C305($b_seguir)
				C_LONGINT:C283($r)
				$b_seguir:=True:C214
				
				KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28="UF";*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
				
				If (Records in selection:C76([ACT_Cargos:173])>0)
					xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10(Year of:C25(vd_FechaUF)))
					BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
					$dia:=Day of:C23(vd_FechaUF)
					
					If ($dia>=9)
						$mes:=Month of:C24(vd_FechaUF)-1
					Else 
						$mes:=Month of:C24(vd_FechaUF)-2
					End if 
					
					If ($mes<=0)
						$mes:=12-Abs:C99($mes)
						$agno:=Year of:C25(vd_FechaUF)-1
						xBlob:=PREF_fGetBlob (0;"ACT_IPC "+String:C10($agno))
						BLOB_Blob2Vars (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
						$IPC:=arACT_VariacionIPC{$mes}
					Else 
						$IPC:=arACT_VariacionIPC{$mes}
					End if 
					
					If ($IPC=0)
						$r:=CD_Dlog (0;__ ("El porcentaje del IPC para el mes se encuentra en cero.\r¿Desea continuar?");"";__ ("Si");__ ("No"))
						$b_seguir:=($r=1)
					Else 
						$b_seguir:=True:C214
					End if 
				End if 
				
				If ($b_seguir)
					Case of 
						: ((vlACT_id_modo_pago=-10) & (cb_GenerarXDiaCargo=1))
							C_TEXT:C284($vnumTrans;$vtotal)
							ARRAY LONGINT:C221(al_DiasDePago;0)
							If (vl_ExportXCuentas=0)
								KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
								CREATE SET:C116([Personas:7];"TodosPersonas")
								DISTINCT VALUES:C339([Personas:7]ACT_DiaCargo:61;al_DiasDePago)
							Else 
								KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
								KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2)
								CREATE SET:C116([ACT_CuentasCorrientes:175];"TodosPersonas")
								DISTINCT VALUES:C339([ACT_CuentasCorrientes:175]dia_de_cargo:33;al_DiasDePago)
							End if 
							For ($i;1;Size of array:C274(al_DiasDePago))
								USE SET:C118("TodosPersonas")
								If (vl_ExportXCuentas=0)
									QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_DiaCargo:61=al_DiasDePago{$i})
									KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]No:1)
								Else 
									QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]dia_de_cargo:33=al_DiasDePago{$i})
									KRL_RelateSelection (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
									KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10)
								End if 
								CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosXDiaCargo")
								INTERSECTION:C121("SetAvisos";"AvisosXDiaCargo";"AvisosXDiaCargo")
								USE SET:C118("AvisosXDiaCargo")
								$fileNameXdia:=ST_RigthChars ("00"+String:C10(al_DiasDePago{$i});2)+"_"+$fileName
								If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
									$OK:=ACTabc_ExportPorColegio ($fileNameXdia;vlACT_Exportador)
									$vnumTrans:=String:C10(Num:C11($vnumTrans)+Num:C11(vnumTrans))
									$vtotal:=String:C10(Num:C11(Replace string:C233(Replace string:C233(vtotalPAC;".";"");",";""))+Num:C11(Replace string:C233(Replace string:C233($vtotal;".";"");",";""));"|Despliegue_ACT")
								End if 
							End for 
							vnumTransPAC:=$vnumTrans
							vtotalPAC:=$vtotal
							SET_ClearSets ("TodosPersonas";"AvisosXDiaCargo")
							
						Else 
							$OK:=ACTabc_ExportPorColegio ($fileName;vlACT_Exportador)
					End case 
				Else 
					$OK:=0
					CD_Dlog (0;__ ("Los valores del IPC se encuentran desactualizados.")+"\r"+__ ("Verifique los datos en Monedas y Tasas."))
				End if 
			Else 
				$OK:=0
				CD_Dlog (0;__ ("No hay avisos de cobranza emitidos para el rango de fechas especificado para apoderados con modo de pago "+$vt_modoPago+"."))
			End if 
		Else 
			If (vlACT_id_modo_pago#0)
				$OK:=0
				CD_Dlog (0;__ ("No se seleccionó ningún exportador de "+$vt_modoPago+"."))
			End if 
		End if 
		
		vMsg:=""
		
		If (cbArchivoValidacion=1)
			ARRAY LONGINT:C221(aidsPersonas;0)
			ARRAY TEXT:C222(at_FechasCargos;0)
			ARRAY TEXT:C222(at_PersonasNombre;0)
			ARRAY TEXT:C222(at_PersonasRut;0)
			ARRAY TEXT:C222(at_PersonasRutPAT_PAC;0)
			ARRAY TEXT:C222(at_PersonasNoTC_CTA;0)
			ARRAY TEXT:C222(at_bancoPersonas;0)
			ARRAY REAL:C219(aMonto;0)
			ARRAY TEXT:C222(at_nombreFamilia;0)
			C_TEXT:C284($folderPath;$fileName;$tipo;$title)
			C_REAL:C285($vr_monto)
			C_POINTER:C301($ptrFieldCargo)
			ARRAY LONGINT:C221($al_idsApdos;0)
			
			$vb_mostrarCaracteresTC:=False:C215
			If (cbMontoaPagar=1)
				$ptrFieldCargo:=->[ACT_Cargos:173]Saldo:23
			Else 
				$ptrFieldCargo:=->[ACT_Cargos:173]Monto_Neto:5
			End if 
			
			  //For ($j;1;3)
			If ($OK=1)
				$tipo:=$vt_modoPago
				$fileName:="V_"+$file
				$title:=""
				USE SET:C118("SetAvisos")
				
				Case of 
					: (vlACT_id_modo_pago=-9)
						$title:="Fecha Vencimiento Aviso"+"\t"+"Familia"+"\t"+"Nombre Apoderado"+"\t"+"Rut Apoderado"+"\t"+"Rut PAT"+"\t"+"No Tarjeta Crédito"+"\t"+"Banco"+"\t"+"Monto Cargado"+"\r\n"
					: (vlACT_id_modo_pago=-10)
						$title:="Fecha Vencimiento Aviso"+"\t"+"Familia"+"\t"+"Nombre Apoderado"+"\t"+"Rut Apoderado"+"\t"+"Rut PAC"+"\t"+"No Cuenta Corriente"+"\t"+"Banco"+"\t"+"Monto Cargado"+"\r\n"
					Else 
						$title:="Familia"+"\t"+"Nombre Apoderado"+"\t"+"Rut Apoderado"+"\t"+"Monto Cargado"+"\r\n"
				End case 
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando datos para archivo de validación Interno ")+$tipo+__ ("..."))
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Avisos")
				AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->$al_idsApdos)
				While (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					USE SET:C118("Avisos")
					If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
						FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
						
						$Apdo:=Find in field:C653([Personas:7]No:1;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
						
						QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
						ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;<)
						CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosARetirar")  //para quitar del set principal
						
						If ($Apdo#-1)
							GOTO RECORD:C242([Personas:7];$Apdo)
						Else 
							REDUCE SELECTION:C351([Personas:7];0)
						End if 
						$linea:=Find in array:C230(aidsPersonas;[Personas:7]No:1)
						
						$vr_monto:=0
						READ ONLY:C145([ACT_Transacciones:178])
						READ ONLY:C145([ACT_Cargos:173])
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						$set:="setCargos"
						CREATE SET:C116([ACT_Cargos:173];$set)
						ACTac_OpcionesGenerales ("FiltraAvisosGenArchivoBancario";->$set)
						
						If (vl_otrasMonedas=1)
							$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$set;$ptrFieldCargo;vd_fechaUF))
						Else 
							$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$set;$ptrFieldCargo;vd_fechaUF))
						End if 
						CLEAR SET:C117($set)
						
						
						If ($linea=-1)
							AT_Insert (1;1;->aidsPersonas;->at_FechasCargos;->at_PersonasNombre;->at_PersonasRut;->at_PersonasNoTC_CTA;->at_bancoPersonas;->aMonto;->at_nombreFamilia;->at_PersonasRutPAT_PAC)
							aidsPersonas{1}:=[Personas:7]No:1
							$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
							If (vlACT_id_modo_pago=-10)  //para cuando hayan días de pago 00
								Case of 
									: (<>tXS_RS_DateFormat="D@")
										at_FechasCargos{1}:=$diaFecha+<>tXS_RS_DateSeparator+String:C10(vl_MesApdo;"00")+<>tXS_RS_DateSeparator+String:C10(vl_AñoApdo;"0000")
									: (<>tXS_RS_DateFormat="M@")
										at_FechasCargos{1}:=String:C10(vl_MesApdo;"00")+<>tXS_RS_DateSeparator+$diaFecha+<>tXS_RS_DateSeparator+String:C10(vl_AñoApdo;"0000")
									: (<>tXS_RS_DateFormat="Y@")
										at_FechasCargos{1}:=String:C10(vl_AñoApdo;"0000")+<>tXS_RS_DateSeparator+String:C10(vl_MesApdo;"00")+<>tXS_RS_DateSeparator+$diaFecha
								End case 
							Else 
								at_FechasCargos{1}:=String:C10([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;7)
							End if 
							at_PersonasNombre{1}:=[Personas:7]Apellidos_y_nombres:30
							at_PersonasRut{1}:=ST_Uppercase ([Personas:7]RUT:6)
							at_PersonasRutPAT_PAC{1}:=ST_Boolean2Str ((vlACT_id_modo_pago=-9);[Personas:7]ACT_RUTTitular_TC:56;ST_Boolean2Str ((vlACT_id_modo_pago=-10);[Personas:7]ACT_RUTTitutal_Cta:50;""))
							at_PersonasNoTC_CTA{1}:=ST_Boolean2Str ((vlACT_id_modo_pago=-9);ACTpp_CRYPTTC ("TCFromReport";->[Personas:7]ACT_Numero_TC:54;->$vb_mostrarCaracteresTC);ST_Boolean2Str ((vlACT_id_modo_pago=-10);[Personas:7]ACT_Numero_Cta:51;""))
							at_bancoPersonas{1}:=ST_Boolean2Str ((vlACT_id_modo_pago=-9);[Personas:7]ACT_Banco_TC:53;ST_Boolean2Str ((vlACT_id_modo_pago=-10);[Personas:7]ACT_Banco_Cta:47;""))
							aMonto{1}:=$vr_monto
							KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]No:1;"")
							KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
							ARRAY TEXT:C222($at_nombreFamilia;0)
							SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;$at_nombreFamilia)
							at_nombreFamilia{1}:=AT_array2text (->$at_nombreFamilia;" - ")
						Else 
							aMonto{$linea}:=aMonto{$linea}+$vr_monto
						End if 
						DIFFERENCE:C122("Avisos";"AvisosARetirar";"Avisos")
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Size of array:C274(aidsPersonas)/Size of array:C274($al_idsApdos);__ ("Recopilando información para archivo ")+$tipo+__ ("..."))
					USE SET:C118("Avisos")
				End while 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				SET_ClearSets ("Avisos";"AvisosARetirar")
				
				
				$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Archivos de Validación";$fileName)
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo de validación Interno ")+$tipo+__ ("..."))
				IO_SendPacket ($ref;$title)
				For ($i;1;Size of array:C274(aidsPersonas))
					$line:=ST_Boolean2Str (((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10));at_FechasCargos{$i}+"\t";"")
					$line:=$line+at_nombreFamilia{$i}+"\t"+at_PersonasNombre{$i}+"\t"+SR_FormatoRUT2 (at_PersonasRut{$i})+"\t"
					$line:=$line+ST_Boolean2Str (((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10));at_PersonasRutPAT_PAC{$i}+"\t";"")
					$line:=$line+ST_Boolean2Str (((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10));at_PersonasNoTC_CTA{$i}+"\t";"")
					$line:=$line+ST_Boolean2Str (((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10));at_bancoPersonas{$i}+"\t";"")
					$line:=$line+String:C10(aMonto{$i};"|Despliegue_ACT")+"\r\n"
					IO_SendPacket ($ref;$line)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsPersonas);__ ("Generando archivo de validación Interno ")+$tipo+__ ("..."))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				CLOSE DOCUMENT:C267($ref)
				AT_Initialize (->aidsPersonas;->at_FechasCargos;->at_PersonasNombre;->at_PersonasRut;->at_PersonasNoTC_CTA;->aMonto;->at_bancoPersonas;->at_nombreFamilia;->at_PersonasRutPAT_PAC)
				
			End if 
		End if 
		
		SET_ClearSets ("SetAvisos")
		
		C_TEXT:C284($vnumTrans;vnumTrans)
		C_TEXT:C284($vFecha;vtACT_Fecha)
		C_TEXT:C284($vtotal;vt_total)
		Case of 
			: (vlACT_id_modo_pago=-9)
				$vFecha:=vFechaPAT
				$vnumTrans:=vnumTransPAT
				$vtotal:=vtotalPAT
				
			: (vlACT_id_modo_pago=-10)
				$vFecha:=vFechaPAC
				$vnumTrans:=vnumTransPAC
				$vtotal:=vtotalPAC
				
			: (vlACT_id_modo_pago=-11)
				$vFecha:=vFechaCUP
				$vnumTrans:=vnumTransCUP
				$vtotal:=vtotalCUP
				
			Else 
				$vFecha:=vtACT_Fecha
				$vnumTrans:=vnumTrans
				$vtotal:=vt_total
		End case 
		
		$extraRTN:=True:C214
		If ($OK=1)
			vMsg:=__ ("Archivo ")+$vt_modoPago+__ (" generado con éxito:")+"\r\r"+__ ("Fecha: ")+"\t"+$vFecha+"\r"+__ ("Número de Transacciones: ")+"\t"+$vnumTrans+"\r"+__ ("Monto Total: ")+"\t"+$vtotal+"\r"+__ ("Nombre archivo: ")+"\t"+$fileName+("\r"*Num:C11($extraRTN))+("\r"*Num:C11($extraRTN))
			$b_subir:=True:C214
		Else 
			vMsg:=__ ("Archivo ")+$vt_modoPago+__ (" no generado.")+("\r"*Num:C11($extraRTN))+("\r"*Num:C11($extraRTN))
			$b_subir:=False:C215
		End if 
		
		If (cbArchivoValidacion=1)  //RCH
			If ($OK=1)
				vMsg:=vMsg+__ ("Archivo de Validación ")+$vt_modoPago+__ (" generado con éxito.")+"\r"
			End if 
		End if 
		
		If (vMsg#"")
			LOG_RegisterEvt (Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233(vMsg;"\t";" ");"\r\r";"\r");"\r";". ");"..";".")+"Proceso iniciado desde el"+ST_Boolean2Str (vb_utilizarRecSelected;" explorador.";" menú Asistentes.")+" Fecha moneda variable: "+String:C10(vd_FechaUF)+"."+ST_Boolean2Str ((vl_SeleccionItem=1);" Cargos exportados con la opción Seleccionar ítems a exportar activada.";""))
			  //20170214 RCH
			  //CD_Dlog (0;vMsg)
			ACTcd_DlogWithShowOnDisk (SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Archivos Bancarios";0;vMsg)
		End if 
		
		
		  // MOD Ticket N° 196415 20180203 Patricio Aliaga
		If ($b_subir)
			OB GET PROPERTY NAMES:C1232([xxACT_ArchivosBancarios:118]Configuracion:15;$at_dummy;$al_dummy)
			If (Size of array:C274($at_dummy)>0)
				C_OBJECT:C1216($ob_datos)
				$ob_datos:=OB Get:C1224([xxACT_ArchivosBancarios:118]Configuracion:15;"DatosFtp")
				If (OB Get:C1224($ob_datos;"activo")=1)
					C_LONGINT:C283($l_errorFTP)
					C_TEXT:C284($t_ruta;$t_msg)
					If (Num:C11(CD_Dlog (0;__ ("El modelo de exportación está configurado para enviar el archivo a un sitio FTP.\n\n¿Desea subir el archivo ahora?");"";__ ("Si");__ ("No")))=1)
						$t_ruta:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Archivos Bancarios"+Folder separator:K24:12+$vt_modoPago+Folder separator:K24:12+$fileName
						$l_errorFTP:=ACTabc_FtpArchivoBancario ($ob_datos;$t_ruta)
					End if 
				End if 
			End if 
		End if 
		
		
	End if 
End if 