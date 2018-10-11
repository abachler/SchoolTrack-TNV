//%attributes = {}
  //TBL_ChangeValue

  //OK:=1
  //ALL SUBRECORDS([xShell_List]FieldRefs)
  //While ((Not(End subselection([xShell_List]FieldRefs))) & (ok=1))
  //If (Type(Field([xShell_List]FieldRefs'FileRef;[xShell_List]FieldRefs'FieldRef)->)#7)
  //  //$ptr:=Rubrique([Tables]FieldRefs'FileRef;[Tables]FieldRefs'FieldRef)
  //READ ONLY(Table([xShell_List]FieldRefs'FileRef)->)
  //QRY_QueryWithArray (Field([xShell_List]FieldRefs'FileRef;[xShell_List]FieldRefs'FieldRef);->aText2)
  //If (Records in selection(Table([xShell_List]FieldRefs'FileRef)->)#0)
  //$Process:=IT_UThermometer (1;0;__ ("Actualizando… Un momento por favor"))
  //ARRAY TEXT(aText1;Records in selection(Table([xShell_List]FieldRefs'FileRef)->))
  //For ($i;1;Size of array(aText1))
  //aText1{$i}:=$1
  //  //aText1{$i}:=$2
  //End for 
  //OK:=KRL_Array2Selection (->aText1;Field([xShell_List]FieldRefs'FileRef;[xShell_List]FieldRefs'FieldRef))
  //IT_UThermometer (-2;$Process)
  //End if 
  //End if 
  //NEXT SUBRECORD([xShell_List]FieldRefs)
  //End while 
  //$0:=OK

  //20110531 AS. Se modifica metodo para trabajar directamente con la tabla  [xShell_List_FieldRefs]

OK:=1
QUERY:C277([xShell_List_FieldRefs:236];[xShell_List_FieldRefs:236]ListName:4=[xShell_List:39]Listname:1)
While ((Not:C34(End selection:C36([xShell_List_FieldRefs:236]))) & (ok=1))
	If (Type:C295(Field:C253([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2)->)#7)
		  //$ptr:=Rubrique([Tables]FieldRefs'FileRef;[Tables]FieldRefs'FieldRef)
		READ ONLY:C145(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)
		QRY_QueryWithArray (Field:C253([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2);->aText2)
		If (Records in selection:C76(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)#0)
			$Process:=IT_UThermometer (1;0;__ ("Actualizando… Un momento por favor"))
			ARRAY TEXT:C222(aText1;Records in selection:C76(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->))
			For ($i;1;Size of array:C274(aText1))
				aText1{$i}:=$1
				  //aText1{$i}:=$2
			End for 
			OK:=KRL_Array2Selection (->aText1;Field:C253([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2))
			IT_UThermometer (-2;$Process)
		End if 
	End if 
	NEXT RECORD:C51([xShell_List_FieldRefs:236])
End while 
$0:=OK