If (Size of array:C274(alACT_Largo)>0)
	ACTcfg_CheckRRecuadDef 
End if 
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->vNombreModelo;->vl_LargoReg;->vl_TiposReg;->vt_CharFiller;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal;->vl_PreviosReg;->vl_PosterioresReg;->r1;->r2;->r3)
$NameModel:="["+atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}+"] "+vNombreModelo
PREF_SetBlob (0;$NameModel;xBlob)
$ref:=Create document:C266("")
If (ok=1)
	CLOSE DOCUMENT:C267($ref)
	BLOB TO DOCUMENT:C526(document;xBlob)
	If (ok=0)
		CD_Dlog (0;__ ("Se produjo un error durante la grabación del archivo."))
	End if 
End if 
SET BLOB SIZE:C606(xBlob;0)