//%attributes = {}
  //TBL_LoadListsArrays

dhTBL_DeclareArrays 

READ ONLY:C145([xShell_List:39])
ALL RECORDS:C47([xShell_List:39])

ARRAY TEXT:C222(<>aLists;Records in selection:C76([xShell_List:39]))
ARRAY POINTER:C280(<>aListPtr;Records in selection:C76([xShell_List:39]))
ARRAY POINTER:C280(<>ay_xLSTPopUpPointer;Records in selection:C76([xShell_List:39]))
For ($i;1;Records in selection:C76([xShell_List:39]))
	<>aLists{$i}:=[xShell_List:39]Listname:1
	<>aListPtr{$i}:=Get pointer:C304([xShell_List:39]ArrayName1:5)
	If ([xShell_List:39]PopupArrayName:3#"")
		<>ay_xLSTPopUpPointer{$i}:=Get pointer:C304([xShell_List:39]PopupArrayName:3)
	End if 
	$Array:=Get pointer:C304([xShell_List:39]ArrayName1:5)
	If (Not:C34(Is nil pointer:C315($Array)))
		BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;$array)
	Else 
		If (Not:C34(Is compiled mode:C492))
			CD_Dlog (0;__ ("Arreglo no definido (")+[xShell_List:39]Listname:1+__ ("): ")+[xShell_List:39]ArrayName1:5)
		End if 
	End if 
	NEXT RECORD:C51([xShell_List:39])
End for 
ARRAY TEXT:C222(aText1;0)

dhTBL_LoadArrays 