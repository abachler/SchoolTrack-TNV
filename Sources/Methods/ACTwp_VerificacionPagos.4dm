//%attributes = {}
  //ACTwp_VerificacionPagos
  //Metodo que permite verificar los pagos de un dia en particular
TRACE:C157
If (USR_GetUserID <0)
	
	ARRAY TEXT:C222($at_fechas;0)
	
	  //MONJAS INGLESAS
	$t_ip:="http://152.231.83.35"
	$t_port:=""
	t_fecha1:="06-10-2015"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88781")
	$t_accion:="revisaPagos"
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="08-10-2015"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	$t_accion:="revisaPagos"
	
	  //Saint Paul
	$t_ip:="http://190.151.93.157"
	$t_port:=""
	t_fecha1:="08-10-2015"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"17914")
	$t_accion:="revisaPagos"
	
	  //SSCC Manquehue 20151020
	
	$t_accion:="revisaPagos"
	
	
	
	
	
	  //Saint Paul
	$t_ip:="http://190.151.93.157"
	$t_port:=""
	t_fecha1:="27-11-2015"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"17914")
	$t_accion:="revisaPagos"
	$t_accion:="enviaMail"
	
	  //MONJAS INGLESAS
	$t_ip:="http://152.231.83.35"
	$t_port:=""
	t_fecha1:="13-12-2015"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88781")
	$t_accion:="revisaPagos"
	$t_accion:="enviaMail"
	
	  //
	  //SIAO
	  //$t_ip:="http://200.75.2.218"
	  //$t_port:=""
	  //t_fecha1:="27-11-2015"
	  //$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"86096")
	  //$t_accion:="revisaPagos"
	
	  //  //San Gabriel
	  //$t_ip:="http://190.82.116.10"
	  //$t_port:=""
	  //t_fecha1:="29-11-2015"
	  //$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	  //$t_accion:="revisaPagos"
	
	
	
	
	$t_accion:="revisaPagos"
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="04-01-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	$t_accion:="revisaPagos"
	
	  //Mackay
	$t_ip:="http://200.72.32.174"
	$t_port:="8081"
	t_fecha1:="26-02-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"17884")
	$t_accion:="revisaPagos"
	
	
	$t_ip:="http://152.231.83.35"
	$t_port:=""
	t_fecha1:="14-03-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88781")
	$t_accion:="revisaPagos"
	$t_accion:="enviaMail"
	
	
	  //Mackay
	$t_ip:="http://200.72.32.174"
	$t_port:="8081"
	t_fecha1:="04-03-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"17884")
	$t_accion:="revisaPagos"
	
	
	
	
	
	  //Scuola
	$t_ip:="http://190.196.208.28"
	$t_port:=""
	t_fecha1:="23-03-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88633")
	$t_accion:="revisaPagos"
	$t_accion:="enviaMail"
	
	  //Lincoln Chicureo
	$t_ip:="http://190.98.213.92"
	$t_port:=""
	t_fecha1:="24-03-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"263117")
	$t_accion:="revisaPagos"
	$t_accion:="enviaMail"
	  //50349
	
	
	  //MONJAS INGLESAS
	$t_ip:="http://152.231.83.35"
	$t_port:=""
	t_fecha1:="08-03-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88781")
	$t_accion:="revisaPagos"
	$t_accion:="enviaMail"
	
	
	
	  //Altazor
	$t_ip:="http://186.67.167.140"
	$t_port:="8080"
	t_fecha1:="31-03-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"148660")
	$t_accion:="revisaPagos"
	
	
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="04-08-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	
	  //MAnquehue
	$t_ip:="http://schooltrack.ssccmanquehue.cl"
	$t_port:=""
	t_fecha1:="05-09-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88773")
	
	
	
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="23-11-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="15-11-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="15-11-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	  //SIAO
	$t_ip:="http://200.75.2.218"
	$t_port:=""
	t_fecha1:="30-11-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"86096")
	
	  //Saint Paul
	$t_ip:="http://190.151.93.157"
	$t_port:=""
	t_fecha1:="30-11-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"17914")
	
	
	
	  //MONJAS INGLESAS
	$t_ip:="http://152.231.83.35"
	$t_port:=""
	t_fecha1:="13-12-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88781")
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="12-12-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	
	  //MONJAS INGLESAS
	$t_ip:="http://152.231.83.35"
	$t_port:=""
	t_fecha1:="28-11-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"88781")
	
	  //SIAO
	$t_ip:="http://200.75.2.218"
	$t_port:=""
	t_fecha1:="19-12-2016"  //Aviso eliminado en ACT
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"86096")
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="14-12-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	  //Altazor
	$t_ip:="http://186.67.167.140"
	$t_port:="8080"
	t_fecha1:="23-12-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"148660")
	$t_accion:="revisaPagos"
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="19-12-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	  //San Gabriel
	$t_ip:="http://190.82.116.10"
	$t_port:=""
	t_fecha1:="26-12-2016"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89664")
	
	
	
	  //Saint Paul
	$t_ip:="http://190.151.93.157"
	$t_port:=""
	t_fecha1:="28-06-2017"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"17914")
	
	  //Craighouse
	$t_ip:="http://190.215.33.235:8081"
	$t_port:=""
	t_fecha1:="21-05-2017"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"89176")
	
	
	
	
	  //Cabo de Hornos
	$t_ip:="http://colegiocabodehornos.colegium.com"
	$t_port:=""
	t_fecha1:="04-07-2017"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"204412")
	ARRAY TEXT:C222($at_fechas;0)
	ARRAY TEXT:C222($at_llave;0)
	APPEND TO ARRAY:C911($at_fechas;t_fecha1)
	APPEND TO ARRAY:C911($at_llave;$t_llave)
	
	
	
	
	  //The Antofagasta British School (II)
	$t_ip:="http://186.10.18.18"
	$t_port:=""
	  //t_fecha1:="22-05-2017"
	  //t_fecha1:="23-05-2017"
	  //t_fecha1:="24-05-2017"
	  //t_fecha1:="25-05-2017"
	  //t_fecha1:="26-05-2017"
	  //t_fecha1:="27-05-2017"
	  //t_fecha1:="01-06-2017"
	  //t_fecha1:="02-06-2017"
	  //t_fecha1:="04-06-2017"
	  //t_fecha1:="05-06-2017"
	  //t_fecha1:="06-06-2017"
	  //t_fecha1:="09-06-2017"
	  //t_fecha1:="11-06-2017"
	  //t_fecha1:="12-06-2017"
	  //t_fecha1:="13-06-2017"
	  //t_fecha1:="14-06-2017"
	  //t_fecha1:="15-06-2017"
	  //t_fecha1:="16-06-2017"
	  //t_fecha1:="21-06-2017"
	  //t_fecha1:="26-06-2017"
	  //t_fecha1:="27-06-2017"
	  //t_fecha1:="30-06-2017"
	  //t_fecha1:="03-07-2017"
	ARRAY TEXT:C222($at_fechas;0)
	ARRAY TEXT:C222($at_llave;0)
	  //APPEND TO ARRAY($at_fechas;"22-05-2017")
	  //APPEND TO ARRAY($at_fechas;"23-05-2017")
	  //APPEND TO ARRAY($at_fechas;"24-05-2017")
	  //APPEND TO ARRAY($at_fechas;"25-05-2017")
	  //APPEND TO ARRAY($at_fechas;"26-05-2017")
	  //APPEND TO ARRAY($at_fechas;"27-05-2017")
	  //APPEND TO ARRAY($at_fechas;"01-06-2017")
	  //APPEND TO ARRAY($at_fechas;"02-06-2017")
	  //APPEND TO ARRAY($at_fechas;"04-06-2017")
	  //APPEND TO ARRAY($at_fechas;"05-06-2017")
	  //APPEND TO ARRAY($at_fechas;"06-06-2017")
	  //APPEND TO ARRAY($at_fechas;"09-06-2017")
	  //APPEND TO ARRAY($at_fechas;"11-06-2017")
	  //APPEND TO ARRAY($at_fechas;"12-06-2017")
	  //APPEND TO ARRAY($at_fechas;"13-06-2017")
	  //APPEND TO ARRAY($at_fechas;"14-06-2017")
	  //APPEND TO ARRAY($at_fechas;"15-06-2017")
	  //APPEND TO ARRAY($at_fechas;"16-06-2017")
	  //APPEND TO ARRAY($at_fechas;"21-06-2017")
	  //APPEND TO ARRAY($at_fechas;"26-06-2017")
	  //APPEND TO ARRAY($at_fechas;"27-06-2017")
	  //APPEND TO ARRAY($at_fechas;"30-06-2017")
	  //APPEND TO ARRAY($at_fechas;"03-07-2017")
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"3611")
	APPEND TO ARRAY:C911($at_fechas;"04-07-2017")
	APPEND TO ARRAY:C911($at_llave;$t_llave)
	
	
	  //British
	$t_ip:="http://186.103.232.59"
	$t_port:=""
	t_fecha1:="04-07-2017"
	$t_llave:=ACTwp_GeneraKey (t_fecha1;"cl";"120871")
	ARRAY TEXT:C222($at_fechas;0)
	ARRAY TEXT:C222($at_llave;0)
	APPEND TO ARRAY:C911($at_fechas;t_fecha1)
	APPEND TO ARRAY:C911($at_llave;$t_llave)
	
	For ($l_indice;1;Size of array:C274($at_fechas))
		t_fecha1:=$at_fechas{$l_indice}
		$t_llave:=$at_llave{$l_indice}
		
		$t_textoFinal:=""
		For ($i;1;3)  //obtiene totales, verifica dia y obtiene totales
			  //For ($i;1;4)//obtiene totales, verifica dia, obtiene totales y envia mail
			  //For ($i;1;1)
			Case of 
				: (($i=1) | ($i=3))
					$t_accion:="retornaInfo1"
				: ($i=2)
					$t_accion:="revisaPagos"
				: ($i=4)
					$t_accion:="enviaMail"
			End case 
			
			Case of 
				: ($t_accion="retornaInfo1")
					$t_peticion:="/actwa/ajax/retornaInfo1?fecha1="+t_fecha1+"&fecha2="+t_fecha1+"&llave="+$t_llave
					
				: ($t_accion="revisaPagos")
					$t_peticion:="/actwa/ajax/revisaPagos?fecha="+t_fecha1+"&llave="+$t_llave
					
				: ($t_accion="enviaMail")
					$t_peticion:="/actwa/ajax/enviaMail?fecha="+t_fecha1+"&llave="+$t_llave
					
			End case 
			
			If ($t_port#"")
				$t_requestIP:=$t_ip+":"+$t_port+$t_peticion
			Else 
				$t_requestIP:=$t_ip+$t_peticion
			End if 
			
			C_TEXT:C284($content;$t_response)
			C_BLOB:C604($xBlob)
			C_OBJECT:C1216($ob)
			$l_httpCode:=HTTP Request:C1158(HTTP GET method:K71:1;$t_requestIP;$content;$xBlob)
			If ($l_httpCode=200)
				$t_texto:=Convert to text:C1012($xBlob;"UTF-8")
				$ob:=JSON Parse:C1218($t_texto)
				$t_textoFinal:=$t_textoFinal+JSON Stringify:C1217($ob;*)
			End if 
			$t_textoFinal:=$t_textoFinal+<>cr
			  //If (False)
			SET TEXT TO PASTEBOARD:C523($t_textoFinal)
			  //End if 
		End for 
		SET TEXT TO PASTEBOARD:C523($t_textoFinal)
	End for 
End if 