//%attributes = {}
  //ACTpgs_MapVariables

$index:=$1
Case of 
	: (rCheques=1)
		  //vsACT_FormasdePago:="Cheque"
		vlACT_FormasdePago:=-4
		vrACT_MontoPago:=arACT_MontoCheque{$index}
		vtACT_ObservacionesPago:=atACT_ObsDoc{$index}
		vtACT_BancoNombre:=atACT_BancoNombre{$index}
		vtACT_BancoCodigo:=atACT_BancoCodigo{$index}
		vtACT_BancoCuenta:=atACT_Cuenta{$index}
		vdACT_FechaDocumento:=adACT_Fecha{$index}
		vtACT_NoSerie:=atACT_Serie{$index}
		vtACT_BancoRUTTitular:=atACT_RUTTitular{$index}
		vtACT_BancoTitular:=atACT_Titular{$index}
	: (rLetras=1)
		  //$el:=Find in array(atACT_FormasdePago;"Letra@")
		  //If ($el#-1)
		  //vsACT_FormasdePago:=atACT_FormasdePago{$el}
		  //Else 
		  //vsACT_FormasdePago:="Letra"
		  //End if 
		vlACT_FormasdePago:=-8
		vrACT_MontoPago:=arACT_LCMonto{$index}
		vdACT_LFechaEmision:=adACT_LCEmision{$index}
		vdACT_LFechaVencimiento:=adACT_LCVencimiento{$index}
		vtACT_LTitular:=atACT_LCAceptante{$index}
		vtACT_LRUTTitular:=atACT_LCRut{$index}
		vdACT_FechaPago:=adACT_LCEmision{$index}
		vtACT_LDocumento:=String:C10(arACT_LCFolio{$index})
		vrACT_LImpuesto:=arACT_LCImpuesto{$index}
		vtACT_LIndiceLetras:=String:C10($index)+";"+String:C10(Size of array:C274(arACT_LCFolio))
		vtACT_ObservacionesPago:=atACT_ObsDoc{$index}
End case 
vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
  //$ctaIndex:=Find in array(atACT_FormasdePago;vsACT_FormasdePago+"@")
  //$vt_formaDePago:=vsACT_FormasdePago+"@"
ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
  //vsACT_CtaContablePago:=atACT_FdPCtaContable{$ctaIndex}
  //vsACT_CentroContablePago:=atACT_FdPCentroCostos{$ctaIndex}
  //vsACT_CCtaContablePago:=atACT_FdPCCtaContable{$ctaIndex}
  //vsACT_CCentroContablePago:=atACT_FdPCCentroCostos{$ctaIndex}
  //vsACT_CodAuxCtaPago:=atACT_FdPCtaCodAux{$ctaIndex}
  //vsACT_CodAuxCCtaPago:=atACT_FdPCCtaCodAux{$ctaIndex}
