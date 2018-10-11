//%attributes = {}
  //WIZ_ACT_GeneracionIEC_IEV 
  //SRACT_SelFecha
TRACE:C157
  //en produccion crear el proceso autorizado
  //If (LICENCIA_esModuloAutorizado (1;12))
If ((LICENCIA_esModuloAutorizado (1;12)) | (<>gRolBD="90468"))  //20150309 RCH El Grange debe solo enviar los libros de venta. No necesariamente con licencia
	If (USR_GetMethodAcces (Current method name:C684))
		WDW_OpenFormWindow (->[ACT_IECV:253];"ACT_Asistente_IEC_IEV";-1;4;__ ("Asistentes"))
		DIALOG:C40([ACT_IECV:253];"ACT_Asistente_IEC_IEV")
		CLOSE WINDOW:C154
		If (ok=1)
			
			C_LONGINT:C283($l_procId)
			
			  //reemplazo formatos de montos 20140930 RCH
			  //VALIDA montos
			  //atACTie_COLUMNA5 // exento
			  //atACTie_COLUMNA6 // neto
			  //atACTie_COLUMNA7 // iva
			  //atACTie_COLUMNA18 // total
			ARRAY POINTER:C280($ap_punteros;0)
			Case of 
				: (cs_totales=1)
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA5)
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA6)
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA7)
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA18)
					
				: (l_compra=1)
					
					
				: (l_venta=1)
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA18)  //exento
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA19)  //neto
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA20)  //iva
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA21)  //iva fuera plazo 
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA22)  //iva propio
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA23)  //iva terceros
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA24)  //ley 18211
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA25)  //iva retenido
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA26)  //iva retenido parcial
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA27)  //credito empresas constructoras
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA28)  //deposito envases
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA29)  //total
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA30)  //iva no retenido
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA31)  //no facturable
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA32)  //monto periodo
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA33)  //venta pasajes nac
					APPEND TO ARRAY:C911($ap_punteros;->atACTie_COLUMNA34)  //venta pasajes inter
					
			End case 
			
			For ($i;1;Size of array:C274($ap_punteros))
				For ($j;1;Size of array:C274($ap_punteros{$i}->))
					  //quito formatos
					If ($ap_punteros{$i}->{$j}#"")
						$ap_punteros{$i}->{$j}:=String:C10(Num:C11($ap_punteros{$i}->{$j}))
					End if 
				End for 
			End for 
			
			Case of 
				: (cs_totales=1)
					$vt_element:="IEV_Resumen"
					$t_accion:="ArchivoIEV"
					$l_tipoOperacion:=2
					
				: (l_compra=1)
					$vt_element:="IEC"
					$t_accion:="ArchivoIEC"
					PREF_Set (0;"ACT_DTE_FactorPropIVA";String:C10(vrACT_Proporcionalidad))
					$l_tipoOperacion:=1
					
				: (l_venta=1)
					$vt_element:="IEV"
					$t_accion:="ArchivoIEV"
					$l_tipoOperacion:=2
					
			End case 
			
			$t_periodo:=String:C10(vlACTdte_YearIE;"0000")+"-"+String:C10(vlACTdte_MesIE;"00")
			
			$l_procId:=IT_UThermometer (1;0;"Generando "+$vt_element+", para el período "+$t_periodo+"...")
			
			ACTcfg_OpcionesRazonesSociales ("CargaByID";->alACTcfg_Razones{atACTcfg_Razones})
			
			  //$vt_ruta:=xfGetDirName ("")
			If (vt_rutaArchivo#"")
				$t_ruta:=SYS_GetParentNme (vt_rutaArchivo)
			Else 
				$t_ruta:=Temporary folder:C486
			End if 
			
			
			If ($t_ruta#"")
				$vt_fileName:="PlantillaImportacion"+$vt_element+DTS_MakeFromDateTime +".txt"
				$vt_fullPath:=$t_ruta+$vt_fileName
				ok:=1
				EM_ErrorManager ("Install")
				EM_ErrorManager ("SetMode";"")
				If (SYS_TestPathName ($vt_fullPath)=1)
					DELETE DOCUMENT:C159($vt_fullPath)
				End if 
				If (ok=1)
					If (SYS_IsWindows )
						USE CHARACTER SET:C205("windows-1252";0)
					Else 
						USE CHARACTER SET:C205("MacRoman";0)
					End if 
					
					  //genera archivo de texto segun formato necesario
					$ref:=Create document:C266($vt_fullPath;"TEXT")
					$t_rutaArchivo:=document
					$t_rutaArchivo2Del:=$t_rutaArchivo
					ARRAY TEXT:C222($atACT_Campos;0)
					
					IT_UThermometer (0;$l_procId;"Generando txt...")
					$t_line:=""
					ACTdte_OpcionesGeneralesIE ("CargaArchivoConfiguracion";->$vt_element;->$atACT_Campos)
					IO_SendPacket ($ref;AT_array2text (->$atACT_Campos;"\t")+"\r\n")
					For ($i;1;Size of array:C274(atACTie_COLUMNA3))
						$t_line:=atACTie_COLUMNA1{$i}+"\t"+atACTie_COLUMNA2{$i}+"\t"+atACTie_COLUMNA3{$i}+"\t"+atACTie_COLUMNA4{$i}+"\t"+atACTie_COLUMNA5{$i}+"\t"+atACTie_COLUMNA6{$i}+"\t"+atACTie_COLUMNA7{$i}+"\t"+atACTie_COLUMNA8{$i}+"\t"+atACTie_COLUMNA9{$i}+"\t"+atACTie_COLUMNA10{$i}+"\t"+atACTie_COLUMNA11{$i}+"\t"+atACTie_COLUMNA12{$i}+"\t"+atACTie_COLUMNA13{$i}+"\t"+atACTie_COLUMNA14{$i}+"\t"+atACTie_COLUMNA15{$i}+"\t"+atACTie_COLUMNA16{$i}+"\t"+atACTie_COLUMNA17{$i}+"\t"+atACTie_COLUMNA18{$i}+"\t"+atACTie_COLUMNA19{$i}+"\t"+atACTie_COLUMNA20{$i}+"\t"+atACTie_COLUMNA21{$i}+"\t"+atACTie_COLUMNA22{$i}+"\t"+atACTie_COLUMNA23{$i}+"\t"+atACTie_COLUMNA24{$i}+"\t"+atACTie_COLUMNA25{$i}+"\t"+atACTie_COLUMNA26{$i}+"\t"+atACTie_COLUMNA27{$i}+"\t"+atACTie_COLUMNA28{$i}+"\t"+atACTie_COLUMNA29{$i}+"\t"+atACTie_COLUMNA30{$i}
						IO_SendPacket ($ref;$t_line+"\r\n")
					End for 
					CLOSE DOCUMENT:C267($ref)
					  //ACTcd_DlogWithShowOnDisk ($vt_fullPath;0;__ ("Plantilla creada con éxito.")+<>cr+<>cr+__ ("Encontrará el archivo en la ruta: ")+ST_Qte ($vt_fullPath))
					
					IT_UThermometer (0;$l_procId;"Creando IE...")
					  //guarda iecv
					C_BLOB:C604($x_blobArchivo)
					DOCUMENT TO BLOB:C525($t_rutaArchivo;$x_blobArchivo)
					  //$l_id:=ACTiecv_createRecord ($l_tipoOperacion;$t_periodo;$x_blobArchivo;alACTcfg_Razones{atACTcfg_Razones})
					$l_id:=ACTiecv_createRecord ($l_tipoOperacion;$t_periodo;$x_blobArchivo;alACTcfg_Razones{atACTcfg_Razones};1;3;0;vrACT_folioNotif;vtACT_CodAut)
					
					IT_UThermometer (0;$l_procId;"Generando txt según formato requerido...")
					  //carga archivo a arreglos
					  //$t_rutaArchivo:=ACTdte_GeneraArchivo ($t_accion;->$t_rutaArchivo;->$l_id)
					$t_txtIE:=ACTdte_GeneraArchivo ($t_accion;->$t_rutaArchivo;->$l_id)
					
					  //$t_txtIE:=_0000_TestsSJC
					
					IT_UThermometer (0;$l_procId;"Enviando txt...")
					  //envia archivo
					C_TEXT:C284($vt_estado)
					If ($t_rutaArchivo#"")
						  //$vt_estado:=ACTdte_SendFiles2FTP ($t_rutaArchivo)
						  //If ($vt_estado="transferido")
						  //$l_estado:=1
						  //If (Not(ACTiecv_actualizaEstado ($l_id;$l_estado)))
						  //$t_parametro:=ST_Concatenate ("";->$l_id;->$l_estado)
						  //BM_CreateRequest ("ACT_ActualizaEstadoLibro";$t_parametro;$t_parametro)
						  //End if 
						  //
						  //Else 
						  //ACTdte_LogAction ("Se produjo un error en el envío del libro de ventas";True;True)
						  //End if 
						$vt_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->alACTcfg_Razones{atACTcfg_Razones};->[ACT_RazonesSociales:279]RUT:3)
						  //$vt_rut:=Replace string(SR_FormatoRUT2 ($vt_rut);".";"")
						$vt_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$vt_rut)
						Case of 
							: ($t_accion="ArchivoIEC")
								$vl_Result:=WSact_GeneraLibrosContables ($vt_rut;$t_txtIE;"compra")
							: ($t_accion="ArchivoIEV")
								$vl_Result:=WSact_GeneraLibrosContables ($vt_rut;$t_txtIE;"venta")
						End case 
						
						If ($vl_Result=1)
							$l_estado:=1
							If (Not:C34(ACTiecv_actualizaEstado ($l_id;$l_estado)))
								$t_parametro:=ST_Concatenate ("";->$l_id;->$l_estado)
								BM_CreateRequest ("ACT_ActualizaEstadoLibro";$t_parametro;$t_parametro)
							End if 
							
							ACTiecv_obtieneEstadoDesdeDTE ($l_id)
							  //
							  //If ((vlWS_folioDTE#0) | (vtWS_glosa#""))
							  //[ACT_IECV]estado:=[ACT_IECV]estado ?+ 2
							  //[ACT_IECV]id_iecv_dtenet:=vlWS_folioDTE
							  //[ACT_IECV]glosa_procesamiento_dtenet:=vtWS_glosa
							  //If (vtWS_glosa="OK Procesamiento TXT@")
							  //[ACT_IECV]estado:=[ACT_IECV]estado ?+ 3
							  //End if 
							  //SAVE RECORD([ACT_IECV])
							  //End if 
							
						End if 
						
					End if 
					
					IT_UThermometer (0;$l_procId;"Eliminando txt local...")
					  //elimina archivo generado
					DELETE DOCUMENT:C159($t_rutaArchivo2Del)
					
					IT_UThermometer (0;$l_procId;"Esperando a DTENet...")
					
					  //ACTiecv_obtieneEstadoDesdeDTE ($l_id)
					
					IT_UThermometer (-2;$l_procId)
					
					USE CHARACTER SET:C205(*;0)
					
					  //interfaz manejo de libros
					WIZ_ACT_ManejoIEC_IEV 
					
				Else 
					CD_Dlog (0;__ ("No fue posible generar el archivo. Revise si el archivo está en uso.")+"\r\r"+__ ("Intente más tarde."))
				End if 
				EM_ErrorManager ("Clear")
			End if 
			
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 