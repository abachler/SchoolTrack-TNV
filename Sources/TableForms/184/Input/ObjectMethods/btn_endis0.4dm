C_LONGINT:C283($vl_Column;$vl_row)
C_TEXT:C284($vt_fileName;$vt_localPath)
LISTBOX GET CELL POSITION:C971(lb_adjuntos;$vl_Column;$vl_row)

If ($vl_row>0)
	$vt_fileName:=atACT_AdjuntosNombre{$vl_row}
	$vt_localPath:=Temporary folder:C486+"ACT"+Folder separator:K24:12
	SYS_CreatePath ($vt_localPath)
	$vt_localPath:=Temporary folder:C486+"ACT"+Folder separator:K24:12+$vt_fileName
	
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	If (SYS_TestPathName ($vt_localPath)=1)
		DELETE DOCUMENT:C159($vt_localPath)
	End if 
	If (ok=1)
		$ref:=Create document:C266($vt_localPath)
		CLOSE DOCUMENT:C267($ref)
		If (ok=1)
			C_BLOB:C604($xBlob)
			$vt_parentPath:=ACTio_OpcionesArchivos ("AdjuntosPagares";->[ACT_Pagares:184]ID:12;->$vt_fileName)
			$xBlob:=KRL_GetFileFromServer ($vt_parentPath;True:C214)
			BLOB TO DOCUMENT:C526(document;$xBlob)
			SET BLOB SIZE:C606($xBlob;0)
			OPEN URL:C673($vt_localPath)
		End if 
	Else 
		CD_Dlog (0;__ ("El archivo no pudo ser abierto."))
	End if 
	EM_ErrorManager ("Clear")
End if 