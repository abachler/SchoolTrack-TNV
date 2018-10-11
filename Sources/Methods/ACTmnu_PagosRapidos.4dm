//%attributes = {}
  // Método: ACTmnu_PagosRapidos
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-03-10, 10:51:15
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($RNApdo;$RNTercero)
$RNApdo:=-1
$RNTercero:=-1

  // Código principal
If (USR_GetMethodAcces (Current method name:C684))
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible ingresar pagos en este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intentelo de nuevo más tarde."))
		$tempACTisRunning:=<>bAccountTrackIsRunning
		If (<>lACT_PagosRapidos#0)
			<>bAccountTrackIsRunning:=False:C215
			POST OUTSIDE CALL:C329(<>lACT_PagosRapidos)
			DELAY PROCESS:C323(Current process:C322;15)
			<>bAccountTrackIsRunning:=$tempACTisRunning
		End if 
	Else 
		<>bAccountTrackIsRunning:=True:C214
		If (<>lACT_PagosRapidos=0)
			Case of 
				: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
					If (Size of array:C274(abrSelect)>0)
						  //If (cbDatosApdo=1)
						$RNApdo:=alBWR_RecordNumber{abrSelect{1}}
						  //End if 
					End if 
				: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
					If (Size of array:C274(abrSelect)>0)
						GOTO RECORD:C242([ACT_CuentasCorrientes:175];alBWR_RecordNumber{abrSelect{1}})
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
						If (Records in selection:C76([Personas:7])=1)
							$RNApdo:=Record number:C243([Personas:7])
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
								If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
									QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
									If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
										KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
										If (Records in selection:C76([Personas:7])=1)
											$RNApdo:=Record number:C243([Personas:7])
										End if 
									End if 
								Else 
									QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
									If (Records in selection:C76([Personas:7])=1)
										$RNApdo:=Record number:C243([Personas:7])
									End if 
								End if 
							End if 
						End if 
					End if 
				: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
					If (Size of array:C274(abrSelect)>0)
						GOTO RECORD:C242([ACT_Boletas:181];alBWR_RecordNumber{abrSelect{1}})
						QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Boletas:181]ID_Tercero:21)
						If (Records in selection:C76([ACT_Terceros:138])=1)
							$RNTercero:=Record number:C243([ACT_Terceros:138])
						Else 
							QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
							If (Records in selection:C76([Personas:7])=1)
								If (cbDatosApdo=1)
									$RNApdo:=Record number:C243([Personas:7])
								Else 
									QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
									KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
									SET AUTOMATIC RELATIONS:C310(True:C214)
									ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>)
									Case of 
										: (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
											KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
											If (Records in selection:C76([Personas:7])=1)
												$RNApdo:=Record number:C243([Personas:7])
											End if 
											
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
												KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
												If (Records in selection:C76([Personas:7])=1)
													$RNApdo:=Record number:C243([Personas:7])
												End if 
											End if 
											AT_Initialize (->at_nombreAlumnos;->al_idsCtas)
									End case 
									SET AUTOMATIC RELATIONS:C310(False:C215)
								End if 
							End if 
						End if 
					End if 
				: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
					If (Size of array:C274(abrSelect)>0)
						$RNTercero:=alBWR_RecordNumber{abrSelect{1}}
					End if 
			End case 
			C_TEXT:C284($vt_procNameVD)
			ACTpgs_OpcionesVR ("ObtieneNombreProceso";->$vt_procNameVD)
			  //<>lACT_PagosRapidos:=New process("ACTcc_RegistroPagosRapidos";64*1024;$vt_procNameVD;$RNApdo;$RNTercero;vpXS_IconModule;vsBWR_CurrentModule)
			<>lACT_PagosRapidos:=New process:C317("ACTcc_RegistroPagosRapidos";256*1024;$vt_procNameVD;$RNApdo;$RNTercero;vpXS_IconModule;vsBWR_CurrentModule)  //ASM 20141022 Se sube la memoria. Se caía la aplicación.
		Else 
			BRING TO FRONT:C326(<>lACT_PagosRapidos)
		End if 
	End if 
End if 

