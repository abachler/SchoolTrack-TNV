//%attributes = {}
  //ACTeod_MultasAutomaticas
  //20110408 RCH. A solicitud del icif se deja en herramientas/ejecutar...
C_DATE:C307($vd_CurrentDate)
$vd_CurrentDate:=Current date:C33(*)
ACTcfg_OpcionesRecargosAut ("RecalculoMultasFinDeDia";->$vd_CurrentDate)
