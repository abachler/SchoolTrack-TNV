//%attributes = {}
C_TEXT:C284($t_localPath)
C_OBJECT:C1216($o_curlOptions;$o_private)

  //$t_localPath:="Macintosh HD:Users:alberto:Desktop:app.zip"
$t_localPath:="C:\\Users\\Condor-Admin\\Desktop\\app.zip"

OB SET:C1220($o_private;\
"showProgress";True:C214;\
"callbackMethod";"FTPcurl_CallBack";\
"processNumber";Current process:C322;\
"windowId";Frontmost window:C447;\
"workerName";"";\
"workerMethod";""\
)

WS_GetFtpLoginInfo 
OB SET:C1220($o_curlOptions;\
"URL";"ftp://ftp.colegium.com//test.zip";\
"USERNAME";vtWS_ftpLoginName;\
"PASSWORD";vtWS_ftpPassword\
)


FTPcurl_Upload ($t_localPath;$o_curlOptions;$o_private)



