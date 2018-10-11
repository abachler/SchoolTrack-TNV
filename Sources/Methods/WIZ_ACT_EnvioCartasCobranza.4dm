//%attributes = {}
  //WIZ_ACT_EnvioCartasCobranza


C_BOOLEAN:C305($b_PDF_OK)
C_LONGINT:C283($l_recNum)
C_REAL:C285($r_records)
C_TEXT:C284($t_currPrinter)

TRACE:C157
  //en produccion crear el proceso autorizado

If (USR_GetMethodAcces (Current method name:C684))
	
	$b_PDF_OK:=UTIL_ImpresoraPDF 
	
	If ($b_PDF_OK)
		
		If ((Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7])) & (vsBWR_CurrentModule="AccountTrack"))
			
			If (Semaphore:C143("GeneracionPDFCartaXEmail"))
				CD_Dlog (0;__ ("En estos momentos hay un proceso de generación de PDFs en curso.")+"\r\r"+__ ("Intente realizar la operación más tarde."))
			Else 
				If (Test semaphore:C652("EnvioPDFCartaCXEmail"))
					CD_Dlog (0;__ ("En estos momentos hay un proceso de envío de e-Mail en curso.")+"\r\r"+__ ("Intente realizar la operación más tarde."))
				Else 
					
					$r_records:=BWR_SearchRecords 
					If ($r_records#-1)
						
						WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_EnvioCartaCobranza1";-1;4;__ ("Enviar Cartas de Cobranza"))
						DIALOG:C40([xxSTR_Constants:1];"ACT_EnvioCartaCobranza1")
						CLOSE WINDOW:C154
						If (ok=1)
							ACTecc_OpcionesGenerales ("GuardaBlob")
							
							READ ONLY:C145([xShell_Reports:54])
							$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_Reports:54]ID:7;->alACTecc_Informes{atACTecc_Informes})
							If ($l_recNum#-1)
								ACTecc_GeneraPDF (->alACTecc_ApoderadoID2Enviar;$l_recNum)
							Else 
								CD_Dlog (0;"Reporte no encontrado...")
							End if 
						End if 
						ACTecc_OpcionesGenerales ("DeclaraVariables")
					Else 
						CD_Dlog (0;__ ("No hay registros seleccionados en el explorador."))
					End if 
					
				End if 
				CLEAR SEMAPHORE:C144("GeneracionPDFCartaXEmail")
			End if 
			
		Else 
			CD_Dlog (0;__ ("Ejecute esta opción desde Apoderados en AccountTrack."))
		End if 
		
	Else 
		CD_Dlog (0;__ ("No es posible generar el archivo PDF. Si está en una versión de sistema operativo inferior a Windows 10 verifique que la impresora Win2PDF esté instalada."))  //20170809 RCH
	End if 
End if 


