//%attributes = {}
  //SRACTac_EndAviso

C_POINTER:C301($varPtr;$arrPtr1;$arrPtr2;$arrPtr3;$arrPtr4;$arrPtr5;$arrPtr6)
C_POINTER:C301($arrPtr7;$arrPtr8)

$aviso:=1
If (Count parameters:C259=1)
	$aviso:=$1
End if 

SRACTacmx_LoadVarsPagosRef ("InitVars";->$aviso)
$varPtr:=Get pointer:C304("vlACT_SRac_IDAviso"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vlACT_SRac_MesNum"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vtACT_SRac_MesText"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vlACT_SRac_AñoAviso"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vdACT_SRac_FechaAviso"+String:C10($aviso))
$varPtr->:=!00-00-00!
$varPtr:=Get pointer:C304("vdACT_SRac_FechaVencimiento"+String:C10($aviso))
$varPtr->:=!00-00-00!
$varPtr:=Get pointer:C304("vdACT_SRac_2FechaPago"+String:C10($aviso))
$varPtr->:=!00-00-00!
$varPtr:=Get pointer:C304("vdACT_SRac_3FechaPago"+String:C10($aviso))
$varPtr->:=!00-00-00!
$varPtr:=Get pointer:C304("vdACT_SRac_4FechaPago"+String:C10($aviso))
$varPtr->:=!00-00-00!
$varPtr:=Get pointer:C304("vtACT_SRac_Observaciones"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vrACT_SRac_SaldoAnterior"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_InteresesAnteriores"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_CargosAnteriores"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_Total"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_MontoAPagar"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vtACT_SRac_TotalText"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_MontoAPagarText"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vrACT_SRac_MontoNeto"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_Intereses"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_MontoPagado"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vtACT_SRac_ComunaEC"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_CiudadEC"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_CodPostalEC"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_EmailPersonal"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_ApdoNombre"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_IDNacApdo"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_IDNac2Apdo"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_IDNac3Apdo"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_DirEC"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_DirPersonal"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_DirProfesional"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_CodigoFamilias"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_NombreFamilias"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_MododePago"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vrACT_SRac_SaldoApdo"+String:C10($aviso))
$varPtr->:=0

$varPtr:=Get pointer:C304("vtACT_SRac_NombreCta"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_IDNacCta"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_CursoCta"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_NivelCta"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_CodigoCta"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vrACT_SRac_SaldoCta"+String:C10($aviso))
$varPtr->:=0

$varPtr:=Get pointer:C304("vrACT_SRac_MontoExento"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_MontoAfecto"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_Tot2Fecha"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_Tot3Fecha"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_Tot4Fecha"+String:C10($aviso))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRac_MontoIVA"+String:C10($aviso))
$varPtr->:=0

$varPtr:=Get pointer:C304("vtACT_SRac_IDDT"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_EstadoDT"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_EmitidoPor"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_TotalTextDT"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_FechaEmisionDT"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_Afecto"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_IVA"+String:C10($aviso))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRac_TotalDT"+String:C10($aviso))
$varPtr->:=""

$arrPtr1:=Get pointer:C304("atACT_CGlosaImpresion"+String:C10($aviso))
$arrPtr2:=Get pointer:C304("arACT_CMontoNeto"+String:C10($aviso))
$arrPtr3:=Get pointer:C304("atACT_CAlumno"+String:C10($aviso))
$arrPtr4:=Get pointer:C304("asACT_Afecto"+String:C10($aviso))
$arrPtr5:=Get pointer:C304("atACT_CAlumnoCurso"+String:C10($aviso))
$arrPtr6:=Get pointer:C304("atACT_CAlumnoNivelNombre"+String:C10($aviso))
  //$arrPtr7:=Get pointer("alACT_Cantidad"+String($aviso))  //RCH
  //20130626 RCH NF CANTIDAD
$arrPtr7:=Get pointer:C304("arACT_Cantidad"+String:C10($aviso))  //RCH

$arrPtr8:=Get pointer:C304("atACT_MonedaSimbolo"+String:C10($aviso))
AT_Initialize ($arrPtr1;$arrPtr2;$arrPtr3;$arrPtr4;$arrPtr5;$arrPtr6)
AT_Initialize ($arrPtr7;$arrPtr8)  //RCH

  //20170718 RCH
$arrPtr1:=Get pointer:C304("atACT_SRac_RespNombre"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_IDNacResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_IDNac2Resp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_IDNac3Resp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_ComunaECResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_CiudadECResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_CodPostalECResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_DirECResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_DirPersonalResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_DirProfesionalResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)
$arrPtr1:=Get pointer:C304("atACT_SRac_EmailPersonalResp"+String:C10($aviso))
AT_Initialize ($arrPtr1)