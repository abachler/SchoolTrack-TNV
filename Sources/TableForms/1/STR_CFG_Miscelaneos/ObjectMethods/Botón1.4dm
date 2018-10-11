WDW_OpenFormWindow (->[xxSTR_Constants:1];"ReligionExtendida";0;Palette form window:K39:9)
DIALOG:C40([xxSTR_Constants:1];"ReligionExtendida")
CLOSE WINDOW:C154
For ($i;1;Size of array:C274(aRelMetaDef))
	READ WRITE:C146([xxSTR_MetaReligionDef:165])
	QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]ID:1=aIDs{$i})
	If (aRelMetaDef{$i}="")
		DELETE RECORD:C58([xxSTR_MetaReligionDef:165])
	Else 
		[xxSTR_MetaReligionDef:165]Index:4:=$i
		SAVE RECORD:C53([xxSTR_MetaReligionDef:165])
	End if 
	KRL_UnloadReadOnly (->[xxSTR_MetaReligionDef:165])
End for 
ARRAY LONGINT:C221(aIDs;0)
ARRAY TEXT:C222(aRelMetaDef;0)
ARRAY LONGINT:C221(aIndexMeta;0)