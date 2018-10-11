//%attributes = {}
  //IO_SendPacket

C_TIME:C306($ref;$1)
C_TEXT:C284($text;$2)

$ref:=$1
$text:=$2
If ($ref#?00:00:00?)
	SEND PACKET:C103($ref;st_Mac2Win ($text))
End if 