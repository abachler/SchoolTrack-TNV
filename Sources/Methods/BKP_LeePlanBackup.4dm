//%attributes = {"executedOnServer":true}
  // BKP_LeePlanBackup()
  // Por: Alberto Bachler K.: 06-04-15, 08:43:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_backupPlan;$t_rutaPlanBackup;$t_uuidDatabase)


If (False:C215)
	C_TEXT:C284(BKP_LeePlanBackup ;$0)
	C_TEXT:C284(BKP_LeePlanBackup ;$1)
End if 

$t_uuidDatabase:=$1

$t_rutaPlanBackup:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"BackupPlan-"+$t_uuidDatabase+".json"
If (Test path name:C476($t_rutaPlanBackup)=Is a document:K24:1)
	$t_backupPlan:=Document to text:C1236($t_rutaPlanBackup;"UTF-8")
End if 

$0:=$t_backupPlan