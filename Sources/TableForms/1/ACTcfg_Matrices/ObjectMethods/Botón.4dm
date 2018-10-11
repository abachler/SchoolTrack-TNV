C_POINTER:C301($vyQRY_TablePointer;vyQRY_TablePointer)
C_POINTER:C301(yBWR_currentTable;$yBWR_currentTable)
C_TEXT:C284(vsBWR_CurrentModule;$vsBWR_CurrentModule)

C_LONGINT:C283($l_matrixID)
$l_matrixID:=[ACT_Matrices:177]ID:1


$vyQRY_TablePointer:=vyQRY_TablePointer
vyQRY_TablePointer:=->[ACT_CuentasCorrientes:175]
$vsBWR_CurrentModule:=vsBWR_CurrentModule
vsBWR_CurrentModule:="AccountTrack"
$yBWR_currentTable:=yBWR_currentTable
yBWR_currentTable:=->[ACT_CuentasCorrientes:175]

WDW_OpenFormWindow (->[ACT_MatricesAsignacionAut:289];"Reglas";-1;4;"Reglas")
DIALOG:C40([ACT_MatricesAsignacionAut:289];"Reglas")
CLOSE WINDOW:C154

  //Se restauran valores de conf.
vyQRY_TablePointer:=$vyQRY_TablePointer
vsBWR_CurrentModule:=$vsBWR_CurrentModule
yBWR_currentTable:=$yBWR_currentTable

If ($l_matrixID>0)
	ACTcfg_loadMatrixItems ($l_matrixID)
End if 