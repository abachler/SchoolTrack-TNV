//%attributes = {"executedOnServer":true}
  // BKP_GuardaPlanBackup()
  // Por: Alberto Bachler K.: 06-04-15, 08:38:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_planRespaldo_json;$t_rutaPlanBackup;$t_uuidDatabase)


If (False:C215)
	C_TEXT:C284(BKP_GuardaPlanBackup ;$1)
	C_TEXT:C284(BKP_GuardaPlanBackup ;$2)
End if 

$t_uuidDatabase:=$1
$t_planRespaldo_json:=$2

$t_rutaCarpetaPrefBackup:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"Backup"+SYS_FolderDelimiterOnServer 
If (Test path name:C476($t_rutaCarpetaPrefBackup)#Is a folder:K24:2)
	SYS_CreaCarpetaServidor ($t_rutaCarpetaPrefBackup)
End if 


$t_rutaPlanBackup:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"BackupPlan-"+$t_uuidDatabase+".json"


TEXT TO BLOB:C554($t_planRespaldo_json;$x_blob;UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($t_rutaPlanBackup;$x_blob)