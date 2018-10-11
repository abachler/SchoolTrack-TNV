Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		ACTinit_LoadPrefs 
		INSERT IN ARRAY:C227(atACT_TiposDato;1;4)
		atACT_TiposDato{1}:="N"
		atACT_TiposDato{2}:="AN"
		atACT_TiposDato{3}:="F"
		atACT_TiposDato{4}:="H"
		xALP_ACT_RecepRecaud 
		vt_CharFiller:=""
		vl_LargoReg:=0
		vl_TiposReg:=0
		vl_PreviosReg:=0
		vl_PosterioresReg:=0
		vtACT_BancoNombre:=""
		vtACT_BancoCodigo:=""
		vNombreModelo:=""
		NewFiller:=False:C215
		modificado:=False:C215
		vLastRow:=0
		vLastCol:=0
		alACT_Campo{0}:=0
		atACT_Descripcion{0}:=""
		alACT_Largo{0}:=0
		atACT_TipoDato{0}:=""
		atACT_Posicion{0}:=""
		atACT_Correspondencia{0}:=""
		alACT_PosIni{0}:=0
		alACT_PosFinal{0}:=0
		IT_SetButtonState (False:C215;->bInsertLine;->bDeleteLine;->bTestImport;->bSaveDef;->bLoadDef;->bModelos;->bDeleteModelo;->bSave)
		IT_SetEnterable (False:C215;0;->vl_TiposReg;->vl_LargoReg;->vt_CharFiller;->vl_PreviosReg;->vl_PosterioresReg;->vNombreModelo)
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
