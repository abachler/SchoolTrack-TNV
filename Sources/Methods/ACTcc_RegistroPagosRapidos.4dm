//%attributes = {}
  // Método: ACTcc_RegistroPagosRapidos
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-03-10, 10:48:11
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_PICTURE:C286($3)
C_REAL:C285(RNApdo)
C_LONGINT:C283(RNTercero)

ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")

RNApdo:=$1
RNTercero:=$2
vpXS_IconModule:=$3
vsBWR_CurrentModule:=$4
vb_RecordInInputForm:=True:C214
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTpgs_VentasRapidas";0;4;__ ("Ventas Directas"))
DIALOG:C40([xxSTR_Constants:1];"ACTpgs_VentasRapidas")
CLOSE WINDOW:C154
<>lACT_PagosRapidos:=0