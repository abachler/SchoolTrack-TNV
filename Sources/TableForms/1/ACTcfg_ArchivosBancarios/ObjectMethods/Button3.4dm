SET BLOB SIZE:C606(xBlob;0)
$ref:=Open document:C264("")

If (ok=1)
	CLOSE DOCUMENT:C267($ref)
	DOCUMENT TO BLOB:C525(document;xBlob)
	If (ok=0)
		CD_Dlog (0;__ ("Se produjo un error durante la lectura del archivo."))
		SET BLOB SIZE:C606(xBlob;0)
	Else 
		vl_LargoReg:=0
		vl_TiposReg:=0
		vt_CharFiller:=""
		vl_PreviosReg:=0
		vl_PosterioresReg:=0
		AL_UpdateArrays (xALP_RecepRecaud;0)
		
		AT_Initialize (->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
		BLOB_Blob2Vars (->xBlob;0;->vNombreModelo;->vl_LargoReg;->vl_TiposReg;->vt_CharFiller;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal;->vl_PreviosReg;->vl_PosterioresReg)
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
		IT_SetButtonState ((Not:C34((vt_CharFiller="") | (vl_LargoReg=0) | (vl_TiposReg=0)));->bInsertLine;->bDeleteLine;->bSaveDef)
		If ((vt_CharFiller="") | (vl_LargoReg=0) | (vl_TiposReg=0))
			_O_DISABLE BUTTON:C193(bTestImport)
		Else 
			If (Size of array:C274(alACT_Campo)>0)
				_O_ENABLE BUTTON:C192(bTestImport)
			End if 
		End if 
		modificado:=True:C214
		_O_ENABLE BUTTON:C192(bSave)
	End if 
End if 