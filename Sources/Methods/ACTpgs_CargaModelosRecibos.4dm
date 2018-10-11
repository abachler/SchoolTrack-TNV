//%attributes = {}
  //ACTpgs_CargaModelosRecibos

C_TEXT:C284($vt_ImprimirDesde)
If (Count parameters:C259=1)
	$vt_ImprimirDesde:=$1
End if 

READ ONLY:C145([xShell_Reports:54])
  //If (cb_generarRcibosDesdeAC=0)  //20170711 RCH se carga en ACTcfg_LoadConfigData/ACTcfg_OpcionesGenRecibo
If ((cb_generarRcibosDesdeAC=0) | (vrACT_SeleccionadoAPagar=0))  //20170802 RCH Si no se seleccionan cargos, se selecciona inform desde Pagos
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_Pagos:172]);*)
Else 
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_Avisos_de_Cobranza:124]);*)
End if 
QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]ReportType:2="gSR2")
If ($vt_ImprimirDesde="")
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
End if 
ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
ARRAY TEXT:C222(atACT_Recibos;0)
SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACT_Recibos)
If (Size of array:C274(atACT_Recibos)>0)
	vtACT_ModeloRecibo:=atACT_Recibos{1}
	atACT_Recibos:=1
Else 
	vtACT_ModeloRecibo:="No hay modelos."
	IT_SetButtonState (False:C215;->cbImprimirRecPago)
End if 
cbImprimirRecPago:=0
_O_DISABLE BUTTON:C193(bModRecibo)