Case of 
	: (Form event:C388=On Drop:K2:12)
		If ((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))) & ((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID ))))
			
			DRAG AND DROP PROPERTIES:C607($srcObject;$element;$process)
			GET LIST ITEM:C378(hl_observaciones;$element;$itemRef;$observación)
			If ($itemRef<0)
				CD_Dlog (0;__ ("Por favor seleccione una observación de la categoría.\rNo es posible asignar todas las observaciones de una categoría."))
			Else 
				$parentListItem:=List item parent:C633(hl_observaciones;$itemRef)
				If ($parentListItem#0)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_observaciones;$parentListItem)
					GET LIST ITEM:C378(hl_observaciones;Selected list items:C379(hl_observaciones);$refCategoria;$categoría)
				Else 
					$categoria:=""
				End if 
				
				
				If (Find in array:C230(alSTR_ObsEval_RefObs;$itemRef)<0)
					AT_Insert (0;1;->atSTR_ObsEval_Categoria;->atSTR_ObsEval_Observacion;->alSTR_ObsEval_RefObs)
					atSTR_ObsEval_Categoria{Size of array:C274(atSTR_ObsEval_Categoria)}:=$categoría
					atSTR_ObsEval_Observacion{Size of array:C274(atSTR_ObsEval_Observacion)}:=$observación
					alSTR_ObsEval_RefObs{Size of array:C274(alSTR_ObsEval_RefObs)}:=$itemRef
					CREATE RECORD:C68([Alumnos_ObservacionesEvaluacion:30])
					[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2:=vlSTR_CurrentAsignaturaID
					[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1:=vlSTR_CurrentAlumnoID
					[Alumnos_ObservacionesEvaluacion:30]Periodo:3:=vlSTR_PeriodoObservaciones
					[Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10:=$itemRef
					[Alumnos_ObservacionesEvaluacion:30]RegistradaPor:8:=<>tUSR_CurrentUser
					[Alumnos_ObservacionesEvaluacion:30]Categoría:4:=$categoría
					[Alumnos_ObservacionesEvaluacion:30]Observacion:5:=$observación
					SAVE RECORD:C53([Alumnos_ObservacionesEvaluacion:30])
					AT_MultiLevelSort (">>";->atSTR_ObsEval_Categoria;->atSTR_ObsEval_Observacion;->alSTR_ObsEval_RefObs)
					HL_ClearList (hl_ObservacionesAlumno;$sublist)
					hl_ObservacionesAlumno:=New list:C375
					$newRefCategoria:=-1
					For ($I;1;Size of array:C274(alSTR_ObsEval_RefObs))
						$found:=HL_FindElement (hl_ObservacionesAlumno;atSTR_ObsEval_Categoria{$i})
						If ($found=-1)
							$subList:=New list:C375
							APPEND TO LIST:C376($subList;atSTR_ObsEval_Observacion{$i};alSTR_ObsEval_RefObs{$i})
							SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;alSTR_ObsEval_RefObs{$i};False:C215;0;0)
							APPEND TO LIST:C376(hl_ObservacionesAlumno;atSTR_ObsEval_Categoria{$i};$newRefCategoria;$sublist;True:C214)
							SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;$newRefCategoria;False:C215;1;0)
							$newRefCategoria:=$newRefCategoria-1
						Else 
							GET LIST ITEM:C378(hl_ObservacionesAlumno;$found;$RefCategoria;$categoria;$sublist)
							APPEND TO LIST:C376($subList;atSTR_ObsEval_Observacion{$i};alSTR_ObsEval_RefObs{$i})
							SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;alSTR_ObsEval_RefObs{$i};False:C215;0;0)
							SET LIST ITEM:C385(hl_ObservacionesAlumno;$RefCategoria;$categoria;$RefCategoria;$sublist;True:C214)
							SET LIST ITEM PROPERTIES:C386(hl_ObservacionesAlumno;$RefCategoria;False:C215;1;0)
						End if 
					End for 
					_O_REDRAW LIST:C382(hl_Observaciones)
					SELECT LIST ITEMS BY REFERENCE:C630(hl_Observaciones;$itemRef)
					_O_REDRAW LIST:C382(hl_ObservacionesAlumno)
					SET LIST PROPERTIES:C387(hl_ObservacionesAlumno;2;0;16;1)
					modobservaciones:=True:C214
				End if 
			End if 
		Else 
			BEEP:C151
		End if 
End case 
