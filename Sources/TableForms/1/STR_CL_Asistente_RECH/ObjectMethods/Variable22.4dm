


vt_Foldername:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
If (vt_folderName#"")
	  //20171128 ASM Ticket 193895 comento codigo porque producía un problema en la generación de los archivos al cambiar el directorio
	  //If (vt_folderName[[Length(vt_Foldername)]]=Folder separator)
	  //vt_folderName:=Substring(vt_Foldername;1;Length(vt_Foldername)-1)
	  //End if 
	If (Test path name:C476(vt_foldername)=0)
		_O_ENABLE BUTTON:C192(bGenerar)
	End if 
End if 