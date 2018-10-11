//%attributes = {"executedOnServer":true}
  // BUILD_LoadPreferences()
  //
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 13:31:29
  // -----------------------------------------------------------
C_OBJECT:C1216($0)

C_TEXT:C284($t_hora;$t_rutaPrefs)
C_OBJECT:C1216($ob_PrefAutoUpdate)


If (False:C215)
	C_OBJECT:C1216(BUILD_LoadPreferences ;$0)
End if 

$t_rutaPrefs:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"autoupdateSettings.json"
If (Test path name:C476($t_rutaPrefs)<Is a folder:K24:2)
	$t_hora:="19:00:00"
	$ob_PrefAutoUpdate:=OB_Create 
	OB_SET_Long ($ob_PrefAutoUpdate;1;"descargar")
	OB_SET_Long ($ob_PrefAutoUpdate;0;"instalarAuto")
	OB_SET_Long ($ob_PrefAutoUpdate;1;"instalarProgramado")
	OB_SET_Long ($ob_PrefAutoUpdate;1;"dia")
	OB_SET ($ob_PrefAutoUpdate;->$t_hora;"hora")
	OB_ObjectToJsonDocument ($ob_PrefAutoUpdate;$t_rutaPrefs)
Else 
	OB_JsonDocumentToObject ($t_rutaPrefs;->$ob_PrefAutoUpdate)
End if 

$0:=$ob_PrefAutoUpdate


