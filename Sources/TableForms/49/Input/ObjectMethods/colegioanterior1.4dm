$menu:=AT_array2text (->aColegiosGrupo)
$def:=Find in array:C230(aColegiosGrupo;[Alumnos:2]Colegio_de_origen:25)
If ($def=-1)
	$def:=1
End if 
$choice:=Pop up menu:C542($menu;$def)
If ($choice>0)
	[Alumnos:2]Colegio_de_origen:25:=aColegiosGrupo{$choice}
	
	READ WRITE:C146([xShell_List:39])
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Colegio Anterior")
	ARRAY TEXT:C222(aTexts;0)
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->aTexts)
	$found:=Find in array:C230(aTexts;[Alumnos:2]Colegio_de_origen:25)
	If ($found=-1)
		APPEND TO ARRAY:C911(aTexts;[Alumnos:2]Colegio_de_origen:25)
		SORT ARRAY:C229(aTexts)
		  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->aTexts)
		  //$arrPtr:=Get pointer([xShell_List]ArrayName1)
		  //COPY ARRAY(aTexts;$arrPtr->)
		  //SAVE RECORD([xShell_List])
		TBL_SaveListAndArrays (->aTexts)
	End if 
	ARRAY TEXT:C222(aTexts;0)
	KRL_UnloadReadOnly (->[xShell_List:39])
End if 