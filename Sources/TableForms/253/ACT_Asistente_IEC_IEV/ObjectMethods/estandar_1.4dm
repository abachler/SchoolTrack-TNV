$vt_ruta:=xfGetDirName ("")
If ($vt_ruta#"")
	
	$vt_fileName:="PlantillaImportacionIEC"+String:C10(vlACTdte_YearIE)+"-"+String:C10(vlACTdte_MesIE;"00")+".txt"
	$vt_fullPath:=$vt_ruta+$vt_fileName
	ok:=1
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	If (SYS_TestPathName ($vt_fullPath)=1)
		DELETE DOCUMENT:C159($vt_fullPath)
	End if 
	If (ok=1)
		If (r_win=1)
			USE CHARACTER SET:C205("windows-1252";0)
		Else 
			USE CHARACTER SET:C205("MacRoman";0)
		End if 
		$ref:=Create document:C266($vt_fullPath;"TEXT")
		
		ARRAY TEXT:C222($atACT_Campos;0)
		ARRAY LONGINT:C221($alACT_IdsCampos;0)
		
		$vt_element:="IEC"
		ACTdte_OpcionesGenerales ("CargaArchivoConfiguracion";->$vt_element;->$atACT_Campos;->$alACT_IdsCampos)
		IO_SendPacket ($ref;AT_array2text (->$atACT_Campos;"\t"))
		CLOSE DOCUMENT:C267($ref)
		ACTcd_DlogWithShowOnDisk ($vt_fullPath;0;__ ("Plantilla creada con éxito.")+"\r\r"+__ ("Encontrará el archivo en la ruta: ")+ST_Qte ($vt_fullPath))
		USE CHARACTER SET:C205(*;0)
	Else 
		CD_Dlog (0;__ ("No fue posible generar el archivo. Revise si el archivo está en uso.")+"\r\r"+__ ("Intente más tarde."))
	End if 
	EM_ErrorManager ("Clear")
End if 
