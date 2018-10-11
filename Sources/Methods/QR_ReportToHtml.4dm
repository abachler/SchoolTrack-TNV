//%attributes = {}
  //QR_ReportToHtml

Case of 
	: (vtQR_CurrentReportType="4DSE")
		QR GET DESTINATION:C756(xQR_ReportArea;$savedDestination)
		QR SET DESTINATION:C745(xQR_ReportArea;qr HTML file:K14903:5)
		QR RUN:C746(xQR_ReportArea)
		QR SET DESTINATION:C745(xQR_ReportArea;$savedDestination)
		
	: (vtQR_CurrentReportType="gSR2")
		  //$msg:="Para que los navegadores Internet puedan interpretar correctamente el informe es "+"necesario que en su modelo de informe hayan sido insertados los tags html en las "+"secciones y/u objetos apropiados."+"\r\rSi ya lo hizo haga click en el botón Generar HTML."
		  //$msg:=$msg+"\r\rSi ya lo hizo haga click en el botón Generar HTML."
		SRcust_AutoCode (xReportData)
		OK:=CD_Dlog (0;__ ("Para que los navegadores Internet puedan interpretar correctamente el informe es necesario que en su modelo de informe hayan sido insertados los tags html en las secciones y/u objetos apropiados.\r\rSi ya lo hizo haga click en el botón Generar HTML.");__ ("");__ ("Generar HTML");__ ("Cancelar"))
		If (ok=1)
			$fileName:=Replace string:C233([xShell_Reports:54]ReportName:26;" ";"_")+".html"
			$err:=SR Print HTML (xSR_ReportBlob;$fileName;SR PrintToDisk File Dialog+SR PrintToDisk Static Text;SR All Sections;SR Generic Option Set On)
		End if 
End case 

