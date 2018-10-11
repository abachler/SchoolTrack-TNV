//%attributes = {}
  //ACTpgs_AppendCarToArray

recNumCargo:=$1
If (recNumCargo#-1)
	READ ONLY:C145([ACT_Cargos:173])
	KRL_GotoRecord (->[ACT_Cargos:173];recNumCargo)
	AT_Insert (1;1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
	AT_Insert (1;1;->alACT_CIdsCargos;->arACT_MontoPagado;->arACT_MontoIVA;->alACT_CIdDctoCargo;->arACT_CMontoAfecto;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
	AT_Insert (1;1;->alACT_CIdsAvisos;->adACT_CfechaInteres)
	adACT_CFechaEmision{1}:=[ACT_Cargos:173]FechaEmision:22
	adACT_CFechaVencimiento{1}:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
	atACT_CAlumno{1}:=[Alumnos:2]apellidos_y_nombres:40
	atACT_CGlosa{1}:=[ACT_Cargos:173]Glosa:12
	arACT_CMontoNeto{1}:=[ACT_Cargos:173]Monto_Neto:5
	arACT_CIntereses{1}:=[ACT_Cargos:173]Intereses:29
	arACT_CSaldo{1}:=[ACT_Cargos:173]Saldo:23
	alACT_RecNumsCargos{1}:=Record number:C243([ACT_Cargos:173])
	alACT_CRefs{1}:=[ACT_Cargos:173]Ref_Item:16
	alACT_CIDCtaCte{1}:=[ACT_Cargos:173]ID_CuentaCorriente:2
	arACT_MontoMoneda{1}:=[ACT_Cargos:173]Monto_Moneda:9
	atACT_MonedaCargo{1}:=[ACT_Cargos:173]Moneda:28
	alACT_CIdsCargos{1}:=[ACT_Cargos:173]ID:1
	arACT_MontoPagado{1}:=[ACT_Cargos:173]MontosPagados:8
	arACT_MontoIVA{1}:=[ACT_Cargos:173]Monto_IVA:20
	alACT_CIdDctoCargo{1}:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
	arACT_CMontoAfecto{1}:=[ACT_Cargos:173]Monto_Afecto:27
	alACT_CidCargoGenInt{1}:=[ACT_Cargos:173]ID_CargoRelacionado:47
	alACT_CIdsAvisos{1}:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
	ACTpgs_SimboloMoneda 
End if 