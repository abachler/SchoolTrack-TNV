Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_BLOB:C604($blob)
		vt_texto:=""
		$vt_FileName:=Get 4D folder:C485(Current resources folder:K5:16)+"Help Docs"+Folder separator:K24:12+"ACT_TextImportItems.txt"
		DOCUMENT TO BLOB:C525($vt_FileName;$blob)
		vt_texto:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
		vt_g1:=""
		vt_g1Temp:=""
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
		Else 
			r1:=0
			r2:=1
		End if 
		vb_manual:=False:C215
		vi_PageNumber:=1
		vi_Step:=1
		
		ACTimp_ItemsArrayDelarations 
		xALP_ACT_SET_PreImportItem 
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 



