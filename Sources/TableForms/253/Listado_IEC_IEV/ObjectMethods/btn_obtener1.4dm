C_TEXT:C284($t_idLibro;$t_rut;$t_nombreArchivo;$t_ruta;$t_ref)
C_BLOB:C604($xBlob)
C_TIME:C306($ref)
C_LONGINT:C283($l_result)

$t_idLibro:=CD_Request (__ ("Ingrese id del libro de boleta");"Aceptar";"Cancelar")
If (iresult=1)
	If (Num:C11($t_idLibro)>0)
		READ ONLY:C145([ACT_RazonesSociales:279])
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
		
		C_LONGINT:C283($l_idRS)
		If (Records in selection:C76([ACT_RazonesSociales:279])=1)
			$l_idRS:=[ACT_RazonesSociales:279]id:1
		Else 
			If (Records in selection:C76([ACT_RazonesSociales:279])>1)
				ARRAY TEXT:C222(aQR_Text1;0)
				ARRAY LONGINT:C221(aQR_Longint1;0)
				SELECTION TO ARRAY:C260([ACT_RazonesSociales:279]razon_social:2;aQR_Text1;[ACT_RazonesSociales:279]id:1;aQR_Longint1)
				
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				C_POINTER:C301($ptr)
				<>aChoicePtrs{1}:=->aQR_Text1
				<>aChoicePtrs{2}:=->aQR_Longint1
				TBL_ShowChoiceList (0;"Seleccione una Razón Social";-MAXINT:K35:1)
				If (choiceIdx>0)
					$l_idRS:=aQR_Longint1{choiceIdx}
				End if 
			End if 
		End if 
		
		If ($l_idRS#0)
			
			$t_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$l_idRS;->[ACT_RazonesSociales:279]RUT:3)
			$t_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rut)
			
			$l_result:=WSact_ObtieneLibroContable ($t_rut;"boleta";Num:C11($t_idLibro))
			If ($l_result=1)
				SET TEXT TO PASTEBOARD:C523(vtWS_xml)
				$t_ref:=DOM Parse XML variable:C720(vtWS_xml)
				If (ok=1)
					DOM EXPORT TO VAR:C863($t_ref;$xBlob)
					DOM CLOSE XML:C722($t_ref)
				End if 
				
				$t_ruta:=xfGetDirName 
				If (ok=1)
					$t_nombreArchivo:=$t_ruta+"LibroBoleta_"+$t_rut+"_"+$t_idLibro+".xml"
					If (Test path name:C476($t_nombreArchivo)=Is a document:K24:1)
						DELETE DOCUMENT:C159($t_nombreArchivo)
					End if 
					$ref:=Create document:C266($t_nombreArchivo)
					CLOSE DOCUMENT:C267($ref)
					
					BLOB TO DOCUMENT:C526($t_nombreArchivo;$xBlob)
					ACTcd_DlogWithShowOnDisk ($t_nombreArchivo;0;"Libro de boleta creado. El archivo quedó en la ruta: "+"\r"+$t_nombreArchivo+".")
					
				End if 
			Else 
				CD_Dlog (0;"No fue posible obtener el libro.")
			End if 
		End if 
	End if 
End if 