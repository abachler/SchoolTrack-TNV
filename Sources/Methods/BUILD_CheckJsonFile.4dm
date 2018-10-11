//%attributes = {}
  // BUILD_CheckJsonFile()
  // 
  //
  // creado por: Alberto Bachler Klein: 26-07-16, 20:41:25
  // -----------------------------------------------------------

$t_ruta:=Get 4D folder:C485(Current resources folder:K5:16)+"SchoolTrackInfo.json"
If (Test path name:C476($t_ruta)#Is a document:K24:1)
	$t_dts:=""
	$t_version:=""
	$o_appInfo:=OB_Create 
	OB_SET ($o_appInfo;->$t_dts;"tsGeneracion")
	OB_SET ($o_appInfo;->$t_version;"version")
	OB_ObjectToJsonDocument ($o_appInfo;$t_ruta;True:C214)
End if 