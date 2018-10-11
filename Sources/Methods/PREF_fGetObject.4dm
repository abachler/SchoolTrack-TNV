//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 06-05-17, 22:10:00
  // ----------------------------------------------------
  // Método: PREF_fGetObject
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_OBJECT:C1216($0;$3;$o_objecto)
If (Count parameters:C259=3)
	$o_objecto:=$3
End if 
READ ONLY:C145([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=$1;*)
QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$2)
If ((Records in selection:C76([xShell_Prefs:46])=0) & (Count parameters:C259=3))
	READ WRITE:C146([xShell_Prefs:46])
	CREATE RECORD:C68([xShell_Prefs:46])
	[xShell_Prefs:46]User:9:=$1
	[xShell_Prefs:46]Reference:1:=$2
	[xShell_Prefs:46]_objeto:8:=$3
	SAVE RECORD:C53([xShell_Prefs:46])
End if 
$o_objecto:=[xShell_Prefs:46]_objeto:8
UNLOAD RECORD:C212([xShell_Prefs:46])
REDUCE SELECTION:C351([xShell_Prefs:46];0)
$0:=$o_objecto
READ ONLY:C145([xShell_Prefs:46])