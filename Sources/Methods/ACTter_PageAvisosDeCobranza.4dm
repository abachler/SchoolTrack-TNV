//%attributes = {}
C_TEXT:C284($vt_yearName)
If (Count parameters:C259=1)
	$vt_yearName:=$1
End if 
ACTter_InitVariablesForm ("avisos")
AL_UpdateArrays (xALP_Documentos;0)
AL_UpdateArrays (ALP_CargosXPagar;0)
ACTpp_LoadBoletas ($vt_yearName;"terceros")
AL_UpdateArrays (xALP_Documentos;-2)
AL_UpdateArrays (ALP_CargosXPagar;-2)
$0:=1