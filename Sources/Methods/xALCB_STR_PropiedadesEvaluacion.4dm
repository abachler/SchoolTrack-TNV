//%attributes = {}
  //xALCB_STR_PropiedadesEvaluacion


C_BOOLEAN:C305($0;vb_menu2;vb_subasignanterior)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vRow;vCol)


If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	ARRAY TEXT:C222(aOldAsgName;0)
	COPY ARRAY:C226(atAS_EvalPropSourceName;aOldASGName)
	
	If (vb_menu2)
		
		If (choiceidx>0)
			atAS_EvalPropSourceName{0}:=vt_val_anterior
			atAS_EvalPropSourceName{vRow}:=at_opciones{choiceidx}
		Else 
			AL_GetCurrCell (xALP_CsdList2;vCol;vRow)
			vt_val_anterior:=atAS_EvalPropSourceName{vRow}
			atAS_EvalPropSourceName{vRow}:=vt_val_anterior
		End if 
		
	Else 
		AL_GetCurrCell (xALP_CsdList2;vCol;vRow)
	End if 
	
	If (vb_callBackEnabled)
		vb_callBackEnabled:=False:C215
		
		
		Case of 
			: (vCol=2)
				If ($2>=10)
					vs_oldName:=atAS_EvalPropSourceName{0}
					vL_oldId:=alAS_EvalPropSourceID{vrow}
					aOldASGName{vRow}:=vs_oldName
					If ((atAS_EvalPropSourceName{vRow}#"") & (vs_oldName#atAS_EvalPropSourceName{vRow}))
						  //$value:=atAS_EvalPropSourceName{vRow}+"@" En colombia en colegio buckingham crearon una subasignatura llamada Evaluación y no deja asignarla
						$value:=atAS_EvalPropSourceName{vRow}
						
						If ($value#"")
							ARRAY TEXT:C222(aText1;0)
							$el:=Find in array:C230(aCsdPop;$value)
							If ($el>0)
								INSERT IN ARRAY:C227(aText1;1)
								aText1{1}:=aCsdPop{$el}
								For ($i;$el+1;Size of array:C274(aCsdPop))
									If (aCsdPop{$i}=$value)
										INSERT IN ARRAY:C227(aText1;Size of array:C274(atext1)+1;1)
										aText1{Size of array:C274(atext1)}:=aCsdPop{$i}
									Else 
										$i:=Size of array:C274(aCsdPop)
									End if 
								End for 
							End if 
							Case of 
								: (Size of array:C274(aText1)=0)
									CD_Dlog (0;__ ("Subsector de aprendizaje inexistente."))
									atAS_EvalPropSourceName{vRow}:=""
									  //AL_UpdateArrays (xALP_CsdList2;-2)
								: (Size of array:C274(aText1)=1)
									atAS_EvalPropSourceName{vRow}:=aText1{1}
									  //AL_UpdateArrays (xALP_CsdList2;-2)
									POST KEY:C465(Character code:C91("*");256)
								: (Size of array:C274(aText1)>1)
									POST KEY:C465(Character code:C91("*");256)
							End case 
						End if 
					End if 
					
					If (vb_CsdVariable)  // Ticket 175179 
						$t_textoPeriodoParaLog:=" ("+atSTR_Periodos_Nombre{vlSTR_PeriodoSeleccionado}+")"
					Else 
						$t_textoPeriodoParaLog:=" (todos los períodos)"
					End if 
					
					  // Ticket 175179 
					$vt_textoLog:="Cambio en "+ST_Qte ("Origen de Evaluación")+", Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"] (fila "+String:C10(vRow)+")."
					$vt_textoLog:=$vt_textoLog+"Valor anterior: "+vs_oldName+", Nuevo Valor: "+atAS_EvalPropSourceName{vRow}+" "+$t_textoPeriodoParaLog+"."
					APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
					
				Else 
					If (alAS_EvalPropSourceID{vRow}<0)
						If (vb_CsdVariable)
							$refSubasignatura:=String:C10(Abs:C99(alAS_EvalPropSourceID{vRow}))+"."+String:C10(vlSTR_PeriodoSeleccionado)+"."+String:C10(vRow)
							KRL_FindAndLoadRecordByIndex (->[xxSTR_Subasignaturas:83]Referencia:11;->$refSubasignatura;True:C214)
							  // Ticket 175179 
							  // APPEND TO ARRAY(atSTR_EventLog;"Cambio de nombre de subasignatura en columna "+String(vCol)+": \""+[xxSTR_Subasignaturas]Name+"\"por \""+atAS_EvalPropSourceName{vRow}+"\" en "+atSTR_Periodos_Nombre{vlSTR_PeriodoSeleccionado})
							$vt_texto:=[xxSTR_Subasignaturas:83]Name:2
							[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{vRow}
							SAVE RECORD:C53([xxSTR_Subasignaturas:83])
							  // Ticket 175179 
							$vt_textoLog:="Cambio de nombre de subasignatura en la Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]."
							$vt_textoLog:=$vt_textoLog+"Valor anterior: "+$vt_texto+", Nuevo Valor: "+atAS_EvalPropSourceName{vRow}+"."
							APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
							UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							
						Else 
							For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
								$refSubasignatura:=String:C10(Abs:C99(alAS_EvalPropSourceID{vRow}))+"."+String:C10($i)+"."+String:C10(vRow)
								KRL_FindAndLoadRecordByIndex (->[xxSTR_Subasignaturas:83]Referencia:11;->$refSubasignatura;True:C214)
								  // Ticket 175179 
								  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de nombre de subasignatura en columna "+String(vCol)+": \""+[xxSTR_Subasignaturas]Name+"\"por \""+atAS_EvalPropSourceName{vRow}+"\" en "+atSTR_Periodos_Nombre{$i})
								$vt_texto:=[xxSTR_Subasignaturas:83]Name:2
								[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{vRow}
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
								  // Ticket 175179 
								$vt_textoLog:="Cambio de nombre de subasignatura en la Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]."
								$vt_textoLog:=$vt_textoLog+"Valor anterior: "+$vt_texto+", Nuevo Valor: "+atAS_EvalPropSourceName{vRow}+"."
								APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
								UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							End for 
						End if 
						  //AL_UpdateArrays (xALP_CsdList2;0)
						  //AS_PropEval_MenuAsignaturas 
						  //AL_UpdateArrays (xALP_CsdList2;-2)
						
						  // ////////cambio
						If (Not:C34(vb_menu2))
							AL_SetEnterable (xALP_CsdList2;2;2;aCsdPop)
						Else 
							AL_SetEnterable (xALP_CsdList2;2;0)
						End if 
						
						ARRAY LONGINT:C221($aLong2;0;0)
						For ($i;1;12)
							If (alAS_EvalPropSourceID{$i}<0)
								AL_SetCellEnter (xALP_CsdList2;2;$i;2;$i;$aLong2;1)
								  //Else 
								  //AL_SetCellEnter (xALP_CsdList2;2;$i;2;$i;$aLong2;0)
							End if 
						End for 
						  // ////////cambio
					End if 
				End if 
				
			: (vCol=3)  // Ticket 175179 
				
				If (adAS_EvalPropDueDate{0}#adAS_EvalPropDueDate{vRow})
					$vt_textoLog:="Cambio de "+ST_Qte ("Fecha Límite")+" para "+atAS_EvalPropSourceName{vRow}+" (fila "+String:C10(vRow)+") en la Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]."
					$vt_textoLog:=$vt_textoLog+"Valor anterior: "+String:C10(adAS_EvalPropDueDate{0})+", Nuevo Valor: "+String:C10(adAS_EvalPropDueDate{vRow})+"."
					APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
				End if 
				
			: (vCol=4)
				If (abAS_EvalPropPrintDetail{vRow})
					If (alAS_EvalPropSourceID{vRow}=0)
						atAS_EvalPropPrintName{vRow}:="Parcial "+String:C10(aiAS_EvalPropColumnIndex{vrow})
					Else 
						atAS_EvalPropPrintName{vRow}:=atAS_EvalPropSourceName{vrow}
					End if 
					  //End if 
				Else 
					atAS_EvalPropPrintName{vRow}:=""
				End if 
				
				  // Ticket 175179 
				If (abAS_EvalPropPrintDetail{0}#abAS_EvalPropPrintDetail{vRow})
					$vt_textoLog:="Cambio en "+ST_Qte ("Detallar en Informe")+" para "+atAS_EvalPropSourceName{vRow}+" (fila "+String:C10(vRow)+") en la Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]."
					$vt_textoLog:=$vt_textoLog+" Valor anterior: "+String:C10(abAS_EvalPropPrintDetail{0})+", Nuevo Valor: "+String:C10(abAS_EvalPropPrintDetail{vRow})+"."
					APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
				End if 
				
				POST KEY:C465(Character code:C91("'");256)
				
			: (vCol=5)
				If (atAS_EvalPropPrintName{vRow}="")
					abAS_EvalPropPrintDetail{vRow}:=False:C215
				Else 
					abAS_EvalPropPrintDetail{vRow}:=True:C214
				End if 
				AL_UpdateArrays (xALP_CsdList2;Size of array:C274(alAS_EvalPropSourceID))
				
				  // Ticket 175179 
				If (atAS_EvalPropPrintName{vRow}#atAS_EvalPropPrintName{0})
					$vt_textoLog:="Cambio en "+ST_Qte ("Nombre en informes")+" para "+atAS_EvalPropSourceName{vRow}+" (fila "+String:C10(vRow)+") en la Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]."
					$vt_textoLog:=$vt_textoLog+" Valor anterior: "+atAS_EvalPropPrintName{0}+", Nuevo Valor: "+String:C10(atAS_EvalPropPrintName{vRow})+"."
					APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
				End if 
				
			: (vCol=6)
				
				C_BOOLEAN:C305($vb_grabarLog)
				$vb_grabarLog:=False:C215
				
				Case of 
					: (vlAS_CalcMethod=0)
						$vb_grabarLog:=(arAS_EvalPropCoefficient{vRow}#arAS_EvalPropPonderacion{vRow})  //Ticket 175179
						arAS_EvalPropCoefficient{vRow}:=arAS_EvalPropPonderacion{vRow}
						  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de coeficiente de columna "+String(vCol)+": "+String(arAS_EvalPropPonderacion{vRow}))//Ticket 175179
						$vt_textoLog:="Cambio de coeficiente para "+atAS_EvalPropSourceName{vRow}+" (fila "+String:C10(vRow)+"), nuevo valor: "+String:C10(arAS_EvalPropPonderacion{vRow})+"%."
					: (vlAS_CalcMethod=1)
						$vb_grabarLog:=(arAS_EvalPropCoefficient{vRow}#arAS_EvalPropPonderacion{vRow})  //Ticket 175179
						arAS_EvalPropCoefficient{vRow}:=arAS_EvalPropPonderacion{vRow}
						  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de coeficiente de columna "+String(vCol)+": "+String(arAS_EvalPropPonderacion{vRow}))//Ticket 175179
						$vt_textoLog:="Cambio de coeficiente para "+atAS_EvalPropSourceName{vRow}+" (fila "+String:C10(vRow)+"), nuevo valor: "+String:C10(arAS_EvalPropPonderacion{vRow})+"%."
					: (vlAS_CalcMethod=2)
						$vb_grabarLog:=(arAS_EvalPropCoefficient{vRow}#arAS_EvalPropPonderacion{vRow})  //Ticket 175179
						arAS_EvalPropPercent{vRow}:=arAS_EvalPropPonderacion{vRow}
						  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de factor de ponderación de columna "+String(vCol)+": "+String(arAS_EvalPropPonderacion{vRow}))//Ticket 175179
						$vt_textoLog:="Cambio de factor de ponderación para "+atAS_EvalPropSourceName{vRow}+" (fila "+String:C10(vRow)+"), nuevo valor: "+String:C10(arAS_EvalPropPonderacion{vRow})+"%."
				End case 
				vbRecalcPromedios:=True:C214
				POST KEY:C465(Character code:C91("'");256)
				
				  // Ticket 175179 
				If ($vb_grabarLog)
					APPEND TO ARRAY:C911(atSTR_EventLog;$vt_textoLog)
				End if 
				
		End case 
		vb_callBackEnabled:=True:C214
	End if 
End if 

