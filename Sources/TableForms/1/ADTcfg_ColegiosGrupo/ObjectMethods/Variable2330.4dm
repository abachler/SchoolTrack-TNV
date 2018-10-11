If (vtNuevoColegioGrupo#"")
	$exists:=Find in array:C230(aColegiosGrupo;vtNuevoColegioGrupo)
	If ($exists=-1)
		AL_UpdateArrays (xALP_ColegiosGrupo;0)
		APPEND TO ARRAY:C911(aColegiosGrupo;vtNuevoColegioGrupo)
		SORT ARRAY:C229(aColegiosGrupo)
		AL_UpdateArrays (xALP_ColegiosGrupo;-2)
		
		READ WRITE:C146([xShell_List:39])
		QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Colegio Anterior")
		ARRAY TEXT:C222(aTexts;0)
		BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->aTexts)
		$found:=Find in array:C230(aTexts;vtNuevoColegioGrupo)
		If ($found=-1)
			APPEND TO ARRAY:C911(aTexts;vtNuevoColegioGrupo)
			SORT ARRAY:C229(aTexts)
			  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->aTexts)
			  //$arrPtr:=Get pointer([xShell_List]ArrayName1)
			  //COPY ARRAY(aTexts;$arrPtr->)
			  //SAVE RECORD([xShell_List])
			  //20140107 ASM Ticket  128514
			TBL_SaveListAndArrays (->aTexts)
		End if 
		ARRAY TEXT:C222(aTexts;0)
		KRL_UnloadReadOnly (->[xShell_List:39])
		
	Else 
		CD_Dlog (0;__ ("Este colegio ya existe en la lista."))
	End if 
	vtNuevoColegioGrupo:=""
	_O_DISABLE BUTTON:C193(bAddNewGroupSchool)
End if 