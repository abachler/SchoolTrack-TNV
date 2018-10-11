  //[Asignaturas].Propiedades_Evaluación.Variable637

C_BOOLEAN:C305($b_CancelarTransaccion;$b_Continuar)
C_LONGINT:C283($i;$l_itemEncontrado;$l_recNumAsignatura;$l_respuestaUsuario;$l_SeleccionOrigenEvaluacion;$l_IdNuevaAsignacion)
C_TEXT:C284($t_llaveSubAsignatura;$t_NombreOrigenEvaluacion;$t_periodo;$t_textoPeriodoParaLog)
ARRAY LONGINT:C221($aLong2;0)




ARRAY POINTER:C280(<>aChoicePtrs;1)
$l_recNumAsignatura:=Record number:C243([Asignaturas:18])
$l_IDAsignaturaMadre:=[Asignaturas:18]Numero:1  //ASM 20140610 

If (Size of array:C274(aText1)>1)
	<>aChoicePtrs{1}:=->aText1
	choiceIdx:=1
	TBL_ShowChoiceList (0;"";1)
	If ((ok=1) & (choiceIdx>0))
		atAS_EvalPropSourceName{vRow}:=<>aChoicePtrs{1}->{choiceIdx}
	Else 
		atAS_EvalPropSourceName{vRow}:=""
	End if 
End if 

READ WRITE:C146([xxSTR_Subasignaturas:83])
If ((vs_oldName#__ ("Evaluación directa")) & (vs_oldName#__ ("No ingresable")))
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{vRow})
	If (Not:C34(KRL_IsRecordLocked (->[Asignaturas:18])))
		$b_Continuar:=True:C214
	Else 
		$b_Continuar:=False:C215
	End if 
Else 
	$b_Continuar:=True:C214
End if 

If (vb_CsdVariable)
	$t_textoPeriodoParaLog:=" ("+atSTR_Periodos_Nombre{vlSTR_PeriodoSeleccionado}+")"
Else 
	$t_textoPeriodoParaLog:=" (todos los períodos)"
End if 

If ($b_Continuar)
	$l_SeleccionOrigenEvaluacion:=Find in array:C230(aCsdPop;atAS_EvalPropSourceName{vRow})
	
	$l_respuestaUsuario:=1
	Case of 
		: ($l_SeleccionOrigenEvaluacion=1)  //evaluacion ingresable
			If (vL_oldId<0)
				If (r2=1)
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=vlSTR_PeriodoSeleccionado;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=vRow)
				Else 
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=vRow)
				End if 
				If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
					$l_respuestaUsuario:=CD_Dlog (0;__ ("¿Desea usted eliminar la subasignatura actualmente asignada o conservarla para asignarla posteriormente a otra columna?");__ ("");__ ("Conservar");__ ("Eliminar");__ ("Cancelar"))
					If ($l_respuestaUsuario=2)  //ELIMINAR
						KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])
					Else 
						If ($l_respuestaUsuario=1)  //CONSERVAR
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13:=0)
							UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							READ ONLY:C145([xxSTR_Subasignaturas:83])
						End if 
					End if 
				End if 
			End if 
			If ($l_respuestaUsuario<3)
				If (AScsd_VerificaAsignaciones (vL_OldID;-1;vRow))
					  //AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{vRow};vlSTR_PeriodoSeleccionado;vRow)
					AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{vRow};vlSTR_PeriodoSeleccionado;vRow;$l_IDAsignaturaMadre)  //ASM 20140610 Se eliminaban todas las consolidaciones, incluso las de otras asignaturas
					atAS_EvalPropClassName{vRow}:=""
					alAS_EvalPropSourceID{vRow}:=0  //was -1
					aiAS_EvalPropEnterable{vRow}:=1
					abAS_EvalPropPrintDetail{vRow}:=False:C215
					atAS_EvalPropPrintName{vRow}:=""
					
					  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de origen de la evaluación en columna "+String(vCol)+": Evaluación Ingresable"+$t_textoPeriodoParaLog)//Ticket 175179
				Else 
					atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
				End if 
			Else 
				atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
			End if 
		: ($l_SeleccionOrigenEvaluacion=3)  //no ingresable
			$l_respuestaUsuario:=1
			If (vL_oldId<0)
				If (r2=1)
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=vlSTR_PeriodoSeleccionado;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=vRow)
				Else 
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=vRow)
				End if 
				If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
					$l_respuestaUsuario:=CD_Dlog (0;__ ("¿Desea usted eliminar la subasignatura actualmente asignada o conservarla para asignarla posteriormente a otra columna?");__ ("");__ ("Conservar");__ ("Eliminar");__ ("Cancelar"))
					If ($l_respuestaUsuario=2)  //ELIMINAR
						KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])
					Else 
						If ($l_respuestaUsuario=1)  //CONSERVAR
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13:=0)
							UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							READ ONLY:C145([xxSTR_Subasignaturas:83])
						End if 
					End if 
				End if 
			End if 
			If ($l_respuestaUsuario<3)
				If (AScsd_VerificaAsignaciones (vL_OldID;-2;vRow))
					vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
					  //AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{vRow};vlSTR_PeriodoSeleccionado;vRow)
					AScsd_DesconectaHija_UNA (alAS_EvalPropSourceID{vRow};vlSTR_PeriodoSeleccionado;vRow;$l_IDAsignaturaMadre)  //ASM 20140610 Se eliminaban todas las consolidaciones, incluso las de otras asignaturas
					atAS_EvalPropClassName{vRow}:=""
					alAS_EvalPropSourceID{vRow}:=0  //was -2
					aiAS_EvalPropEnterable{vRow}:=0
					abAS_EvalPropPrintDetail{vRow}:=False:C215
					atAS_EvalPropPrintName{vRow}:=""
					  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de origen de la evaluación en columna "+String(vCol)+": Evaluación No Ingresable"+$t_textoPeriodoParaLog)//Ticket 175179
				Else 
					atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
				End if 
			Else 
				atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
			End if 
		: ($l_SeleccionOrigenEvaluacion=5)  //nueva sub asignatura      
			If (vL_oldId<0)
				If (r2=1)
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=vlSTR_PeriodoSeleccionado;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=vRow)
				Else 
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
					QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=vRow)
				End if 
				If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
					$l_respuestaUsuario:=CD_Dlog (0;__ ("¿Desea usted eliminar la subasignatura actualmente asignada o conservarla para asignarla posteriormente a otra columna?");__ ("");__ ("Conservar");__ ("Eliminar");__ ("Cancelar"))
					If ($l_respuestaUsuario=2)  //ELIMINAR
						KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])
					Else 
						If ($l_respuestaUsuario=1)  //CONSERVAR
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13:=0)
							UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							READ ONLY:C145([xxSTR_Subasignaturas:83])
						End if 
					End if 
				End if 
			End if 
			
			If ($l_respuestaUsuario<3)
				If (AScsd_VerificaAsignaciones (vL_OldID;-3;vRow))
					If ((vb_CsdVariable) & (vlSTR_PeriodoSeleccionado#viSTR_PeriodoActual_Numero))
						$l_respuestaUsuario:=CD_Dlog (0;__ ("Está creando una sub-asignatura para un período que no es el actual. ¿Desea proseguir?");__ ("");__ ("No");__ ("Si"))
					Else 
						$l_respuestaUsuario:=2
					End if 
					If ($l_respuestaUsuario=2)
						If (alAS_EvalPropSourceID{vRow}>=0)
							vs_SubAsig:=""
						Else 
							vs_SubAsig:=atAS_EvalPropSourceName{vRow}
						End if 
						WDW_OpenFormWindow (->[Asignaturas:18];"SubAsignatura";-1;Movable form dialog box:K39:8;__ ("Nueva sub-asignatura"))
						DIALOG:C40([Asignaturas:18];"SubAsignatura")
						CLOSE WINDOW:C154
						If (OK=1)
							atAS_EvalPropSourceName{vRow}:=[xxSTR_Subasignaturas:83]Name:2
							atAS_EvalPropClassName{vRow}:=[Asignaturas:18]Curso:5
							alAS_EvalPropSourceID{vRow}:=[xxSTR_Subasignaturas:83]LongID:7
							aiAS_EvalPropEnterable{vRow}:=0
							abAS_EvalPropPrintDetail{vRow}:=False:C215
							atAS_EvalPropPrintName{vRow}:=""
							vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
							  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de origen de la evaluación en columna "+String(vCol)+": Subasignatura, "+[xxSTR_Subasignaturas]Name+$t_textoPeriodoParaLog)//Ticket 175179
							vt_val_anterior:=atAS_EvalPropSourceName{vRow}
							vb_subasignanterior:=True:C214
						Else 
							atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
						End if 
					Else 
						atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
					End if 
				Else 
					atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
				End if 
			Else 
				atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
			End if 
			
		Else 
			$t_NombreOrigenEvaluacion:=atAS_EvalPropSourceName{vRow}
			atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
			If (Find in array:C230(atAS_EvalPropSourceName;$t_NombreOrigenEvaluacion)>0)
				BEEP:C151
				AL_UpdateArrays (xALP_CsdList2;Size of array:C274(alAS_EvalPropSourceID))
				AL_SetEnterable (xALP_CsdList2;2;2;aCsdPop)
			Else 
				atAS_EvalPropSourceName{vRow}:=$t_NombreOrigenEvaluacion
				$l_itemEncontrado:=Find in array:C230(<>aSAsgName;atAS_EvalPropSourceName{vRow})
				If (<>aSAsgID{$l_itemEncontrado}<0)
					$l_IdNuevaAsignacion:=-3
				Else 
					$l_IdNuevaAsignacion:=<>aSAsgID{$l_itemEncontrado}
				End if 
				
				If (AScsd_VerificaAsignaciones (vL_OldID;$l_IdNuevaAsignacion;vRow))
					Case of 
						: (vL_OldID>0)
							READ WRITE:C146([Asignaturas:18])
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=vL_OldID)
							QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=lConsID)
							KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
							AScsd_LeeReferencias (vL_OldID)
							If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
								[Asignaturas:18]Consolidacion_Madre_Id:7:=0
								[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
							End if 
							SAVE RECORD:C53([Asignaturas:18])
							UNLOAD RECORD:C212([Asignaturas:18])
							READ ONLY:C145([Asignaturas:18])
						: (vL_OldID<0)
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							$t_llaveSubAsignatura:=String:C10(lConsID)+"."+String:C10(vlSTR_PeriodoSeleccionado)+"."+String:C10(vRow)
							QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_llaveSubAsignatura)
							[xxSTR_Subasignaturas:83]Columna:13:=0
							SAVE RECORD:C53([xxSTR_Subasignaturas:83])
							UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							READ ONLY:C145([xxSTR_Subasignaturas:83])
					End case 
					aiAS_EvalPropEnterable{vRow}:=0
					If ($l_itemEncontrado>0)
						vb_CsdVariable:=(r2=1)
						$t_periodo:=String:C10(vlSTR_PeriodoSeleccionado)
						$b_CancelarTransaccion:=AScsd_AsignaAsignaturaHija (lConsID;sConsName;<>aSAsgID{$l_itemEncontrado};vRow;$t_periodo)
						If (Not:C34($b_CancelarTransaccion))
							vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
							atAS_EvalPropClassName{vRow}:=<>aSAsgClass{$l_itemEncontrado}
							If (<>aSAsgID{$l_itemEncontrado}<0)
								alAS_EvalPropSourceID{vRow}:=-lConsID
								  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de origen de la evaluación en columna "+String(vCol)+": Sub-asignatura, "+$t_NombreOrigenEvaluacion+$t_textoPeriodoParaLog)//Ticket 175179
							Else 
								alAS_EvalPropSourceID{vRow}:=<>aSAsgID{$l_itemEncontrado}
								  //APPEND TO ARRAY(atSTR_EventLog;"Cambio de origen de la evaluación en columna "+String(vCol)+": Asignatura, "+$t_NombreOrigenEvaluacion+$t_textoPeriodoParaLog)//Ticket 175179
							End if 
							aiAS_EvalPropEnterable{vRow}:=0
							abAS_EvalPropPrintDetail{vRow}:=False:C215
							atAS_EvalPropPrintName{vRow}:=""
							POST KEY:C465(Character code:C91("'");256)
							AL_UpdateArrays (xALP_CsdList2;Size of array:C274(alAS_EvalPropSourceID))
							AL_SetEnterable (xALP_CsdList2;2;2;aCsdPop)
							
						Else 
							atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
						End if 
					Else 
						
					End if 
				Else 
					atAS_EvalPropSourceName{vRow}:=atAS_EvalPropSourceName{0}
				End if 
			End if 
	End case 
	
	vbRecalcPromedios:=True:C214
End if 

AL_RemoveArrays (xALP_CsdList2;1;8)
  //GOTO RECORD([Asignaturas];$l_recNumAsignatura)
  //AS_PropEval_MenuAsignaturas 
GOTO RECORD:C242([Asignaturas:18];$l_recNumAsignatura)
xALSet_AS_PropiedadesEvaluacion 
Case of 
	: (vlAS_CalcMethod=0)
		w0iguales:=1
		w1coeficiente:=0
		w2porcentaje:=0
		AL_SetColOpts (xALP_CsdList2;0;0;0;3)
		AL_SetWidths (xALP_CsdList2;5;1;225)
		OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
	: (vlAS_CalcMethod=1)
		w0iguales:=0
		w1coeficiente:=1
		w2porcentaje:=0
		AL_SetColOpts (xALP_CsdList2;0;0;0;2)
		AL_SetWidths (xALP_CsdList2;5;2;145;80)
		AL_SetFormat (xALP_CsdList2;6;"##0";0;0;0;0)
		AL_SetHeaders (xALP_CsdList2;6;1;__ ("Coeficientes"))
		OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
	: (vlAS_CalcMethod=2)
		w0iguales:=0
		w2porcentaje:=1
		w1coeficiente:=0
		AL_SetColOpts (xALP_CsdList2;0;0;0;2)
		AL_SetWidths (xALP_CsdList2;5;2;145;80)
		AL_SetFormat (xALP_CsdList2;6;"##0,00%";0;0;0;0)
		AL_SetHeaders (xALP_CsdList2;6;1;__ ("Ponderaciones"))
		OBJECT SET VISIBLE:C603(*;"ponderacion@";True:C214)
End case 
AL_UpdateArrays (xALP_CsdList2;-2)

For ($i;1;12)
	If (alAS_EvalPropSourceID{$i}<0)
		AL_SetCellEnter (xALP_CsdList2;2;$i;2;$i;$aLong2;1)
	Else 
		AL_SetCellEnter (xALP_CsdList2;2;$i;2;$i;$aLong2;-1)
	End if 
End for 
