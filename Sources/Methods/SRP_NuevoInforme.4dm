//%attributes = {}
  // SRP_NuevoInforme()
  // 
  //
  // creado por: Alberto Bachler Klein: 04-04-16, 16:30:27
  // -----------------------------------------------------------

$error:=SR_LoadReport (xReportData;SR_GetTextProperty (0;0;SRP_Area_NewReport))
SRP_FijaTabla (xReportData;vlQR_SRMainTable)
SRcust_AutoCode (xReportData)
