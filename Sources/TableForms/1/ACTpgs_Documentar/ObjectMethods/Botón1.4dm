C_REAL:C285($vr_descuentoAfecto;$vr_descuentoExento)
C_LONGINT:C283($cbImprimirBoletas)

$vr_descuentoAfecto:=vrACT_MontoDesctoAfecto  //se iniciializa el descuento para que se haga la validación del descuento sólo al salir de la ventana y no al marcar o desmarcar avisos o ítems o cuentas...
$vr_descuentoExento:=vrACT_MontoDesctoExento
vrACT_MontoDesctoAfecto:=0
vrACT_MontoDesctoExento:=0

$cbImprimirBoletas:=cbImprimirBoletas
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTpgs_AvisosDocumentar";0;4;__ ("Avisos por pagar"))
DIALOG:C40([xxSTR_Constants:1];"ACTpgs_AvisosDocumentar")
CLOSE WINDOW:C154
vrACT_MontoDesctoAfecto:=$vr_descuentoAfecto
vrACT_MontoDesctoExento:=$vr_descuentoExento

ACTdesc_OpcionesGenerales ("CalculaDesdeIngresoPago")  //20170506 RCH

cbImprimirBoletas:=$cbImprimirBoletas

AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
ACTpgs_RetornaArreglosCargos 
AT_Initialize (->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp)
AT_Initialize (->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
ACTcfg_OpcionesRecargosCaja ("CargaDatosMulta")
ACTcfg_OpcionesRecargosCaja ("ValidacionesFormDocumentar")
ACTfdp_OpcionesRecargos ("CargaMontoRecargoDocumentar")
If ((modCargos) & (chequesGenerados))
	POST KEY:C465(Character code:C91("g");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
End if 