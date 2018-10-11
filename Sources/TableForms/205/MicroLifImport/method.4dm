Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		document:=""
		ARRAY LONGINT:C221(alBBL_RecordStart;0)
		vhBBL_DocRef:=?00:00:00?
		vlBBL_CurrentRecordNum:=0
		vtBBL_CurrentRecord:=""
		_O_ARRAY STRING:C218(3;asBBL_MarcField;0)
		_O_ARRAY STRING:C218(4;asBBL_MarcFieldSubField;0)
		_O_ARRAY STRING:C218(2;asBBL_MarcIndicator;0)
		_O_ARRAY STRING:C218(1;asBBL_MarcSubField;0)
		ARRAY TEXT:C222(atBBL_MarcFieldData;0)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 