//%attributes = {}
  //SQ_getLastID

C_LONGINT:C283($tableNum;$fieldNum)
C_REAL:C285($positif;$negatif)
$fieldPointer:=$1
$tablePointer:=Table:C252(Table:C252($fieldPointer))
$tableNum:=Table:C252($1)
$fieldNum:=Field:C253($1)

If (Is field number valid:C1000($tableNum;$fieldNum))
	READ WRITE:C146([xShell_SequenceNumbers:67])
	
	QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]Table_Number:1=$tableNum;*)
	QUERY:C277([xShell_SequenceNumbers:67]; & ;[xShell_SequenceNumbers:67]FieldNumber:4=$fieldNum)
	
	$positif:=0
	$negatif:=0
	READ ONLY:C145($tablePointer->)
	If (KRL_IsFieldIndexed ($fieldPointer))
		SCAN INDEX:C350($fieldPointer->;1;>)
		If ($fieldPointer-><0)
			$negatif:=$fieldPointer->
		End if 
		SCAN INDEX:C350($fieldPointer->;1;<)
		If ($fieldPointer->>0)
			$positif:=$fieldPointer->
		End if 
		
	Else 
		ALL RECORDS:C47($tablePointer->)
		ORDER BY:C49($tablePointer->;$fieldPointer->;>)
		FIRST RECORD:C50($tablePointer->)
		If ($fieldPointer-><0)
			$negatif:=$fieldPointer->
		End if 
		LAST RECORD:C200($tablePointer->)
		If ($fieldPointer->>0)
			$positif:=$fieldPointer->
		End if 
	End if 
	UNLOAD RECORD:C212($tablePointer->)
	
	If (Records in selection:C76([xShell_SequenceNumbers:67])=0)
		CREATE RECORD:C68([xShell_SequenceNumbers:67])
		[xShell_SequenceNumbers:67]Table_Number:1:=$tableNum
		[xShell_SequenceNumbers:67]FieldNumber:4:=$fieldNum
	End if 
	[xShell_SequenceNumbers:67]ID_Positif:2:=$positif
	[xShell_SequenceNumbers:67]ID_Negatif:3:=$negatif
	SAVE RECORD:C53([xShell_SequenceNumbers:67])
	UNLOAD RECORD:C212([xShell_SequenceNumbers:67])
	READ ONLY:C145([xShell_SequenceNumbers:67])
End if 