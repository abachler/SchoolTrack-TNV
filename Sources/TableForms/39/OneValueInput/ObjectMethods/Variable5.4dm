If ([xShell_List:39]ArrayName1:5="◊aListSect")  //20141104 RCH Se deja campo en 80 caracteres. Se controla el ingreso. En el else, se deja igual.
	If (Length:C16(sValue)>80)
		svalue:=Substring:C12(sValue;1;77)+"..."
	End if 
Else 
	If (Length:C16(sValue)>70)
		svalue:=Substring:C12(sValue;1;70)+"..."
	End if 
End if 
$pos:=Find in array:C230(sElements;sValue)
Case of 
	: (sValue="")
		$r:=CD_Dlog (0;__ ("No se puede agregar un elemento vacío a una tabla"))
	: (($pos#-1) & ($pos#selements))
		$r:=CD_Dlog (0;__ ("Ya existe este valor en la tabla"))
	Else 
		ACCEPT:C269
End case 