C_BOOLEAN:C305(vb_menu2;vb_subasignanterior)
  // Ticket Nº 175179
$b_editPropEva:=(((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ((<>lUSR_RelatedTableUserID=vlSTR_IDProfesor) & (<>viSTR_AutorizarPropEval=1))) & (cb_bloqueoPropDeEval=0))

If ($b_editPropEva)
	Case of 
		: ((alProEvt=1) | (alProEvt=2))
			
			C_LONGINT:C283(vCol;vRow;$i;$row_SubAsig)
			$row_SubAsig:=0
			vCol:=AL_GetColumn (xALP_CsdList2)
			vRow:=AL_GetLine (xALP_CsdList2)
			
			If (vcol=2)
				vb_menu2:=True:C214
				
				ARRAY TEXT:C222(at_opciones;0)
				
				For ($i;1;Size of array:C274(aCsdPop))
					Case of 
						: (aCsdPop{$i}="(subasignaturas")
							APPEND TO ARRAY:C911(at_opciones;"- SubAsignaturas")
							$row_SubAsig:=Size of array:C274(at_opciones)
						: (aCsdPop{$i}#"-")
							APPEND TO ARRAY:C911(at_opciones;aCsdPop{$i})
					End case 
				End for 
				
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				
				<>aChoicePtrs{1}:=->at_opciones
				
				TBL_ShowChoiceList (0;"Seleccione";2)
				
				If (choiceidx>0)
					If (choiceidx=$row_SubAsig)
						choiceidx:=choiceidx+1
					End if 
					C_TEXT:C284(vt_val_anterior)
					vb_callBackEnabled:=True:C214
					vt_val_anterior:=atAS_EvalPropSourceName{vrow}
					xALCB_STR_PropiedadesEvaluacion (xALP_CsdList2;10)
					
				End if 
			Else 
				vb_menu2:=False:C215
			End if 
			
	End case 
	
End if 