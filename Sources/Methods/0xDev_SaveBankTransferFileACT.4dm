//%attributes = {}
  //0xDev_SaveBankTransferFileACT

C_TIME:C306($ref)
C_TEXT:C284($text)

$text:=Get text from pasteboard:C524
$text:=$text+Char:C90(1)+Char:C90(1)+Char:C90(1)
$ref:=Create document:C266("";"ctf")
If (ok=1)
	USE CHARACTER SET:C205("MacRoman";0)
	SEND PACKET:C103($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	USE CHARACTER SET:C205(*;0)
Else 
	BEEP:C151
	ALERT:C41("No se pudo guardar el documento")
End if 