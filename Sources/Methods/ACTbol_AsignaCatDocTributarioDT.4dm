//%attributes = {}
  // Método: ACTbol_AsignaCatDocTributarioDT
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 22-02-10, 19:12:29
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




C_BLOB:C604($xBlob)
ARRAY LONGINT:C221(al_idsBoletas;0)
ARRAY LONGINT:C221($al_idsNoProcesados;0)
C_LONGINT:C283(vl_exId)
C_LONGINT:C283(vl_newId)
$xBlob:=$1
BLOB_Blob2Vars (->$xBlob;0;->al_idsBoletas;->vl_exId;->vl_newId)

For ($i;1;Size of array:C274(al_idsBoletas))
	$vl_idBoleta:=al_idsBoletas{$i}
	$index:=Find in field:C653([ACT_Boletas:181]ID:1;$vl_idBoleta)
	If ($index#-1)
		READ WRITE:C146([ACT_Boletas:181])
		GOTO RECORD:C242([ACT_Boletas:181];$index)
		If ([ACT_Boletas:181]ID_Categoria:12=vl_exId)
			If (Not:C34(Locked:C147([ACT_Boletas:181])))
				[ACT_Boletas:181]ID_Categoria:12:=vl_newId
				SAVE RECORD:C53([ACT_Boletas:181])
			Else 
				APPEND TO ARRAY:C911($al_idsNoProcesados;al_idsBoletas{$i})
			End if 
		End if 
	End if 
End for 
If (Size of array:C274($al_idsNoProcesados)>0)
	COPY ARRAY:C226($al_idsNoProcesados;al_idsBoletas)
	BLOB_Variables2Blob (->$xBlob;0;->al_idsBoletas;->vl_exId;->vl_newId)
	BM_CreateRequest ("AsignaIDDocTribDts";"";"";$xBlob)
End if 
ARRAY LONGINT:C221(al_idsBoletas;0)

$0:=True:C214