//%attributes = {}
  // SR_PrintReport()
  // Por: Alberto Bachler K.: 21-08-15, 18:30:24
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (SR_ValidaScripts (xReportData))
	SR Do Command (xReportData;SR MenuItem Print;1)
Else 
	CD_Dlog (0;__ ("Este informe tiene comandos prohibidos en sus scripts.\r\rEl informe no puede imprimirse."))
End if 