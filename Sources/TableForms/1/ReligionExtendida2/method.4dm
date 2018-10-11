Case of 
	: (Form event:C388=On Load:K2:1)
		<>areligión:=1
		READ ONLY:C145([xxSTR_MetaReligionDef:165])
		ARRAY LONGINT:C221(aIDs;0)
		ARRAY TEXT:C222(aRelMetaDef;0)
		ARRAY LONGINT:C221(aIndexMeta;0)
		QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=<>areligión{1})
		SELECTION TO ARRAY:C260([xxSTR_MetaReligionDef:165]Efemeride:3;aRelMetaDef;[xxSTR_MetaReligionDef:165]ID:1;aIDs;[xxSTR_MetaReligionDef:165]Index:4;aIndexMeta)
		SORT ARRAY:C229(aIndexMeta;aRelMetaDef;aIDs;>)
		
		OBJECT SET ENABLED:C1123(bDelEfemeride;False:C215)
End case 