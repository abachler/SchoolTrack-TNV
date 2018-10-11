//%attributes = {}
  //DIAP_ConfigCargaTipoExamen
C_POINTER:C301($y_id;$y_tipo;$1;$2)
$y_id:=$1
$y_tipo:=$2

C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)

$xBlob:=PREF_fGetBlob (0;"DIAP_TipoExamen";$xBlob)

If (BLOB size:C605($xBlob)>0)
	BLOB_Blob2Vars (->$xBlob;0;$y_id;$y_tipo)
	
Else 
	
	APPEND TO ARRAY:C911($y_id->;1)
	APPEND TO ARRAY:C911($y_tipo->;"Escrito")
	APPEND TO ARRAY:C911($y_id->;2)
	APPEND TO ARRAY:C911($y_tipo->;"Oral")
	
End if 
SORT ARRAY:C229($y_id->;$y_tipo->;>)
BLOB_Variables2Blob (->$xBlob;0;$y_id;$y_tipo)
PREF_SetBlob (0;"DIAP_TipoExamen";$xBlob)
SET BLOB SIZE:C606($xBlob;0)