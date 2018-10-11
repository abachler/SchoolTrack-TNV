AL_ExitCell (xALP_ASNotas)

$text:=Get text from pasteboard:C524
$ref:=Create document:C266("";"TEXT")
If (OK=1)
	
	If (SYS_IsMacintosh )
		USE CHARACTER SET:C205("MacRoman";0)
	Else 
		USE CHARACTER SET:C205("windows-1252";0)
	End if 
	
	SEND PACKET:C103($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	USE CHARACTER SET:C205(*;0)
End if 

ARRAY LONGINT:C221($al_selectedRows;0)
AL_SetSelect (xALP_ASNotas;$al_selectedRows)