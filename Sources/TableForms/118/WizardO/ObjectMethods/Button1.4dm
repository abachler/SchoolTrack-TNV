C_BLOB:C604($blob)
vt_ruta:=xfGetFileName 
If (ok=1)
	If (SYS_TestPathName (vt_ruta)=Is a document:K24:1)
		vtACT_fileName:=SYS_Path2FileName (vt_ruta)
		SET BLOB SIZE:C606($blob;0)
		  //capturar error
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		DOCUMENT TO BLOB:C525(vt_ruta;$blob)
		EM_ErrorManager ("Clear")
		  // / capturar error
	End if 
	If (ok=1)
		$path:=Temporary folder:C486+"ImportArchACT.txt"
		SYS_DeleteFile ($path)
		$ref:=Create document:C266($path)
		
		If (ok=1)
			CLOSE DOCUMENT:C267($ref)
			BLOB TO DOCUMENT:C526($path;$blob)
			$ref:=Open document:C264($path;"";Read mode:K24:5)
			If (ok=1)
				CLOSE DOCUMENT:C267($ref)
			End if 
		End if 
		
		If (Ok=1)
			  //2012105 RCH 
			  //$err:=ACTabc_ImportByWizard ($document)
			  //$err:=ACTabc_ImportByWizard ($document;Current date(*);False;[xxACT_ArchivosBancarios]id_forma_de_pago)
			$err:=ACTabc_ImportByWizard ($path;Current date:C33(*);False:C215;vlACT_id_modo_pago)  //20160610 RCH
			DELETE DOCUMENT:C159($path)
			If ($err=0)
				WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"ACT_PreImportArchivos";0;4;__ ("Datos Importados"))
				DIALOG:C40([xxACT_ArchivosBancarios:118];"ACT_PreImportArchivos")
				CLOSE WINDOW:C154
			Else 
				CD_Dlog (0;__ ("No se encontró información en el archivo de texto seleccionado."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("El archivo no pudo ser abierto"))
	End if 
End if 