//%attributes = {}
  // Método: ACTpgs_DeclarationsFormasPago
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 01-03-10, 16:33:43
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTpgs_DeclarationsFormasPago

ARRAY TEXT:C222(atACT_TipoTarjeta;0)

_O_C_STRING:C293(80;VSACT_LUGARDEPAGO)
C_TEXT:C284(vsACT_FormasdePago;vtACT_ObservacionesPago)
C_LONGINT:C283(vlACT_FormasdePago)
vsACT_LugardePago:=""
vsACT_FormasdePago:=""
vtACT_ObservacionesPago:=""
vlACT_FormasdePago:=0

C_TEXT:C284(vtACT_BancoNombre;vtACT_BancoCuenta;vtACT_BancoTitular;vtACT_NoSerie;vtACT_FechaDocumento)
C_DATE:C307(vdACT_FechaDocumento)
vtACT_BancoNombre:=""
vtACT_BancoCuenta:=""
vtACT_BancoTitular:=""
vtACT_NoSerie:=""
vtACT_FechaDocumento:=""
  //20130417 RCH Valor por defecto
  //vdACT_FechaDocumento:=!00/00/00!
vdACT_FechaDocumento:=Current date:C33(*)

C_TEXT:C284(vtACT_TCDocumento;vtACT_TCTipo;vtACT_TCNumero;vtACT_TCBancoEmisor;vtACT_TCTitular;vtACT_TCMesVencimiento;vtACT_TCAgnoVencimiento;vtACT_TCBancoCodigo)
vtACT_TCDocumento:=""
vtACT_TCTipo:=""
vtACT_TCNumero:=""
vtACT_TCBancoEmisor:=""
vtACT_TCTitular:=""
vtACT_TCMesVencimiento:=""
vtACT_TCAgnoVencimiento:=""
vtACT_TCBancoCodigo:=""

  //C_TEXT(vtACT_RDocumento)
  //vtACT_RDocumento:=""

  // Ticket 116401
C_TEXT:C284(vtACT_TDDocumento;vtACT_TDTipo;vtACT_TDNumero;vtACT_TDBancoEmisor;vtACT_TDTitular;vtACT_TDMesVencimiento;vtACT_TDAgnoVencimiento;vtACT_TDBancoCodigo)
C_TEXT:C284(vtACT_RDocumento)
vtACT_RDocumento:=""
vtACT_TDDocumento:=""
vtACT_TDTipo:=""
vtACT_TDNumero:=""
vtACT_TDBancoEmisor:=""
vtACT_TDTitular:=""
vtACT_TDMesVencimiento:=""
vtACT_TDAgnoVencimiento:=""
vtACT_TDBancoCodigo:=""



C_TEXT:C284(vtACT_LDocumento;vtACT_LFechaEmision;vtACT_LFechaVencimiento;vtACT_LTitular)
C_DATE:C307(vdACT_LFechaVencimiento;vdACT_LFechaEmision)
vtACT_LDocumento:=""
vtACT_LFechaEmision:=""
vtACT_LFechaVencimiento:=""
vtACT_LTitular:=""
  //20130417 RCH Valor por defecto
  //vdACT_LFechaVencimiento:=!00/00/00!
  //vdACT_LFechaEmision:=!00/00/00!
vdACT_LFechaVencimiento:=Current date:C33(*)
vdACT_LFechaEmision:=Current date:C33(*)