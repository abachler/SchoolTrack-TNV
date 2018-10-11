C_TEXT:C284($vt_fileName)

EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$vt_fileName:=xfGetFileName 
EM_ErrorManager ("Clear")
If (ok=1)
	If ($vt_fileName#"")
		$vb_continuar:=ADTcdd_ValidateDocumentSize (document;50;20)
		If ($vb_continuar)
			If (ok=1)
				C_BLOB:C604($vx_blob)
				C_TEXT:C284($vt_path)
				
				DOCUMENT TO BLOB:C525(document;$vx_blob)
				$vt_path:=ACTio_OpcionesArchivos ("AdjuntosPagares";->[ACT_Pagares:184]ID:12;->$vt_fileName)
				KRL_SendFileToServer ($vt_path;$vx_blob;True:C214)
				SET BLOB SIZE:C606($vx_blob;0)
				ACTio_OpcionesArchivos ("CargaPagaresDesdeFicha")
				ACTcfg_OpcionesPagares ("SetObjetosPag2")
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("El archivo no puede ser agregado. Es posible que el documento esté abierto."))
End if 