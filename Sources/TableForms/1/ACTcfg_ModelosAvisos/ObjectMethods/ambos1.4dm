C_TEXT:C284($filename)
C_LONGINT:C283($tableNumber;$table)

$tableNumber:=Table:C252(->[xShell_Reports:54])

$line:=AL_GetLine (xAL_ModelosAvisos)

$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosAvID{$line})

SET CHANNEL:C77(12;"")
If (ok=1)
	SEND VARIABLE:C80($tableNumber)
	SEND RECORD:C78([xShell_Reports:54])
	SET CHANNEL:C77(11)
End if 