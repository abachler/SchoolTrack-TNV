If (Length:C16(sValue)>70)
	svalue:=Substring:C12(sValue;1;70)+"..."
End if 
Case of 
	: (r1=1)
		sValue:=sValue+", [M]"
	: (r2=1)
		sValue:=sValue+", [D]"
	: (r3=1)
		sValue:=sValue+", [T]"
End case 
$pos:=Find in array:C230(sElements;sValue)
Case of 
	: (sValue="")
		$r:=CD_Dlog (0;__ ("No se puede agregar un elemento vacío a una tabla."))
	: (($pos#-1) & ($pos#sElements))
		$r:=CD_Dlog (0;__ ("Ya existe este valor en la tabla."))
	Else 
		ACCEPT:C269
End case 