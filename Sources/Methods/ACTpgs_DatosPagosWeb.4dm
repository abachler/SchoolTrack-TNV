//%attributes = {}
  //ACTpgs_DatosPagosWeb

C_TEXT:C284($t_accion;$1;$t_texto;$2)
C_OBJECT:C1216($ob_datos)
C_POINTER:C301($y_puntero1;$y_puntero2)

$t_accion:=$1
If (Count parameters:C259>=2)
	$t_texto:=$2
End if 
If (Count parameters:C259>=3)
	$y_puntero1:=$3
End if 
If (Count parameters:C259>=4)
	$y_puntero2:=$4
End if 

Case of 
	: ($t_accion="CargaArreglos")
		AT_Initialize ($y_puntero1;$y_puntero2)
		
		ok:=1
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		$ob_datos:=JSON Parse:C1218($t_texto)
		EM_ErrorManager ("Clear")
		If (vl_ErrorCode=0)
			If (False:C215)
				SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($ob_datos;*))
			End if 
			ARRAY TEXT:C222($at_datosParaQuitar;0)
			  //Pago WEB. Datos excluidos
			APPEND TO ARRAY:C911($at_datosParaQuitar;"id_cliente")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"aplicacion")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"usuario")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"sesion")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"email_enviado")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"logo_cliente")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"se_uso_conciliacion")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"ingresado_act")
			
			  //WP
			APPEND TO ARRAY:C911($at_datosParaQuitar;"json")
			APPEND TO ARRAY:C911($at_datosParaQuitar;"web_cliente")
			
			ARRAY TEXT:C222($at_nombres;0)
			ARRAY LONGINT:C221($al_tipos;0)
			C_TEXT:C284($t_datos)  //20180103 RCH
			OB GET PROPERTY NAMES:C1232($ob_datos;arrNames;arrTypes)
			For ($l_indice;1;Size of array:C274(arrNames))
				If (Find in array:C230($at_datosParaQuitar;arrNames{$l_indice})=-1)
					If (Find in array:C230($at_datosParaQuitar;arrNames{$l_indice})=-1)
						  //20180103 RCH
						$t_datos:=OB Get:C1224($ob_datos;arrNames{$l_indice};Is text:K8:3)
						Case of 
							: (arrNames{$l_indice}="monto")  //Para corregir separador
								$t_datos:=Replace string:C233($t_datos;".";<>tXS_RS_DecimalSeparator)
								$t_datos:=Replace string:C233($t_datos;",";<>tXS_RS_DecimalSeparator)
							: (arrNames{$l_indice}="fecha_transaccion")  //Corrige fecha transaccion
								$t_datos:=Substring:C12($t_datos;1;19)
						End case 
						  //Quita valores nulos
						If ($t_datos#"null")
							APPEND TO ARRAY:C911($y_puntero1->;arrNames{$l_indice})
							APPEND TO ARRAY:C911($y_puntero2->;$t_datos)
						End if 
					End if 
				End if 
				
			End for 
		End if 
		
End case 