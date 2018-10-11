//%attributes = {}
  //SRACTbol_EndBoletaGrange

$bol:=String:C10($1)

  //20130626 RCH NF CANTIDAD
AT_Initialize (->atACT_CodigoFamilia;->arACT_MontoPagado;->arACT_Cantidad;->arACT_Unitario;->arACT_CTotalDesctos)
For ($i;1;13)
	$var1:=Get pointer:C304("vtACT_DetalleCargo"+String:C10($i)+$bol)
	$var2:=Get pointer:C304("vrACT_PagadoCargo"+String:C10($i)+$bol)
	$var3:=Get pointer:C304("vtACT_Alumno"+String:C10($i)+$bol)
	$var4:=Get pointer:C304("vlACT_Cantidad"+String:C10($i)+$bol)
	$var5:=Get pointer:C304("vrACT_Unitario"+String:C10($i)+$bol)
	$var6:=Get pointer:C304("vrACT_Descto"+String:C10($i)+$bol)
	$var7:=Get pointer:C304("vbACT_HideMonto"+String:C10($i)+$bol)
	$var1->:=""
	$var2->:=0
	$var3->:=""
	$var4->:=0
	$var5->:=0
	$var6->:=0
	$var7->:=False:C215
End for 
If ($bol="1")
	vCodigoFamilia1:=""
	vTotal1:=0
	vNeto1:=0
	vIVA1:=0
	vPorcentajeIVA1:=0
	vNumBol1:=0
	vFechaE1:=!00-00-00!
	vNombreApdo1:=""
	vRUTApdo1:=""
	vDireccionApdo1:=""
	vComunaApdo1:=""
	vCiudadApdo1:=""
	vTotalDesctos1:=0
	vbACT_HideTotal1:=False:C215
	vbACT_HideNeto1:=False:C215
	vbACT_HIdePorcIVA1:=False:C215
	vbACT_HideIVA1:=False:C215
Else 
	vCodigoFamilia2:=""
	vTotal2:=0
	vNeto2:=0
	vIVA2:=0
	vPorcentajeIVA2:=0
	vNumBol2:=0
	vFechaE2:=!00-00-00!
	vNombreApdo2:=""
	vRUTApdo2:=""
	vDireccionApdo2:=""
	vComunaApdo2:=""
	vCiudadApdo2:=""
	vTotalDesctos2:=0
	vbACT_HideTotal2:=False:C215
	vbACT_HideNeto2:=False:C215
	vbACT_HIdePorcIVA2:=False:C215
	vbACT_HideIVA2:=False:C215
End if 