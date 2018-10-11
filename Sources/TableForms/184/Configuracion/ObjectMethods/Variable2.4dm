ARRAY TEXT:C222($atACT_NombresP;0)

READ ONLY:C145([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_CuentasCorrientes:175]);*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="Pagare@")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)

SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;$atACT_NombresP)

If (Size of array:C274($atACT_NombresP)>0)
	$choice:=IT_PopUpMenu (->$atACT_NombresP;->vtACTp_ModPagare)
	If ($choice#0)
		vtACTp_ModPagare:=$atACT_NombresP{$choice}
	End if 
Else 
	CD_Dlog (0;"No hay modelos de informe (Informes Super Report desde Cuentas Corrientes, de nom"+"bre Pagaré, un documento "+"por registro).")
End if 