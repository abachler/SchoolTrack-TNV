If (bto_Exportacion=1)
	AL_SetLine (xALP_ExportBankFiles;1)
	vi_NoPagina:=6
	vi_PageNumber:=6
	_O_ENABLE BUTTON:C192(bPrev)
	FORM GOTO PAGE:C247(vi_PageNumber)
Else 
	AL_SetLine (xALP_ImportPagos;1)
	vb_modificadoTf:=False:C215
	vi_NoPagina:=4
	vi_PageNumber:=4
	_O_ENABLE BUTTON:C192(bPrev)
	FORM GOTO PAGE:C247(vi_PageNumber)
End if 