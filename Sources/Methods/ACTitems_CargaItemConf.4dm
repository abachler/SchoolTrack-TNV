//%attributes = {}
  //ACTitems_CargaItemConf

AL_UpdateArrays (xALP_Items;-2)
If (Size of array:C274(alACT_IdItem)>0)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_IdItem{1})
End if 
For ($i;1;12)
	$buttonPointer:=Get pointer:C304("bMes"+String:C10($i))
	If ([xxACT_Items:179]Meses_de_cargo:9 ?? $i)
		$buttonPointer->:=1
		OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-9)
	Else 
		$buttonPointer->:=0
		OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-3)
	End if 
End for 
SET QUERY LIMIT:C395(1)
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
SET QUERY LIMIT:C395(0)
If (Records in selection:C76([ACT_Cargos:173])=0)
	IT_SetButtonState (True:C214;->j1)
	IT_SetButtonState ((Not:C34([xxACT_Items:179]EsRelativo:5)) & (Not:C34([xxACT_Items:179]EsDescuento:6));->j2)
Else 
	IT_SetButtonState (False:C215;->j1;->j2)
End if 

  //20140106 RCH Carga descuentos por cuenta
AL_UpdateArrays (xALP_DesctosHijos;0)
AL_UpdateArrays (xALP_DesctosFamilia;0)
ACTdesc_OpcionesVariables ("LeeConfItem";->[xxACT_Items:179]ID:1)
ARRAY TEXT:C222(atACT_HijoNumero;0)
ARRAY TEXT:C222(atACT_Tramo;0)
ARRAY TEXT:C222(atACT_Familia;0)
LOC_LoadList2Array ("ACT_Hijos";->atACT_HijoNumero)
LOC_LoadList2Array ("ACT_Tramos";->atACT_Tramo)
LOC_LoadList2Array ("ACT_Cargas";->atACT_Familia)
ARRAY REAL:C219(arACT_DesctoPorHijo;16)
ARRAY REAL:C219(arACT_DesctoTramo;16)
ARRAY REAL:C219(arACT_DesctoPorFamilia;16)
For ($i;1;16)
	$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
	$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
	$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
	arACT_DesctoPorHijo{$i}:=$hijo->
	arACT_DesctoTramo{$i}:=$tramo->
	arACT_DesctoPorFamilia{$i}:=$familia->
End for 
AL_UpdateArrays (xALP_DesctosHijos;-2)
AL_UpdateArrays (xALP_DesctosFamilia;-2)
  //20140106 RCH Carga descuentos por cuenta

ACTcfg_OpcionesRazonesSociales ("ActualizaNombreRazon")
j1:=Num:C11(Not:C34(([xxACT_Items:179]VentaRapida:3)))
j2:=Num:C11(([xxACT_Items:179]VentaRapida:3))

  //recargos automaticos
ACTcfg_OpcionesRecAutTabla ("CargaVarsConfiguracion")

OBJECT SET VISIBLE:C603(bDisableMeses;(j2=1))
IT_SetEnterable (True:C214;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
If (j2=1)
	IT_SetEnterable (False:C215;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
	ACTcfg_Habilitatramoshijos (False:C215;False:C215;False:C215)
	OBJECT SET ENTERABLE:C238([xxACT_Items:179]TasaInteresMensual:25;False:C215)
	OBJECT SET ENTERABLE:C238([xxACT_Items:179]AfectoInteres:26;False:C215)
	For ($i;1;12)
		OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-3)
	End for 
Else 
	ACTcfg_HabilitaOpcionesItem (False:C215)
End if 




REDRAW WINDOW:C456
ACTcfg_SaveItemdeCargo 

$l_existe:=Find in array:C230(alACT_IdItem;[xxACT_Items:179]ID:1)
If ($l_existe=-1)
	$l_existe:=1
End if 
AL_SetLine (xALP_items;vi_lastLine)
