$explorerProcessPos:=Find in array:C230(<>alXS_ModuleRef;1)
If ($explorerProcessPos>0)
	  //ARRAY TEXT($at_Asignaturas;0)
	  //ARRAY LONGINT($al_recNumAsignaturas;0)
	  //HL_CopyReferencedListToArray (◊hl_avgDiff_Asignaturas;->$at_Asignaturas;->$al_recNumAsignaturas)
	  //CREATE SET FROM ARRAY([Asignaturas];$al_recNumAsignaturas;"DiferenciasPromedio")
	  //◊vt_IPMsg_ShowSet:="DiferenciasPromedio"
	<>vl_IPMsg_Tab2Select:=18
	<>vt_IPMsg_Message:="ShowList"
	POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$explorerProcessPos})
	BRING TO FRONT:C326(<>alXS_ModuleProcessID{$explorerProcessPos})
End if 