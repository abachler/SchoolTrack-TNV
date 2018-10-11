//%attributes = {}
C_LONGINT:C283($i;$r)

QUERY:C277([xShell_List_FieldRefs:236];[xShell_List_FieldRefs:236]ListName:4=[xShell_List:39]Listname:1)
If (Records in selection:C76([xShell_List_FieldRefs:236])#0)
	$Process:=IT_UThermometer (1;0;__ ("Reconstruyendo la lista ")+[xShell_List_FieldRefs:236]ListName:4+__ ("…"))
	ARRAY TEXT:C222(aText1;0)
	ARRAY TEXT:C222(aText2;0)
	ARRAY TEXT:C222($reserve;0)
	COPY ARRAY:C226(aListElements;$reserve)
	AT_Initialize (->aListElements)
	For ($i;1;Records in selection:C76([xShell_List_FieldRefs:236]))
		$tableptr:=Table:C252([xShell_List_FieldRefs:236]FileRef:1)
		$fieldPtr:=Field:C253(Table:C252($tablePtr);[xShell_List_FieldRefs:236]FieldRef:2)
		$type:=Type:C295($fieldPtr->)
		If ($type#7)
			QUERY:C277($tablePtr->;$fieldPtr->#"")
			If (Records in selection:C76(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)#0)
				AT_DistinctsFieldValues ($fieldPtr;->aText1)
				COPY ARRAY:C226(aListElements;aText2)
				AT_Union (->aText1;->aText2;->aListElements)
			End if 
			NEXT RECORD:C51([xShell_List_FieldRefs:236])
		Else 
			$i:=_O_Records in subselection:C7([xShell_List_FieldRefs:236]FieldRef:2)
			COPY ARRAY:C226($reserve;aListElements)
			$r:=CD_Dlog (0;__ ("Esta tabla no puede ser reconstruida");__ (""))
		End if 
	End for 
	  //DELAY PROCESS(Current process;15)
	changed:=True:C214  //AT_Initialize (->aText1;->aText2)
	ARRAY TEXT:C222($tempTextArray;0)
	AT_Text2Array (->$tempTextArray;[xShell_List:39]DefaultValues:10;"\r")
	COPY ARRAY:C226(aListElements;aText2)
	AT_Union (->$tempTextArray;->aText2;->aListElements)
	AT_Initialize (->aText1;->aText2)
	SORT ARRAY:C229(aListElements;>)
	IT_UThermometer (-2;$Process)
End if 

