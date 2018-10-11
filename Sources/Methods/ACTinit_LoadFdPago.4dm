//%attributes = {}
  //ACTinit_LoadFdPago
C_BOOLEAN:C305($vb_configuracion)
C_BOOLEAN:C305($vb_pagoWP)
C_LONGINT:C283($l_idFormaDePago)  //20180529 RCH Ticket 208159

ACTcfg_OpcionesFormasDePago ("DeclaraArreglos")
$vb_configuracion:=False:C215
If (Count parameters:C259>=1)
	$vb_configuracion:=$1
End if 
If (Count parameters:C259>=2)
	$vb_pagoWP:=$2
End if 
If (Count parameters:C259>=3)
	$l_idFormaDePago:=$3
End if 

READ ONLY:C145([ACT_Formas_de_Pago:287])

ARRAY LONGINT:C221($alACT_ids;0)
ARRAY LONGINT:C221($alACT_recNums;0)
ARRAY LONGINT:C221($alACT_recNums2;0)
ARRAY LONGINT:C221($alACT_DAReturn;0)

QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]visible_en_conf:12=True:C214)
If (Not:C34($vb_configuracion))
	If ($vb_pagoWP)
		QUERY SELECTION:C341([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]permite_ingreso_pago:11=True:C214;*)
		QUERY SELECTION:C341([ACT_Formas_de_Pago:287]; | ;[ACT_Formas_de_Pago:287]id:1=-18)  //webpay
	Else 
		QUERY SELECTION:C341([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]permite_ingreso_pago:11=True:C214)
	End if 
End if 

  //20180529 RCH Para validar que la fdp solicitada sea devuelta.
If ($l_idFormaDePago#0)
	C_LONGINT:C283($l_existe)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_existe)
	QUERY SELECTION:C341([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$l_idFormaDePago)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($l_existe=0)
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]visible_en_conf:12=True:C214)
	End if 
End if 

ORDER BY:C49([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1;>)
SELECTION TO ARRAY:C260([ACT_Formas_de_Pago:287];$alACT_recNums;[ACT_Formas_de_Pago:287]id:1;alACT_FormasdePagoID;[ACT_Formas_de_Pago:287]forma_de_pago_old:2;atACT_FormasdePago;[ACT_Formas_de_Pago:287]codigo_ingreso:3;atACT_FdPCodes;[ACT_Formas_de_Pago:287]codigo_interno:8;atACT_FdPCodInterno;[ACT_Formas_de_Pago:287]id_centro_contra:7;alACT_idCCentroFDP;[ACT_Formas_de_Pago:287]id_centro_plan:5;alACT_idCentroFDP;[ACT_Formas_de_Pago:287]id_cuenta_contra:6;alACT_idCCtaFDP;[ACT_Formas_de_Pago:287]id_cuenta_plan:4;alACT_idCtaFDP)
  //[ACT_Formas_de_Pago]glosa_forma_de_pago;atACT_FormasdePagoNew)

ARRAY TEXT:C222(atACT_FormasdePagoNew;0)
For ($i;1;Size of array:C274(alACT_FormasdePagoID))
	APPEND TO ARRAY:C911(atACT_FormasdePagoNew;ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->alACT_FormasdePagoID{$i}))
End for 

  // para ordenar las formas de pago...
alACT_FormasdePagoID{0}:=0
AT_SearchArray (->alACT_FormasdePagoID;"<";->$alACT_DAReturn)
For ($i;1;Size of array:C274($alACT_DAReturn))
	APPEND TO ARRAY:C911($alACT_ids;Abs:C99(alACT_FormasdePagoID{$alACT_DAReturn{$i}}))
	APPEND TO ARRAY:C911($alACT_recNums2;Abs:C99($alACT_recNums{$alACT_DAReturn{$i}}))
End for 
SORT ARRAY:C229($alACT_ids;$alACT_recNums2;>)
AT_OrderArraysByArray (MAXLONG:K35:2;->$alACT_recNums2;->$alACT_recNums;->alACT_FormasdePagoID;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCodInterno;->alACT_idCCentroFDP;->alACT_idCentroFDP;->alACT_idCCtaFDP;->alACT_idCtaFDP;->atACT_FormasdePagoNew)

ACTcfg_LoadConfigData (10)

For ($i;1;Size of array:C274(alACT_idCtaFDP))
	AT_Insert ($i;1;->atACT_FdPCtaContable;->atACT_FdPCtaCodAux;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCtaCodAux;->atACT_FdPCCentroCostos)
	  // plan de cuenta
	$vl_existe:=Find in array:C230(<>alACT_idCta;alACT_idCtaFDP{$i})
	If ($vl_existe>0)
		atACT_FdPCtaContable{$i}:=<>asACT_CuentaCta{$vl_existe}
		atACT_FdPCtaCodAux{$i}:=<>asACT_CodAuxCta{$vl_existe}
	End if 
	  // centro de costo
	$vl_existe:=Find in array:C230(<>alACT_idCentro;alACT_idCentroFDP{$i})
	If ($vl_existe>0)
		atACT_FdPCentroCostos{$i}:=<>asACT_Centro{$vl_existe}
	End if 
	  // plan cuenta contra
	$vl_existe:=Find in array:C230(<>alACT_idCta;alACT_idCCtaFDP{$i})
	If ($vl_existe>0)
		atACT_FdPCCtaContable{$i}:=<>asACT_CuentaCta{$vl_existe}
		atACT_FdPCCtaCodAux{$i}:=<>asACT_CodAuxCta{$vl_existe}
	End if 
	  // centro costo contra
	$vl_existe:=Find in array:C230(<>alACT_idCentro;alACT_idCCentroFDP{$i})
	If ($vl_existe>0)
		atACT_FdPCCentroCostos{$i}:=<>asACT_Centro{$vl_existe}
	End if 
End for 

  //por compatibilidad se llena cheque a fecha
  //$vl_existe:=Find in array(alACT_FormasdePagoID;-5)
  //If ($vl_existe>0)
  //vtACT_CPCAFecha:=atACT_FdPCtaContable{$vl_existe}
  //vtACT_CCCAFecha:=atACT_FdPCentroCostos{$vl_existe}
  //vtACT_CCPCAFecha:=atACT_FdPCCtaContable{$vl_existe}
  //vtACT_CCCCAFecha:=atACT_FdPCCentroCostos{$vl_existe}
  //vtACT_CAUXCCAFecha:=atACT_FdPCtaCodAux{$vl_existe}
  //vtACT_CAUXCCCAFecha:=atACT_FdPCCtaCodAux{$vl_existe}
  //vtACT_CICAFecha:=atACT_FdPCodInterno{$vl_existe}
  //End if 

  //20130103 RCH Se leia una forma que finalmente no se utilizo...
READ ONLY:C145([ACT_EstadosFormasdePago:201])
QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id:1=-4)
If (Records in selection:C76([ACT_EstadosFormasdePago:201])>0)
	vtACT_CPCAFecha:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_EstadosFormasdePago:201]id_cuenta_contable:5;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
	vtACT_CCCAFecha:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_EstadosFormasdePago:201]id_centro_costo:6;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
	vtACT_CCPCAFecha:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
	vtACT_CCCCAFecha:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_EstadosFormasdePago:201]id_centro_costo_contra:8;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
	vtACT_CAUXCCAFecha:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_EstadosFormasdePago:201]id_cuenta_contable:5;->[ACT_Cuentas_Contables:286]codigo_aux:5)
	vtACT_CAUXCCCAFecha:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7;->[ACT_Cuentas_Contables:286]codigo_aux:5)
	vtACT_CICAFecha:=[ACT_EstadosFormasdePago:201]Codigo_interno:4
End if 

  //20130318 RCH Se utiliza en el ingreso de pago
COPY ARRAY:C226(atACT_FormasdePagoNew;atACT_FormasdePagoNew2)