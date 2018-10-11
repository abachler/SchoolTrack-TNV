Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_PageNumber:=1
		vCR_Replacement:=""
		vt_g1:=""
		
		vt_URL:=Get 4D folder:C485(Current resources folder:K5:16)+"PDFs"+Folder separator:K24:12+"ImportNotasActuales_STR.pdf"
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		WA OPEN URL:C1020(x4DLiveWindow;vt_URL)
		
		r1:=Choose:C955(SYS_IsMacintosh ;1;0)
		r2:=Choose:C955(SYS_IsWindows ;1;0)
		
		OBJECT SET ENABLED:C1123(*;"importar";False:C215)
		OBJECT SET ENABLED:C1123(bPrev;False:C215)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		  // Modificado por: Alexis Bustamante (11-04-2017)
		  //(23-04-2017) Segunda Modificacion:
		  // //se quita validación de sistema MAC o Windows desde el que se importa ya que no es necesario
		  //ya que si se creo le archivo en MAC pero se esta importando en windows no se puede continuar con importación
		  //TICKET 176934 
		C_BOOLEAN:C305($b_habilitar)
		$b_habilitar:=(aIdentificadores>0) & (vt_g1#"")
		
		  //$b_habilitar:=$b_habilitar & ((SYS_IsMacintosh  & (r1=1)) | (SYS_IsWindows  & (r2=1)))
		
		OBJECT SET ENABLED:C1123(bImport;$b_habilitar)
		  //OBJECT SET ENABLED(*;"importar";(aIdentificadores>0) & (vt_g1#"") & (SYS_IsMacintosh  & (r1=1)) | (SYS_IsWindows  & (r2=1))))
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
