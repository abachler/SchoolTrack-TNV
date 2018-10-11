C_BLOB:C604($blob)
$namePref:="ConcentraciónNotas.cl."+String:C10(vl_UltimoAgno)
SET BLOB SIZE:C606($blob;0)
BLOB_Variables2Blob (->$blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
PREF_SetBlob (0;$namePref;$blob)

vl_UltimoAgno:=al_AgnosConcentracion{al_AgnosConcentracion}
$namePref:="ConcentraciónNotas.cl."+String:C10(vl_UltimoAgno)
$blob:=PREF_fGetBlob (0;$namePref;$blob)
BLOB_Blob2Vars (->$blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)