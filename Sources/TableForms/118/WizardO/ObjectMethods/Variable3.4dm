Case of 
	: (vi_PageNumber=1)
		vi_NoPagina:=1
		vi_PageNumber:=1
	: (vi_PageNumber=2)
		vi_NoPagina:=1
		vi_PageNumber:=1
	: (vi_PageNumber=3)
		vi_NoPagina:=2
		vi_PageNumber:=2
	: (vi_PageNumber=4)
		vi_NoPagina:=3
		vi_PageNumber:=3
	: (vi_PageNumber=5)
		AL_SetLine (xALP_ExportBankFilesH;1)
		vi_NoPagina:=4
		vi_PageNumber:=4
	: (vi_PageNumber=6)
		AL_SetLine (xALP_ExportBankFilesF;1)
		vi_NoPagina:=5
		vi_PageNumber:=5
	: (vi_PageNumber=7)
		AL_SetLine (xALP_ExportBankFiles;1)
		vi_NoPagina:=6
		vi_PageNumber:=6
End case 

Case of 
	: (bto_Exportacion=1)
		Case of 
			: (vi_PageNumber=3)
				If (PWTrf_Pac1=1)
					vi_PageNumber:=2
					vi_NoPagina:=2
				End if 
			: (vi_PageNumber=5)
				xALP_ACT_ExportBankFiles (1)
				IT_SetButtonState ((cs_encabezado=1);->bInsertLine)
			: (vi_PageNumber=6)
				xALP_ACT_ExportBankFiles (2)
				IT_SetButtonState ((cs_registroControl=1);->bInsertLine)
		End case 
	: (bto_Importacion=1)
		If (vi_PageNumber=2)
			vb_testImport:=False:C215
		End if 
End case 
If (vi_PageNumber=1)
	_O_ENABLE BUTTON:C192(bNext)
	_O_DISABLE BUTTON:C193(bPrev)
Else 
	If ((vi_PageNumber=3) & ((WTrf_tb3=1) | (WTrf_ac3=1)) & (bto_Exportacion=1))
		_O_ENABLE BUTTON:C192(bNext)
		_O_DISABLE BUTTON:C193(bPrev)
	Else 
		If (((vi_PageNumber=5) & ((WTrf_tb3=1) | (WTrf_ac3=1))) | ((vi_PageNumber=5) & (Size of array:C274(al_Numero)>0)) & (bto_Exportacion=1))
			_O_DISABLE BUTTON:C193(bPrev)
		Else 
			_O_ENABLE BUTTON:C192(bPrev)
		End if 
	End if 
End if 
FORM GOTO PAGE:C247(vi_PageNumber)