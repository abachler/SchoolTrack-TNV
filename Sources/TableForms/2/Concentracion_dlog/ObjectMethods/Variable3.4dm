C_BLOB:C604($blob;xBlob)
$namePref:="ConcentraciónNotas.cl."+String:C10(vl_UltimoAgno)
SET BLOB SIZE:C606($blob;0)
BLOB_Variables2Blob (->$blob;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
PREF_SetBlob (0;$namePref;$blob)



BLOB_Variables2Blob (->xBlob;0;->sAltSchool1;->sAltSchool2;->sAltSchool3;->sAltSchool4;->sAltCity1;->sAltCity2;->sAltCity3;->sAltCity4;->sAltCoop1;->sAltCoop2;->sAltCoop3;->sAltCoop4;->sAltPlan1;->sAltPlan2;->sAltPlan3;->sAltPlan4;->vi_DecAsistencia;->vt_TituloConcentracion;->vl_OrdenAlfabetico)
PREF_SetBlob (0;"Decretos Concentraciones";xBlob)
SET BLOB SIZE:C606(xBlob;0)