vb_isReportFolder:=False:C215  //MONO PIBLICAR CARPETA DE INFORMES EN SN3
CREATE SET:C116(vyQR_TablePointer->;"previa")
GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$reportName)
WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"gestionReportesSN";0;4;__ ("Gestión de Informe "+$reportName+" en SchoolNet"))
DIALOG:C40([SN3_PublicationPrefs:161];"gestionReportesSN")
CLOSE WINDOW:C154
USE SET:C118("previa")
CLEAR SET:C117("previa")