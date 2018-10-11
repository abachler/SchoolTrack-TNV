$r:=CD_Dlog (0;__ ("Esto eliminará los ítems de las listas del colegio y los reemplazará por los ítems por defecto del sistema. Esto afecta a las listas de todos los módulos. ¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	UNLOAD RECORD:C212([xShell_List:39])
	TBL_LoadListLibraryDeveloper 
	QUERY:C277([xShell_List:39];[xShell_List:39]Module:4=vsBWR_CurrentModule;*)
	QUERY:C277([xShell_List:39]; | [xShell_List:39]Module:4="All")
	ARRAY TEXT:C222(pLists;0)
	SELECTION TO ARRAY:C260([xShell_List:39]Listname:1;pLists)
	SORT ARRAY:C229(pLists;>)
	AL_UpdateArrays (xALP_Tables;0)
	If (Size of array:C274(pLists)>0)
		pLists:=1
		vListName:=pLists{1}
		ARRAY TEXT:C222(sElements;0)
		QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=vListName)
		sLayout:=[xShell_List:39]Form_Name:6
		BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->sElements)
		SORT ARRAY:C229(sElements;>)
		
		Changed:=False:C215
		sElements:=0
		IT_SetButtonState (False:C215;->bDel;->bEdit;->bInfos)
		AL_UpdateArrays (xALP_Tables;-2)
		
		TBL_SetListApparence 
	End if 
End if 