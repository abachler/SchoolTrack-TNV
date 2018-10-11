//%attributes = {}
  //ACTter_PageGeneral

C_LONGINT:C283($0)

ACTcfg_LoadConfigData (8)
vdACTTer_FechaC:=DTS_GetDate ([ACT_Terceros:138]DTS_Creacion:22)
vdACTTer_FechaM:=DTS_GetDate ([ACT_Terceros:138]DTS_Modificacion:23)

UFLD_LoadFileTplt (->[ACT_Terceros:138])

ACTcfg_ArregloDocsTribs (->[ACT_Terceros:138]id_CatDocTrib:55)

  //20171229 RCH
C_POINTER:C301($y_general;$y_otra)
$y_general:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_general")
$y_otra:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_otra")

$l_valor:=OB Get:C1224([ACT_Terceros:138]OB_Direccion_Facturacion:82;"tipo_direccion_facturacion";Is longint:K8:6)

$y_general->:=Num:C11(($l_valor=0) | ($l_valor ?? 1))
$y_otra->:=Num:C11($l_valor ?? 2)

$0:=1