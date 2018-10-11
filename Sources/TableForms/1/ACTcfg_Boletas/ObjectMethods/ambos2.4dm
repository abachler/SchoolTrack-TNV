C_LONGINT:C283($table)
$text:=CD_Request (__ ("Número de Documentos Tributarios por página (max. 4):");__ ("OK");__ ("Cancelar");__ ("");__ ("1"))
vlSR_RegXPagina:=Num:C11($text)
While ((OK=1) & ((vlSR_RegXPagina<1) | (vlSR_RegXPagina>4)))
	$text:=CD_Request (__ ("Número de Documentos Tributarios por página (max. 4):");__ ("OK");__ ("Cancelar");__ ("");__ ("1"))
	vlSR_RegXPagina:=Num:C11($text)
End while 
If (OK=1)
	vb_NotInReportEditor:=True:C214
	QR_NewSuperReportTemplate (->[ACT_Boletas:181];True:C214)
	ACTcfg_LeeConfEnNuevoProc ("GuardaConfiguracion")
	ACTcfg_LoadBolModels 
	AL_UpdateArrays (xAL_Modelos;-2)
	  //ACTcfg_LoadConfigData (8)
	ACTcfg_LoadBolModels 
	xALPSet_ACT_TiposdeDoc 
	ACTcfg_MarkStandardDTModels 
	If (Size of array:C274(atACT_ModelosDoc)>0)
		AL_SetLine (xAL_Modelos;1)
		atACT_ModelosDoc:=1
		cb_EsEstandar:=Num:C11(abACT_ModelosEsSt{1})
		_O_ENABLE BUTTON:C192(cb_EsEstandar)
	Else 
		AL_SetLine (xAL_Modelos;0)
		atACT_ModelosDoc:=0
		cb_EsEstandar:=0
		_O_DISABLE BUTTON:C193(cb_EsEstandar)
	End if 
	IT_SetButtonState ((atACT_ModelosDoc>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)
End if 