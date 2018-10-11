
$ItemV:=String:C10([xShell_Userfields:76]FieldID:7;"00000/")+<>aUFvalues{<>aUFvalues}
vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
EXECUTE FORMULA:C63("vPointer:=»"+vField)
QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$itemV)
$f:=Records in selection:C76(Table:C252([xShell_Userfields:76]FileNo:6)->)
If ($f>0)
	$r:=CD_Dlog (0;<>aUFvalues{<>aUFvalues}+__ ("Es utilizado en la base de datos.\r¿ Desea Ud. eliminarlo ?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		AT_Delete (<>aUFValues;1;-><>aUFvalues;-><>aUFOcc)
		[xShell_Userfields:76]UserFieldName:1:=[xShell_Userfields:76]UserFieldName:1
	End if 
	<>aUFOcc:=0
	<>aUFvalues:=0
	sUFValue:=""
Else 
	AT_Delete (<>aUFValues;1;-><>aUFvalues;-><>aUFOcc)
	<>aUFOcc:=0
	<>aUFvalues:=0
	sUFValue:=""
	[xShell_Userfields:76]UserFieldName:1:=[xShell_Userfields:76]UserFieldName:1
End if 