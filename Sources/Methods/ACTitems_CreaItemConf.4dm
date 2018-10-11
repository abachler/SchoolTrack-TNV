//%attributes = {}
  //ACTitems_CreaItemConf

CREATE RECORD:C68([xxACT_Items:179])
[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
[xxACT_Items:179]Glosa:2:=__ ("Nuevo Item")
[xxACT_Items:179]Glosa_de_Impresión:20:=[xxACT_Items:179]Glosa:2
[xxACT_Items:179]Moneda:10:=ST_GetWord (ACT_DivisaPais ;1;";")
[xxACT_Items:179]VentaRapida:3:=False:C215

  //[xxACT_Items]Periodo:=<>gNombreAgnoEscolar
  //20140423 RCH Se asigna el periodo del filtro si es que es diferente a mostrar todos...
C_TEXT:C284($t_periodo)
$t_periodo:=PREF_fGet (0;"ACT_pref_filtroItems";"Todos")
If ($t_periodo="Todos")
	[xxACT_Items:179]Periodo:42:=<>gNombreAgnoEscolar
Else 
	[xxACT_Items:179]Periodo:42:=$t_periodo
End if 

For ($i;1;12)
	[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?- $i
	OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-3)
End for 

  //20140510 por defecto estan afectos a recargos automaticos al vencimiento
[xxACT_Items:179]id_tipoRecargoAut:45:=1
ACTcfg_OpcionesRecAutTabla ("CargaVarsConfiguracion")

ACTdesc_OpcionesVariables ("InitVars")

ACTcfg_Habilitatramoshijos (False:C215;False:C215;False:C215)
If ((<>gCountryCode="cl") & ([xxACT_Items:179]Moneda:10="UF@"))
	OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_UF")
Else 
	OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_ACT")
End if 
ACTcfg_Habilitatramoshijos (True:C214;True:C214;True:C214)

AL_SetSort (xALP_Items;0)

AL_UpdateArrays (xALP_items;0)
AT_Insert (1;1;->alACT_IdItem;->atACT_GlosaItem)
alACT_IdItem{1}:=[xxACT_Items:179]ID:1
atACT_GlosaItem{1}:=[xxACT_Items:179]Glosa:2
vi_lastLine:=1
AL_UpdateArrays (xALP_Items;-2)
AL_SetLine (xALP_items;vi_lastLine)
j1:=1
j2:=0
IT_SetButtonState (True:C214;->j1;->j2)
GOTO OBJECT:C206([xxACT_Items:179]Glosa:2)
HIGHLIGHT TEXT:C210([xxACT_Items:179]Glosa:2;1;80)