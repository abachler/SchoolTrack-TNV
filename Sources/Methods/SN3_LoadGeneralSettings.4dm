//%attributes = {}
  //SN3_LoadGeneralSettings

C_BLOB:C604($settingsBlob)

  //==========  CREAMOS UNA CONFIGURACION GENERICA PARA LA PRIMERA VEZ  ==========

SN3_InitGeneralSettings 

$OT_Object:=OT New 

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

  //==========  FIN CONFIG. GENERICA  ==========

$settingsBlob:=PREF_fGetBlob (0;"SN3GeneralSettings";$settingsBlob)

$OT_Object:=OT BLOBToObject ($settingsBlob)

  //==========  GENERAL CONFIG  ==========

SN3_EnvioActivado:=OT GetLong ($OT_Object;"envioActivado")
SN3_AccesoDesactivado:=OT GetLong ($OT_Object;"accesoSN3desactivado")
SN3_eMailAdministrador:=OT GetText ($OT_Object;"emailAdministrador")

  //==========  PROXY CONFIG  ==========

SN3_Proxy_Host:=OT GetText ($OT_Object;"proxy_host")
SN3_Proxy_UserID:=OT GetText ($OT_Object;"proxy_user")
SN3_Proxy_IsSocks:=OT GetLong ($OT_Object;"proxy_issocks")
SN3_Proxy_ServerPort:=OT GetLong ($OT_Object;"proxy_serverport")

  //==========  SEND FROM CONFIG  ==========

SN3_SendFrom_Server:=OT GetLong ($OT_Object;"sendFrom_server")
SN3_SendFrom_Workstation:=OT GetLong ($OT_Object;"sendFrom_workstation")
SN3_SendFrom_SelectedWS:=OT GetText ($OT_Object;"sendFrom_selectedWS")

  //==========  FTP CONFIG  ==========

SN3_FTP_Server:=OT GetText ($OT_Object;"ftp_server")
SN3_FTP_User:=OT GetText ($OT_Object;"ftp_user")
SN3_FTP_Password:=OT GetText ($OT_Object;"ftp_pass")
SN3_FTP_Port:=OT GetLong ($OT_Object;"ftp_port")
  //SN3_FTP_Passive:=OT GetLong ($OT_Object;"ftp_passive")
SN3_FTP_Passive:=1  //20170520 RCH

OT Clear ($OT_Object)

  // 20010702 RCH En algunas bases las 2 preferencias estan en 0...
If ((SN3_SendFrom_Server=0) & (SN3_SendFrom_Workstation=0))
	SN3_SendFrom_Server:=1
End if 