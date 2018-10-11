//%attributes = {}
  //ACTdte_OpcionesGenerales
C_TEXT:C284($vt_accion;$1;$vt_nombrePref)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="CargaConf")
		C_TEXT:C284(vtACT_rutaServer;vtACT_rutaCliente;$vt_propiedad)
		C_LONGINT:C283(cs_generaOnServer)
		C_TEXT:C284(vtACT_rutaOnServer)
		
		cs_generaOnServer:=0
		vtACT_rutaOnServer:=""
		
		$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPagoServer"
		vtACT_rutaServer:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
		$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPago"
		vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
		
		ACTcfdi_OpcionesGenerales ("LeeCheckBox")
		
	: ($vt_accion="CargaProveedoresXDefecto")
		Case of 
			: (<>gCountryCode="mx")
				  //APPEND TO ARRAY($at_proveedores;"Buzón Fiscal")
				  //APPEND TO ARRAY($at_proveedores;"ClickBalance")  // Maguen David
				  //APPEND TO ARRAY($at_proveedores;"Sae")  //Yaocalli
				  //APPEND TO ARRAY($at_proveedores;"Levicom")  // WIlliams
				  //APPEND TO ARRAY($at_proveedores;"BuzonE")  // WIlliams
				
				APPEND TO ARRAY:C911($vy_pointer1->;"Buzón Fiscal")
				APPEND TO ARRAY:C911($vy_pointer1->;"ClickBalance")
				APPEND TO ARRAY:C911($vy_pointer1->;"Sae")
				APPEND TO ARRAY:C911($vy_pointer1->;"Levicom")
				APPEND TO ARRAY:C911($vy_pointer1->;"BuzonE")
				APPEND TO ARRAY:C911($vy_pointer1->;"Levicom txt")
				
				  //20130808 RCH
				  //: (<>gCountryCode="cl")
			Else 
				  //ACTdte_OpcionesGenerales ("CargaProveedores";->$at_proveedores)
				APPEND TO ARRAY:C911($vy_pointer1->;"Colegium")
				
		End case 
		
	: ($vt_accion="CargaProveedores")
		  //20121009 RCH carga proveedores por defecto
		ACTdte_OpcionesGenerales ("CargaProveedoresXDefecto";$vy_pointer1)
		
		  //APPEND TO ARRAY($vy_pointer1->;"Colegium")
		ACTdte_OpcionesGenerales ("BuscaProveedoresPrefs")
		While (Not:C34(End selection:C36([xShell_Prefs:46])))
			APPEND TO ARRAY:C911($vy_pointer1->;ST_GetWord ([xShell_Prefs:46]Reference:1;3;";"))
			NEXT RECORD:C51([xShell_Prefs:46])
		End while 
		
	: ($vt_accion="GetNombrePref")
		$vy_pointer1->:="ACT_CFG_DTE_Proveedores;"+String:C10($vy_pointer2->)+";"
		
	: ($vt_accion="BuscaProveedoresPrefs")
		If (vlACT_RSSel=0)
			vlACT_RSSel:=-1
		End if 
		ACTdte_OpcionesGenerales ("GetNombrePref";->$vt_nombrePref;->vlACT_RSSel)
		READ ONLY:C145([xShell_Prefs:46])
		
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vt_nombrePref+"@")
		ORDER BY:C49([xShell_Prefs:46];[xShell_Prefs:46]Reference:1;>)
		
	: ($vt_accion="EliminaProveedor")
		ARRAY TEXT:C222($at_proveedores;0)
		ACTdte_OpcionesGenerales ("CargaProveedoresXDefecto";->$at_proveedores)
		
		If (at_proveedores<=Size of array:C274(at_proveedores))
			  //If (at_proveedores{at_proveedores}#"Colegium")
			If (Find in array:C230($at_proveedores;at_proveedores{at_proveedores})=-1)
				$vl_resp:=CD_Dlog (0;__ ("El proveedor ")+ST_Qte (at_proveedores{at_proveedores})+__ (" será eliminado de la lista sin ninguna verificación adicional.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
				If ($vl_resp=1)
					ACTdte_OpcionesGenerales ("GetNombrePref";->$vt_nombrePref;->vlACT_RSSel)
					$vt_nombrePref:=$vt_nombrePref+at_proveedores{at_proveedores}
					  //elimina registro preferencia
					ACTdte_OpcionesGenerales ("EliminaPrefProveedor";->$vt_nombrePref)
					  //elimina elemento lista
					AT_Delete (at_proveedores;1;->at_proveedores)
					at_proveedores:=1
					  //guarda en conf
					ACTcfdi_OpcionesGenerales ("SaveConf";->vlACT_RSSel)
					  //carga conf
					ACTcfdi_OpcionesGenerales ("CargaConf")
					
				End if 
			Else 
				CD_Dlog (0;__ ("Los proveedores por defecto no pueden ser eliminados."))
			End if 
		Else 
			BEEP:C151
		End if 
		
		
		
		
		
		
		
	: ($vt_accion="EliminaPrefProveedor")
		READ WRITE:C146([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vy_pointer1->)
		DELETE RECORD:C58([xShell_Prefs:46])
		KRL_UnloadReadOnly (->[xShell_Prefs:46])
		
	: ($vt_accion="CargaProveedor")
		C_TEXT:C284($filePath;$vt_code;$vt_nombreProveedor)
		C_LONGINT:C283($err;$vl_recs;$vl_offSet)
		  //carga archivo
		$filePath:=xfGetFileName ("Restaurar desde:";"")
		If ($filePath#"")
			USE CHARACTER SET:C205("MacRoman";1)
			
			C_BLOB:C604($xBlob)
			DOCUMENT TO BLOB:C525(document;$xBlob)
			$vl_offSet:=0
			$vt_code:=Convert to text:C1012($xBlob;"MacRoman")
			$validFile:=ACTtrf_IsValidTransferFile ($vt_code)
			If ($validFile)
				
				  //ABK 20170213: desactivo este código: FootRunner abandonado, al parecer el código está validado antes en ACTtrf_IsValidTransferFile. 
				  // y la validación no es posible en PROCESS 4D TAGS si no se hace
				If (False:C215)
					  //  //footrunner valida el codigo
					  //$err:=FRAppendChecksum ($vt_code)
					  //If ($err#0)
					  //CD_Dlog (0;__ ("Error al validar el código."))
					  //Else 
				End if 
				
				
				  //obtengo el nombre del proveedor desde el nombre del archivo
				$vt_nombreProveedor:=SYS_Path2FileName ($filePath)
				$vt_nombreProveedor:=Substring:C12($vt_nombreProveedor;1;Length:C16($vt_nombreProveedor)-4)
				ARRAY TEXT:C222($at_proveedores;0)
				ACTdte_OpcionesGenerales ("CargaProveedoresXDefecto";->$at_proveedores)
				If (Find in array:C230($at_proveedores;$vt_nombreProveedor)#-1)
					$vt_nombreProveedor:=$vt_nombreProveedor+" 1"
				End if 
				ACTdte_OpcionesGenerales ("GetNombrePref";->$vt_nombrePref;->vlACT_RSSel)
				  //con el nombre base de la preferencia mas el proveedor obtengo el string completo
				$vt_nombrePref:=$vt_nombrePref+$vt_nombreProveedor
				  //cargo los proveedores para saber si ya hay alguno llamado igual
				ACTdte_OpcionesGenerales ("BuscaProveedoresPrefs")
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_recs)
				QUERY SELECTION:C341([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$vt_nombrePref)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_recs=0)
					ACTdte_OpcionesGenerales ("CreaPrefProveedor";->$vt_nombrePref;->$xBlob)
					  //carga conf
					ACTcfdi_OpcionesGenerales ("CargaConf")
				Else 
					CD_Dlog (0;__ ("Ya existe un proveedor con el nombre ")+ST_Qte ($vt_nombreProveedor)+"."+"\r\r"+__ ("El archivo no puede ser importado."))
				End if 
				SET BLOB SIZE:C606($xBlob;0)
				
				
				  //End if 
				
			Else 
				CD_Dlog (0;__ ("Código no válido"))
			End if 
			
			USE CHARACTER SET:C205(*;1)
		End if 
		
	: ($vt_accion="CreaPrefProveedor")
		READ WRITE:C146([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vy_pointer1->)
		If (Records in selection:C76([xShell_Prefs:46])=0)
			PREF_SetBlob (0;$vy_pointer1->;$vy_pointer2->)
		End if 
		KRL_UnloadReadOnly (->[xShell_Prefs:46])
		
	: ($vt_accion="EditaProveedor")
		ARRAY TEXT:C222($at_proveedores;0)
		ACTdte_OpcionesGenerales ("CargaProveedoresXDefecto";->$at_proveedores)
		If (at_proveedores<=Size of array:C274(at_proveedores))
			If (Find in array:C230($at_proveedores;at_proveedores{at_proveedores})=-1)
				C_BOOLEAN:C305($valid;$validFile)
				C_LONGINT:C283($offset)
				C_TEXT:C284($vt_nombrePref)
				C_BOOLEAN:C305(vbACT_noMostrarTexto)
				C_BLOB:C604($xBlob)
				
				vbACT_noMostrarTexto:=True:C214
				
				ACTdte_OpcionesGenerales ("GetNombrePref";->$vt_nombrePref;->vlACT_RSSel)
				$vt_nombrePref:=$vt_nombrePref+at_proveedores{at_proveedores}
				$xBlob:=PREF_fGetBlob (0;$vt_nombrePref;$xBlob)
				
				If (BLOB size:C605($xBlob)>0)
					$offset:=0
					vtCode:=Convert to text:C1012($xBlob;"MacRoman")
					$validFile:=ACTtrf_IsValidTransferFile (vtCode)
					If ($validFile)
						$vt_nombreArchivo:=ST_GetWord (ST_GetWord ($vt_nombrePref;4;"_");3;";")
						vtCode:=ACTtrf_RemoveCheckCode (vtCode)
						WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"EditArchivoBancario";-1;4;__ ("Edición de código de ")+$vt_nombreArchivo)
						DIALOG:C40([xxACT_ArchivosBancarios:118];"EditArchivoBancario")
						CLOSE WINDOW:C154
						If (OK=1)
							  //agrega caracteres de validacion al texto...
							vtCode:=ACTtrf_AddCheckCode (vtCode)
							TEXT TO BLOB:C554(vtCode;$xBlob;Mac text without length:K22:10)
							
							  //guarda preferencia
							PREF_SetBlob (0;$vt_nombrePref;$xBlob)
							
							SET BLOB SIZE:C606($xBlob;0)
							vtCode:=""
						End if 
					Else 
						CD_Dlog (0;__ ("El código almacenado en este registro parece estar corrupto. Póngase en contacto con el personal de Colegium para solucionar este problema."))
					End if 
					
				Else 
					CD_Dlog (0;__ ("Archivo de configuración no encontrado."))
				End if 
			Else 
				BEEP:C151
			End if 
		Else 
			BEEP:C151
		End if 
		
	: ($vt_accion="EjecutaCodigo")
		C_TEXT:C284(vtACTdte_errorGen;vtACTdte_rutaArchivo)
		C_LONGINT:C283(vlACT_RSSel;$offset;$err;$vl_idBoleta)
		C_TEXT:C284($vtCode;$vt_documentName;$vt_fullPath)
		C_BOOLEAN:C305($vb_continuar)
		
		$vb_continuar:=False:C215
		vtACTdte_errorGen:=""
		vtACTdte_rutaArchivo:=""
		$vl_idBoleta:=$vy_pointer1->
		
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta;True:C214)
		If (ok=1)
			
			Case of 
				: (([ACT_Boletas:181]MX_pathFile:32="") | (<>gCountryCode="mx"))  //para mx siempre entra
					$vb_continuar:=True:C214
				Else 
					If (SYS_TestPathName ([ACT_Boletas:181]MX_pathFile:32;Server)#Is a document:K24:1)
						$vb_continuar:=True:C214
					Else 
						  // copio el documento a la ruta especificada
						ACTdte_OpcionesGenerales ("CopiaDocumentosACarpetas";->[ACT_Boletas:181]ID:1)
					End if 
			End case 
			
			
			If ($vb_continuar)
				
				vlACT_RSSel:=[ACT_Boletas:181]ID_RazonSocial:25
				If (vlACT_RSSel=0)
					vlACT_RSSel:=-1
				End if 
				
				C_TEXT:C284($vt_nombrePref)
				ACTdte_OpcionesGenerales ("GetNombrePref";->$vt_nombrePref;->vlACT_RSSel)
				$vt_nombrePref:=$vt_nombrePref+at_proveedores{at_proveedores}
				READ ONLY:C145([xShell_Prefs:46])
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
				QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vt_nombrePref)
				
				If (Records in selection:C76([xShell_Prefs:46])=1)
					
					$vtCode:=Convert to text:C1012([xShell_Prefs:46]_blob:10;"MacRoman")
					If (ACTtrf_IsValidTransferFile ($vtCode))
						$vtCode:=ACTtrf_RemoveCheckCode ($vtCode)
						
						If ($err#0)
							LOG_RegisterEvt ("Error al validar código. Archivo no generado.")
						Else 
							
							$t_Error:=EXE_Execute ($vtCode)
							
							
							If ($t_Error#"")
								LOG_RegisterEvt (__ ("Error al ejecutar código: \r")+$t_Error)
							Else 
								
								If (vtACTdte_errorGen="1")  // ok
									KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta;True:C214)
									$vt_propiedad:="FILE|rutaAlmacenamientoArchivosServer"
									$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
									If ($vt_valor#"")
										$vt_rutaServer:=$vt_valor+SYS_Path2FileName (vtACTdte_rutaArchivo)
										$t_error:=KRL_CopyFileToServer (vtACTdte_rutaArchivo;$vt_rutaServer;True:C214)
										If ($t_error="")
											[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
											SAVE RECORD:C53([ACT_Boletas:181])
											LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" generado con éxito.")
											
										Else 
											LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" no pudo ser almacenado en el servidor.")
										End if 
									Else 
										vtACTdte_errorGen:="-5"
										LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+". Error al almacenar archivo en el servidor. Archivo generado, se debe revisar.")
									End if 
									
								Else 
									CD_Dlog (0;"Documento de texto no generado. Por favor revise el registro de actividades para obtener detalles (error "+vtACTdte_errorGen+").")
								End if 
							End if 
						End if 
					Else 
						CD_Dlog (0;"código no válido")
					End if 
				End if 
			End if 
			
		Else 
			LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+". No se pudo actualizar la ruta del archivo en el registro.")
		End if 
		
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
		
	: ($vt_accion="CopiaDocumentosACarpetas")
		C_TEXT:C284(vtACT_rutaCliente;vtACT_rutaServer)
		$vl_idBoleta:=$vy_pointer1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta)
		
		$vt_documentName:=SYS_Path2FileName ([ACT_Boletas:181]MX_pathFile:32)
		If (vtACT_rutaCliente#"")
			$vt_fullPath:=vtACT_rutaCliente+$vt_documentName
			ACTcfdi_OpcionesGenerales ("ObtieneArchivoDesdeServer";->[ACT_Boletas:181]MX_pathFile:32;->$vt_fullPath)
		End if 
		If (vtACT_rutaServer#"")
			  //obtengo el dcto desde el server...
			$vt_fullPathDestino:=vtACT_rutaServer+SYS_Path2FileName ([ACT_Boletas:181]MX_pathFile:32)
			SYS_CreateFolderOnServer (SYS_GetParentNme ($vt_fullPathDestino))
			$ok:=SYS_CopyFileOnServer ([ACT_Boletas:181]MX_pathFile:32;$vt_fullPathDestino)
			If ($ok=0)
				LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" no pudo ser almacenado en la ruta "+vtACT_rutaServer+".")
			End if 
		End if 
		
	: ($vt_accion="ObtieneGlosaEstadoDTE")
		Case of 
			: (<>gCountryCode="cl")
				Case of 
					: ([ACT_Boletas:181]DTE_estado_id:24=1)
						$vt_retorno:="Documento emitido."
					: ([ACT_Boletas:181]DTE_estado_id:24=3)
						$vt_retorno:="Documento listo para ser generado y enviado."
					: ([ACT_Boletas:181]DTE_estado_id:24=7)
						$vt_retorno:="Documento enviado a DTE."
					: ([ACT_Boletas:181]DTE_estado_id:24 ?? 4)  // se comenta para no perder el detalle del error
						$vt_retorno:=[ACT_Boletas:181]DTE_estado_glosa:34
					: ([ACT_Boletas:181]DTE_estado_id:24=15)
						$vt_retorno:="Respuesta recibida, folio asignado."
				End case 
			Else   //mx//20130408 RCH se agrega caso..
				Case of 
					: ([ACT_Boletas:181]DTE_estado_id:24=1)
						$vt_retorno:="Registro generado."
					: ([ACT_Boletas:181]DTE_estado_id:24=2)
						$vt_retorno:="CFDI (documento de texto) generado."
				End case 
		End case 
		
	: ($vt_accion="CargaArchivoConfiguracion")
		Case of 
			: ($vy_pointer1->="IEV")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Excepción Emisor Receptor")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio Anulado")
				APPEND TO ARRAY:C911($vy_pointer2->;"Operación")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tasa Impuesto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Número Interno")
				APPEND TO ARRAY:C911($vy_pointer2->;"Indicador Serv. Periódico")
				APPEND TO ARRAY:C911($vy_pointer2->;"Indicador Venta Sin costo")
				APPEND TO ARRAY:C911($vy_pointer2->;"Fecha Documento FORMATO AAAA-MM-DD")
				APPEND TO ARRAY:C911($vy_pointer2->;"Código Sucursal")
				APPEND TO ARRAY:C911($vy_pointer2->;"RUT Cliente")
				APPEND TO ARRAY:C911($vy_pointer2->;"Razón Social")
				APPEND TO ARRAY:C911($vy_pointer2->;"Número Id Receptor Extranjero")
				APPEND TO ARRAY:C911($vy_pointer2->;"Nacionalidad Receptor Extranjero")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento Referencia")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio Documento Referencia")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Exento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Neto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto IVA")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA fuera de plazo")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Propio")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Terceros")
				APPEND TO ARRAY:C911($vy_pointer2->;"Ley 18211")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Retenido Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Retenido Parcial")
				APPEND TO ARRAY:C911($vy_pointer2->;"Crédito Empresas Constructoras")
				APPEND TO ARRAY:C911($vy_pointer2->;"Depósito Envases")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA No Retenido")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto No Facturable")
				APPEND TO ARRAY:C911($vy_pointer2->;"Total Monto Periodo")
				APPEND TO ARRAY:C911($vy_pointer2->;"Venta Pasajes Nacional")
				APPEND TO ARRAY:C911($vy_pointer2->;"Venta Pasajes Internacional")
				
			: ($vy_pointer1->="IEC")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Documento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Excepción Emisor")
				APPEND TO ARRAY:C911($vy_pointer2->;"Folio")
				APPEND TO ARRAY:C911($vy_pointer2->;"Anulado")
				APPEND TO ARRAY:C911($vy_pointer2->;"Operación")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tipo Impuesto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tasa del Impuesto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Número Interno")
				APPEND TO ARRAY:C911($vy_pointer2->;"Fecha Documento FORMATO AAAA-MM-DD")
				APPEND TO ARRAY:C911($vy_pointer2->;"Código Sucursal")
				APPEND TO ARRAY:C911($vy_pointer2->;"RUT Proveedor")
				APPEND TO ARRAY:C911($vy_pointer2->;"Razón Social")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Exento")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Neto")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto IVA")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Neto Activo Fijo")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Activo Fijo")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA Uso Común")
				APPEND TO ARRAY:C911($vy_pointer2->;"Impuesto Sin derecho a crédito")
				APPEND TO ARRAY:C911($vy_pointer2->;"Monto Total")
				APPEND TO ARRAY:C911($vy_pointer2->;"IVA No Retenido")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tabaco Puros")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tabaco Cigarrillos")
				APPEND TO ARRAY:C911($vy_pointer2->;"Tabaco Elaborado")
				APPEND TO ARRAY:C911($vy_pointer2->;"Impuesto Vehículo")
				APPEND TO ARRAY:C911($vy_pointer2->;"CodIVANoRec")
				APPEND TO ARRAY:C911($vy_pointer2->;"MntIVANoRec")
				APPEND TO ARRAY:C911($vy_pointer2->;"CodImp")
				APPEND TO ARRAY:C911($vy_pointer2->;"TasaImp")
				APPEND TO ARRAY:C911($vy_pointer2->;"MntImp")
				
		End case 
		
	: ($vt_accion="EncabezadosImportacionDT")
		  //NO CAMBIAR LOS NOMBRES DE LAS COLUMNAS PORQUE SE UTILIZAN PARA UBICAR LA POSICION DE LOS DATOS A IMPORTAR
		AT_Initialize ($vy_pointer1)
		APPEND TO ARRAY:C911($vy_pointer1->;"Número")
		APPEND TO ARRAY:C911($vy_pointer1->;"Fecha")
		APPEND TO ARRAY:C911($vy_pointer1->;"Razón Social")
		APPEND TO ARRAY:C911($vy_pointer1->;"RUT")
		APPEND TO ARRAY:C911($vy_pointer1->;"Dirección")
		APPEND TO ARRAY:C911($vy_pointer1->;"Comuna")
		APPEND TO ARRAY:C911($vy_pointer1->;"Ciudad")
		APPEND TO ARRAY:C911($vy_pointer1->;"Giro")
		APPEND TO ARRAY:C911($vy_pointer1->;"MailEnvioDTE")
		APPEND TO ARRAY:C911($vy_pointer1->;"Neto")
		APPEND TO ARRAY:C911($vy_pointer1->;"Exento")
		APPEND TO ARRAY:C911($vy_pointer1->;"IVA")
		APPEND TO ARRAY:C911($vy_pointer1->;"Total")
		APPEND TO ARRAY:C911($vy_pointer1->;"TipoDocRef")
		APPEND TO ARRAY:C911($vy_pointer1->;"FolioDocRef")
		APPEND TO ARRAY:C911($vy_pointer1->;"CodigRef")
		APPEND TO ARRAY:C911($vy_pointer1->;"RazonRef")
		APPEND TO ARRAY:C911($vy_pointer1->;"FechaRef")
End case 

$0:=$vt_retorno