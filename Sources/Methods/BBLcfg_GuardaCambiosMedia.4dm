//%attributes = {}
  // BBLcfg_GuardaCambiosMedia()
  // Por: Alberto Bachler: 17/09/13, 12:46:30
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_sololectura)

  // cargo el registro de preferencias si estaba en solo lectura o si no estaba en memoria
$b_sololectura:=Read only state:C362([xxBBL_Preferencias:65])
If (($b_sololectura) | (Record number:C243([xxBBL_Preferencias:65])<0))
	ALL RECORDS:C47([xxBBL_Preferencias:65])
	READ WRITE:C146([xxBBL_Preferencias:65])
	FIRST RECORD:C50([xxBBL_Preferencias:65])
End if 

  // guardo las preferencias
SORT ARRAY:C229(<>atBBL_Media;<>alBBL_IDMedia;<>asBBL_AbrevMedia;>)
BLOB_Variables2Blob (->[xxBBL_Preferencias:65]Items_TipoDocumentos:31;0;-><>atBBL_Media;-><>asBBL_AbrevMedia;-><>alBBL_IDMedia;-><>vlBBL_MediaPorDefecto)
SAVE RECORD:C53([xxBBL_Preferencias:65])

If ($b_sololectura)
	KRL_UnloadReadOnly (->[xxBBL_Preferencias:65])
End if 

KRL_ExecuteEverywhere ("BBL_LeePrefsCodigosBarra")

