Modelos:=AT_array2text (->atACT_ModelosBancoLimpio)
$choice:=Pop up menu:C542(Modelos)

If ($choice>0)
	If (modificado)
		$grabar:=CD_Dlog (0;__ ("¿Desea guardar el modelo para este banco?");__ ("");__ ("Si");__ ("No"))
		If ($grabar=1)
			If (Size of array:C274(alACT_Largo)>0)
				ACTcfg_CheckRRecuadDef 
			End if 
			SET BLOB SIZE:C606(xBlob;0)
			BLOB_Variables2Blob (->xBlob;0;->vNombreModelo;->vl_LargoReg;->vl_TiposReg;->vt_CharFiller;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal;->vl_PreviosReg;->vl_PosterioresReg;->r1;->r2;->r3)
			$NameModel:="["+atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}+"] "+vNombreModelo
			PREF_SetBlob (0;$NameModel;xBlob)
			SET BLOB SIZE:C606(xBlob;0)
		End if 
	End if 
	
	AL_UpdateArrays (xALP_RecepRecaud;0)
	AT_Initialize (->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
	vt_CharFiller:=""
	vl_LargoReg:=0
	vl_TiposReg:=0
	vl_PreviosReg:=0
	vl_PosterioresReg:=0
	
	SET BLOB SIZE:C606(xBlob;0)
	xBlob:=PREF_fGetBlob (0;atACT_ModelosBanco{$choice};xBlob)
	BLOB_Blob2Vars (->xBlob;0;->vNombreModelo;->vl_LargoReg;->vl_TiposReg;->vt_CharFiller;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal;->vl_PreviosReg;->vl_PosterioresReg;->r1;->r2;->r3)
	SET BLOB SIZE:C606(xBlob;0)
	
	alACT_Campo{0}:=0
	atACT_Descripcion{0}:=""
	alACT_Largo{0}:=0
	atACT_Tipo{0}:=""
	atACT_Posicion{0}:=""
	atACT_Correspondencia{0}:=""
	alACT_PosIni{0}:=0
	alACT_PosFinal{0}:=0
	
	AL_UpdateArrays (xALP_RecepRecaud;-2)
	ALP_SetAlternateLigneColor (xALP_RecepRecaud;Size of array:C274(alACT_Campo))
	ARRAY LONGINT:C221(alACT_FillerPositions;0)
	$j:=1
	$filler:=Find in array:C230(atACT_Descripcion;"Filler")
	
	While ($filler#-1)
		INSERT IN ARRAY:C227(alACT_FillerPositions;Size of array:C274(alACT_FillerPositions)+1;1)
		alACT_FillerPositions{$j}:=$filler
		$j:=$j+1
		$filler:=Find in array:C230(atACT_Descripcion;"Filler";$filler+1)
	End while 
	For ($i;1;Size of array:C274(alACT_FillerPositions))
		AL_SetRowStyle (xALP_RecepRecaud;alACT_FillerPositions{$i};1;"")
		AL_SetRowColor (xALP_RecepRecaud;alACT_FillerPositions{$i};"";7;"";0)
	End for 
	AL_UpdateArrays (xALP_RecepRecaud;-2)
	ALP_SetAlternateLigneColor (xALP_RecepRecaud;Size of array:C274(alACT_Campo))
	If ((vt_CharFiller="") | (vl_LargoReg=0) | (vl_TiposReg=0))
		_O_DISABLE BUTTON:C193(bInsertLine)
		_O_DISABLE BUTTON:C193(bDeleteLine)
		_O_DISABLE BUTTON:C193(bTestImport)
		_O_DISABLE BUTTON:C193(bSaveDef)
	Else 
		_O_ENABLE BUTTON:C192(bInsertLine)
		_O_ENABLE BUTTON:C192(bDeleteLine)
		_O_ENABLE BUTTON:C192(bSaveDef)
		If (Size of array:C274(alACT_Campo)>0)
			_O_ENABLE BUTTON:C192(bTestImport)
		End if 
	End if 
	_O_ENABLE BUTTON:C192(bLoadDef)
	_O_ENABLE BUTTON:C192(bDeleteModelo)
	OBJECT SET ENTERABLE:C238(vl_TiposReg;True:C214)
	OBJECT SET ENTERABLE:C238(vl_LargoReg;True:C214)
	OBJECT SET ENTERABLE:C238(vt_CharFiller;True:C214)
	OBJECT SET ENTERABLE:C238(vl_PreviosReg;True:C214)
	OBJECT SET ENTERABLE:C238(vl_PosterioresReg;True:C214)
	OBJECT SET ENTERABLE:C238(vNombreModelo;True:C214)
	modificado:=False:C215
	_O_DISABLE BUTTON:C193(bSave)
End if 