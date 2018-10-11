//%attributes = {}
  // QR_GetReportsByType()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 16:12:25
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_IdInforme)
C_TEXT:C284($l_tipoInforme;$t_nombreInforme)


If (False:C215)
	C_TEXT:C284(QR_GetReportsByType ;$1)
	C_LONGINT:C283(QR_GetReportsByType ;$2)
End if 

vtQR_CurrentReportType:=$1
vbQR_FavoritesSelected:=False:C215

CLEAR LIST:C377(hl_Informes)
Case of 
	: (vtQR_CurrentReportType="4DFO")
		vtQR_ReportType:="Informe no Editable"
		OBJECT SET TITLE:C194(*;"informes";"Informes no Editables")
		hl_Informes:=Copy list:C626(hl_Reports_4DFORMS)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";0)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";0)
		
		
	: (vtQR_CurrentReportType="gSR2")
		vtQR_ReportType:="Informe SuperReport"
		OBJECT SET TITLE:C194(*;"informes";"Informes SuperReport")
		hl_Informes:=Copy list:C626(hl_Reports_SRP)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";0)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";0)
		
		
	: (vtQR_CurrentReportType="4DSE")
		vtQR_ReportType:="Informe en Columnas"
		OBJECT SET TITLE:C194(*;"informes";"Informes en Columnas")
		hl_Informes:=Copy list:C626(hl_Reports_QR)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";0)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";0)
		
		
	: (vtQR_CurrentReportType="4DET")
		vtQR_ReportType:="Etiquetas"
		OBJECT SET TITLE:C194(*;"informes";"Etiquetas")
		hl_Informes:=Copy list:C626(hl_Reports_LB)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";0)
		
	: (vtQR_CurrentReportType="4DWR")
		vtQR_ReportType:="4D Write"
		OBJECT SET TITLE:C194(*;"informes";"4D Write")
		hl_Informes:=Copy list:C626(hl_Reports_WR)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";0)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";0)
		
	: (vtQR_CurrentReportType="4DVW")
		vtQR_ReportType:="4D View"
		OBJECT SET TITLE:C194(*;"informes";"4D View")
		hl_Informes:=Copy list:C626(hl_Reports_VW)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";0)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";Bold:K14:2)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";0)
		
	: (vtQR_CurrentReportType="4DCT")
		vtQR_ReportType:="4D Chart"
		OBJECT SET TITLE:C194(*;"informes";"4D Chart")
		hl_Informes:=Copy list:C626(hl_Reports_CT)
		OBJECT SET FONT STYLE:C166(*;"4DFO_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DSE_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DET_Title";0)
		OBJECT SET FONT STYLE:C166(*;"gSR2_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DWR_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DDW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DVW_Title";0)
		OBJECT SET FONT STYLE:C166(*;"4DCT_Title";Bold:K14:2)
		
	Else 
		hl_Informes:=New list:C375
End case 
SET LIST PROPERTIES:C387(hl_Informes;2;0;18)

If (Count parameters:C259=2)
	$l_IdInforme:=$2
Else 
	If (Count list items:C380(hl_Informes)>0)
		GET LIST ITEM:C378(hl_Informes;1;$l_IdInforme;$t_nombreInforme)
	Else 
		$l_IdInforme:=0
	End if 
End if 

If ($l_IdInforme#0)
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Informes;$l_IdInforme)
	QR_LoadSelectedReport 
Else 
	REDUCE SELECTION:C351([xShell_Reports:54];0)
End if 

SELECT LIST ITEMS BY POSITION:C381(hl_FavoriteReports;Count list items:C380(hl_FavoriteReports)+1)

