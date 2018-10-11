//%attributes = {}
  //ACTpgs_CreacionPago

C_TEXT:C284(vtACT_CPCAFecha;vtACT_CCCAFecha;vtACT_CCPCAFecha;vtACT_CCCCAFecha)
C_TEXT:C284(vtACTpgs_Moneda)
C_REAL:C285(vrACTpgs_MontoMoneda)
C_TEXT:C284($t_nombreUsuario)
C_TEXT:C284($t_referencia;$t_json;$t_ordenCompra)
C_BOOLEAN:C305(vbACT_IngresoPagosCaja)

$saldo:=$1
If (Count parameters:C259>=2)
	$t_nombreUsuario:=$2
End if 
  //20150815 RCH Corrige defecto. No se guardaba esta info
If (Count parameters:C259>=3)
	$t_referencia:=$3
End if 
If (Count parameters:C259>=4)
	$t_json:=$4
End if 
If (Count parameters:C259>=5)
	$t_ordenCompra:=$5
End if 

If ($t_nombreUsuario="")
	$t_nombreUsuario:=<>tUSR_CurrentUser
End if 

CREATE RECORD:C68([ACT_Pagos:172])
[ACT_Pagos:172]ID:1:=SQ_SeqNumber (->[ACT_Pagos:172]ID:1)
  //20130729 RCH
  //[ACT_Pagos]IngresadoPor:=<>tUSR_CurrentUser
[ACT_Pagos:172]IngresadoPor:25:=$t_nombreUsuario
IDParaTrans:=[ACT_Pagos:172]ID:1
[ACT_Pagos:172]Fecha:2:=vdACT_FechaPago
[ACT_Pagos:172]FechaIngreso:24:=Current date:C33(*)
If ([ACT_Documentos_de_Pago:176]ID_Tercero:48#0)
	[ACT_Pagos:172]ID_Tercero:26:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
Else 
	[ACT_Pagos:172]ID_Apoderado:3:=[Personas:7]No:1
End if 
If (vbACT_PagoXCuenta)
	KRL_GotoRecord (->[ACT_CuentasCorrientes:175];RNCta)
	[ACT_Pagos:172]ID_CtaCte:21:=[ACT_CuentasCorrientes:175]ID:1
Else 
	[ACT_Pagos:172]ID_CtaCte:21:=0
End if 
[ACT_Pagos:172]ID_AvisoDeCobranza:4:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
[ACT_Pagos:172]ID_DocumentodePago:6:=[ACT_Documentos_de_Pago:176]ID:1
[ACT_Pagos:172]ID_Boleta:8:=0
[ACT_Pagos:172]Monto_Pagado:5:=vrACT_MontoPago
[ACT_Pagos:172]FormaDePago:7:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
[ACT_Pagos:172]id_forma_de_pago:30:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51
[ACT_Pagos:172]forma_de_pago_new:31:=[ACT_Documentos_de_Pago:176]forma_de_pago_new:52
  //[ACT_Pagos]FormaDePago:=vsACT_FormasdePago
[ACT_Pagos:172]Observaciones:13:=vtACT_ObservacionesPago
[ACT_Pagos:172]Saldo:15:=$saldo
[ACT_Pagos:172]Lugar_de_Pago:18:=vsACT_LugardePago

If ((vtACTpgs_Moneda="") | (vrACTpgs_MontoMoneda=0))
	vtACTpgs_Moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
	vrACTpgs_MontoMoneda:=vrACT_MontoPago
	vrACTpgs_MontoAjuste:=0
End if 
[ACT_Pagos:172]Moneda:27:=vtACTpgs_Moneda
[ACT_Pagos:172]MontoEnMoneda:28:=vrACTpgs_MontoMoneda
[ACT_Pagos:172]ValorParidad:29:=ACTut_fValorDivisa ([ACT_Pagos:172]Moneda:27;vdACT_FechaPago)
ACTcfgmyt_OpcionesGenerales ("InicializaVars")

  //20150815 RCH Corrige defecto. No se guardaba esta info
[ACT_Pagos:172]Bancomer_referencia:35:=$t_referencia
[ACT_Pagos:172]ID_WebpayOC:32:=Num:C11($t_ordenCompra)
[ACT_Pagos:172]Datos_pago:36:=$t_json

  //20161002 RCH
If (vbACT_IngresoPagosCaja)
	ACTcfg_AsignaCorrelativoPago 
End if 

[ACT_Pagos:172]Fecha_creacion:40:=DTS_MakeFromDateTime   // 179864

SAVE RECORD:C53([ACT_Pagos:172])

  //20151104 ASM ticket 150749 para actualizar el tipo de pago
ACTwp_ActualizaCampoTipoPago ($t_json;[ACT_Pagos:172]ID:1)
ACTpgs_AsignaCuentasContables (->[ACT_Pagos:172]ID:1)