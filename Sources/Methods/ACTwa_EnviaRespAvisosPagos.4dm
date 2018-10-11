//%attributes = {}
  //ACTwa_EnviaRespAvisosPagos

C_REAL:C285($r_idApoderado;$1;$r_idTercero;$2)
C_LONGINT:C283($l_indiceAC;$l_indicePgs;$vl_codigo)
C_TEXT:C284($t_principal;$temporal;$t_ac;$node;$t_pgs;$json;$vt_descripcion)
C_TEXT:C284($json;$0)

C_OBJECT:C1216($ob_raiz;$ob_estado;$ob_temp)
ARRAY OBJECT:C1221($ao_Pagos;0)
ARRAY OBJECT:C1221($ao_Avisos;0)


$r_idApoderado:=$1
If (Count parameters:C259>=2)
	$r_idTercero:=$2
End if 


  // Modificado por: Alexis Bustamante (10-06-2017)
  //Ticket 179869


  //record numbers
ARRAY LONGINT:C221($alACT_recNumsAC;0)
ARRAY LONGINT:C221($alACT_recNumsPgs;0)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Pagos:172])

$ob_raiz:=OB_Create 
$ob_estado:=OB_Create 

$vl_codigo:=0
$vt_descripcion:=""

OB_SET ($ob_estado;->$vl_codigo;"codigo")
OB_SET ($ob_estado;->$vt_descripcion;"descripcion")
  //agrego objeto estado al raiz
OB_SET ($ob_raiz;->$ob_estado;"estado")

  //retorna avisos
If ($r_idTercero=0)
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$r_idApoderado)
Else 
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=$r_idTercero)
End if 
LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC;"")

  //$temporal:=JSON Append node ($t_principal;"avisos")
C_TEXT:C284($vt_id;$vt_idpersona;$vt_idtercero;$vt_fechaemision;$vt_fechavencimiento;$vt_saldoanterior;$vt_intereses;$vt_montoneto;$vt_montoapagar;$vt_moneda)

For ($l_indiceAC;1;Size of array:C274($alACT_recNumsAC))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC{$l_indiceAC})
	$ob_temp:=OB_Create 
	
	$vt_id:=String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	$vt_idpersona:=String:C10([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	$vt_idtercero:=String:C10([ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
	$vt_fechaemision:=ACTwp_ObtieneStringDesdeFecha ([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
	$vt_fechavencimiento:=ACTwp_ObtieneStringDesdeFecha ([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
	$vt_saldoanterior:=String:C10([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12;"|Despliegue_ACT")
	$vt_intereses:=String:C10([ACT_Avisos_de_Cobranza:124]Intereses:13;"|Despliegue_ACT")
	$vt_montoneto:=String:C10([ACT_Avisos_de_Cobranza:124]Monto_Neto:11;"|Despliegue_ACT")
	$vt_montoapagar:=String:C10([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;"|Despliegue_ACT")
	$vt_moneda:=[ACT_Avisos_de_Cobranza:124]Moneda:17
	
	OB_SET ($ob_temp;->$vt_id;"id")
	OB_SET ($ob_temp;->$vt_idpersona;"idpersona")
	OB_SET ($ob_temp;->$vt_idtercero;"idtercero")
	OB_SET ($ob_temp;->$vt_fechaemision;"fechaemision")
	OB_SET ($ob_temp;->$vt_fechavencimiento;"fechavencimiento")
	OB_SET ($ob_temp;->$vt_saldoanterior;"saldoanterior")
	OB_SET ($ob_temp;->$vt_intereses;"intereses")
	OB_SET ($ob_temp;->$vt_montoneto;"montoneto")
	OB_SET ($ob_temp;->$vt_montoapagar;"montoapagar")
	OB_SET ($ob_temp;->$vt_moneda;"moneda")
	
	APPEND TO ARRAY:C911($ao_Avisos;$ob_temp)
	CLEAR VARIABLE:C89($ob_temp)
End for 
OB_SET ($ob_raiz;->$ao_Avisos;"avisos")

  //retorna pagos
If ($r_idTercero=0)
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=$r_idApoderado;*)
Else 
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=$r_idTercero;*)
End if 
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)


ARRAY LONGINT:C221($alACT_recNumsPgs;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$alACT_recNumsPgs;"")

C_TEXT:C284($vt_idpersona;$vt_idtercero;$vt_idpago;$vt_fechapago;$vt_montopago;$vt_saldopago;$vt_formapago;$vt_ordencompra)
C_LONGINT:C283($vl_ordencompra)

For ($l_indicePgs;1;Size of array:C274($alACT_recNumsPgs))
	GOTO RECORD:C242([ACT_Pagos:172];$alACT_recNumsPgs{$l_indicePgs})
	
	$ob_temp:=OB_Create 
	
	$vt_idpersona:=String:C10([ACT_Pagos:172]ID_Apoderado:3)
	$vt_idtercero:=String:C10([ACT_Pagos:172]ID_Tercero:26)
	$vt_idpago:=String:C10([ACT_Pagos:172]ID:1)
	$vt_fechapago:=ACTwp_ObtieneStringDesdeFecha ([ACT_Pagos:172]Fecha:2)
	$vt_montopago:=String:C10([ACT_Pagos:172]Monto_Pagado:5;"|Despliegue_ACT_Pagos")
	$vt_saldopago:=String:C10([ACT_Pagos:172]Saldo:15;"|Despliegue_ACT_Pagos")
	$vt_formapago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Pagos:172]id_forma_de_pago:30)
	$vl_ordencompra:=[ACT_Pagos:172]ID_WebpayOC:32
	  //20150815 RCH
	
	OB_SET ($ob_temp;->$vt_idpersona;"idpersona")
	OB_SET ($ob_temp;->$vt_idtercero;"idtercero")
	OB_SET ($ob_temp;->$vt_idpago;"idpago")
	OB_SET ($ob_temp;->$vt_fechapago;"fechapago")
	OB_SET ($ob_temp;->$vt_montopago;"montopago")
	OB_SET ($ob_temp;->$vt_saldopago;"saldopago")
	OB_SET ($ob_temp;->$vt_formapago;"formapago")
	OB_SET ($ob_temp;->$vl_ordencompra;"ordencompra")
	
	APPEND TO ARRAY:C911($ao_Pagos;$ob_temp)
	CLEAR VARIABLE:C89($ob_temp)
End for 
OB_SET ($ob_raiz;->$ao_Pagos;"pagos")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json