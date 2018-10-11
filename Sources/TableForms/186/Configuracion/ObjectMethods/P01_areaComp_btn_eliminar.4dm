$err:=AL_GetCellSel (xALP_Competencias;$col;$row)
If (($col>0) & ($row>0))
	$recNum:=alEVLG_Competencias_RecNums{$row}{$col}
	If ($recNum>=0)
		$l_competenciaEliminada:=MPAcfg_Comp_Eliminar ($recNum)
		If ($l_competenciaEliminada=1)
			MPAcfg_ContenidoAreas 
			  //$lineDimensiones:=AL_GetLine (xALP_Dimensiones)
			  //$lineEjes:=AL_GetLine (xALP_ejes)
			  //$lineAreas:=AL_GetLine (xALP_AreasMPA)
			  //Case of 
			  //: ($lineDimensiones>0)
			  //EVLG_ListaAprendizajesDimension 
			  //: ($lineEjes>0)
			  //EVLG_ListaAprendizajesDelEje 
			  //Else 
			  //EVLG_ListaObjetosDelArea 
			  //End case 
		End if 
	End if 
End if 

