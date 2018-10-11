ARRAY TEXT:C222($atACT_NombresC;0)

READ ONLY:C145([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_CuentasCorrientes:175]);*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="Contrato@")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)

SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;$atACT_NombresC)

If (Size of array:C274($atACT_NombresC)>0)
	$choice:=IT_PopUpMenu (->$atACT_NombresC;->vtACTp_ModContrato)
	If ($choice#0)
		vtACTp_ModContrato:=$atACT_NombresC{$choice}
	End if 
Else 
	CD_Dlog (0;"No hay modelos de informe (Informes Super Report desde cuentas corrientes, de nom"+"bre Contrato, un document"+"o "+"por registro).")
End if 