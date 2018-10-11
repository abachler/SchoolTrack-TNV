//%attributes = {}
  //ACTdte_EnviaRecibeArchivos

C_TEXT:C284($1;$vt_accion;$vt_path)
C_TEXT:C284($0;$vt_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4;$ptr5;$ptr6;$ptr7)
C_LONGINT:C283($i;$vl_idBoleta)
C_LONGINT:C283($vl_idBoleta)
C_TEXT:C284($vt_parametro;$vt_estado;$vt_tipoDoc)
C_LONGINT:C283($vl_procesados)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
Case of 
	: ($vt_accion="EnviaRegistrosDT")
		If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
			
			While (Semaphore:C143("ACT_GeneraDTEs"))  //solo se inicia un proceso a la vez. Puede ser que el proceso en background emita. Cuando se lanza el proceso desde el menu, se esperara que termine...
				IDLE:C311
				DELAY PROCESS:C323(Current process:C322;20)
			End while 
			
			ARRAY LONGINT:C221($alACT_recNumsDT;0)
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Emitido_desde:27;<)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$alACT_recNumsDT;"")
			For ($i;1;Size of array:C274($alACT_recNumsDT))
				READ WRITE:C146([ACT_Boletas:181])
				GOTO RECORD:C242([ACT_Boletas:181];$alACT_recNumsDT{$i})
				If (Not:C34(Locked:C147([ACT_Boletas:181])))
					If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2))
						  //genera archivo de texto
						  //[ACT_Boletas]MX_pathFile
						  //$vt_parametro:=ACTdte_GeneraArchivo ("GeneraDctoTexto";->[ACT_Boletas]ID)
						  //If ($vt_parametro#"")
						  //READ WRITE([ACT_Boletas])
						  //GOTO RECORD([ACT_Boletas];$alACT_recNumsDT{$i})
						  //  //$vl_procesados:=$vl_procesados+Num(ACTdte_EnviaRecibeArchivos ("EnviaArchivo";->$alACT_recNumsDT{$i};->$vt_path))
						  //End if 
						$vl_procesados:=$vl_procesados+ACTdte_EmiteDocumento ([ACT_Boletas:181]ID:1)
					End if 
				End if 
				KRL_UnloadReadOnly (->[ACT_Boletas:181])
			End for 
			  // envia registros al ftp... 
			
			CLEAR SEMAPHORE:C144("ACT_GeneraDTEs")
			
		End if 
		$vt_retorno:=String:C10($vl_procesados)
		
	: ($vt_accion="EnviaArchivo")
		TRACE:C157
		  //$vl_idBoleta:=$ptr1->
		  //$vt_path:=$ptr2->
		  //$vt_estado:=ACTdte_SendFiles2FTP ($vt_path)
		  //If ($vt_estado="transferido")
		  //READ WRITE([ACT_Boletas])
		  //GOTO RECORD([ACT_Boletas];$vl_idBoleta)
		  //  //[ACT_Boletas]DTE_id_estado:=4
		  //[ACT_Boletas]DTE_estado_id:=[ACT_Boletas]DTE_estado_id ?+ 2
		  //[ACT_Boletas]DTE_log:=vt_msg+ST_Boolean2Str ([ACT_Boletas]DTE_log="";"";<>cr)+[ACT_Boletas]DTE_log
		  //SAVE RECORD([ACT_Boletas])
		  //KRL_UnloadReadOnly (->[ACT_Boletas])
		  //$vt_retorno:="1"
		  //Else 
		  //$vt_retorno:="0"
		  //End if 
		
	: ($vt_accion="RecibeRegistrosDT")
		TRACE:C157
		  //C_BOOLEAN($b_esperarRespuesta)
		  //If (Not(Nil($ptr1)))
		  //$b_esperarRespuesta:=$ptr1->
		  //End if 
		  //ARRAY LONGINT($alACT_recNumsDT;0)
		  //LONGINT ARRAY FROM SELECTION([ACT_Boletas];$alACT_recNumsDT;"")
		  //For ($i;1;Size of array($alACT_recNumsDT))
		  //READ WRITE([ACT_Boletas])
		  //GOTO RECORD([ACT_Boletas];$alACT_recNumsDT{$i})
		  //If (Not(Locked([ACT_Boletas])))
		  //  //If ([ACT_Boletas]DTE_id_estado=4)
		  //If (([ACT_Boletas]DTE_estado_id ?? 2) & (Not([ACT_Boletas]DTE_estado_id ?? 3)))
		  //C_LONGINT($l_folio)
		  //C_TEXT($vt_glosa)
		  //  //$l_folio:=WSact_getFolioDTE ([ACT_Boletas]ID)
		  //$ok:=WSact_getFolioDTE ([ACT_Boletas]ID;->$l_folio;->$vt_glosa;[ACT_Boletas]codigo_SII)
		  //If (ok=1)
		  //If (($l_folio#0) | ($vt_glosa#""))
		  //$b_continuar:=True
		  //If (($vt_glosa="Documento no encontrado.") & ($b_esperarRespuesta))
		  //$b_continuar:=False
		  //End if 
		  //
		  //If ($b_continuar)
		  //GOTO RECORD([ACT_Boletas];$alACT_recNumsDT{$i})
		  //  //[ACT_Boletas]DTE_id_estado:=8
		  //
		  //ACTcfdi_OpcionesGenerales ("OnLoadConf";->[ACT_Boletas]ID_RazonSocial)
		  //
		  //[ACT_Boletas]DTE_estado_id:=[ACT_Boletas]DTE_estado_id ?+ 3
		  //If ($l_folio>0)
		  //$vl_docs:=Num(ACTbol_OpcionesGenerales ("BuscaDocDuplicado";->[ACT_Boletas]TasaIVA;->$l_folio;->[ACT_Boletas]ID_Categoria;->[ACT_Boletas]documento_electronico;->[ACT_Boletas]ID_RazonSocial))
		  //If ($vl_docs>0)
		  //TRACE
		  //[ACT_Boletas]DTE_estado_id:=[ACT_Boletas]DTE_estado_id ?+ 4
		  //[ACT_Boletas]Numero:=0
		  //$vt_glosa:="Error - Boleta con folio duplicado en BD. Folio que se iba a asignar: "+String($l_folio)+"."
		  //Else 
		  //[ACT_Boletas]Numero:=$l_folio
		  //End if 
		  //Else 
		  //  //error...
		  //[ACT_Boletas]DTE_estado_id:=[ACT_Boletas]DTE_estado_id ?+ 4
		  //End if 
		  //[ACT_Boletas]DTE_estado_glosa:=$vt_glosa
		  //SAVE RECORD([ACT_Boletas])
		  //
		  //$vl_procesados:=$vl_procesados+1
		  //End if 
		  //End if 
		  //End if 
		  //End if 
		  //End if 
		  //KRL_UnloadReadOnly (->[ACT_Boletas])
		  //End for 
		  //$vt_retorno:=String($vl_procesados)
		
	: ($vt_accion="ValidaEmisionDTE")
		$vl_idBoleta:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta)
		$vt_tipoDoc:=[ACT_Boletas:181]codigo_SII:33
		$vl_idApdo:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_Apoderado:14)
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idApdo)
		
		Case of 
			: (([ACT_RazonesSociales:279]comuna:8="") & (($vt_tipoDoc="33") | ($vt_tipoDoc="34") | ($vt_tipoDoc="52")))
				  //$vt_retorno:="0"  `error. No se puede emitir el documento en DTENET
				$vt_retorno:="Error. Debe tener comuna ingresada, en Configuración/Generales, antes de poder em"+"iir un documento tributario electrónico."  //error. No se puede emitir el documento en DTENET
				
			: (([ACT_RazonesSociales:279]direccion:7="") & (($vt_tipoDoc="33") | ($vt_tipoDoc="34") | ($vt_tipoDoc="52")))
				  //$vt_retorno:="0"  `error. No se puede emitir el documento en DTENET
				$vt_retorno:="Error. Debe tener dirección ingresada, en Configuración/Generales, antes de poder"+" emitr un documento tributario electrónico."  //error. No se puede emitir el documento en DTENET
				
			: ([ACT_RazonesSociales:279]giro:18="")
				$vt_retorno:="Error. Debe tener giro ingresado, en Configuración/Generales, antes de poder emit"+"ir un documento tributario electrónico."  //error. No se puede emitir el documento en DTENET
				
			Else 
				$vt_retorno:=""  //continua
		End case 
		
End case 
$0:=$vt_retorno