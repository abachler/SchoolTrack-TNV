//%attributes = {}
  //UD_v20110907_EliminaSR

C_LONGINT:C283($proc)

$proc:=IT_UThermometer (1;0;"Verificando Reportes...")
READ WRITE:C146([xShell_Reports:54])

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=0;*)
QUERY:C277([xShell_Reports:54]; | ;[xShell_Reports:54]ReportName:26="")
CREATE SET:C116([xShell_Reports:54];"REP1")

QUERY BY FORMULA:C48([xShell_Reports:54];BLOB size:C605([xShell_Reports:54]xReportData_:29)=0)
CREATE SET:C116([xShell_Reports:54];"REP2")
UNION:C120("REP1";"REP2";"REP3")
USE SET:C118("REP3")

QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]IsStandard:38=False:C215;*)
QUERY SELECTION:C341([xShell_Reports:54]; & ;[xShell_Reports:54]ReportType:2="gSR2";*)
QUERY SELECTION:C341([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7>0)

SET_ClearSets ("REP1";"REP2";"REP3")

DELETE SELECTION:C66([xShell_Reports:54])
KRL_ReloadAsReadOnly (->[xShell_Reports:54])

IT_UThermometer (-2;$proc)