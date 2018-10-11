//%attributes = {}
C_DATE:C307($vd_fecha1;$1;$vd_fecha2;$2)
If (Count parameters:C259>1)
	$vd_fecha1:=$1
	$vd_fecha2:=$2
End if 

READ ONLY:C145([xShell_Logs:37])
QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Module:8="Actuadatos")

If (($vd_fecha1#!00-00-00!) & ($vd_fecha2#!00-00-00!))
	QUERY SELECTION:C341([xShell_Logs:37];[xShell_Logs:37]Event_Date:3>=$vd_fecha1;*)
	QUERY SELECTION:C341([xShell_Logs:37]; & ;[xShell_Logs:37]Event_Date:3<=$vd_fecha2)
End if 

ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
