//%attributes = {}
  // SYS_ParseXMLDatabaseSettings()
  // Por: Alberto Bachler K.: 25-09-15, 13:25:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_TEXT:C284($t_rutaCarpetaTemporal;$t_rutaPropiedadesXML;$t_XMLrefPropiedades)

If (Application type:C494=4D Remote mode:K5:5)
	$t_rutaPropiedadesXML:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"settings.4DSettings"
	$x_blob:=KRL_GetFileFromServer ($t_rutaPropiedadesXML;True:C214)
	$t_rutaCarpetaTemporal:=Temporary folder:C486+"SchoolTrack"+Folder separator:K24:12
	SYS_CreateFolder ($t_rutaCarpetaTemporal)
	$t_rutaPropiedadesXML:=$t_rutaCarpetaTemporal+"settings.4DSettings"
	BLOB TO DOCUMENT:C526($t_rutaPropiedadesXML;$x_blob)
Else 
	$t_rutaPropiedadesXML:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
End if 

$t_XMLrefPropiedades:=DOM Parse XML source:C719($t_rutaPropiedadesXML)


$0:=$t_XMLrefPropiedades