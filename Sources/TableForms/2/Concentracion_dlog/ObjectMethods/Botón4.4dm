C_BLOB:C604($blob;xBlob)
$namePref:="ConcentraciónNotas.cl."+String:C10(vl_UltimoAgno)
SET BLOB SIZE:C606($blob;0)
BLOB_Variables2Blob (->$blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
PREF_SetBlob (0;$namePref;$blob)
FORM GOTO PAGE:C247(1)