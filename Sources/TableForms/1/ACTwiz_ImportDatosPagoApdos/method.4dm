Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		LOC_LoadIdenNacionales 
		ARRAY TEXT:C222(aIdentificadores;0)
		ARRAY POINTER:C280(aIDFieldPointers;5)
		COPY ARRAY:C226(<>at_IDNacional_Names;aIdentificadores)
		ARRAY TEXT:C222(aIdentificadores;5)
		aIdentificadores{4}:="Código Interno"
		aIdentificadores{5}:="Pasaporte"
		aIDFieldPointers{1}:=->[Personas:7]RUT:6
		aIDFieldPointers{2}:=->[Personas:7]IDNacional_2:37
		aIDFieldPointers{3}:=->[Personas:7]IDNacional_3:38
		aIDFieldPointers{4}:=->[Personas:7]Codigo_interno:22
		aIDFieldPointers{5}:=->[Personas:7]Pasaporte:59
		aIdentificadores:=1
		aIDFieldPointers:=1
		  //vt_g2:=OBJECT Get title(*;"texto")
		
		vt_URL:=Get 4D folder:C485(Current resources folder:K5:16)+"PDFs"+Folder separator:K24:12+"ImportacionDatosPago_ACT.pdf"
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		
		WA OPEN URL:C1020(x4DLiveWindow;vt_URL)
		
		vt_g1:=""
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
			r3:=0
		Else 
			r1:=0
			r2:=1
			r3:=0
		End if 
		cb_TieneEncabezado:=0
		vi_PageNumber:=1
		vi_Step:=1
		
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		_O_DISABLE BUTTON:C193(bImport)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
