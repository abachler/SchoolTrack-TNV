C_POINTER:C301($srcObject)
C_LONGINT:C283($srcElement;$srcProcess;$row;$column)

Case of 
	: (Form event:C388=On Drop:K2:12)
		
		If (MPAcfg_Area_EsValida )
			DRAG AND DROP PROPERTIES:C607($srcObject;$srcElement;$srcProcess)
			LISTBOX GET CELL POSITION:C971($srcObject->;$column;$row;$columnVar)
			If ($srcObject->=lb_asignaturas)
				$el:=Find in array:C230(atMPA_AsignaturasArea;$columnVar->{$srcElement})
				If ($el=-1)
					$l_transaccionOK:=MPAcfg_Area_AsignaAsignatura ($columnVar->{$srcElement};[MPA_DefinicionAreas:186]AreaAsignatura:4)
					If ($l_transaccionOK=1)
						$insertAt:=Drop position:C608
						If ($insertAt<=0)
							$insertAt:=Size of array:C274(atMPA_AsignaturasArea)+1
						End if 
						AT_Insert ($insertAt;1;->atMPA_AsignaturasArea)
						atMPA_AsignaturasArea{$insertAT}:=$columnVar->{$srcElement}
						MPAcfg_Area_AlGuardar 
						SAVE RECORD:C53([MPA_DefinicionAreas:186])
						
						
						If (cb_AutoActualizaMatricesMPA=1)
							$l_recNumArea:=Record number:C243([MPA_DefinicionAreas:186])
							QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=[MPA_DefinicionAreas:186]ID:1)
							ARRAY LONGINT:C221($aRecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								GOTO RECORD:C242([MPA_DefinicionEjes:185];$aRecNums{$i})
								MPAcfg_ActualizaMatrices ($l_recNumArea;Eje_Aprendizaje;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5;$aRecNums{$i})
							End for 
							QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=[MPA_DefinicionAreas:186]ID:1)
							ARRAY LONGINT:C221($aRecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$aRecNums{$i})
								MPAcfg_ActualizaMatrices ($l_recNumArea;Dimension_Aprendizaje;[MPA_DefinicionDimensiones:188]DesdeGrado:6;[MPA_DefinicionDimensiones:188]HastaGrado:7;$aRecNums{$i})
							End for 
							QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=[MPA_DefinicionAreas:186]ID:1)
							ARRAY LONGINT:C221($aRecNums;0)
							LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$aRecNums;"")
							For ($i;1;Size of array:C274($aRecNums))
								GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$aRecNums{$i})
								MPAcfg_ActualizaMatrices ($l_recNumArea;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;$aRecNums{$i})
							End for 
						End if 
						
						
						  // leo las asignaturas actualmente asignadas al área
						  // el arreglo es desplegado en el listbox lb_asisgnaturasArea
						ARRAY BOOLEAN:C223(lb_asignaturasArea;0)
						ARRAY TEXT:C222(atMPA_AsignaturasArea;0)
						If ([MPA_DefinicionAreas:186]AreaAsignatura:4#"")
							QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4;=;[MPA_DefinicionAreas:186]AreaAsignatura:4)
							SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;atMPA_AsignaturasArea)
							LISTBOX SORT COLUMNS:C916(lb_asignaturasArea;1;>)
						End if 
					End if 
				End if 
			End if 
		End if 
End case 