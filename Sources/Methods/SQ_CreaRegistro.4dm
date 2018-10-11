//%attributes = {}
  //SQ_CreaRegistro

C_POINTER:C301($fieldPointer;$1)
$fieldPointer:=$1
$tableNum:=Table:C252($fieldPointer)
$fieldNum:=Field:C253($fieldPointer)


If (Is field number valid:C1000($tableNum;$fieldNum))
	QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]Table_Number:1;=;$tableNum;*)
	QUERY:C277([xShell_SequenceNumbers:67]; & [xShell_SequenceNumbers:67]FieldNumber:4;=;$fieldNum)
	CREATE RECORD:C68([xShell_SequenceNumbers:67])
	[xShell_SequenceNumbers:67]Table_Number:1:=$tableNum
	[xShell_SequenceNumbers:67]FieldNumber:4:=$fieldNum
	SAVE RECORD:C53([xShell_SequenceNumbers:67])
	UNLOAD RECORD:C212([xShell_SequenceNumbers:67])
End if 