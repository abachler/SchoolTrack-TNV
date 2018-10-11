$r:=CD_Dlog (0;__ ("Los cambios realizados desde la última grabación se perderán. \r\r¿Desea proseguir?");__ ("");__ ("No");__ ("Si"))
If ($r=2)
	vNombreModelo:=""
	AL_UpdateArrays (xALP_RecepRecaud;0)
	AT_Initialize (->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
	vt_CharFiller:=""
	vl_LargoReg:=0
	vl_TiposReg:=0
	vl_PreviosReg:=0
	vl_PosterioresReg:=0
	AL_UpdateArrays (xALP_RecepRecaud;-2)
	IT_SetButtonState (False:C215;->bInsertLine;->bDeleteLine;->bTestImport;->bSaveDef;->bLoadDef;->bDeleteModelo;->bSave)
	IT_SetEnterable (False:C215;0;->vl_TiposReg;->vl_LargoReg;->vt_CharFiller;->vl_PreviosReg;->vl_PosterioresReg)
	modificado:=False:C215
End if 