$vl_idRS:=alACTcfg_Razones{atACTcfg_Razones}
READ WRITE:C146([ACT_RazonesSociales:279])
QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=$vl_idRS)
If (Records in selection:C76([ACT_RazonesSociales:279])=1)
	If ([ACT_RazonesSociales:279]estadoConfiguracion:33 ?? 7)
		
		$path:=xfGetFileName (__ ("Seleccione el archivo...");"XML";True:C214)
		If (ok=1)
			C_BOOLEAN:C305($vb_res)
			C_BLOB:C604($xBlob)
			ARRAY TEXT:C222($atACTdte_DatosCAF;10)
			$vb_res:=ACTdte_CargarCAF ($path;->$atACTdte_DatosCAF)
			If ($vb_res)
				$vt_mensaje:=__ ("Se cargarán folios para el RUT: ")+$atACTdte_DatosCAF{1}+__ (", para el tipo de documento: ")+$atACTdte_DatosCAF{3}+" ("+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$atACTdte_DatosCAF{3})+"). "+"\r\r"+__ ("Folios a cargar desde ")+$atACTdte_DatosCAF{4}+", "+__ ("hasta ")+$atACTdte_DatosCAF{5}+"."+"\r\r"
				$vt_mensaje:=$vt_mensaje+__ ("¿Desea continuar?")
				$vl_resp:=CD_Dlog (0;$vt_mensaje;"";"Si";"No")
				
				If ($vl_resp=1)
					$vt_retorno:=ACTfol_OpcionesGenerales ("ValidaCreacionRegistro";->$vl_idRS;->$atACTdte_DatosCAF)
					If ($vt_retorno="")
						DOCUMENT TO BLOB:C525($path;$xBlob)
						$vt_caf:=ACTfol_OpcionesGenerales ("ObtieneTextoCaf";->$xBlob)
						
						If ($vt_caf#"")
							$vt_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]RUT:3)
							$ok:=WSact_CargaCAF ($vt_rut;$vt_caf)
							If ($ok=1)
								
								$vl_idFolios:=Num:C11(ACTfol_OpcionesGenerales ("CreaRegistro";->$vl_idRS;->$atACTdte_DatosCAF;->$xBlob))
								If ($vl_idFolios>0)
									ACTcfgbol_OpcionesDTE ("CargaArreglosCAF";->$vl_idRS)
								Else 
									C_BLOB:C604($xBlob2)
									BLOB_Variables2Blob (->$xBlob2;0;->$vl_idRS;->$atACTdte_DatosCAF;->$xBlob)
									$vt_llave:=ACTfol_OpcionesGenerales ("RetornaLlaveDesdeArreglo";->$atACTdte_DatosCAF)
									If ($vt_llave#"")
										BM_CreateRequest ("ACT_CreaRegistroCAF";$vt_llave;$vt_llave;$xBlob2)
									End if 
								End if 
								
							Else 
								CD_Dlog (0;__ ("El código de autorización de folios no pudo ser cargado."))
							End if 
						Else 
							CD_Dlog (0;__ ("El código de autorización de folios no pudo ser obtenido."))
						End if 
					Else 
						CD_Dlog (0;$vt_retorno)
					End if 
				End if 
			Else 
				CD_Dlog (0;__ ("El archivo no pudo ser cargado."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("Antes de enviar el código de autorización de folios debe verificar la configuración inicial."))
	End if 
End if 
  //KRL_UnloadReadOnly (->[ACT_RazonesSociales])
