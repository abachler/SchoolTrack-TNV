//%attributes = {}
  //QR_DuplicateTemplate

GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$CurrentReportName)
KRL_GotoRecord (->[xShell_Reports:54];$recNum)


$name:=ST_GetUnicName (2;->hl_Informes;[xShell_Reports:54]ReportName:26)
DUPLICATE RECORD:C225([xShell_Reports:54])
[xShell_Reports:54]ID:7:=0
[xShell_Reports:54]UUID:47:=Generate UUID:C1066
[xShell_Reports:54]Propietary:9:=<>lUSR_CurrentUserID
[xShell_Reports:54]ReportName:26:=$name
[xShell_Reports:54]Public:8:=False:C215
[xShell_Reports:54]UUID_institucion:33:=""
[xShell_Reports:54]IsStandard:38:=False:C215
[xShell_Reports:54]DTS_Repositorio:45:=""
[xShell_Reports:54]timestampISO_repositorio:37:=""
[xShell_Reports:54]EnRepositorio:48:=False:C215
[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
SAVE RECORD:C53([xShell_Reports:54])
$recNum:=Record number:C243([xShell_Reports:54])

atQR_filter:=4

Case of 
	: ([xShell_Reports:54]ReportType:2="4DFO")  // 4D Form
		$icon:=Use PicRef:K28:4+27513
	: ([xShell_Reports:54]ReportType:2="gSR2")  // SuperReport
		$icon:=Use PicRef:K28:4+27512
		APPEND TO LIST:C376(hl_Reports_SRP;$name;$recNum)
		SET LIST ITEM PROPERTIES:C386(hl_Reports_SRP;$recNum;True:C214;0;$icon)
		SORT LIST:C391(hl_Reports_SRP;>)
		_O_REDRAW LIST:C382(hl_Reports_SRP)
	: ([xShell_Reports:54]ReportType:2="4DSE")  //Quick Report
		$icon:=Use PicRef:K28:4+27514
		APPEND TO LIST:C376(hl_Reports_QR;$name;$recNum)
		SET LIST ITEM PROPERTIES:C386(hl_Reports_QR;$recNum;True:C214;0;$icon)
		SORT LIST:C391(hl_Reports_QR;>)
		_O_REDRAW LIST:C382(hl_Reports_QR)
	: ([xShell_Reports:54]ReportType:2="4DET")  //Etiquetas
		$icon:=Use PicRef:K28:4+27516
		APPEND TO LIST:C376(hl_Reports_LB;$name;$recNum)
		SET LIST ITEM PROPERTIES:C386(hl_Reports_LB;$recNum;True:C214;0;$icon)
		SORT LIST:C391(hl_Reports_LB;>)
		_O_REDRAW LIST:C382(hl_Reports_LB)
	: ([xShell_Reports:54]ReportType:2="4DVW")  //4D View
		$icon:=Use PicRef:K28:4+27514
		APPEND TO LIST:C376(hl_Reports_VW;$name;$recNum)
		SET LIST ITEM PROPERTIES:C386(hl_Reports_VW;$recNum;True:C214;0;$icon)
		SORT LIST:C391(hl_Reports_VW;>)
		_O_REDRAW LIST:C382(hl_Reports_VW)
	: ([xShell_Reports:54]ReportType:2="4DWR")  // 4D Write
		$icon:=Use PicRef:K28:4+27512
		APPEND TO LIST:C376(hl_Reports_WR;$name;$recNum)
		SET LIST ITEM PROPERTIES:C386(hl_Reports_WR;$recNum;True:C214;0;$icon)
		SORT LIST:C391(hl_Reports_WR;>)
		_O_REDRAW LIST:C382(hl_Reports_WR)
End case 

KRL_ReloadAsReadOnly (->[xShell_Reports:54])

APPEND TO LIST:C376(hl_informes;$name;$recNum)
SET LIST ITEM PROPERTIES:C386(hl_informes;$recNum;True:C214;0;$icon)
SORT LIST:C391(hl_informes;>)
_O_REDRAW LIST:C382(hl_informes)
SELECT LIST ITEMS BY REFERENCE:C630(hl_Informes;$recNum)


QR_LoadSelectedReport 