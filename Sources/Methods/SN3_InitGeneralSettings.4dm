//%attributes = {}
  //SN3_InitGeneralSettings

C_LONGINT:C283(SN3_EnvioActivado;SN3_Proxy_IsSocks;SN3_Proxy_ServerPort;SN3_SendFrom_Server;SN3_SendFrom_Workstation;SN3_FTP_Port;SN3_FTP_Passive;SN3_AccesoDesactivado)
C_TEXT:C284(SN3_eMailAdministrador;SN3_Proxy_Host;SN3_Proxy_UserID;SN3_SendFrom_SelectedWS;SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password)

SN3_EnvioActivado:=0
SN3_AccesoDesactivado:=0

SN3_eMailAdministrador:=""

SN3_Proxy_Host:=""
SN3_Proxy_UserID:=""
SN3_Proxy_IsSocks:=0
SN3_Proxy_ServerPort:=0

SN3_SendFrom_Server:=1
SN3_SendFrom_Workstation:=0
SN3_SendFrom_SelectedWS:=""

SN3_FTP_Server:="ftpsn3.colegium.com"
SN3_FTP_User:="sn3comm"
SN3_FTP_Password:="SN3comm8321"
SN3_FTP_Port:=21
  //SN3_FTP_Passive:=0
SN3_FTP_Passive:=1  //20170520 RCH

