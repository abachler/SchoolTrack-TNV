
If (vlMPA_recNumArea>=0)
	Case of 
		: ((alProEvt=AL Row drag event) | (alProEvt=AL Cell drag event))
			AL_GetDrgSrcRow (Self:C308->;$sourceRow)
			AL_GetDrgArea (Self:C308->;$areaDst)
			Case of 
				: ($areaDst=xALP_Competencias)
					CD_Dlog (0;__ ("Las dimensiones de aprendizajes son un contenedor para Competencias. No se puede asignar una Dimension a una competencia."))
					MPAcfg_ContenidoAreas 
					
				: ($areaDst=xALP_AreasMPA)
					CD_Dlog (0;__ ("Las dimensiones de aprendizajes no pueden ser desplazadas o copiadas individualmente (dependen siempre de un Eje de Aprendizaje)."))
					MPAcfg_ContenidoAreas 
					
				: ($areaDst=xALP_Ejes)
					AL_GetDrgDstRow (xALP_Ejes;$rowEjes)
					GOTO RECORD:C242([MPA_DefinicionEjes:185];alEVLG_Ejes_RecNums{$rowEjes})
					$nuevoIDEje:=[MPA_DefinicionEjes:185]ID:1
					$newEje:=[MPA_DefinicionEjes:185]Nombre:3
					$l_recNumDimension:=alEVLG_Dimensiones_RecNums{$sourceRow}
					KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension)
					$idDimension:=[MPA_DefinicionDimensiones:188]ID:1
					
					  // creo el conjunto de las matrices que podrían necesitar recalculo si el desplazamiento de la dimensión se completa
					QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_DefinicionDimensiones:188]ID_Eje:3;*)
					QUERY:C277([MPA_ObjetosMatriz:204]; | ;[MPA_ObjetosMatriz:204]ID_Eje:3=$nuevoIDEje)
					KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1)
					CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
					
					$b_aplicacionCompatible:=True:C214
					For ($i;1;24)
						If (([MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $i) & (Not:C34([MPA_DefinicionEjes:185]BitsNiveles:20 ?? $i)))
							$b_aplicacionCompatible:=False:C215
							$i:=24
						End if 
					End for 
					
					If (Not:C34($b_aplicacionCompatible))
						CD_Dlog (0;__ ("La dimensión está configurada para aplicar en niveles no habilitados en el eje de destino.\r\rNo es posible asociar la Dimensión al Eje seleccionado."))
					Else 
						KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNumDimension;True:C214)
						[MPA_DefinicionDimensiones:188]ID_Eje:3:=$nuevoIDEje
						If (Not:C34(MPAcfg_Dim_EsUnica ))
							CD_Dlog (0;__ ("Ya existe un dimensión con el mismo nombre en el eje de destino.\r\rNo es posible transferir la dimensión."))
						Else 
							If (ok=1)
								If (OK=1)
									START TRANSACTION:C239
									QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$idDimension)
									ARRAY LONGINT:C221($aIDsEjes;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
									ARRAY LONGINT:C221($aIDsDimensiones;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
									AT_Populate (->$aIDsEjes;->$nuevoIDEje)
									OK:=KRL_Array2Selection (->$aIDsEjes;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
									
									If (OK=1)
										QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$idDimension)
										ARRAY LONGINT:C221($aIDsEjes;Records in selection:C76([MPA_ObjetosMatriz:204]))
										AT_Populate (->$aIDsEjes;->$nuevoIDEje)
										OK:=KRL_Array2Selection (->$aIDsEjes;->[MPA_ObjetosMatriz:204]ID_Eje:3)
									End if 
									
									If (OK=1)
										QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$idDimension)
										ARRAY LONGINT:C221($aIdEjes;Records in selection:C76([MPA_DefinicionCompetencias:187]))
										AT_Populate (->$aIdEjes;->$nuevoIDEje)
										OK:=KRL_Array2Selection (->$aIdEjes;->[MPA_DefinicionCompetencias:187]ID_Eje:2)
									End if 
									
									If (OK=1)
										LOG_RegisterEvt ("Dimensión de aprendizaje \""+[MPA_DefinicionCompetencias:187]Competencia:6+"\" asignada al Eje de aprendizaje \""+$newEje+"\"")
										[MPA_DefinicionDimensiones:188]ID_Eje:3:=$nuevoIDEje
										SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
										VALIDATE TRANSACTION:C240
										
										  //Agrego al conjunto de matrices a recalcular las matrices que pueden requerir recalculo 
										  // producto del cambio de eje de la dimensión
										UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
										
										
										KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
										If (cb_AutoActualizaMatricesMPA=1)
											MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;Record number:C243([MPA_DefinicionCompetencias:187]))
										End if 
										MPAcfg_ContenidoAreas (-1;alEVLG_Marcos_RecNums{$rowEjes};Record number:C243([MPA_DefinicionDimensiones:188]))
									Else 
										CANCEL TRANSACTION:C241
									End if 
									UNLOAD RECORD:C212([MPA_DefinicionDimensiones:188])
								End if 
							End if 
						End if 
					End if 
					If ($rowEjes>0)
						AL_SetScroll (xALP_Ejes;$rowEjes;1)
					End if 
					
					
				: ($areaDst=Self:C308->)
					AL_GetDrgSrcCol (Self:C308->;$sourceCol)
					AL_GetDrgSrcRow (Self:C308->;$sourceRow)
					AL_GetDrgArea (Self:C308->;$areaDst)
					AL_GetDrgDstRow (Self:C308->;$DestRow)
					If ($areaDst=Self:C308->)
						$recNum:=alEVLG_Dimensiones_RecNums{$sourceRow}
						COPY ARRAY:C226(alEVLG_Dimensiones_RecNums;$aValidRecNums)
						DELETE FROM ARRAY:C228($aValidRecNums;$sourceRow)
						If ($DestRow>Size of array:C274($aValidRecNums))
							APPEND TO ARRAY:C911($aValidRecNums;$recNum)
							$destRow:=Size of array:C274($aValidRecNums)
						Else 
							INSERT IN ARRAY:C227($aValidRecNums;$DestRow)
							$aValidRecNums{$DestRow}:=$recNum
						End if 
						For ($i;1;Size of array:C274($aValidRecNums))
							READ WRITE:C146([MPA_DefinicionDimensiones:188])
							GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$aValidRecNums{$i})
							[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20:=$i
							SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
							
							Case of 
								: ([MPA_DefinicionDimensiones:188]DesdeGrado:6=999)
									atEVLG_Dimensiones_Etapas{$i}:="Por nivel"
									
								: ([MPA_DefinicionDimensiones:188]DesdeGrado:6>-100)
									atEVLG_Dimensiones_Etapas{$i}:=String:C10([MPA_DefinicionDimensiones:188]DesdeGrado:6)+" - "+String:C10([MPA_DefinicionDimensiones:188]HastaGrado:7)
									
								Else 
									atEVLG_Dimensiones_Etapas{$i}:="Todos"
							End case 
							  //atEVLG_Dimensiones_Etapas{$i}:=String([MPA_DefinicionDimensiones]DesdeGrado)+" - "+String([MPA_DefinicionDimensiones]HastaGrado)
							atEVLG_Dimensiones_Nombres{$i}:=[MPA_DefinicionDimensiones:188]Dimensión:4
							alEVLG_Dimensiones_RecNums{$i}:=Record number:C243([MPA_DefinicionDimensiones:188])
						End for 
						UNLOAD RECORD:C212([MPA_DefinicionDimensiones:188])
						READ ONLY:C145([MPA_DefinicionDimensiones:188])
						AL_SetLine (Self:C308->;$DestRow)
					End if 
			End case 
			
		: (alProEvt=AL Empty Area Double click)
			$l_recNumDimension:=MPAcfg_Dim_Agregar 
			
			
		: (alProEvt=AL Double click event)
			$l_filaDimension:=AL_GetLine (xALP_Dimensiones)
			MPAcfg_Dim_Propiedades (alEVLG_Dimensiones_RecNums{$l_filaDimension})
			MPAcfg_ContenidoAreas (-1;vlMPA_recNumEje;alEVLG_Dimensiones_RecNums{$l_filaDimension})
			
		: ((alProEvt=AL Empty Area Control Click) | (alProEvt=AL Single Control Click))
			$line:=AL_GetClickedRow (Self:C308->)
			$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
			$l_filaEjes:=AL_GetLine (xALP_Ejes)
			$l_filaArea:=AL_GetLine (xALP_AreasMPA)
			MPAcfg_ContenidoAreas 
			Case of 
				: (($l_filaEjes>0) & (($line=0) | ($line>Size of array:C274(alEVLG_Dimensiones_RecNums))))
					$popUpContent:=__ ("(Asignar Color...;(-;Nueva Dimensión en Eje \"^2\";(Eliminar Dimensión...;(-;(Agregar Competencia en...;(-;Ejes, Dimensiones y Competencias del área \"^1\";Dimensiones y Competencias del Eje \"^2\";(Competencias en...")
					$popUpContent:=Replace string:C233($popUpContent;"^1";Replace string:C233(ST_ClearExtraCR (atEVLG_Marcos_Nombres{$l_filaArea});"/";"|"))
					$popUpContent:=Replace string:C233($popUpContent;"^2";Replace string:C233(ST_ClearExtraCR (atEVLG_Ejes_Nombres{$l_filaEjes});"/";"|"))
				: (($line=0) | ($line>Size of array:C274(alEVLG_Dimensiones_RecNums)))
					If ($l_filaEjes>0)
						$popUpContent:=__ ("(Asignar Color...;(-;Nueva Dimensión en Eje \"^2\"...;(Eliminar Dimensión...;(-;(Añadir Competencia en...;(-;Ejes, Dimensiones y Competencias del área \"^1\";(Dimensiones y Competencias del Eje")
					Else 
						$popUpContent:=__ ("(Asignar Color...;(-;(Nueva Dimensión en Eje...;(Eliminar Dimensión...;(-;(Añadir Competencia en...;(-;Ejes, Dimensiones y Competencias del área \"^1\";(Dimensiones y Competencias del Eje")
					End if 
					$popUpContent:=Replace string:C233($popUpContent;"^1";Replace string:C233(ST_ClearExtraCR (atEVLG_Marcos_Nombres{$l_filaArea});"/";"|"))
				: ($line>0)
					$popUpContent:=__ ("Asignar Color...;(-;Nueva Dimensión en Eje \"^2\"...;Eliminar Dimensión \"^3\";(-;Añadir Competencia en \"^3\";(-;Ejes, Dimensiones y Competencias del área \"^1\";Dimensiones y Competencias del Eje \"^2\";Competencias en \"^3\"")
					If ($l_filaEjes=0)
						KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$line})
						$l_filaEjes:=Find in array:C230(alEVLG_Ejes_Ids;[MPA_DefinicionDimensiones:188]ID_Eje:3)
						If ($l_filaEjes>0)
							AL_SetLine (xALP_Ejes;$l_filaEjes)
						End if 
					End if 
					$popUpContent:=Replace string:C233($popUpContent;"^1";Replace string:C233(ST_ClearExtraCR (atEVLG_Marcos_Nombres{$l_filaArea});"/";"|"))
					$popUpContent:=Replace string:C233($popUpContent;"^2";Replace string:C233(ST_ClearExtraCR (atEVLG_Ejes_Nombres{$l_filaEjes});"/";"|"))
					$popUpContent:=Replace string:C233($popUpContent;"^3";Replace string:C233(ST_ClearExtraCR (atEVLG_Dimensiones_Nombres{$line});"/";"|"))
			End case 
			
			$result:=Pop up menu:C542($popupContent;0)
			
			Case of 
				: ($result=1)  //asignar color
					WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_ColorGrid";-1;1)
					DIALOG:C40([xShell_Dialogs:114];"XS_ColorGrid")
					CLOSE WINDOW:C154
					If (OK=1)
						READ WRITE:C146([MPA_DefinicionDimensiones:188])
						GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$line})
						[MPA_DefinicionDimensiones:188]ColorTexto:9:=bColorTexto
						[MPA_DefinicionDimensiones:188]ColorFondo:10:=bColorFondo
						SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
						AL_SetRowColor (Self:C308->;$line;"";bColorTexto;"";bColorFondo)
					End if 
					MPAcfg_ContenidoAreas 
					
					
				: ($result=3)  //agregar Dimension
					$l_recNumDimension:=MPAcfg_Dim_Agregar 
					
					
				: ($result=4)  //Eliminar Dimensión
					$l_dimensionEliminada:=MPAcfg_Dim_Eliminar (alEVLG_Dimensiones_RecNums{$l_filaDimensiones})
					If ($l_dimensionEliminada=1)
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1;-1)
					End if 
					
					
				: ($result=6)
					$l_recNumDimension:=alEVLG_Dimensiones_RecNums{$l_filaDimensiones}
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;$l_recNumDimension;-1)
					$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Dimension_Aprendizaje)
					
				: ($result=8)  //Ejes, Dimensiones y aprendizajes del Área
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;-1;-1;-1)
					
				: ($result=9)  //Dimensiones y aprendizajes del Eje
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1;-1)
					
				: ($result=10)
					$l_recNumDimension:=alEVLG_Dimensiones_RecNums{$l_filaDimensiones}
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;$l_recNumDimension;-1)
					
			End case 
			
		: (alProEvt=AL Single click event)
			MPAcfg_ContenidoAreas 
			
			
	End case 
End if 
