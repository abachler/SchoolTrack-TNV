//%attributes = {}
  //PREF_fGetBlob

C_BLOB:C604($0;$3;$blob)
C_LONGINT:C283($expandedSized;$currrentsize)
If (Count parameters:C259=3)
	$blob:=$3
End if 
READ ONLY:C145([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=$1;*)
QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$2)
If ((Records in selection:C76([xShell_Prefs:46])=0) & (Count parameters:C259=3))
	READ WRITE:C146([xShell_Prefs:46])
	CREATE RECORD:C68([xShell_Prefs:46])
	[xShell_Prefs:46]User:9:=$1
	[xShell_Prefs:46]Reference:1:=$2
	[xShell_Prefs:46]_blob:10:=$3
	SAVE RECORD:C53([xShell_Prefs:46])
	UNLOAD RECORD:C212([xShell_Prefs:46])
	$blob:=BLOB_ExpandBlob ($3)
Else 
	$blob:=BLOB_ExpandBlob ([xShell_Prefs:46]_blob:10)
End if 
REDUCE SELECTION:C351([xShell_Prefs:46];0)
$0:=$blob
READ ONLY:C145([xShell_Prefs:46])