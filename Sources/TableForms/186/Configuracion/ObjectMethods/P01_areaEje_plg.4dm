  //MPA_Eje_CambiaSeleccion 
If (vlMPA_recNumArea>=0)
	Case of 
		: (alProEvt=AL Row drag event)
			AL_GetDrgSrcCol (Self:C308->;$sourceCol)
			AL_GetDrgSrcRow (Self:C308->;$sourceRow)
			AL_GetDrgArea (Self:C308->;$areaDst)
			AL_GetDrgDstRow (Self:C308->;$DestRow)
			Case of 
				: (($areaDst=xALP_Competencias) | ($areaDst=xALP_Dimensiones))
					CD_Dlog (0;__ ("Los ejes de aprendizaje son contenedores para dimensiones y competencias.\r\rNo es posible incluir un eje en una dimensión o competencia."))
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;vlMPA_recNumCompetencia)
					
					
				: ($areaDst=Self:C308->)
					$recNum:=alEVLG_EJES_RecNums{$sourceRow}
					COPY ARRAY:C226(alEVLG_EJES_RecNums;$aValidRecNums)
					DELETE FROM ARRAY:C228($aValidRecNums;$sourceRow)
					If ($DestRow>=Size of array:C274(alEVLG_EJES_RecNums))
						APPEND TO ARRAY:C911($aValidRecNums;$recNum)
						$destRow:=Size of array:C274($aValidRecNums)
					Else 
						INSERT IN ARRAY:C227($aValidRecNums;$DestRow)
						$aValidRecNums{$DestRow}:=$recNum
					End if 
					For ($i;1;Size of array:C274($aValidRecNums))
						READ WRITE:C146([MPA_DefinicionEjes:185])
						GOTO RECORD:C242([MPA_DefinicionEjes:185];$aValidRecNums{$i})
						[MPA_DefinicionEjes:185]OrdenamientoNumerico:9:=$i
						SAVE RECORD:C53([MPA_DefinicionEjes:185])
						alEVLG_EJES_RecNums{$i}:=Record number:C243([MPA_DefinicionEjes:185])
						Case of 
							: ([MPA_DefinicionEjes:185]DesdeGrado:4=999)
								atEVLG_Ejes_Etapas{$i}:="Por nivel"
								
							: ([MPA_DefinicionEjes:185]DesdeGrado:4>-100)
								atEVLG_Ejes_Etapas{$i}:=String:C10([MPA_DefinicionEjes:185]DesdeGrado:4)+" - "+String:C10([MPA_DefinicionEjes:185]HastaGrado:5)
								
							Else 
								atEVLG_Ejes_Etapas{$i}:="Todos"
						End case 
						
						alEVLG_Ejes_Ids{$i}:=[MPA_DefinicionEjes:185]ID:1
						atEVLG_Ejes_Nombres{$i}:=[MPA_DefinicionEjes:185]Nombre:3
					End for 
					UNLOAD RECORD:C212([MPA_DefinicionEjes:185])
					READ ONLY:C145([MPA_DefinicionEjes:185])
					AL_SetLine (Self:C308->;$DestRow)
					
				: ($areaDst=xALP_AreasMPA)
					AL_GetDrgDstRow (xALP_AreasMPA;$DestRow)
					$l_filaAreas:=AL_GetLine (xALP_AreasMPA)
					$destAreaRecNum:=alEVLG_Marcos_RecNums{$DestRow}
					$objectRecNum:=alEVLG_EJES_RecNums{$sourceRow}
					If (Macintosh option down:C545 | Windows Alt down:C563 | Windows Ctrl down:C562)
						$l_recNumEje:=MPAcfg_CopiaObjetoEnArea (Eje_Aprendizaje;$objectRecNum;$destAreaRecNum)
						If ($l_recNumEje>=0)
							MPAcfg_ContenidoAreas ($l_recNumAreaDestino;$l_recNumEje;-1;-1)
						Else 
							MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje)
						End if 
					Else 
						$l_recNumEje:=MPAcfg_CambiaAreaObjeto (Eje_Aprendizaje;$objectRecNum;$destAreaRecNum)
						If ($l_recNumEje>=0)
							MPAcfg_ContenidoAreas ($l_recNumAreaDestino;$l_recNumEje;-1;-1)
						Else 
							MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje)
						End if 
					End if 
			End case 
			
			
			
		: ((alProEvt=AL Empty Area Control Click) | (alProEvt=AL Single Control Click))
			$l_filaAreas:=AL_GetLine (xALP_AreasMPA)
			$l_filaEjes:=AL_GetLine (xALP_Ejes)
			$recNumEje:=alEVLG_EJES_RecNums{$l_filaEjes}
			
			If ($l_filaEjes=0)
				$popUpContent:=__ ("Nuevo Eje en \"^1\";(Eliminar Eje...;(-;(Añadir Competencia en...;(-;Ejes, Dimensiones y Competencias del Area \"^1\";(Dimensiones y Competencias del Eje...")
				$popUpContent:=Replace string:C233($popUpContent;"^1";ST_CleanMenuMetaCharacters (atEVLG_Marcos_Nombres{$l_filaAreas}))
				$popUpContent:=Replace string:C233($popUpContent;"^2";ST_CleanMenuMetaCharacters (atEVLG_Ejes_Nombres{$l_filaEjes}))
			Else 
				$popUpContent:=__ ("Nuevo Eje en \"^1\";Eliminar Eje \"^2\";(-;Añadir Competencia en \"^2\";(-;Ejes, Dimensiones y Competencias del Area \"^1\";Dimensiones y Competencias en \"^2\"")
				$popUpContent:=Replace string:C233($popUpContent;"^1";ST_CleanMenuMetaCharacters (atEVLG_Marcos_Nombres{$l_filaAreas}))
				$popUpContent:=Replace string:C233($popUpContent;"^2";ST_CleanMenuMetaCharacters (atEVLG_Ejes_Nombres{$l_filaEjes}))
			End if 
			$result:=Pop up menu:C542($popupContent;0)
			
			
			
			Case of 
				: ($result=1)
					MPAcfg_Eje_Agregar 
					
				: ($result=2)
					$l_ejeEliminado:=MPAcfg_Eje_Eliminar ($recNumEje)
					If ($l_ejeEliminado=1)
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;-1;-1;-1)
					End if 
					
					
				: ($result=4)
					atMPA_EtapasArea:=0
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;$recNumEje;-1;$l_recNumCompetencia)
					$l_recNumCompetencia:=MPAcfg_Comp_Agregar (Eje_Aprendizaje)
					If ($l_recNumCompetencia>=0)
						MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1;$l_recNumCompetencia)
					End if 
					
					
				: ($result=6)
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;-1;-1;-1)
					
				: ($result=7)
					MPAcfg_ContenidoAreas (vlMPA_recNumArea;$recNumEje;-1;-1)
					
			End case 
			
		: (alProEvt=AL Single click event)
			AL_SetLine (xALP_Dimensiones;0)
			MPAcfg_ContenidoAreas 
			
		: (alProEvt=AL Double click event)
			AL_SetLine (xALP_Dimensiones;0)
			MPAcfg_ContenidoAreas 
			MPAcfg_Eje_Propiedades 
			
			
		: (alProEvt=AL Empty Area Double click)
			MPAcfg_Eje_Agregar 
			
			
	End case 
End if 

