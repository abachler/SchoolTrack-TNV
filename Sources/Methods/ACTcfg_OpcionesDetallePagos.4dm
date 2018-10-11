//%attributes = {}
  //ACTcfg_OpcionesDetallePagos

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301($ptr1)
$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraVars")
		C_LONGINT:C283(csACTcfg_MostrarDctos;csACTcfg_AgruparDctosEnCaja)
		csACTcfg_MostrarDctos:=0
		csACTcfg_AgruparDctosEnCaja:=0
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_DetallePagos")
		
	: ($vt_accion="ArmaBlob")
		BLOB_Variables2Blob ($ptr1;0;->csACTcfg_MostrarDctos;->csACTcfg_AgruparDctosEnCaja)
		
	: ($vt_accion="DesarmaBlob")
		BLOB_Blob2Vars ($ptr1;0;->csACTcfg_MostrarDctos;->csACTcfg_AgruparDctosEnCaja)
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_DetallePagos")
		
End case 