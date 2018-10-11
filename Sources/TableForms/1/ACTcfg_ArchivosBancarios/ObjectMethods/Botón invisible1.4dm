$OldBankID:=vtACT_BancoCodigo
Bancos:=AT_array2text (->atACT_BankName)
$choice:=Pop up menu:C542(Bancos)

If ($choice>0)
	If (modificado)
		$grabar:=CD_Dlog (0;__ ("¿Desea guardar el modelo para este banco?");__ ("");__ ("Si");__ ("No"))
		If ($grabar=1)
			If (Size of array:C274(alACT_Largo)>0)
				ACTcfg_CheckRRecuadDef 
			End if 
			SET BLOB SIZE:C606(xBlob;0)
			BLOB_Variables2Blob (->xBlob;0;->vNombreModelo;->vl_LargoReg;->vl_TiposReg;->vt_CharFiller;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal;->vl_PreviosReg;->vl_PosterioresReg;->r1;->r2;->r3)
			$NameModel:="["+vtACT_BancoCodigo+"] "+vNombreModelo
			PREF_SetBlob (0;$NameModel;xBlob)
			SET BLOB SIZE:C606(xBlob;0)
		End if 
		modificado:=False:C215
		_O_DISABLE BUTTON:C193(bSave)
	End if 
	ARRAY TEXT:C222(atACT_ModelosBanco;0)
	ARRAY TEXT:C222(atACT_ModelosBancoLimpio;0)
	vtACT_BancoNombre:=atACT_BankName{$choice}
	vtACT_BancoCodigo:=atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}
	READ ONLY:C145([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="@["+vtACT_BancoCodigo+"]@")
	If (Records in selection:C76([xShell_Prefs:46])>0)
		SELECTION TO ARRAY:C260([xShell_Prefs:46];$RecNumPrefs)
		SELECTION TO ARRAY:C260([xShell_Prefs:46]Reference:1;atACT_ModelosBanco)
		INSERT IN ARRAY:C227(atACT_ModelosBancoLimpio;Size of array:C274(atACT_ModelosBancoLimpio)+1;Records in selection:C76([xShell_Prefs:46]))
		For ($i;1;Size of array:C274($RecNumPrefs))
			GOTO RECORD:C242([xShell_Prefs:46];$RecNumPrefs{$i})
			atACT_ModelosBancoLimpio{$i}:=Substring:C12([xShell_Prefs:46]Reference:1;Position:C15(" ";[xShell_Prefs:46]Reference:1)+1)
		End for 
		_O_ENABLE BUTTON:C192(bModelos)
		SORT ARRAY:C229(atACT_ModelosBancoLimpio;atACT_ModelosBanco;>)
	Else 
		ARRAY TEXT:C222(atACT_ModelosBanco;0)
		ARRAY TEXT:C222(atACT_ModelosBancoLimpio;0)
		_O_DISABLE BUTTON:C193(bModelos)
		vNombreModelo:=""
		AL_UpdateArrays (xALP_RecepRecaud;0)
		AT_Initialize (->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
		vt_CharFiller:=""
		vl_LargoReg:=0
		vl_TiposReg:=0
		vl_PreviosReg:=0
		vl_PosterioresReg:=0
		AL_UpdateArrays (xALP_RecepRecaud;-2)
		IT_SetButtonState (False:C215;->bInsertLine;->bDeleteLine;->bTestImport;->bSaveDef;->bLoadDef;->bModelos;->bDeleteModelo)
		IT_SetEnterable (False:C215;0;->vl_TiposReg;->vl_LargoReg;->vt_CharFiller;->vl_PreviosReg;->vl_PosterioresReg)
	End if 
	OBJECT SET ENTERABLE:C238(vNombreModelo;True:C214)
End if 