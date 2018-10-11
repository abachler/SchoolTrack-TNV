//%attributes = {}
  //PREF_fGet

$0:=""
READ ONLY:C145([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=$1;*)
QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$2)
If ((Records in selection:C76([xShell_Prefs:46])=0) & (Count parameters:C259=3))
	READ WRITE:C146([xShell_Prefs:46])
	CREATE RECORD:C68([xShell_Prefs:46])
	[xShell_Prefs:46]User:9:=$1
	[xShell_Prefs:46]Reference:1:=$2
	[xShell_Prefs:46]Text:4:=$3
	SAVE RECORD:C53([xShell_Prefs:46])
	UNLOAD RECORD:C212([xShell_Prefs:46])
	$0:=$3
Else 
	$0:=[xShell_Prefs:46]Text:4
End if 