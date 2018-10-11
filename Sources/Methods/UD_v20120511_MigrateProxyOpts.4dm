//%attributes = {}
SN3_LoadGeneralSettings 
WEB_LoadSettings 
<>web_proxy_ftp_host:=SN3_Proxy_Host
<>web_proxy_ftp_issocks:=SN3_Proxy_IsSocks
<>web_proxy_ftp_puerto:=String:C10(SN3_Proxy_ServerPort)
<>web_proxy_ftp_userid:=SN3_Proxy_UserID
<>ftp_UsePassive:=SN3_FTP_Passive

WEB_SaveSettings 