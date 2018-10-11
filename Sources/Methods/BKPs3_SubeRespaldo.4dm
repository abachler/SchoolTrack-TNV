//%attributes = {"executedOnServer":true}
  // Método: BKPs3_SubeRespaldo
  // código original de: ??
  // modificado por Alberto Bachler Klein el 16/02/18, 16:50:31
  // eliminación del llamado innecesario a STR_ReadGlobals
  // remplazo de codigo duplicado en varios métodos por llamado a la funcion 
  // BKP_UltimoRespaldoDisponible que devuelve la ruta del ultimo disponible
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($l_indice)
C_LONGINT:C283($vl_httpReponseStatus)
C_BLOB:C604($vx_requestBodyBlob;$vx_responseBodyBlob)
C_BLOB:C604($x_blob)
C_TIME:C306($h_ref)
C_TEXT:C284($t_json;$t_nombreArchivo;$t_rutaCarpetaRespaldos)
C_BOOLEAN:C305($b_continuar;$b_errorEnSubida)
C_TEXT:C284($t;$t_archivoNuevo)
C_TEXT:C284($vt_bucket;$vt_httpVerb;$vt_uri;$vt_uriBase;$t_accion)
C_OBJECT:C1216($ob;$ob_ref)
C_LONGINT:C283($l_intentos;$l_permite;$l_pos)
C_TEXT:C284($t_body;$t_etag;$t_idUpload;$t_rutaDocumento)
C_LONGINT:C283($l_objetos)

  //objetos para subir partes del archivo
C_OBJECT:C1216($ob_base)
C_OBJECT:C1216($ob_parte)

C_TEXT:C284($t_location)
ARRAY OBJECT:C1221($ao_objetos;0)
ARRAY OBJECT:C1221(ao_objetos;0)

ARRAY TEXT:C222($tt_requestHeadersArray;0)
ARRAY TEXT:C222($tt_responseHeadersArray;0)

C_BOOLEAN:C305(<>bXS_esServidorOficial)




  //TRACE
If (Count parameters:C259=1)
	$t_rutaDocumento:=$1
Else 
	$t_rutaDocumento:=BKP_UltimoRespaldoDisponible 
End if 


If (<>bXS_esServidorOficial)
	$l_permite:=Num:C11(PREF_fGet (0;"AWS_PERMITE_ENVIO_CLG";"1"))  // para controlar por si en algún momento necesitamos que no se envíen más los respaldos a AWS
	If ($l_permite=1)
		
		$l_permite:=Num:C11(PREF_fGet (0;"AWS_COLEGIO_PERMITE_ENVIO_CLG";"1"))  // para que el colegio decida si envía o no la base de datos
		If ($l_permite=1)
			
			BKPs3_LoadConfig 
			
			If ((<>gCountryCode#"") & (<>gRolBD#""))
				  //Crear carpeta en S3
				$vt_bucket:="bases-st"
				$vt_uriBase:="/"+ST_Uppercase (<>gCountryCode)+"/"+ST_Uppercase (<>gRolBD)+"/"
				$vt_httpVerb:=HTTP PUT method:K71:6
				
				
				$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uriBase;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
				If ($vl_httpReponseStatus=200)
					BKPs3_EscribeLog (Current method name:C684+". http: "+String:C10($vl_httpReponseStatus))
					
					
					
					
					If (Test path name:C476($t_rutaDocumento)=Is a document:K24:1)
						$t_nombreArchivo:=SYS_Path2FileName ($t_rutaDocumento)
						  //Lista de Buckets para eliminar posterior al envio correcto
						ARRAY TEXT:C222($at_keys;0)
						ARRAY REAL:C219($ar_keysPesos;0)
						$vt_bucket:="bases-st"
						$vt_uri:="/?list-type=2&prefix="+Substring:C12($vt_uriBase;2;Length:C16($vt_uriBase))+"&delimiter=/"
						$vt_httpVerb:=HTTP GET method:K71:1
						$t_accion:="keys"
						
						$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
						If ($vl_httpReponseStatus=200)  //ASM
							$t:=BKPs3_AnalizaRespuesta ($t_accion;$vx_responseBodyBlob;->$at_keys;->$ar_keysPesos)
							
							BKPs3_EscribeLog ("Lista de archivos. Respuesta http: "+String:C10($vl_httpReponseStatus)+". Datos: "+AT_Arrays2Text ("\n";"\t";->$at_keys;->$ar_keysPesos)+".")
							
							  //para evitar que un mismo archivo se suba 2 veces.
							$b_continuar:=True:C214
							
							
							$vt_version:=PREF_fGet (0;"VersionResource")
							If ($vt_version#"")
								$t_archivoNuevo:=Substring:C12($vt_uriBase;2;Length:C16($vt_uriBase))+"v"+$vt_version+"_"+$t_nombreArchivo
							End if 
							
							
							$l_pos:=Find in array:C230($at_keys;$t_archivoNuevo)
							If ($l_pos>0)
								If (Get document size:C479($t_rutaDocumento)=$ar_keysPesos{$l_pos})
									$b_continuar:=False:C215
								End if 
							End if 
							
							If ($b_continuar)
								
								$t_location:=""
								  //Inicia subida
								  //Obiene id para envio.
								$vt_bucket:="bases-st"
								$vt_uri:=$vt_uriBase+"v"+$vt_version+"_"+$t_nombreArchivo+"?uploads="
								$vt_httpVerb:=HTTP POST method:K71:2
								$t_accion:="uploads"
								$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
								If ($vl_httpReponseStatus=200)
									$t_idUpload:=BKPs3_AnalizaRespuesta ($t_accion;$vx_responseBodyBlob)
									
									OB SET:C1220($ob_base;"ruta";$t_rutaCarpetaRespaldos)
									OB SET:C1220($ob_base;"archivo";"v"+$vt_version+"_"+$t_nombreArchivo)
									OB SET:C1220($ob_base;"fullpath";$t_rutaDocumento)
									OB SET:C1220($ob_base;"fullpath";$t_rutaDocumento)
									OB SET:C1220($ob_base;"peso";Get document size:C479($t_rutaDocumento))
									OB SET:C1220($ob_base;"uploadid";$t_idUpload)
									
									  //Sube por parte
									  //envia archivo
									C_LONGINT:C283($l_indice)
									C_TIME:C306($h_ref)
									
									
									$l_MBytesTotal:=Get document size:C479($t_rutaDocumento)/1024/1024
									$l_MBytesSended:=0
									$h_ref:=Open document:C264($t_rutaDocumento;Read mode:K24:5)
									ok:=1
									$l_progreso:=Progress New 
									Progress SET TITLE ($l_progreso;"Enviando respaldo de la base de datos a Amazon S3...")
									While (ok=1)
										$l_indice:=$l_indice+1
										If ($l_indice<=10000)  //límite 5 GB
											
											ARRAY TEXT:C222($tt_requestHeadersArray;0)
											ARRAY TEXT:C222($tt_responseHeadersArray;0)
											SET BLOB SIZE:C606($vx_requestBodyBlob;0)
											SET BLOB SIZE:C606($vx_responseBodyBlob;0)
											
											RECEIVE PACKET:C104($h_ref;$vx_requestBodyBlob;5500000)
											$l_MBytesSended:=$l_MBytesSended+(BLOB size:C605($vx_requestBodyBlob)/1024/1024)
											
											$vt_bucket:="bases-st"
											$vt_uri:=$vt_uriBase+"v"+$vt_version+"_"+$t_nombreArchivo+"?partNumber="+String:C10($l_indice)+"&uploadId="+$t_idUpload
											$vt_httpVerb:=HTTP PUT method:K71:6
											$t_accion:="uploadpart"
											If (BLOB size:C605($vx_requestBodyBlob)>0)
												
												$l_intentos:=0  // Se intenta 5 veces. En caso de error, se cancela el envío.
												$vl_httpReponseStatus:=0
												While (($l_intentos<=5) & ($vl_httpReponseStatus#200))
													$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
													$l_intentos:=$l_intentos+1
												End while 
												If ($l_intentos<=5)
													$b_errorEnSubida:=False:C215
												Else 
													$b_errorEnSubida:=True:C214
												End if 
												
												If ($b_errorEnSubida)
													ok:=0  //No pude enviar una parte y me salgo del ciclo.
												Else 
													  //Obtiene etag para enviarlo en la solicitud de validación
													$t_etag:=""
													$l_pos:=Find in array:C230($tt_responseHeadersArray;"ETag: @")
													If ($l_pos>0)
														$t_etag:=Replace string:C233(Replace string:C233($tt_responseHeadersArray{$l_pos};"ETag: ";"");Char:C90(34);"")
													End if 
													OB SET:C1220($ob_parte;"numeroparte";$l_indice)
													OB SET:C1220($ob_parte;"etag";$t_etag)
													$ob_ref:=OB Copy:C1225($ob_parte)
													APPEND TO ARRAY:C911($ao_objetos;$ob_ref)
												End if 
												Progress SET PROGRESS ($l_progreso;$l_MBytesSended/$l_MBytesTotal;String:C10($l_MBytesSended;"### ##0 MB")+" / "+String:C10($l_MBytesTotal;"### ##0 MB"))
											End if 
											  //Else 
											  //ok:=0
											  //$b_errorEnSubida:=True
										End if 
									End while 
									CLOSE DOCUMENT:C267($h_ref)
									Progress QUIT ($l_progreso)
									OB SET ARRAY:C1227($ob_base;"partes";$ao_objetos)
									
									ARRAY TEXT:C222($tt_requestHeadersArray;0)
									ARRAY TEXT:C222($tt_responseHeadersArray;0)
									SET BLOB SIZE:C606($vx_requestBodyBlob;0)
									SET BLOB SIZE:C606($vx_responseBodyBlob;0)
									
									If ($b_errorEnSubida)
										  //  //elimina upload
										$vt_bucket:="bases-st"
										$vt_uri:=$vt_uriBase+"v"+$vt_version+"_"+$t_nombreArchivo+"?uploadId="+$t_idUpload
										$vt_httpVerb:=HTTP DELETE method:K71:5
										$t_accion:="elimina"
										$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
										
										BKPs3_EscribeLog ("Error al subir archivo "+$t_rutaDocumento+". Error: "+String:C10($vl_httpReponseStatus)+", parte: "+String:C10($l_indice)+".")
									Else 
										  //Confirma upload
										$vt_bucket:="bases-st"
										$vt_uri:=$vt_uriBase+"v"+$vt_version+"_"+$t_nombreArchivo+"?uploadId="+$t_idUpload
										$vt_httpVerb:=HTTP POST method:K71:2
										$t_body:="<CompleteMultipartUpload>"
										For ($l_objetos;1;Size of array:C274($ao_objetos))
											$t_body:=$t_body+"<Part>"
											$t_body:=$t_body+"<PartNumber>"+String:C10(OB Get:C1224($ao_objetos{$l_objetos};"numeroparte"))+"</PartNumber>"
											$t_body:=$t_body+"<ETag>"+ST_Qte (OB Get:C1224($ao_objetos{$l_objetos};"etag"))+"</ETag>"
											$t_body:=$t_body+"</Part>"
										End for 
										$t_body:=$t_body+"</CompleteMultipartUpload>"
										CONVERT FROM TEXT:C1011($t_body;"UTF-8";$vx_requestBodyBlob)
										$t_accion:="confirma"
										$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
										If ($vl_httpReponseStatus=200)  //ASM
											$t_location:=BKPs3_AnalizaRespuesta ($t_accion;$vx_responseBodyBlob)
											
											BKPs3_EscribeLog ("Archivo: "+$t_rutaDocumento+" subido. Respuesta http: "+String:C10($vl_httpReponseStatus)+". Ubicación: "+$t_location+".")
											
											OB SET ARRAY:C1227($ob_base;"respuestahttp";$vl_httpReponseStatus)
											OB SET ARRAY:C1227($ob_base;"archivo";$t_location)
											
											If (($vl_httpReponseStatus=200) & ($t_location#""))
												  //elimina previos
												For ($l_indice;1;Size of array:C274($at_keys))
													ARRAY TEXT:C222($tt_requestHeadersArray;0)
													ARRAY TEXT:C222($tt_responseHeadersArray;0)
													SET BLOB SIZE:C606($vx_requestBodyBlob;0)
													SET BLOB SIZE:C606($vx_responseBodyBlob;0)
													
													If ($at_keys{$l_indice}#$t_archivoNuevo)  //para evitar que el archivo que está subiendo se elimine por si un intento anterior dejó el archivo a medio subir.
														$vt_bucket:="bases-st"
														$vt_uri:=$at_keys{$l_indice}
														$vt_httpVerb:=HTTP DELETE method:K71:5
														$t_accion:="elimina"
														$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
														If ($vl_httpReponseStatus=200)
															BKPs3_EscribeLog ("Archivo: "+$at_keys{$l_indice}+" eliminado. Respuesta hoot: "+String:C10($vl_httpReponseStatus)+".")
														Else 
															$l_indice:=Size of array:C274($at_keys)+1
															BKPs3_EscribeLog ("Se produjo un problema en la conexión con Amazon.")
														End if 
													End if 
												End for 
											End if 
										Else 
											BKPs3_EscribeLog ("Se produjo un problema en la conexión con Amazon.")
										End if 
									End if 
									
								Else 
									BKPs3_EscribeLog ("Error al solicitar uploadid. Respuesta http: "+String:C10($vl_httpReponseStatus)+".")
								End if 
								
							Else 
								BKPs3_EscribeLog ("Archivo "+$t_rutaDocumento+" ya existe en directorio.")
							End if 
						Else 
							BKPs3_EscribeLog ("Se produjo un problema en la conexión con Amazon.")
						End if 
					Else 
						BKPs3_EscribeLog ("No se encontró ningún respaldo")
					End if 
					
				Else 
					BKPs3_EscribeLog ("Se produjo un problema en la conexión con Amazon.")
				End if 
				  //BKPs3_EscribeLog ("Datos obligatorios vacíos.")
			End if 
		Else 
			BKPs3_EscribeLog ("Envío no permitido por colegio.")
		End if 
	Else 
		BKPs3_EscribeLog ("Envío no permitido.")
	End if 
Else 
	BKPs3_EscribeLog ("La máquina no es servidor oficial.")
End if 