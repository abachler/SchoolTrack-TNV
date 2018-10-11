//%attributes = {}
  //SN3_SaveGeneralSettings

C_BLOB:C604($settingsBlob)

$OT_Object:=OT New 
SN3_FTP_Passive:=1  //20170520 RCH
  //==========  GENERAL CONFIG  ==========

OT PutLong ($OT_Object;"envioActivado";SN3_EnvioActivado)
OT PutText ($OT_Object;"emailAdministrador";SN3_eMailAdministrador)
OT PutLong ($OT_Object;"accesoSN3desactivado";SN3_AccesoDesactivado)

  //==========  PROXY CONFIG  ==========

OT PutText ($OT_Object;"proxy_host";SN3_Proxy_Host)
OT PutText ($OT_Object;"proxy_user";SN3_Proxy_UserID)
OT PutLong ($OT_Object;"proxy_issocks";SN3_Proxy_IsSocks)
OT PutLong ($OT_Object;"proxy_serverport";SN3_Proxy_ServerPort)

  //==========  SEND FROM CONFIG  ==========

OT PutLong ($OT_Object;"sendFrom_server";SN3_SendFrom_Server)
OT PutLong ($OT_Object;"sendFrom_workstation";SN3_SendFrom_Workstation)
OT PutText ($OT_Object;"sendFrom_selectedWS";SN3_SendFrom_SelectedWS)

  //==========  FTP CONFIG  ==========

OT PutText ($OT_Object;"ftp_server";SN3_FTP_Server)
OT PutText ($OT_Object;"ftp_user";SN3_FTP_User)
OT PutText ($OT_Object;"ftp_pass";SN3_FTP_Password)
OT PutLong ($OT_Object;"ftp_port";SN3_FTP_Port)
OT PutLong ($OT_Object;"ftp_passive";SN3_FTP_Passive)

$settingsBlob:=OT ObjectToNewBLOB ($OT_Object)
OT Clear ($OT_Object)

PREF_SetBlob (0;"SN3GeneralSettings";$settingsBlob)

