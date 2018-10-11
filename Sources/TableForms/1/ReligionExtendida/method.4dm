Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vReligion:=<>areligion{1}
		READ ONLY:C145([xxSTR_MetaReligionDef:165])
		ARRAY LONGINT:C221(aIDs;0)
		ARRAY TEXT:C222(aRelMetaDef;0)
		ARRAY LONGINT:C221(aIndexMeta;0)
		QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=vReligion)
		SELECTION TO ARRAY:C260([xxSTR_MetaReligionDef:165]Efemeride:3;aRelMetaDef;[xxSTR_MetaReligionDef:165]ID:1;aIDs;[xxSTR_MetaReligionDef:165]Index:4;aIndexMeta)
		SORT ARRAY:C229(aIndexMeta;aRelMetaDef;aIDs;>)
		ALP_DefaultColSettings (xALP_Efemerides;1;"aRelMetaDef";__ ("Efeméride");0;"";0;0;1)
		ALP_DefaultColSettings (xALP_Efemerides;2;"aIDs")
		ALP_SetDefaultAppareance (xALP_Efemerides;9;1;6;1;8)
		AL_SetColOpts (xALP_Efemerides;1;1;1;1;0)
		AL_SetRowOpts (xALP_Efemerides;0;1;0;0;1;0)
		AL_SetEntryOpts (xALP_Efemerides;3;0;0;0;0;"";0)
		AL_SetCallbacks (xALP_Efemerides;"";"xALP_CBEX_Efemerides")
		AL_SetDrgOpts (xALP_Efemerides;0;30;0;1)
		AL_SetDrgSrc (xALP_Efemerides;1;String:C10(xALP_Efemerides))
		AL_SetDrgDst (xALP_Efemerides;1;String:C10(xALP_Efemerides))
		_O_DISABLE BUTTON:C193(bDelEfemeride)
End case 