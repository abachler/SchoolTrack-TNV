//%attributes = {}
  //UFLD_LoadFileTplt

If (Count parameters:C259=2)
	$module:=$2
Else 
	$module:=<>vsXS_CurrentModule
End if 
MESSAGES OFF:C175
READ ONLY:C145([xShell_Userfields:76])
QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=Table:C252($1);*)
QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=$module)
ARRAY TEXT:C222(UFlist;0)
ARRAY INTEGER:C220(aUFtype;0)
ARRAY LONGINT:C221(aUFId;0)
SELECTION TO ARRAY:C260([xShell_Userfields:76]UserFieldName:1;aUFList;[xShell_Userfields:76]FieldID:7;aUFId;[xShell_Userfields:76]FieldType:2;aUFType;[xShell_Userfields:76]MultiEvaluado:8;aUFMulti)
UFFilePtr:=$1

