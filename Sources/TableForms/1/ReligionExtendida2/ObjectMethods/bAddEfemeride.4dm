AT_Insert (1;1;->aIDs;->aIndexMeta)
LISTBOX INSERT ROWS:C913(lb_Efemerides;1)
READ ONLY:C145([xxSTR_MetaReligionDef:165])
CREATE RECORD:C68([xxSTR_MetaReligionDef:165])
[xxSTR_MetaReligionDef:165]ID:1:=SQ_SeqNumber (->[xxSTR_MetaReligionDef:165]ID:1)
[xxSTR_MetaReligionDef:165]Religion:2:=<>areligion{<>areligion}
SAVE RECORD:C53([xxSTR_MetaReligionDef:165])
aIDs{1}:=[xxSTR_MetaReligionDef:165]ID:1
For ($i;1;Size of array:C274(aIndexMeta))
	aIndexMeta{$i}:=$i
End for 
LBX_EditItem_byColNum ("lb_Efemerides";1;1)