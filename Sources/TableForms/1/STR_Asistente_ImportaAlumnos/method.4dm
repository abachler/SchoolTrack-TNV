Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vt_errorStatus:=""
		b1Mac:=0
		b2Win:=1
		b3utf8:=0  //20171122 RCH
		b1Mode:=0
		b2Mode:=1
		b1ModeInitialState:=b1Mode
		b2ModeInitialState:=b2Mode
		viIOstr_PlatFormSource:=3
		vt_ImportDocPath:=""
		_O_DISABLE BUTTON:C193(bBack)
		
		vtIOstr_FilePath:=""
		
		vi_PageNumber:=FORM Get current page:C276
		xALSet_STR_AsistenteImportacion 
		
		vt_RecordNum:=""
		vl_LastRec:=0
		
		$y_rutaBD:=OBJECT Get pointer:C1124(Object named:K67:5;"rutaBD")
		$y_rutaBD->:=SYS_GetServerProperty (XS_DataFileFolder)+SYS_GetServerProperty (XS_DataFileName)
		
		
	: (Form event:C388=On Clicked:K2:4)
		If (FORM Get current page:C276>1)
			_O_ENABLE BUTTON:C192(bBack)
		End if 
		
		Case of 
			: (vi_PageNumber=3)
				If ((vtIOstr_FilePath="") | (viIOstr_PlatFormSource=0))
					_O_DISABLE BUTTON:C193(bNext)
				End if 
		End case 
		
		b1Mac:=Num:C11(viIOstr_PlatFormSource=1)  //20171122 RCH
		b2Win:=Num:C11(viIOstr_PlatFormSource=3)
		b3utf8:=Num:C11(viIOstr_PlatFormSource=4)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
