//%attributes = {}
  //ACTdd_ProtestaCheques

$0:=True:C214

vdACT_FechaProtesto:=!00-00-00!
IDDocP:=0
vtACT_MotivoProtesto:=""

ST_Deconcatenate (";";$1;->vdACT_FechaProtesto;->IDDocP;->vtACT_MotivoProtesto)

READ WRITE:C146([ACT_Documentos_de_Pago:176])
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=IDDocP)

If (Not:C34(Locked:C147([ACT_Documentos_de_Pago:176])))
	[ACT_Documentos_de_Pago:176]FechaProtesto:15:=vdACT_FechaProtesto
	[ACT_Documentos_de_Pago:176]MotivoProtesto:38:=vtACT_MotivoProtesto
	  //[ACT_Documentos_de_Pago]Estado:="Protestado."
	  //[ACT_Documentos_de_Pago]id_estado:=-2
	[ACT_Documentos_de_Pago:176]id_estado:53:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
	[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
	[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
	[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
	[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39:=""
	[ACT_Documentos_de_Pago:176]Depositado_en_Banco_Codigo:40:=""
	[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41:=""
	[ACT_Documentos_de_Pago:176]Depositado_Fecha:42:=!00-00-00!
	[ACT_Documentos_de_Pago:176]Depositado_Por:43:=""
	  //SAVE RECORD([ACT_Documentos_de_Pago])
	ACTdp_fSave 
	ACTdc_CreaDocCarteraProt 
Else 
	$0:=False:C215
End if 