$menu:=AT_array2text (-><>areligion)

$choice:=Pop up menu:C542($menu)
If ($choice>0)
	AL_UpdateArrays (xALP_Efemerides;0)
	vReligion:=<>areligion{$choice}
	READ ONLY:C145([xxSTR_MetaReligionDef:165])
	ARRAY LONGINT:C221(aIDs;0)
	ARRAY TEXT:C222(aRelMetaDef;0)
	ARRAY LONGINT:C221(aIndexMeta;0)
	QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=vReligion)
	SELECTION TO ARRAY:C260([xxSTR_MetaReligionDef:165]Efemeride:3;aRelMetaDef;[xxSTR_MetaReligionDef:165]ID:1;aIDs;[xxSTR_MetaReligionDef:165]Index:4;aIndexMeta)
	SORT ARRAY:C229(aIndexMeta;aRelMetaDef;aIDs;>)
	AL_UpdateArrays (xALP_Efemerides;-2)
	AL_SetLine (xALP_Efemerides;0)
	_O_DISABLE BUTTON:C193(bDelEfemeride)
End if 