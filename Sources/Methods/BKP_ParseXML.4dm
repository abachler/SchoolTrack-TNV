//%attributes = {}
  // BKP_ParseXML()
  // Por: Alberto Bachler K.: 03-09-14, 11:06:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_TEXT:C284($t_backupPrefsPath;$t_rutaCarpetaTemporal;$t_rutaPreferenciasBackup;$t_XMLrefPrefsRespaldo)

If (Application type:C494=4D Remote mode:K5:5)
	$t_rutaPrefRespaldo:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"Backup"+SYS_FolderDelimiterOnServer +"backup.xml"
	$x_blob:=KRL_GetFileFromServer ($t_rutaPrefRespaldo;True:C214)
	$t_rutaCarpetaTemporal:=Temporary folder:C486+"STv11"+Folder separator:K24:12
	SYS_CreateFolder ($t_rutaCarpetaTemporal)
	$t_rutaPrefRespaldo:=$t_rutaCarpetaTemporal+"backup.xml"
	BLOB TO DOCUMENT:C526($t_rutaPrefRespaldo;$x_blob)
Else 
	$t_rutaPrefRespaldo:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"Backup"+Folder separator:K24:12+"backup.xml"
End if 
$t_XMLrefPrefsRespaldo:=DOM Parse XML source:C719($t_rutaPrefRespaldo)

$0:=$t_XMLrefPrefsRespaldo

