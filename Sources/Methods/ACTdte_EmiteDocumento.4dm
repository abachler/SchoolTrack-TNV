//%attributes = {}
  //ACTdte_EmiteDocumento
  //20140809 RCH DTE

C_LONGINT:C283($1)
C_TEXT:C284($t_parametro)
C_LONGINT:C283($0;$l_emitido;$l_idRS;$vl_Result)
C_TEXT:C284($vt_rut)
C_TEXT:C284($vt_parametro)

  //USE CHARACTER SET("latin1";1)

$l_idBoleta:=$1
If (Count parameters:C259>=2)
	$vt_parametro:=$2
End if 

If ($vt_parametro="")
	$vt_parametro:=ACTdte_GeneraArchivo ("GeneraDctoTexto";->$l_idBoleta)
End if 

If ((<>Shift) & (<>CapsLock))  //20170503 RCH Para probar cuando hay error en la firma. Al hacer el proceso desde la ficha del DT.
	C_TEXT:C284($t_param)
	$t_param:=$vt_parametro
	$vt_parametro:=ST_ReplaceCharByAsciiCode ($vt_parametro;"ñ";"n")
	$vt_parametro:=ST_ReplaceCharByAsciiCode ($vt_parametro;"Ñ";"N")
	$vt_parametro:=ST_ReplaceCharByAsciiCode ($vt_parametro;"º";"o")
	$vt_parametro:=ST_ReplaceCharByAsciiCode ($vt_parametro;"°";"o")
	$vt_parametro:=ST_ReplaceAccentedChars ($vt_parametro)
	$t_param:=$t_param+"\r\r"+$vt_parametro
	SET TEXT TO PASTEBOARD:C523($t_param)
	TRACE:C157
End if 

If ($vt_parametro#"")
	  //por problemas con nombre de colegio saint paul
	C_BLOB:C604($xBlob)
	CONVERT FROM TEXT:C1011($vt_parametro;"latin1";$xBlob)
	$vt_parametro:=Convert to text:C1012($xBlob;"latin1")
	
	KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)
	If (ok=1)
		
		  // Modificado por: Saúl Ponce (06-09-2018) Ticket Nº 215581, evitar que se envíe un documento tributario que ya tenga asignado un número (folio) de documento 
		If ([ACT_Boletas:181]Numero:11=0)
			
			  //$vl_procesados:=$vl_procesados+Num(ACTdte_EnviaRecibeArchivos ("EnviaArchivo";->$alACT_recNumsDT{$i};->$vt_path))
			READ ONLY:C145([ACT_RazonesSociales:279])
			If ([ACT_Boletas:181]ID_RazonSocial:25=0)
				$l_idRS:=-1
			Else 
				$l_idRS:=[ACT_Boletas:181]ID_RazonSocial:25
			End if 
			$vt_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$l_idRS;->[ACT_RazonesSociales:279]RUT:3)
			  //$vt_rut:=Replace string(SR_FormatoRUT2 ($vt_rut);".";"")
			$vt_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$vt_rut)
			Case of 
				: (([ACT_Boletas:181]codigo_SII:33="41") | ([ACT_Boletas:181]codigo_SII:33="39"))
					$vl_Result:=WSact_GeneraBoleta ($vt_rut;"";$vt_parametro)
				Else 
					$vl_Result:=WSact_GeneraDocumento ($vt_rut;"";$vt_parametro)
			End case 
			
			If (vtWS_glosa#"")
				[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 2
				[ACT_Boletas:181]DTE_estado_glosa:34:=vtWS_glosa
				
				If ($vl_Result=1)
					  //20180827 RCH Porque en algunos casos no se almacena la info de folio. Ejemplo: Ticket 215186
					LOG_RegisterEvt ("Numeración recibida para DTE id: "+String:C10([ACT_Boletas:181]ID:1)+". Folio recibido: "+String:C10(vlWS_folioDTE)+", glosa: "+vtWS_glosa+".")
					[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 3
					SAVE RECORD:C53([ACT_Boletas:181])
					FLUSH CACHE:C297
					
					ACTcfdi_OpcionesGenerales ("OnLoadConf";->[ACT_Boletas:181]ID_RazonSocial:25)
					
					  //[ACT_Boletas]DTE_estado_id:=[ACT_Boletas]DTE_estado_id ?+ 3
					KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)  //20180827 RCH
					If (vlWS_folioDTE>0)
						$vl_docs:=Num:C11(ACTbol_OpcionesGenerales ("BuscaDocDuplicado";->[ACT_Boletas:181]TasaIVA:16;->vlWS_folioDTE;->[ACT_Boletas:181]ID_Categoria:12;->[ACT_Boletas:181]documento_electronico:29;->[ACT_Boletas:181]ID_RazonSocial:25))
						If ($vl_docs>0)
							CD_Dlog (0;"Por favor revise que el documento "+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->[ACT_Boletas:181]codigo_SII:33)+", emitido con folio "+String:C10(vlWS_folioDTE)+" no esté duplicado.")
						End if 
						KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)  //20180827 RCH
						[ACT_Boletas:181]Numero:11:=vlWS_folioDTE
						$l_emitido:=1
					Else 
						  //error...
						[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 4
					End if 
					
				Else 
					[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 4
				End if 
				
				SAVE RECORD:C53([ACT_Boletas:181])
				
				If ([ACT_Boletas:181]DTE_estado_id:24 ?? 4)
					ACTbol_AnulaDcto (False:C215)
					  //20151003 RCH si se anula, se elimina
					KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)
					LOG_RegisterEvt ("Eliminación de Documento Tributario por error en emisión de documento electrónico. Error: "+vtWS_glosa+". Parámetro: "+$vt_parametro)
					DELETE RECORD:C58([ACT_Boletas:181])
					KRL_UnloadReadOnly (->[ACT_Boletas:181])
				End if 
				
			End if 
			
		End if 
	End if 
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
End if 
$0:=$l_emitido

  //USE CHARACTER SET(*;1)

  //$vt_rut:=Replace string(ST_FormatoRUT([archivos_procesados]rut);".";"")
  //Case of 
  //: ([archivos_procesados]id_tipo_archivo_sii="IEV")
  //$vl_Result:=WSact_GeneraLibrosContables ($vt_rut;$vt_parametro;"venta")
  //: ([archivos_procesados]id_tipo_archivo_sii="IEC")
  //$vl_Result:=WSact_GeneraLibrosContables ($vt_rut;$vt_parametro;"compra")
  //: (([archivos_procesados]id_tipo_archivo_sii="41") | ([archivos_procesados]id_tipo_archivo_sii="39"))
  //$vl_Result:=WSact_GeneraBoleta ($vt_rut;"";$vt_parametro)
  //Else 
  //$vl_Result:=WSact_GeneraDocumento ($vt_rut;"";$vt_parametro)
  //End case 
