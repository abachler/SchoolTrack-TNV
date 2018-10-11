//%attributes = {}
  // Método: ACTbol_AsignaCatDocTributarioT
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 22-02-10, 18:35:27
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




C_BLOB:C604($xBlob)
ARRAY LONGINT:C221(al_idsTerceros;0)
ARRAY LONGINT:C221($al_idsNoProcesados;0)
C_LONGINT:C283(vl_exId)
C_LONGINT:C283(vl_newId)
$xBlob:=$1
BLOB_Blob2Vars (->$xBlob;0;->al_idsTerceros;->vl_exId;->vl_newId)

For ($i;1;Size of array:C274(al_idsTerceros))
	$vl_idTercero:=al_idsTerceros{$i}
	$index:=Find in field:C653([ACT_Terceros:138]Id:1;$vl_idTercero)
	If ($index#-1)
		READ WRITE:C146([ACT_Terceros:138])
		GOTO RECORD:C242([ACT_Terceros:138];$index)
		If ([ACT_Terceros:138]id_CatDocTrib:55=vl_exId)
			If (Not:C34(Locked:C147([ACT_Terceros:138])))
				[ACT_Terceros:138]id_CatDocTrib:55:=vl_newId
				SAVE RECORD:C53([ACT_Terceros:138])
			Else 
				APPEND TO ARRAY:C911($al_idsNoProcesados;al_idsTerceros{$i})
			End if 
		End if 
	End if 
End for 
If (Size of array:C274($al_idsNoProcesados)>0)
	COPY ARRAY:C226($al_idsNoProcesados;al_idsTerceros)
	BLOB_Variables2Blob (->$xBlob;0;->al_idsTerceros;->vl_exId;->vl_newId)
	BM_CreateRequest ("AsignaIDDocTribTercero";"";"";$xBlob)
End if 
ARRAY LONGINT:C221(al_idsTerceros;0)

$0:=True:C214