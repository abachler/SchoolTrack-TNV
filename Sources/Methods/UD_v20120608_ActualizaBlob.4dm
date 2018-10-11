//%attributes = {}
  //UD_v20120608_ActualizaBlob 

If (ACT_AccountTrackInicializado )
	READ ONLY:C145([xxACT_Datos_de_Cierre:116])
	ALL RECORDS:C47([xxACT_Datos_de_Cierre:116])
	ARRAY LONGINT:C221($alACT_recNum;0)
	LONGINT ARRAY FROM SELECTION:C647([xxACT_Datos_de_Cierre:116];$alACT_recNum;"")
	For ($i;1;Size of array:C274($alACT_recNum))
		READ WRITE:C146([xxACT_Datos_de_Cierre:116])
		GOTO RECORD:C242([xxACT_Datos_de_Cierre:116];$alACT_recNum{$i})
		If ([xxACT_Datos_de_Cierre:116]CantidadDeCierres:5>0)
			C_LONGINT:C283(cb_inicializaUFields)
			cb_inicializaUFields:=1
			BLOB_Blob2Vars (->[xxACT_Datos_de_Cierre:116]xPreferences:2;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib;->cb_EliminaHAvisos;->cb_EliminaHPagos;->cb_EliminaHDocDep;->cb_EliminaHDocTrib;->cb_InactivaEgresados;->cb_InactivaRetirados;->cb_LimpiaMatrices;->cb_LimpiaDesctoXCta;->vt_backupFolder;->vt_backupFile;->vl_Mes;->vl_Año)
			BLOB_Variables2Blob (->[xxACT_Datos_de_Cierre:116]xPreferences:2;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib;->cb_EliminaHAvisos;->cb_EliminaHPagos;->cb_EliminaHDocDep;->cb_EliminaHDocTrib;->cb_InactivaEgresados;->cb_InactivaRetirados;->cb_LimpiaMatrices;->cb_LimpiaDesctoXCta;->vt_backupFolder;->vt_backupFile;->vl_Mes;->vl_Año;->cb_inicializaUFields)
			SAVE RECORD:C53([xxACT_Datos_de_Cierre:116])
		End if 
		KRL_UnloadReadOnly (->[xxACT_Datos_de_Cierre:116])
	End for 
End if 