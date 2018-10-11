//%attributes = {}
  //BWR_LoadFormReportsArrays

C_POINTER:C301($1;$filePointer)
If (Count parameters:C259=1)
	$filePointer:=$1
Else 
	$filePointer:=yBWR_currentTable
End if 

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252($filePointer);*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]isOneRecordReport:11;=;True:C214)

QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]CountryCode:1;=;<>vtXS_CountryCode;*)
QUERY SELECTION:C341([xShell_Reports:54]; | ;[xShell_Reports:54]CountryCode:1;=;"")


ARRAY TEXT:C222(atQR_FormReportNames;0)
ARRAY TEXT:C222(atQR_FormReportTypes;0)
ARRAY LONGINT:C221(alQR_FormReportRecNums;0)

SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atQR_FormReportNames;[xShell_Reports:54];alQR_FormReportRecNums)
SELECTION TO ARRAY:C260([xShell_Reports:54]ReportType:2;atQR_FormReportTypes)
SORT ARRAY:C229(atQR_FormReportNames;alQR_FormReportRecNums;atQR_FormReportTypes;>)


$folderIcon:=Use PicRef:K28:4+27511
$srpIcon:=Use PicRef:K28:4+27512
$nonEditIcon:=Use PicRef:K28:4+27513
$QRIcon:=Use PicRef:K28:4+27514
$labelIcon:=Use PicRef:K28:4+27516

hl_reportsList:=New list:C375
hl_reportsList:=AT_Array2ReferencedList (->atQR_FormReportNames;->alQR_FormReportRecNums;hl_reportsList)
For ($i;1;Size of array:C274(atQR_FormReportNames))
	Case of 
		: (atQR_FormReportTypes{$i}="4DSE")
			SET LIST ITEM PROPERTIES:C386(hl_reportsList;alQR_FormReportRecNums{$i};False:C215;0;$QRIcon)
		: (atQR_FormReportTypes{$i}="4DFO")
			SET LIST ITEM PROPERTIES:C386(hl_reportsList;alQR_FormReportRecNums{$i};False:C215;0;$nonEditIcon)
		: (atQR_FormReportTypes{$i}="gSR2")
			SET LIST ITEM PROPERTIES:C386(hl_reportsList;alQR_FormReportRecNums{$i};False:C215;0;$srpIcon)
		: (atQR_FormReportTypes{$i}="4DET")
			SET LIST ITEM PROPERTIES:C386(hl_reportsList;alQR_FormReportRecNums{$i};False:C215;0;$labelIcon)
	End case 
End for 
SET LIST PROPERTIES:C387(hl_reportsList;2;0;18)
_O_REDRAW LIST:C382(hl_reportsList)


