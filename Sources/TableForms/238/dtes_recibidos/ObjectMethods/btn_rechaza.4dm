
  // Modificado por: Saul Ponce (05/10/2017), Ticket 187901 para que los libros se rechacen directamente en SII

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/10/17, 17:46:41
  // ----------------------------------------------------
  // Método: [ACT_DTEs_Recibidos].dtes_recibidos.btn_rechaza
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If (True:C214)
	CD_Dlog (0;__ ("El rechazo de documentos se debe efectuar directamente en el sitio www.sii.cl."))
Else 
	ARRAY LONGINT:C221($alACT_resultado;0)
	C_BOOLEAN:C305($b_continuar)
	C_LONGINT:C283($l_proc)
	C_TEXT:C284($t_rutReceptor)
	C_LONGINT:C283($l_resp)
	C_TEXT:C284($t_motivorechazo;$t_mensaje)
	
	$b_continuar:=False:C215
	lb_dtesRecibidos{0}:=True:C214
	AT_SearchArray (->lb_dtesRecibidos;"=";->$alACT_resultado)
	
	Case of 
		: (Size of array:C274($alACT_resultado)=0)
			CD_Dlog (0;__ ("Seleccione un documento para utilizar esta opción."))
		: (Size of array:C274($alACT_resultado)>1)
			CD_Dlog (0;__ ("Seleccione sólo un documento para utilizar esta opción."))
		Else 
			$b_continuar:=True:C214
	End case 
	
	If ($b_continuar)
		
		$l_bitEstado:=KRL_GetNumericFieldData (->[ACT_DTEs_Recibidos:238]id:1;->alACT_IdDteRec{$alACT_resultado{1}};->[ACT_DTEs_Recibidos:238]estado_dte:14)
		
		If (Not:C34($l_bitEstado ?? 3))
			$t_motivorechazo:=CD_Request (__ ("Ingrese motivo de rechazo de documento:");__ ("Aceptar");__ ("Cancelar");__ (""))
			If (ok=1)
				If ($t_motivorechazo#"")
					$l_proc:=IT_UThermometer (1;0;__ ("Rechazando documento..."))
					
					$t_rutReceptor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->vlACT_RSSel;->[ACT_RazonesSociales:279]RUT:3)
					$t_mensaje:="El documento tributario: "+atACT_Tipo{$alACT_resultado{1}}+", folio: "+atACT_Folio{$alACT_resultado{1}}+", del proveedor: "+atACT_Emisor{$alACT_resultado{1}}+" será rechazado por el motivo: "+$t_motivorechazo+"."
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("¿Desea continuar?")
					$l_resp:=CD_Dlog (0;$t_mensaje;"";__ ("Si");__ ("No"))
					If ($l_resp=1)
						ACTdteRec_RespondeDTE (atACT_EmisorRUT{$alACT_resultado{1}};$t_rutReceptor;Substring:C12(atACT_Tipo{$alACT_resultado{1}};1;Position:C15(":";atACT_Tipo{$alACT_resultado{1}})-1);Num:C11(atACT_Folio{$alACT_resultado{1}});$t_motivorechazo;alACT_IdDteRec{$alACT_resultado{1}})
					End if 
					IT_UThermometer (-2;$l_proc)
					
				Else 
					CD_Dlog (0;__ ("El motivo de rechazo no puede ser vacío."))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("El documento ya fue rechazado."))
		End if 
	End if 
	
End if 
