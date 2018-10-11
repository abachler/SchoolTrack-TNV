//%attributes = {}
  // BUILD_UploadUpdateInfos()
  // 
  //
  // creado por: Alberto Bachler Klein: 19-08-16, 18:55:50
  // -----------------------------------------------------------

C_OBJECT:C1216(ob_Upload_Context)

$t_usuario:="schooltrackapp"
$t_password:="pLqfr6NWzb"

$t_rutaDestinoAppInfo:="ftp://ftp.colegium.com/interno/desarrollo/autoupdate/"+BUILD_ArchivoInfoVersion+".json"
$t_rutaOrigenAppInfo:=Get 4D folder:C485(Current resources folder:K5:16)+BUILD_ArchivoInfoVersion+".json"



CLEAR VARIABLE:C89(ob_Upload_Context)
OB SET:C1220(ob_Upload_Context;\
"srcPath";$t_rutaOrigenAppInfo;"dstPath";$t_rutaDestinoAppInfo;\
"user";$t_usuario;"pass";$t_password;\
"onSuccess";"Upload_SUCCESS";\
"onError";"Upload_CANCEL")

Upload_WITH_PROGRESS (ob_Upload_Context)

