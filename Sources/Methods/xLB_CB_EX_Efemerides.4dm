//%attributes = {}
C_LONGINT:C283($col;$line)
LISTBOX GET CELL POSITION:C971(lb_Efemerides;$col;$line)
If (aRelMetaDef{$line}="")
	READ WRITE:C146([xxSTR_MetaReligionDef:165])
	QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]ID:1=aIDs{$line})
	DELETE RECORD:C58([xxSTR_MetaReligionDef:165])
	KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef:165])
Else 
	READ WRITE:C146([xxSTR_MetaReligionDef:165])
	QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]ID:1=aIDs{$line})
	[xxSTR_MetaReligionDef:165]Efemeride:3:=aRelMetaDef{$line}
	SAVE RECORD:C53([xxSTR_MetaReligionDef:165])
	KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef:165])
End if 