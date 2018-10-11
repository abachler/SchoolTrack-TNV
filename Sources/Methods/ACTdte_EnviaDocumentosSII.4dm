//%attributes = {}
  //ACTdte_EnviaDocumentosSII

C_LONGINT:C283($vl_records)

If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	
	$vl_records:=BWR_SearchRecords 
	If ($vl_records>0)
		C_LONGINT:C283($l_proc;$l_indice)
		C_REAL:C285($r_idRS)
		C_TEXT:C284($t_rut)
		ARRAY LONGINT:C221($ar_idsRS;0)
		DISTINCT VALUES:C339([ACT_Boletas:181]ID_RazonSocial:25;$ar_idsRS)
		$l_proc:=IT_UThermometer (1;0;"Enviando al SII...")
		For ($l_indice;1;Size of array:C274($ar_idsRS))
			$r_idRS:=$ar_idsRS{$l_indice}
			If ($r_idRS=0)
				$r_idRS:=-1
			End if 
			$t_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$r_idRS;->[ACT_RazonesSociales:279]RUT:3)
			$t_rut:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rut)
			$vl_Result:=WSact_EnviarSII ($t_rut)
			If ($vl_Result=1)
				LOG_RegisterEvt ("Opción envío SII ejecutada. Respuesta: "+vtWS_glosa+".")
				SET TEXT TO PASTEBOARD:C523(vtWS_glosa)
				CD_Dlog (0;"Envio SII exitoso. Respuesta: "+vtWS_glosa+" (copiado al portapapeles).")
			Else 
				CD_Dlog (0;"Error al enviar al SII"+Choose:C955(vtWS_glosa="";".";": "+vtWS_glosa))
			End if 
			
		End for 
		IT_UThermometer (-2;$l_proc)
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 