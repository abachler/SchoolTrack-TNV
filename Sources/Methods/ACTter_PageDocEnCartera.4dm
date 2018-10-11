//%attributes = {}
C_LONGINT:C283($vl_tipoDoc)

If (Count parameters:C259>=1)
	$vl_tipoDoc:=$1
End if 
If ($vl_tipoDoc#1) & ($vl_tipoDoc#2)
	$vl_tipoDoc:=1
End if 
ACTpp_HabDesHabAcciones (False:C215)
AL_UpdateArrays (xALP_DocsenCartera;0)
ACTpp_LoadDocsenCartera ($vl_tipoDoc;"terceros")
AL_UpdateArrays (xALP_DocsenCartera;-2)
ACTdc_OnExplorerLoad (xALP_DocsenCartera;->aACT_ApdosDCarRecNum)
atACT_TipoDocumentoCartera:=1
vsACT_TipoDocumento:=atACT_TipoDocumentoCartera{1}
AL_SetLine (xALP_DocsenCartera;0)

$0:=1