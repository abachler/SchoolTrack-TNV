AL_ExitCell (xALP_Efemerides)
AL_UpdateArrays (xALP_Efemerides;0)
AT_Insert (1;1;->aRelMetaDef;->aIDs;->aIndexMeta)
READ ONLY:C145([xxSTR_MetaReligionDef:165])
CREATE RECORD:C68([xxSTR_MetaReligionDef:165])
[xxSTR_MetaReligionDef:165]ID:1:=SQ_SeqNumber (->[xxSTR_MetaReligionDef:165]ID:1)
[xxSTR_MetaReligionDef:165]Religion:2:=vReligion
SAVE RECORD:C53([xxSTR_MetaReligionDef:165])
aIDs{1}:=[xxSTR_MetaReligionDef:165]ID:1
For ($i;1;Size of array:C274(aIndexMeta))
	aIndexMeta{$i}:=$i
End for 
AL_UpdateArrays (xALP_Efemerides;-2)
AL_GotoCell (xALP_Efemerides;1;1)