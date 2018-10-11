$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
BLOB_Variables2Blob (->$blob;0;->at_DatosUnidadesEduc_Values)
PREF_SetBlob (0;$prefRecord;$blob)
CANCEL:C270