//%attributes = {}
  //PREF_Set

READ WRITE:C146([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=$1;*)
QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$2)
If (Records in selection:C76([xShell_Prefs:46])=0)
	CREATE RECORD:C68([xShell_Prefs:46])
	[xShell_Prefs:46]User:9:=$1
	[xShell_Prefs:46]Reference:1:=$2
End if 
[xShell_Prefs:46]Text:4:=$3
SAVE RECORD:C53([xShell_Prefs:46])
UNLOAD RECORD:C212([xShell_Prefs:46])
READ ONLY:C145([xShell_Prefs:46])