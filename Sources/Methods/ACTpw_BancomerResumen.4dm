//%attributes = {}
  //ACTpw_BancomerResumen 

C_DATE:C307($d_fechaInicio;$d_fechaFin)
C_REAL:C285($r_totalPagos)
C_TEXT:C284($t_principal;$t_err;$node;$temporal;$t_pgs;$0;$json)
C_LONGINT:C283($l_indicePgs)

ARRAY LONGINT:C221($alACT_recNumsPgs;0)

ACTcfg_OpcionesRazonesSociales ("LoadConfig")

$d_fechaInicio:=$1
$d_fechaFin:=$2

If ($d_fechaFin=!00-00-00!)
	$d_fechaFin:=$d_fechaInicio
End if 

READ ONLY:C145([ACT_Pagos:172])

QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$d_fechaInicio;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=$d_fechaFin;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]id_forma_de_pago:30=-19;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)

$r_totalPagos:=Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$alACT_recNumsPgs;"")

C_OBJECT:C1216($ob_raiz;$ob_nododatos_envio)

  //se crea objeto principal y Nodos.
$ob_raiz:=OB_Create 
$ob_nododatos_envio:=OB_Create 

  //se agrega al Objeto principal el nodo "datos_envio"
OB_SET ($ob_raiz;->$ob_nododatos_envio;"datos_envio")

  //se escribe sobre el Nodo "datos_envio"
OB_SET ($ob_nododatos_envio;->[ACT_RazonesSociales:279]contacto_eMail:15;"email")
OB_SET ($ob_nododatos_envio;->[ACT_RazonesSociales:279]contacto_nombre:14;"nombredestinatario")

C_TEXT:C284($vt_fecha;$vt_sumap)
C_LONGINT:C283($vl_cantp)

If ($d_fechaInicio=$d_fechaFin)
	$vt_fecha:=ACTwp_ObtieneStringDesdeFecha ($d_fechaInicio)
	OB_SET ($ob_nododatos_envio;->$vt_fecha;"dia")
Else 
	$vt_fecha:=ACTwp_ObtieneStringDesdeFecha ($d_fechaInicio)+"-"+ACTwp_ObtieneStringDesdeFecha ($d_fechaFin)
	OB_SET ($ob_nododatos_envio;->$vt_fecha;"dia")
End if 

$vl_cantp:=Size of array:C274($alACT_recNumsPgs)
$vt_sumap:=String:C10($r_totalPagos;"|Despliegue_ACT_Pagos")

OB_SET ($ob_nododatos_envio;->$vl_cantp;"cantidadpagos")
OB_SET ($ob_nododatos_envio;->$vt_sumap;"sumapagos")


  //se crea Arreglo de Objeto para agregar cada pago
C_OBJECT:C1216($ob_pagos)
ARRAY OBJECT:C1221($aob_Pagos;0)
C_TEXT:C284($t_idpagos;$t_ordencompra;$t_fechapago;$t_monto;$t_referencia;$json)

For ($l_indicePgs;1;Size of array:C274($alACT_recNumsPgs))
	GOTO RECORD:C242([ACT_Pagos:172];$alACT_recNumsPgs{$l_indicePgs})
	$ob_pagos:=OB_Create 
	$t_idpagos:=String:C10([ACT_Pagos:172]ID:1)
	$t_ordencompra:=String:C10([ACT_Pagos:172]ID_WebpayOC:32)
	$t_fechapago:=ACTwp_ObtieneStringDesdeFecha ([ACT_Pagos:172]Fecha:2)
	$t_monto:=String:C10([ACT_Pagos:172]Monto_Pagado:5;"|Despliegue_ACT_Pagos")
	$t_referencia:=[ACT_Pagos:172]Bancomer_referencia:35
	OB_SET ($ob_pagos;->$t_idpagos;"idpago")
	OB_SET ($ob_pagos;->$t_ordencompra;"ordencompra")
	OB_SET ($ob_pagos;->$t_fechapago;"fechapago")
	OB_SET ($ob_pagos;->$t_monto;"monto")
	OB_SET ($ob_pagos;->$t_referencia;"referencia")
	APPEND TO ARRAY:C911($aob_Pagos;$ob_pagos)
	CLEAR VARIABLE:C89($ob_pagos)
End for 
  //se agrega arreglo de objetos a Objeto principal
OB_SET ($ob_raiz;->$aob_Pagos;"pagos")

$json:=OB_Object2Json ($ob_raiz)
$0:=$json



  //C_DATE($d_fechaInicio;$d_fechaFin)
  //C_REAL($r_totalPagos)
  //C_TEXT($t_principal;$t_err;$node;$temporal;$t_pgs;$0;$json)
  //C_LONGINT($l_indicePgs)

  //ARRAY LONGINT($alACT_recNumsPgs;0)

  //ACTcfg_OpcionesRazonesSociales ("LoadConfig")

  //$d_fechaInicio:=$1
  //$d_fechaFin:=$2

  //If ($d_fechaFin=!00-00-00!)
  //$d_fechaFin:=$d_fechaInicio
  //End if 

  //READ ONLY([ACT_Pagos])

  //QUERY([ACT_Pagos];[ACT_Pagos]Fecha>=$d_fechaInicio;*)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]Fecha<=$d_fechaFin;*)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]id_forma_de_pago=-19;*)
  //QUERY([ACT_Pagos]; & ;[ACT_Pagos]Nulo=False)

  //$r_totalPagos:=Sum([ACT_Pagos]Monto_Pagado)
  //LONGINT ARRAY FROM SELECTION([ACT_Pagos];$alACT_recNumsPgs;"")
  //$t_principal:=JSON New 
  //$t_err:=JSON Append node ($t_principal;"datos_envio")
  //$node:=JSON Append text ($t_err;"email";[ACT_RazonesSociales]contacto_eMail)
  //$node:=JSON Append text ($t_err;"nombredestinatario";[ACT_RazonesSociales]contacto_nombre)
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
  //$node:=JSON Append text ($t_pgs;"ordencompra";String([ACT_Pagos]ID_WebpayOC))
  //$node:=JSON Append text ($t_pgs;"fechapago";ACTwp_ObtieneStringDesdeFecha ([ACT_Pagos]Fecha))
  //$node:=JSON Append text ($t_pgs;"monto";String([ACT_Pagos]Monto_Pagado;"|Despliegue_ACT_Pagos"))
  //$node:=JSON Append text ($t_pgs;"referencia";[ACT_Pagos]Bancomer_referencia)
  //End for 
  //JSON SET TYPE ($temporal;JSON_ARRAY)
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($t_principal)

  //$0:=$json