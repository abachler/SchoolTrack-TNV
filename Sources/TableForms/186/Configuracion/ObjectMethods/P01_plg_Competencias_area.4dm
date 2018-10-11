C_LONGINT:C283($areaDst;$DestCol;$err;$i;$iColumnas;$iFilas;$iNiveles;$l_abajoCompetencias;$l_anchoAreaCompetencias)
C_LONGINT:C283($l_anchoColumna;$l_anchoTotal;$l_arribaCompetencias;$l_bitToSet;$l_columna;$l_competenciaEliminada;$l_derechaCompetencias;$l_estilo;$l_estiloActual;$l_fila)
C_LONGINT:C283($l_filaAreaDestino;$l_filaAreas;$l_filaDimensiones;$l_filaEjeDestino;$l_filaEjes;$l_filas;$l_izquierdaCompetencias;$l_numeroColumnas;$l_recNumAreaDestino;$l_recNumCompetencia)
C_LONGINT:C283($l_recNumDimensionDestino;$l_recNumEje;$lineArea;$result;$sourceCol;$sourceRow)
C_TEXT:C284($t_contenidoPopUp;$t_error;$t_ItemAñadir;$t_nombreDimension;$t_NombreEje;$t_nombreEtapa)
C_POINTER:C301($arrayPointer)

C_TEXT:C284(vt_Competencia)
C_LONGINT:C283(vl_aprendizajesEvaluados;vl_objetosEnMatrices)

ARRAY LONGINT:C221($al_dummy;0)
ARRAY LONGINT:C221($aValidRecNums;0)
ARRAY TEXT:C222($aHeaders;0)


$l_columna:=AL_GetColumn (xALP_Competencias)
atMPA_EtapasArea:=$l_columna

vt_Competencia:=""
vl_aprendizajesEvaluados:=0
vl_objetosEnMatrices:=0

If (vlMPA_recNumArea>=0)
	Case of 
		: (alProEvt=AL Column resize event)
			OBJECT GET COORDINATES:C663(xALP_Competencias;$l_izquierdaCompetencias;$l_arribaCompetencias;$l_derechaCompetencias;$l_abajoCompetencias)
			$l_anchoAreaCompetencias:=$l_derechaCompetencias-$l_izquierdaCompetencias
			$l_numeroColumnas:=Size of array:C274(atMPA_EtapasArea)
			$l_anchoTotal:=0
			For ($i;1;$l_numeroColumnas)
				AL_GetWidths (xALP_Competencias;$i;1;$l_anchoColumna)
				$l_anchoTotal:=$l_anchoTotal+$l_anchoColumna
			End for 
			
			If ($l_anchoTotal>$l_anchoAreaCompetencias)
				AL_SetScroll (xALP_Competencias;-2;-2)
			Else 
				AL_SetScroll (xALP_Competencias;-2;-3)
			End if 
			AL_UpdateArrays (xALP_Competencias;-2)
			
		: (alProEvt=AL Cell drag event)
			$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
			$l_filaEjes:=AL_GetLine (xALP_Ejes)
			$lineArea:=AL_GetLine (xALP_AreasMPA)
			
			AL_GetDrgSrcCol (xALP_Competencias;$sourceCol)
			AL_GetDrgSrcRow (xALP_Competencias;$sourceRow)
			AL_GetDrgArea (xALP_Competencias;$areaDst)
			
			Case of 
				: ($areaDst=xALP_AreasMPA)
					AL_GetDrgDstRow (xALP_AreasMPA;$l_filaAreaDestino)
					$l_recNumAreaDestino:=alEVLG_Marcos_RecNums{$l_filaAreaDestino}
					$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol}
					
					If (Macintosh option down:C545 | Windows Alt down:C563 | Windows Ctrl down:C562)
						$l_recNumCompetencia:=MPAcfg_CopiaObjetoEnArea (Logro_Aprendizaje;$l_recNumCompetencia;$l_recNumAreaDestino)
						If ($l_recNumCompetencia>=0)
							MPAcfg_ContenidoAreas ($l_recNumAreaDestino;-1;-1;$l_recNumCompetencia)
						Else 
							MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;vlMPA_recNumCompetencia)
						End if 
					Else 
						$l_recNumCompetencia:=MPAcfg_CambiaAreaObjeto (Logro_Aprendizaje;$l_recNumCompetencia;$l_recNumAreaDestino)
						If ($l_recNumCompetencia>=0)
							MPAcfg_ContenidoAreas ($l_recNumAreaDestino;-1;-1;$l_recNumCompetencia)
						Else 
							MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;vlMPA_recNumCompetencia)
						End if 
					End if 
					
					
				: ($areaDst=xALP_Dimensiones)
					AL_GetDrgDstRow (xALP_Dimensiones;$l_filaAreaDestino)
					$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol}
					$l_recNumDimensionDestino:=alEVLG_Dimensiones_RecNums{$l_filaAreaDestino}
					$t_error:=MPAcfg_Comp_CambiaDimension ($l_recNumCompetencia;$l_recNumDimensionDestino)
					If ($t_Error#"")
						CD_Dlog (0;$t_error)
					Else 
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;$l_recNumDimensionDestino;$l_recNumCompetencia)
					End if 
					AL_SetScroll (xALP_Dimensiones;$l_filaAreaDestino;1)
					
					
				: ($areaDst=xALP_Ejes)
					AL_GetDrgDstRow (xALP_Ejes;$l_filaEjeDestino)
					$l_recNumEje:=alEVLG_Ejes_RecNums{$l_filaEjeDestino}
					$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol}
					$t_error:=MPAcfg_Comp_CambiaEje ($l_recNumCompetencia;$l_recNumEje)
					If ($t_Error#"")
						CD_Dlog (0;$t_Error)
					Else 
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;$l_recNumEje;-1;$l_recNumCompetencia)
					End if 
					AL_SetScroll (xALP_Ejes;$l_filaAreaDestino;1)
					
				: ($areaDst=xALP_Competencias)
					$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
					$l_filaEjes:=AL_GetLine (xALP_Ejes)
					$lineArea:=AL_GetLine (xALP_AreasMPA)
					
					AL_GetDrgDstCol (xALP_Competencias;$DestCol)
					If ($DestCol#$sourceCol)  //cambio de etapa
						$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol}
						KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol})
						If (([MPA_DefinicionCompetencias:187]DesdeGrado:5>-100) & ([MPA_DefinicionCompetencias:187]HastaGrado:13>-100))
							If (Macintosh option down:C545 | Windows Ctrl down:C562)
								$l_recNumCompetencia:=MPAcfg_Comp_Copiar_a_etapa (alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol};alMPA_NivelDesde{$DestCol};alMPA_NivelHasta{$DestCol})
							Else 
								$l_recNumCompetencia:=MPAcfg_Comp_CambiaEtapa (alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol};alMPA_NivelDesde{$DestCol};alMPA_NivelHasta{$DestCol};atMPA_EtapasArea{$DestCol})
							End if 
						Else 
							CD_Dlog (0;__ ("Esta competencia ya está asignada a todas las etapas."))
						End if 
					Else 
						  // solo reordenamiento
						AL_GetDrgDstRow (xALP_competencias;$l_filaAreaDestino)
						$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$sourceRow}{$sourceCol}
						ARRAY LONGINT:C221($aValidRecNums;0)
						$l_filas:=Size of array:C274(atEVLG_Competencias_E1)
						For ($i;1;$l_filas)
							If (alEVLG_Competencias_RecNums{$i}{$sourceCol}>=0)
								APPEND TO ARRAY:C911($aValidRecNums;alEVLG_Competencias_RecNums{$i}{$sourceCol})
							End if 
						End for 
						DELETE FROM ARRAY:C228($aValidRecNums;$sourceRow)
						If ($l_filaAreaDestino>Size of array:C274($aValidRecNums))
							APPEND TO ARRAY:C911($aValidRecNums;$l_recNumCompetencia)
						Else 
							INSERT IN ARRAY:C227($aValidRecNums;$l_filaAreaDestino)
							$aValidRecNums{$l_filaAreaDestino}:=$l_recNumCompetencia
						End if 
						For ($i;1;Size of array:C274($aValidRecNums))
							$arrayPointer:=Get pointer:C304("atEVLG_Competencias_E"+String:C10($sourceCol))
							READ WRITE:C146([MPA_DefinicionCompetencias:187])
							GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$aValidRecNums{$i})
							[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25:=$i
							SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
							$arrayPointer->{$i}:=[MPA_DefinicionCompetencias:187]Competencia:6
							alEVLG_Competencias_RecNums{$i}{$sourceCol}:=Record number:C243([MPA_DefinicionCompetencias:187])
						End for 
						UNLOAD RECORD:C212([MPA_DefinicionCompetencias:187])
						READ ONLY:C145([MPA_DefinicionCompetencias:187])
					End if 
					
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;$l_recNumCompetencia)
					AL_SetScroll (xALP_Dimensiones;1;1)
					AL_SetScroll (xALP_Ejes;1;1)
			End case 
			
			
			
			
			
			
			
			
		: (alProevt=AL Empty Area Control Click)
			$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
			$l_filaEjes:=AL_GetLine (xALP_ejes)
			
			ARRAY TEXT:C222($aHeaders;0)
			$err:=AL_GetHeaders (xALP_Competencias;$aHeaders)
			$t_nombreEtapa:=";(  Etapa: "+ST_CleanMenuMetaCharacters ($aHeaders{$l_columna})
			
			If ($l_filaDimensiones>0)
				$t_nombreDimension:=atEVLG_Dimensiones_Nombres{$l_filaDimensiones}
				$t_nombreDimension:=";(  "+__ ("Dimensión:")+" )"+ST_CleanMenuMetaCharacters ($t_nombreDimension)
			Else 
				$t_nombreDimension:="(  "+__ ("Dimensión: [ninguna]")+")"
			End if 
			
			If ($l_filaEjes>0)
				$t_NombreEje:=atEVLG_Ejes_Nombres{$l_filaEjes}
				$t_nombreEje:=";(  "+__ ("Eje:")+")"+ST_CleanMenuMetaCharacters ($t_NombreEje)
			Else 
				$t_nombreEje:=";(  "+__ ("Eje: [ninguno]")+")"
			End if 
			$t_ItemAñadir:=__ ("Añadir Competencia en... ")+$t_nombreEtapa+$t_nombreEje+$t_nombreDimension
			
			$t_contenidoPopUp:=$t_ItemAñadir+";(-;("+__ ("Propiedades...")+";(-;("+__ ("Eliminar...")+";(-;("+__ ("Utilizar en todas las etapas")+")"
			$result:=Pop up menu:C542($t_contenidoPopUp;0)
			Case of 
				: ($result=1)
					$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
					$l_filaEjes:=AL_GetLine (xALP_ejes)
					$lineArea:=AL_GetLine (xALP_AreasMPA)
					
					
					Case of 
						: ($l_filaDimensiones>0)
							KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$l_filaDimensiones})
							If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionDimensiones:188]DesdeGrado:6) & ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5#0))
								CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
							Else 
								$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Dimension_Aprendizaje)
							End if 
							
						: ($l_filaEjes>0)
							GOTO RECORD:C242([MPA_DefinicionEjes:185];alEVLG_EJES_RecNums{$l_filaEjes})
							If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionEjes:185]DesdeGrado:4) & ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19#0))
								CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
							Else 
								$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Eje_Aprendizaje)
							End if 
							
						: ($lineArea>0)
							$l_recNumCompetencia:=MPAcfg_Comp_Agregar (0)
							
							
					End case 
			End case 
			
			
			
			
			
			
			
		: (alProevt=AL Empty Area Double click)
			$l_fila:=AL_GetLine (xALP_Competencias)
			$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
			$l_filaEjes:=AL_GetLine (xALP_ejes)
			$lineArea:=AL_GetLine (xALP_AreasMPA)
			Case of 
				: ($l_filaDimensiones>0)
					GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$l_filaDimensiones})
					If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionDimensiones:188]DesdeGrado:6) & ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5#0))
						CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
					Else 
						$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Dimension_Aprendizaje)
					End if 
					
				: ($l_filaEjes>0)
					GOTO RECORD:C242([MPA_DefinicionEjes:185];alEVLG_EJES_RecNums{$l_filaEjes})
					If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionEjes:185]DesdeGrado:4) & ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19#0))
						CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
					Else 
						$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Eje_Aprendizaje)
					End if 
				: ($lineArea>0)
					$l_recNumCompetencia:=MPAcfg_Comp_Agregar (0)
					
			End case 
			
			
		: (alProEvt=AL Double click event)
			$err:=AL_GetCellSel (xALP_Competencias;$l_columna;$l_fila)
			$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
			If ($l_recNumCompetencia>=0)
				MPAcfg_Comp_Propiedades ($l_recNumCompetencia)
				MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1;$l_recNumCompetencia)
			Else 
				$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
				$l_filaEjes:=AL_GetLine (xALP_ejes)
				$lineArea:=AL_GetLine (xALP_AreasMPA)
				Case of 
					: ($l_filaDimensiones>0)
						GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$l_filaDimensiones})
						If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionDimensiones:188]DesdeGrado:6) & ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5#0))
							CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
						Else 
							$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Dimension_Aprendizaje)
						End if 
						
					: ($l_filaEjes>0)
						GOTO RECORD:C242([MPA_DefinicionEjes:185];alEVLG_EJES_RecNums{$l_filaEjes})
						If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionEjes:185]DesdeGrado:4) & ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19#0))
							CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
						Else 
							$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Eje_Aprendizaje)
						End if 
					: ($lineArea>0)
						$l_recNumCompetencia:=MPAcfg_Comp_Agregar (0)
				End case 
			End if 
			
			
		: (alProEvt=AL Single Control Click)
			$l_filaDimensiones:=AL_GetLine (xALP_Dimensiones)
			$l_filaEjes:=AL_GetLine (xALP_ejes)
			$l_filaAreas:=AL_GetLine (xALP_AreasMPA)
			
			  // click derecho no selecciona la celda en ALP, selección por código
			$l_fila:=AL_GetLine (xALP_Competencias)
			$err:=AL_GetCellSel (xALP_Competencias;$l_columna;$l_fila)
			
			ARRAY TEXT:C222($aHeaders;0)
			$err:=AL_GetHeaders (xALP_Competencias;$aHeaders)
			$t_nombreEtapa:=";(  Etapa: "+ST_CleanMenuMetaCharacters ($aHeaders{$l_columna})
			
			If (($l_columna>0) & ($l_fila>0))
				$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
				If ($l_recNumCompetencia>=0)
					GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$l_recNumCompetencia)
					If ([MPA_DefinicionCompetencias:187]ID_Eje:2#0)
						vlMPA_recNumEje:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[MPA_DefinicionCompetencias:187]ID_Eje:2)
						If (vlMPA_recNumEje>0)
							vlMPA_IDEje:=[MPA_DefinicionCompetencias:187]ID_Eje:2
							$l_filaEjes:=Find in array:C230(alEVLG_EJES_RecNums;vlMPA_recNumEje)
							AL_SetLine (xALP_ejes;$l_filaEjes)
						End if 
						$t_NombreEje:=KRL_GetTextFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]Nombre:3)
						$t_nombreEje:=";(  Eje: "+ST_CleanMenuMetaCharacters ($t_NombreEje)
					Else 
						$t_nombreEje:=";(  Eje: [ninguno]"
					End if 
					If ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0)
						vlMPA_recNumDimension:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[MPA_DefinicionCompetencias:187]ID_Dimension:23)
						If (vlMPA_recNumDimension>0)
							vlMPA_IDDimension:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
							$l_filaDimensiones:=Find in array:C230(alEVLG_EJES_RecNums;vlMPA_recNumEje)
							AL_SetLine (xALP_ejes;$l_filaDimensiones)
						End if 
						$t_nombreDimension:=KRL_GetTextFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]Dimensión:4)
						$t_nombreDimension:=";(  Dimensión: "+ST_CleanMenuMetaCharacters ($t_nombreDimension)
					Else 
						$t_nombreDimension:=";(  Dimensión: [ninguna]"
					End if 
					$t_nombreEtapa:=";(  Etapa: "+ST_CleanMenuMetaCharacters ($aHeaders{$l_columna})
					$t_ItemAñadir:=__ ("Añadir Competencia en... ")+$t_nombreEtapa+$t_nombreEje+$t_nombreDimension
					If ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4>0)
						$t_contenidoPopUp:=$t_ItemAñadir+";(-;"+__ ("Propiedades...")+";(-;"+__ ("Eliminar...")+";(-;"+__ ("Utilizar en todas las etapas")+")"
					Else 
						$t_contenidoPopUp:=$t_ItemAñadir+";(-;"+__ ("Propiedades...")+";(-;"+__ ("Eliminar...")+";(-;"+__ ("Utilizar sólo en etapa")+ST_CleanMenuMetaCharacters ($aHeaders{$l_columna})+")"
					End if 
				Else 
					
					If ($l_filaDimensiones>0)
						$t_nombreDimension:=atEVLG_Dimensiones_Nombres{$l_filaDimensiones}
						$t_nombreDimension:=";(  "+__ ("Dimensión: ")+" )"+ST_CleanMenuMetaCharacters ($t_nombreDimension)
					Else 
						$t_nombreDimension:=";(  "+__ ("Dimensión: [ninguna]")+")"
					End if 
					
					If ($l_filaEjes>0)
						$t_NombreEje:=atEVLG_Ejes_Nombres{$l_filaEjes}
						$t_nombreEje:=";(  "+__ ("Eje:")+")"+ST_CleanMenuMetaCharacters ($t_NombreEje)
					Else 
						$t_nombreEje:=";( "+__ (" Eje: [ninguno]")+")"
					End if 
					$t_ItemAñadir:=__ ("Añadir Competencia en... ")+$t_nombreEtapa+$t_nombreEje+$t_nombreDimension
					$t_contenidoPopUp:=$t_ItemAñadir+";(-;("+__ ("Propiedades...")+";(-;("+__ ("Eliminar...")+";(-;("+__ ("Utilizar en todas las etapas")+")"
				End if 
				
				$result:=Pop up menu:C542($t_contenidoPopUp;0)
				Case of 
					: ($result=1)
						atMPA_EtapasArea:=$l_columna
						Case of 
							: ($l_filaDimensiones>0)
								GOTO RECORD:C242([MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums{$l_filaDimensiones})
								If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionDimensiones:188]DesdeGrado:6) & ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5#0))
									CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
								Else 
									$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Dimension_Aprendizaje)
								End if 
								
							: ($l_filaEjes>0)
								GOTO RECORD:C242([MPA_DefinicionEjes:185];alEVLG_EJES_RecNums{$l_filaEjes})
								If ((alMPA_NivelDesde{$l_columna}#[MPA_DefinicionEjes:185]DesdeGrado:4) & ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19#0))
									CD_Dlog (0;__ ("Está intentando agregar una Competencia en una etapa que no corresponde a la del Eje o Dimensión de aprendizaje seleccionado.\r\rUna Competencia debe necesariamente ser asignada a la misma etapa del Eje o Dimensión del que depende."))
								Else 
									$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Eje_Aprendizaje)
								End if 
								
							: ($l_filaAreas>0)
								MPAcfg_ContenidoAreas (vlMPA_recNumArea;-1;-1;$l_recNumCompetencia)
								$l_recNumCompetencia:=MPAcfg_Comp_Agregar (0)
								
						End case 
						
						
						
						
						
					: ($result=6)
						$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
						MPAcfg_Comp_Propiedades ($l_recNumCompetencia)
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1;$l_recNumCompetencia)
						
						
						
					: ($result=8)
						$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
						$l_competenciaEliminada:=MPAcfg_Comp_Eliminar ($l_recNumCompetencia)
						If ($l_competenciaEliminada=1)
							MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension)
						End if 
						
						
						
					: ($result=10)
						$l_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
						If ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4=1)
							KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;True:C214)
							[MPA_DefinicionCompetencias:187]DesdeGrado:5:=-100
							[MPA_DefinicionCompetencias:187]HastaGrado:13:=-100
							[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=0
							For ($iNiveles;1;Size of array:C274(<>al_NumeroNivelesActivos))
								$l_bitToSet:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$iNiveles})
								[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
							End for 
							If (MPAcfg_Comp_EsUnica )
								SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
								If (cb_AutoActualizaMatricesMPA=1)
									MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;$l_recNumCompetencia)
								End if 
							Else 
								CD_Dlog (0;__ ("Existe una competencia con el mismo nombre en el mismo contenedor (Area, Eje o Dimensión) que aplica en las mismas etapas o niveles académicos.\r\rNo es posible extender la aplicación de esta competencia a todas las etapas."))
							End if 
						Else 
							MPAcfg_Comp_CambiaEtapa ($l_recNumCompetencia;alMPA_NivelDesde{$l_columna};alMPA_NivelHasta{$l_columna};atMPA_EtapasArea{$l_columna})
						End if 
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;$l_recNumCompetencia)
						
						
				End case 
			End if 
			
			
			
			
		: (alProEvt=AL Single click event)
			$err:=AL_GetCellSel (xALP_Competencias;$l_columna;$l_fila)
			$l_recNum:=-1
			If (($l_columna>0) & ($l_fila>0))
				$l_recNum:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
				$y_arregloEtapa:=Get pointer:C304("atEVLG_Competencias_E"+String:C10($l_columna))
				vt_Competencia:=$y_arregloEtapa->{$l_fila}
				OBJECT SET TITLE:C194(bCompetencia;vt_Competencia)
			End if 
			
			If ($l_recNum<0)
				AL_SetCellBorder (xALP_Competencias;$l_columna;$l_fila;0;0;0;0;0;0;0;0;0)
			End if 
			
			For ($iColumnas;1;Size of array:C274(alEVLG_Competencias_RecNums{$l_fila}))
				For ($iFilas;1;Size of array:C274(alEVLG_Competencias_RecNums))
					If (($l_recNum>=0) & (alEVLG_Competencias_RecNums{$iFilas}{$iColumnas}=$l_recNum))
						AL_SetCellBorder (xALP_Competencias;$iColumnas;$iFilas;1;1;1;1;0;2;187;187;187)
					Else 
						AL_SetCellBorder (xALP_Competencias;$iColumnas;$iFilas;0;0;0;0;0;0;0;0;0)
					End if 
				End for 
			End for 
			
			
			AL_UpdateArrays (xALP_Competencias;-2)
			If (($l_columna>0) & ($l_fila>0))
				vlMPA_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
			Else 
				vlMPA_recNumCompetencia:=-1
			End if 
			IT_SetButtonState (vlMPA_recNumCompetencia>=0;->bDeleteCompetencia)
			
			
	End case 
	
	$err:=AL_GetCellSel (xALP_Competencias;$l_columna;$l_fila)
	If (($l_columna>0) & ($l_fila>0))
		vlMPA_recNumCompetencia:=alEVLG_Competencias_RecNums{$l_fila}{$l_columna}
		If (vlMPA_recNumCompetencia>=0)
			MPAcfg_InfoUsoEnunciado (Logro_Aprendizaje;vlMPA_recNumCompetencia)
		End if 
	Else 
		MPAcfg_InfoUsoEnunciado (Logro_Aprendizaje;No current record:K29:2)
	End if 
End if 