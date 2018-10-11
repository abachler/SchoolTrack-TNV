//%attributes = {"executedOnServer":true}
  // BUILD_SavePreferences()
  //
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 19:28:33
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_OBJECT:C1216($1)

C_TEXT:C284($t_rutaPrefs)
C_OBJECT:C1216($ob_preferencias)


If (False:C215)
	C_LONGINT:C283(BUILD_SavePreferences ;$0)
	C_OBJECT:C1216(BUILD_SavePreferences ;$1)
End if 

$ob_preferencias:=$1

$t_rutaPrefs:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"autoupdateSettings.json"
OB_ObjectToJsonDocument ($ob_preferencias;$t_rutaPrefs)

$0:=OK