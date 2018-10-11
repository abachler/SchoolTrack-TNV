//%attributes = {}
  //ACTpgs_DocumentarInit

AT_Initialize (->atACT_BancoNombre;->atACT_BancoCodigo;->atACT_Cuenta;->atACT_Titular;->atACT_RUTTitular;->atACT_Serie;->atACT_Fecha;->adACT_Fecha;->arACT_MontoCheque;->asACT_RUTTitular;->abACT_Modificados)
vrACT_MontoAPagar:=0
vrACT_MontoAPagarApdo:=0
vtACT_NoSerie:=""
vrACT_MontoPrimero:=0
$Fecha:=String:C10(Current date:C33(*);7)
$date:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($Fecha;1;2));Num:C11(Substring:C12($Fecha;4;2));Num:C11(Substring:C12($Fecha;7)))
$StringFecha:=String:C10($date)
vtACT_FechaDocumento:=$Fecha
vdACT_FechaDocumento:=Current date:C33(*)
vlACT_Cuotas:=10
vsACT_LugardePago:=""
IT_SetEnterable (True:C214;0;->vrACT_MontoAPagarApdo;->vlACT_Cuotas)
  //IT_SetButtonState (False;->bIngresarPago;->bNextPago;->bImprimirLista) `para permitir el ingreso de pagos aunque el apoderado no tenga deuda
GOTO OBJECT:C206(vrACT_MontoAPagarApdo)

$Fecha:=String:C10(Current date:C33(*);7)
vtACT_LCFechaEDocumento:=$Fecha
vtACT_LCFechaVDocumento:=$Fecha
vdACT_LCFechaEDocumento:=Current date:C33(*)
vdACT_LCFechaVDocumento:=Current date:C33(*)
vlACT_LCFolio:=0
vrACT_LCMontoPrimero:=0
vBool:=False:C215
AT_Populate (->abACT_LCModificados;->vBool)

vlACT_FormasdePago:=0
vsACT_FormasdePago:=""
vrACT_MontoPago:=0
vtACT_ObservacionesPago:=""
vdACT_LFechaEmision:=!00-00-00!
vdACT_LFechaVencimiento:=!00-00-00!
vtACT_LTitular:=""
vtACT_LRUTTitular:=""
vtACT_LDocumento:=""
vrACT_LImpuesto:=0
vtACT_LIndiceLetras:=""

AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento;->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados)