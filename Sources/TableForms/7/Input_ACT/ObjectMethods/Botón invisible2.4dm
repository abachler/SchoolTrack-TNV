$tipoDocumento:=AT_array2text (->atACT_TipoDocumentoCartera)
$choice:=Pop up menu:C542($tipoDocumento)
If ($choice#0)
	atACT_TipoDocumentoCartera:=$choice
	vsACT_TipoDocumento:=atACT_TipoDocumentoCartera{$choice}
	AL_UpdateArrays (xALP_DocsenCartera;0)
	ACTpp_LoadDocsenCartera ($choice)
	AL_UpdateArrays (xALP_DocsenCartera;-2)
	AL_SetLine (xALP_DocsenCartera;0)
	ACTpp_HabDesHabAcciones (False:C215)
End if 