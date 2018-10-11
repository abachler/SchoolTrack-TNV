C_LONGINT:C283($table)

$text:=CD_Request (__ ("Número de avisos por página (max. 4):");__ ("OK");__ ("Cancelar");__ ("");__ ("1"))
vlSR_RegXPagina:=Num:C11($text)
While ((OK=1) & ((vlSR_RegXPagina<1) | (vlSR_RegXPagina>4)))
	$text:=CD_Request (__ ("Número de avisos por página (max. 4):");__ ("OK");__ ("Cancelar");__ ("");__ ("1"))
	vlSR_RegXPagina:=Num:C11($text)
End while 
If (OK=1)
	vb_NotInReportEditor:=True:C214
	QR_NewSuperReportTemplate (->[ACT_Avisos_de_Cobranza:124];True:C214)
	ACTcfg_LoadAvModels 
	AL_UpdateArrays (xAL_ModelosAvisos;-2)
	ACTcfg_MarkStandardAvModels 
	If (Size of array:C274(atACT_ModelosAv)>0)
		AL_SetLine (xAL_ModelosAvisos;1)
		atACT_ModelosAv:=1
		cb_EsEstandar:=Num:C11(abACT_ModelosAvEsSt{1})
		_O_ENABLE BUTTON:C192(cb_EsEstandar)
	Else 
		AL_SetLine (xAL_ModelosAvisos;0)
		atACT_ModelosAv:=0
		cb_EsEstandar:=0
		_O_DISABLE BUTTON:C193(cb_EsEstandar)
	End if 
	IT_SetButtonState ((atACT_ModelosAv>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)
End if 