Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		vt_URL:=Get 4D folder:C485(Current resources folder:K5:16)+"PDFs"+Folder separator:K24:12+"ImportAnaliticos_MT.pdf"
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		If (vt_URL#"")
			WA OPEN URL:C1020(x4DLiveWindow;vt_URL)
		End if 
		
		r1Mac:=Choose:C955(SYS_IsMacintosh ;1;0)
		r2Win:=Choose:C955(SYS_IsWindows ;1;0)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 