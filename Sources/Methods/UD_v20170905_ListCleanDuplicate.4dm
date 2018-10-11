//%attributes = {}
  //UD_v20170905_ListCleanDuplicate
  //MONO, limpia los elementos duplicados de un lista, tanto en el blob y en el json

C_LONGINT:C283($i;$v;$l_idTermometro)
C_OBJECT:C1216($ob_lista)
C_BOOLEAN:C305($b_save)
ARRAY TEXT:C222($at_nodos;0)
ARRAY TEXT:C222($at_listValues;0)
ARRAY TEXT:C222($at_listDistintcValues;0)
ARRAY LONGINT:C221($al_recNumList;0)

$l_idTermometro:=IT_Progress (1;0;0;"Revisando Listas ...")
READ ONLY:C145([xShell_List:39])
ALL RECORDS:C47([xShell_List:39])
LONGINT ARRAY FROM SELECTION:C647([xShell_List:39];$al_recNumList;"")

For ($i;1;Size of array:C274($al_recNumList))
	READ WRITE:C146([xShell_List:39])
	GOTO RECORD:C242([xShell_List:39];$al_recNumList{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recNumList);"Revisando listas: "+[xShell_List:39]Listname:1)
	$b_save:=False:C215
	$ob_lista:=OB_JsonToObject ([xShell_List:39]json:2)
	OB_GetChildNodes ($ob_lista;->$at_nodos)
	
	For ($v;1;Size of array:C274($at_nodos))
		OB_GET ($ob_lista;->$at_listValues;$at_nodos{$v})
		COPY ARRAY:C226($at_listValues;$at_listDistintcValues)
		AT_DistinctsArrayValues (->$at_listDistintcValues)
		If (Size of array:C274($at_listDistintcValues)<Size of array:C274($at_listValues))
			OB_SET ($ob_lista;->$at_listDistintcValues;$at_nodos{$v})
			$b_save:=True:C214
		End if 
	End for 
	
	[xShell_List:39]json:2:=OB_Object2Json ($ob_lista)
	
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_listValues)
	COPY ARRAY:C226($at_listValues;$at_listDistintcValues)
	AT_DistinctsArrayValues (->$at_listDistintcValues)
	If (Size of array:C274($at_listDistintcValues)<Size of array:C274($at_listValues))
		$b_save:=True:C214
		BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->$at_listDistintcValues)
	End if 
	
	If ($b_save)
		SAVE RECORD:C53([xShell_List:39])
	End if 
	KRL_UnloadReadOnly (->[xShell_List:39])
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

TBL_LoadListsArrays 