//%attributes = {}
C_TEXT:C284($vt_yearHist)
If (Count parameters:C259>=1)
	$vt_yearHist:=$1
End if 
ACTpp_HabDesHabAcciones (False:C215)
AL_UpdateArrays (xALP_DocsDepositados;0)
ACTpp_LoadDocsDepositados ($vt_yearHist;->[ACT_Terceros:138]Id:1)
AL_UpdateArrays (xALP_DocsDepositados;-2)
AL_SetLine (xALP_DocsDepositados;0)
$0:=1