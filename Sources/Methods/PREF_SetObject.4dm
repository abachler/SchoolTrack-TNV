//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 06-05-17, 22:12:35
  // ----------------------------------------------------
  // Método: PREF_SetObject
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_OBJECT:C1216($3;$o_objecto)

$o_objecto:=$3
READ WRITE:C146([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=$1;*)
QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$2)
If (Records in selection:C76([xShell_Prefs:46])=0)
	CREATE RECORD:C68([xShell_Prefs:46])
	[xShell_Prefs:46]User:9:=$1
	[xShell_Prefs:46]Reference:1:=$2
End if 
[xShell_Prefs:46]_objeto:8:=$o_objecto
SAVE RECORD:C53([xShell_Prefs:46])
UNLOAD RECORD:C212([xShell_Prefs:46])
READ ONLY:C145([xShell_Prefs:46])