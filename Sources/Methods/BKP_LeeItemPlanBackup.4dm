//%attributes = {"executedOnServer":true}
  // BKP_LeeItemPlanBackup()
  // Por: Alberto Bachler K.: 30-10-14, 09:03:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)

C_POINTER:C301($y_retorno)
C_TEXT:C284($t_json;$t_nombreElemento;$t_rutaPlanBackup;$t_uuidDatabase)
C_OBJECT:C1216($ob_objeto)


If (False:C215)
	C_TEXT:C284(BKP_LeeItemPlanBackup ;$1)
	C_POINTER:C301(BKP_LeeItemPlanBackup ;$2)
End if 

$t_nombreElemento:=$1
$y_retorno:=$2

READ ONLY:C145([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
FIRST RECORD:C50([xShell_ApplicationData:45])
$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
$t_rutaPlanBackup:=SYS_GetServerProperty (XS_StructureFolder)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"BackupPlan-"+$t_uuidDatabase+".json"
If (Test path name:C476($t_rutaPlanBackup)=Is a document:K24:1)
	$t_json:=Document to text:C1236($t_rutaPlanBackup;"UTF-8")
End if 

$ob_objeto:=OB_JsonToObject ($t_json)
OB_GET ($ob_objeto;$y_retorno;$t_nombreElemento)


