C_LONGINT:C283($l_areaEliminada;$l_Areas;$l_competenciasNoAsignadas;$l_filaSeleccionada;$l_itemSeleccionado;$l_opcionAsignacion)
C_TEXT:C284($t_itemsPopup;$t_tituloVentana)


Case of 
		
	: (alProEvt=AL Double click event)
		$l_filaSeleccionada:=AL_GetLine (xALP_AreasMPA)
		MPAcfg_ContenidoAreas 
		MPAcfg_Area_Propiedades (alEVLG_Marcos_RecNums{$l_filaSeleccionada})
		MPAcfg_Area_Lista 
		MPAcfg_ContenidoAreas 
		
	: (alProEvt=AL Single click event)
		AL_SetLine (xALP_Ejes;0)
		AL_SetLine (xAlp_Dimensiones;0)
		MPAcfg_ContenidoAreas 
		
	: (alProEvt=AL Single Control Click)
		
		MPAcfg_ContenidoAreas 
		
		SET QUERY LIMIT:C395(1)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_competenciasNoAsignadas)
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11;=;[MPA_DefinicionAreas:186]ID:1;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Eje:2;=;0;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23;=;0)
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_Areas)
		QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]AreaMPA:4=[MPA_DefinicionAreas:186]AreaAsignatura:4)
		
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		$t_itemsPopup:=__ ("Todos los ítems del area;")
		If ($l_competenciasNoAsignadas>0)
			$t_itemsPopup:=$t_itemsPopup+__ ("Competencias no asociadas a Ejes o Dimensiones")+";(-;"
		Else 
			$t_itemsPopup:=$t_itemsPopup+__ ("(Competencias no asociadas a Ejes o Dimensiones")+";(-;"
		End if 
		If ($l_Areas>0)
			$t_itemsPopup:=$t_itemsPopup+__ ("Asignar a las asignaturas del área...")+";(-;"+__ ("Eliminar todas las asignaciones...")+";(-;"
		Else 
			$t_itemsPopup:=$t_itemsPopup+"("+__ ("Asignar a las asignaturas del área")+"...;(-;("+__ ("Eliminar todas las asignaciones...")+";(-;"
		End if 
		$t_itemsPopup:=$t_itemsPopup+__ ("Eliminar Area...")+";(-);"+__ ("Propiedades...")
		
		$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopup)
		
		If ($l_itemSeleccionado>0)
			$l_filaSeleccionada:=AL_GetLine (xALP_AreasMPA)
			Case of 
				: ($l_itemSeleccionado=1)
					  //
					
				: ($l_itemSeleccionado=2)
					vb_SoloEnunciadosNoAsociados:=True:C214
					MPAcfg_ContenidoAreas 
					
				: ($l_itemSeleccionado=4)  //asignador
					KRL_GotoRecord (->[MPA_DefinicionAreas:186];alEVLG_Marcos_RecNums{$l_filaSeleccionada})
					$t_tituloVentana:=__ ("Asignación del Mapa de Aprendizaje del Área ")
					WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"Asignador";-1;8;$t_tituloVentana+atEVLG_Marcos_Nombres{$l_filaSeleccionada})
					DIALOG:C40([MPA_DefinicionAreas:186];"Asignador")
					CLOSE WINDOW:C154
					
					If (OK=1)
						KRL_GotoRecord (->[MPA_DefinicionAreas:186];alEVLG_Marcos_RecNums{$l_filaSeleccionada})
						$l_opcionAsignacion:=(r1_SoloSinAsignaciones*1)+(r2_CompletarAsignaciones*2)+(r3_ReemplazarNoEvaluadas*3)+(r4_ReemplazarEvaluadas*4)
						$l_itemSeleccionado:=2
						MPAcfg_AsignaMapas (alEVLG_Marcos_RecNums{$l_filaSeleccionada};->atMPA_AsignaturasArea;$l_opcionAsignacion)
					End if 
					
				: ($l_itemSeleccionado=6)
					MPAcfg_Area_EliminaAsignaciones (alEVLG_Marcos_RecNums{$l_filaSeleccionada})
					
				: ($l_itemSeleccionado=8)
					$l_filaSeleccionada:=AL_GetLine (xALP_AreasMPA)
					$l_areaEliminada:=MPAcfg_Area_Eliminar (alEVLG_Marcos_RecNums{$l_filaSeleccionada})
					MPAcfg_Area_Lista 
					If ($l_filaSeleccionada>Size of array:C274(alEVLG_Marcos_RecNums))
						$l_filaSeleccionada:=$l_filaSeleccionada-1
					End if 
					AL_SetLine (xALP_AreasMPA;$l_filaSeleccionada)
					MPAcfg_ContenidoAreas 
					
				: ($l_itemSeleccionado=10)
					MPAcfg_Area_Propiedades (alEVLG_Marcos_RecNums{$l_filaSeleccionada})
					MPAcfg_Area_Lista 
					MPAcfg_ContenidoAreas (alEVLG_Marcos_RecNums{$l_filaSeleccionada})
			End case 
		End if 
		
End case 

