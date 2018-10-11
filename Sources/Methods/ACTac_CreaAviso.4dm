//%attributes = {}
  //ACTac_CreaAviso

$date:=$1
$fechaVencimiento:=$2
$fechaPago2:=$3
$fechaPago3:=$4
$fechaPago4:=$5
$vl_idApdo:=$6
$vl_idTercero:=$7
$id_CtaCte:=$8
$month:=$9
$year:=$10
$vtCT_CurrentUser:=$11

CREATE RECORD:C68([ACT_Avisos_de_Cobranza:124])
[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24:=True:C214
[ACT_Avisos_de_Cobranza:124]ID_Aviso:1:=SQ_SeqNumber (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4:=$date
[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5:=$fechaVencimiento
[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18:=$fechaPago2
[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19:=$fechaPago3
[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20:=$fechaPago4
[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3:=$vl_idApdo
[ACT_Avisos_de_Cobranza:124]ID_Tercero:26:=$vl_idTercero
[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2:=$id_CtaCte
[ACT_Avisos_de_Cobranza:124]Mes:6:=$month
[ACT_Avisos_de_Cobranza:124]Agno:7:=$year
[ACT_Avisos_de_Cobranza:124]Moneda:17:=<>vsACT_MonedaColegio
[ACT_Avisos_de_Cobranza:124]CreadoPor:29:=$vtCT_CurrentUser
ACTac_ActualizaNombre ("AsignaValorACampo")
SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])

