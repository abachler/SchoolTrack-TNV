//%attributes = {}
  //VS_SaveTableProperties

If (Count parameters:C259=2)
	$country:=$1
	$language:=$2
	XSvs_ActualizaLocalizacionTabla (Record number:C243([xShell_Tables:51]);$country;$language;vtXS_TableAlias)
End if 
SAVE RECORD:C53([xShell_Tables:51])