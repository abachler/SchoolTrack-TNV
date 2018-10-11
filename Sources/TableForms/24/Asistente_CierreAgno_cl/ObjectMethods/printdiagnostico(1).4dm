ARRAY TEXT:C222(at_TextLines;0)
OBJECT SET VISIBLE:C603(*;"Diagnostico@";True:C214)

$ref:=Open document:C264(vt_DiagnosticFileName)
RECEIVE PACKET:C104($ref;$record;"\r")
While (OK=1)
	INSERT IN ARRAY:C227(at_TextLines;Size of array:C274(at_TextLines)+1;1)
	If (SYS_IsWindows )
		$record:=_O_Win to Mac:C464($record)
	End if 
	at_TextLines{Size of array:C274(at_TextLines)}:=$record
	RECEIVE PACKET:C104($ref;$record;"\r")
End while 
CLOSE DOCUMENT:C267($ref)

READ ONLY:C145(*)
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Diagnostico")
xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29

ALL RECORDS:C47([xxSTR_Constants:1])
REDUCE SELECTION:C351([xxSTR_Constants:1];1)

If ((Macintosh option down:C545) | (Windows Alt down:C563))
	iSR_WinRef:=SR Preview (xSR_ReportBlob;10;60;610;600;8;[xShell_Reports:54]ReportName:26)
Else 
	$err:=SR Print Report (xSR_ReportBlob;3;65535)
End if 