rLetras:=0
If (Self:C308->=0)
	Self:C308->:=1
End if 
FORM GOTO PAGE:C247(1)
xALSet_ACT_Documentar 
AL_UpdateArrays (xALP_DocumentarLC;0)
AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
AT_Initialize (->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
AL_UpdateArrays (xALP_DocumentarLC;-2)
If (vl_indexLC>0)
	ACTcfg_LoadConfigData (8)
	alACT_Proxima{vl_indexLC}:=vlACT_LCFolio  //para cuando se saque la transaccion
	ACTcfg_SaveConfig (8)
End if 
ACTcfg_OpcionesRecargosCaja ("CargaDatosMulta")
ACTcfg_OpcionesRecargosCaja ("ValidacionesFormDocumentar")
ACTfdp_OpcionesRecargos ("CargaMontoRecargoDocumentar")