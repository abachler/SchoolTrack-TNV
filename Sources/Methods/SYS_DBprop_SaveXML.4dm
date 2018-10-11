//%attributes = {}
  // SYS_SaveXMLDatabaseSettings()
  // Por: Alberto Bachler K.: 06-10-15, 11:34:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BLOB:C604($x_blob)
C_TEXT:C284($t_rutaCarpetaTemporal;$t_rutaPropiedadesXML;$t_text;$t_XMLrefPropiedades)


If (False:C215)
	C_TEXT:C284(SYS_SaveXMLDatabaseSettings ;$1)
End if 

$t_XMLrefPropiedades:=$1

$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;"preferences/schooltrack/uuid_db")
If (OK=1)
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$t_uuidPrefsDB)
End if 


If (Application type:C494=4D Remote mode:K5:5)
	$t_rutaPropiedadesXML:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"settings.4DSettings"
	$t_rutaCarpetaTemporal:=Temporary folder:C486+"SchoolTrack"+Folder separator:K24:12
	SYS_CreateFolder ($t_rutaCarpetaTemporal)
	$t_rutaPropiedadesXML:=$t_rutaCarpetaTemporal+"settings.4DSettings"
	DOM EXPORT TO FILE:C862($t_XMLrefPropiedades;$t_rutaPropiedadesXML)
	DOCUMENT TO BLOB:C525($t_rutaPropiedadesXML;$x_blob)
	$t_text:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)
	$t_text:=Replace string:C233($t_text;"\r";"")
	$t_text:=Replace string:C233($t_text;"\t";"")
	$t_text:=ST_ClearSpaces ($t_text)
	$t_text:=Replace string:C233($t_text;"> <";"><")
	TEXT TO BLOB:C554($t_text;$x_blob;UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($t_rutaPropiedadesXML;$x_blob)
	$t_rutaPropiedadesXML:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"settings.4DSettings"
	KRL_SendFileToServer ($t_rutaPropiedadesXML;$x_blob;True:C214)
	If (Util_isValidUUID ($t_uuidPrefsDB))
		$t_rutaPropiedadesXML_backup:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"settings{"+$t_uuidPrefsDB+"}.xml"
		KRL_SendFileToServer ($t_rutaPropiedadesXML_backup;$x_blob;True:C214)
	End if 
Else 
	$t_rutaPropiedadesXML:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"settings.4DSettings"
	DOM EXPORT TO VAR:C863($t_XMLrefPropiedades;$x_blob)
	$t_text:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)
	$t_text:=Replace string:C233($t_text;"\r";"")
	$t_text:=Replace string:C233($t_text;"\t";"")
	$t_text:=ST_ClearSpaces ($t_text)
	$t_text:=Replace string:C233($t_text;"> <";"><")
	TEXT TO BLOB:C554($t_text;$x_blob;UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($t_rutaPropiedadesXML;$x_blob)
	If (Util_isValidUUID ($t_uuidPrefsDB))
		$t_rutaPropiedadesXML_backup:=SYS_GetServer_4DFolder (Database folder:K5:14)+"Preferences"+SYS_FolderDelimiterOnServer +"settings{"+$t_uuidPrefsDB+"}.xml"
		BLOB TO DOCUMENT:C526($t_rutaPropiedadesXML_backup;$x_blob)
	End if 
End if 
DOM CLOSE XML:C722($t_XMLrefPropiedades)