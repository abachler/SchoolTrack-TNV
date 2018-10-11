//%attributes = {"executedOnServer":true}
  // BUILD_LoadAutoupdateInfo()
  //
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 20:15:19
  // -----------------------------------------------------------
C_OBJECT:C1216($0)

C_TEXT:C284($t_rutaCarpetaAutoUpdates;$t_rutaInfoAutoUpdate)
C_OBJECT:C1216($ob_autoupdateInfos)


If (False:C215)
	C_OBJECT:C1216(BUILD_LoadAutoupdateInfo ;$0)
End if 

$t_rutaCarpetaAutoUpdates:=Get 4D folder:C485(Active 4D Folder:K5:10)+"SchoolTrack-Autoupdate"
SYS_CreaCarpetaServidor ($t_rutaCarpetaAutoUpdates)
$t_rutaInfoAutoUpdate:=$t_rutaCarpetaAutoUpdates+Folder separator:K24:12+"SchoolTrackInfo.json"

OB_JsonDocumentToObject ($t_rutaInfoAutoUpdate;->$ob_autoupdateInfos)

$0:=$ob_autoupdateInfos