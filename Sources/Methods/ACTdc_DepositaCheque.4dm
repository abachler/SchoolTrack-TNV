//%attributes = {}
  //ACTdc_DepositaCheque

$text:=$1
$0:=True:C214

$IDDocC:=0
$banco:=""
$codigo:=""
$ctacte:=""
$fechaDeposito:=!00-00-00!
$depositadoPor:=""

ST_Deconcatenate (";";$text;->$IDDocC;->$banco;->$codigo;->$ctacte;->$fechaDeposito;->$depositadoPor)

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=$IDDocC)
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
$lockedPagos:=Locked:C147([ACT_Documentos_de_Pago:176])

If (Not:C34(($lockedCartera) | ($lockedPagos)))
	  //[ACT_Documentos_de_Pago]id_estado:=-11
	[ACT_Documentos_de_Pago:176]id_estado:53:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoDepositado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
	[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
	[ACT_Documentos_de_Pago:176]Depositado:35:=True:C214
	[ACT_Documentos_de_Pago:176]En_cartera:34:=False:C215
	[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39:=$banco
	[ACT_Documentos_de_Pago:176]Depositado_en_Banco_Codigo:40:=$codigo
	[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41:=$ctacte
	[ACT_Documentos_de_Pago:176]Depositado_Fecha:42:=$fechaDeposito
	[ACT_Documentos_de_Pago:176]Depositado_Por:43:=$depositadoPor
	$vl_idApdo:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
	$vl_idTer:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
	  //SAVE RECORD([ACT_Documentos_de_Pago])
	ACTdp_fSave 
	LOG_RegisterEvt ("Depósito de documento Nº "+[ACT_Documentos_de_Pago:176]NoSerie:12+" del banco "+[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7+".")
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
	DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosIdsApdoTerceros";->$vl_idApdo;->$vl_idTer)
Else 
	$0:=False:C215
End if 