//%attributes = {}
  //DIAP_ConfigCargaIdiomas
C_POINTER:C301($y_id;$y_lengua;$1;$2)
C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)
$y_id:=$1
$y_lengua:=$2

$xBlob:=PREF_fGetBlob (0;"DIAP_LenguasMaternas";$xBlob)

If (BLOB size:C605($xBlob)>0)
	BLOB_Blob2Vars (->$xBlob;0;$y_id;$y_lengua)
Else 
	
	APPEND TO ARRAY:C911($y_id->;1)
	APPEND TO ARRAY:C911($y_lengua->;"Español")
	APPEND TO ARRAY:C911($y_id->;2)
	APPEND TO ARRAY:C911($y_lengua->;"Alemán")
	
End if 
SORT ARRAY:C229($y_id->;$y_lengua->;>)

BLOB_Variables2Blob (->$xBlob;0;$y_id;$y_lengua)
PREF_SetBlob (0;"DIAP_LenguasMaternas";$xBlob)
SET BLOB SIZE:C606($xBlob;0)