//%attributes = {}
  //CD_ReportProblem

C_TEXT:C284(vt_RepairMethod;$1;vt_Msg;$2;vt_text)
C_BLOB:C604($3;vx_Blob)

vt_Msg:=$2
vt_RepairMethod:=$1
If (Count parameters:C259=3)
	vx_Blob:=$3
	SET BLOB SIZE:C606($3;0)
End if 
WDW_OpenFormWindow (->[xShell_Dialogs:114];"CD_ReportProblem";10;-8;__ ("Reporte de incidente"))
DIALOG:C40([xShell_Dialogs:114];"CD_ReportProblem")
CLOSE WINDOW:C154

vt_Msg:=""
vbAutoRepairAllowed:=False:C215
SET BLOB SIZE:C606(vx_Blob;0)

$0:=0
If (bExecute=1)
	If (vt_RepairMethod="*")
		$0:=1
	Else 
		KRL_ExecuteMethod (vt_RepairMethod)
	End if 
End if 