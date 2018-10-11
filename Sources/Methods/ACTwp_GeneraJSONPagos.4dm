//%attributes = {}
  //ACTwp_GeneraJSONPagos

C_DATE:C307($d_fechaInicio;$d_fechaFin;$1;$2)
C_TEXT:C284($t_principal;$t_err;$node;$temporal;$t_pgs;$json;$0)
C_LONGINT:C283($l_indicePgs)
C_REAL:C285($r_totalPagos)

ARRAY LONGINT:C221($alACT_recNumsPgs;0)

If (Count parameters:C259>=1)
	$d_fechaInicio:=$1
End if 
If (Count parameters:C259>=2)
	$d_fechaFin:=$2
End if 
If ($d_fechaFin=!00-00-00!)
	$d_fechaFin:=$d_fechaInicio
End if 

ACTcfg_OpcionesRazonesSociales ("LoadConfig")

If ($d_fechaInicio#!00-00-00!)
	If ($d_fechaFin>=$d_fechaInicio)
		
		READ ONLY:C145([ACT_Pagos:172])
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$d_fechaInicio;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$d_fechaFin;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]id_forma_de_pago:30=-18;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
		
		$r_totalPagos:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$alACT_recNumsPgs;"")
		
		C_OBJECT:C1216($ob_raiz;$ob_temp;$ob_datos)
		ARRAY OBJECT:C1221($ao_pagos;0)
		
		
		  // Modificado por: Alexis Bustamante (12-06-2017)
		  //Ticket 179869
		
		C_TEXT:C284($vt_fecha;$vt_sumapagos)
		C_LONGINT:C283($vl_cantidadpagos)
		
		$ob_raiz:=OB_Create 
		$ob_datos:=OB_Create 
		
		OB_SET ($ob_datos;->[ACT_RazonesSociales:279]contacto_eMail:15;"email")
		OB_SET ($ob_datos;->[ACT_RazonesSociales:279]contacto_nombre:14;"destinatario")
		
		If ($d_fechaInicio=$d_fechaFin)
			$vt_fecha:=ACTwp_ObtieneStringDesdeFecha ($d_fechaInicio)
		Else 
			$vt_fecha:=ACTwp_ObtieneStringDesdeFecha ($d_fechaInicio)+"-"+ACTwp_ObtieneStringDesdeFecha ($d_fechaFin)
		End if 
		$vt_sumapagos:=String:C10($r_totalPagos;"|Despliegue_ACT_Pagos")
		$vl_cantidadpagos:=Size of array:C274($alACT_recNumsPgs)
		
		OB_SET ($ob_datos;->$vt_fecha;"dia")
		OB_SET ($ob_datos;->$vl_cantidadpagos;"cantidadpagos")
		OB_SET ($ob_datos;->$vt_sumapagos;"sumapagos")
		OB_SET ($ob_raiz;->$ob_datos;"datos_envio")
		
		C_TEXT:C284($vt_idpago;$vt_nombrepersona;$vt_fechapago;$vt_montopago;$vt_formapago;$vt_ordencompra)
		C_LONGINT:C283($vl_saldo)
		For ($l_indicePgs;1;Size of array:C274($alACT_recNumsPgs))
			GOTO RECORD:C242([ACT_Pagos:172];$alACT_recNumsPgs{$l_indicePgs})
			$vt_idpago:=String:C10([ACT_Pagos:172]ID:1)
			$ob_temp:=OB_Create 
			OB_SET ($ob_temp;->$vt_idpago;"idpago")
			If ([ACT_Pagos:172]ID_Apoderado:3#0)
				$vt_nombrepersona:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30)
			Else 
				$vt_nombrepersona:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Pagos:172]ID_Tercero:26;->[ACT_Terceros:138]Nombre_Completo:9)
			End if 
			OB_SET ($ob_temp;->$vt_nombrepersona;"nombrepersona")
			$vt_fechapago:=ACTwp_ObtieneStringDesdeFecha ([ACT_Pagos:172]Fecha:2)
			$vt_montopago:=String:C10([ACT_Pagos:172]Monto_Pagado:5;"|Despliegue_ACT_Pagos")
			$vt_formapago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Pagos:172]id_forma_de_pago:30)
			$vt_ordencompra:=String:C10([ACT_Pagos:172]ID_WebpayOC:32)  //20150707 RCH
			$vl_saldo:=[ACT_Pagos:172]Saldo:15  //20151202 RCH
			OB_SET ($ob_temp;->$vt_fechapago;"fechapago")
			OB_SET ($ob_temp;->$vt_montopago;"montopago")
			OB_SET ($ob_temp;->$vt_formapago;"formapago")
			OB_SET ($ob_temp;->$vt_ordencompra;"ordencompra")
			OB_SET ($ob_temp;->$vl_saldo;"saldo")
			APPEND TO ARRAY:C911($ao_pagos;$ob_temp)
			CLEAR VARIABLE:C89($ob_temp)
		End for 
		OB_SET ($ob_raiz;->$ao_pagos;"pagos")
		$json:=OB_Object2Json ($ob_raiz)
		
		
		  //$t_principal:=JSON New 
		  //$t_err:=JSON Append node ($t_principal;"datos_envio")
		  //$node:=JSON Append text ($t_err;"email";[ACT_RazonesSociales]contacto_eMail)
		  //$node:=JSON Append text ($t_err;"destinatario";[ACT_RazonesSociales]contacto_nombre)
		
		
		  //If ($d_fechaInicio=$d_fechaFin)
		  //$node:=JSON Append text ($t_err;"dia";ACTwp_ObtieneStringDesdeFecha ($d_fechaInicio))
		  //Else 
		  //$node:=JSON Append text ($t_err;"dia";ACTwp_ObtieneStringDesdeFecha ($d_fechaInicio)+"-"+ACTwp_ObtieneStringDesdeFecha ($d_fechaFin))
		  //End if 
		  //$node:=JSON Append real ($t_err;"cantidadpagos";Size of array($alACT_recNumsPgs))
		  //$node:=JSON Append text ($t_err;"sumapagos";String($r_totalPagos;"|Despliegue_ACT_Pagos"))
		  //$temporal:=JSON Append node ($t_principal;"pagos")
		  //For ($l_indicePgs;1;Size of array($alACT_recNumsPgs))
		  //GOTO RECORD([ACT_Pagos];$alACT_recNumsPgs{$l_indicePgs})
		  //$t_pgs:=JSON Append node ($temporal;"pago")
		  //$node:=JSON Append text ($t_pgs;"idpago";String([ACT_Pagos]ID))
		
		  //  //20170406 RCH
		  //  //$node:=JSON Append text ($t_pgs;"nombrepersona";KRL_GetTextFieldData (->[Personas]No;->[ACT_Pagos]ID_Apoderado;->[Personas]Apellidos_y_nombres))
		  //If ([ACT_Pagos]ID_Apoderado#0)
		  //$node:=JSON Append text ($t_pgs;"nombrepersona";KRL_GetTextFieldData (->[Personas]No;->[ACT_Pagos]ID_Apoderado;->[Personas]Apellidos_y_nombres))
		  //Else 
		  //$node:=JSON Append text ($t_pgs;"nombrepersona";KRL_GetTextFieldData (->[ACT_Terceros]Id;->[ACT_Pagos]ID_Tercero;->[ACT_Terceros]Nombre_Completo))
		  //End if 
		
		  //$node:=JSON Append text ($t_pgs;"fechapago";ACTwp_ObtieneStringDesdeFecha ([ACT_Pagos]Fecha))
		  //$node:=JSON Append text ($t_pgs;"montopago";String([ACT_Pagos]Monto_Pagado;"|Despliegue_ACT_Pagos"))
		  //$node:=JSON Append text ($t_pgs;"formapago";ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Pagos]id_forma_de_pago))
		  //$node:=JSON Append text ($t_pgs;"ordencompra";String([ACT_Pagos]ID_WebpayOC))  //20150707 RCH
		  //$node:=JSON Append real ($t_pgs;"saldo";[ACT_Pagos]Saldo)  //20151202 RCH
		  //End for 
		  //JSON SET TYPE ($temporal;JSON_ARRAY)
		  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($t_principal)
	Else 
		$json:=ACTwa_RespuestaError (-15)
	End if 
Else 
	$json:=ACTwa_RespuestaError (-14)
End if 
$0:=$json