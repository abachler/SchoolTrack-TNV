C_LONGINT:C283($table)

$line:=AL_GetLine (xAL_Modelos)

$table:=Table:C252(->[ACT_Boletas:181])*-1
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=alACT_ModelosDocID{$line})

DUPLICATE RECORD:C225([xShell_Reports:54])
$index:=1
$sName:=[xShell_Reports:54]ReportName:26
While (Find in field:C653([xShell_Reports:54]ReportName:26;$sName)>-1)
	$sName:=[xShell_Reports:54]ReportName:26+" "+String:C10($index)
	$index:=$index+1
End while 
  //[xShell_Reports]IsStandard:=False
  //[xShell_Reports]ReportName:=$sName
[xShell_Reports:54]ReportName:26:=$sName
[xShell_Reports:54]IsStandard:38:=False:C215
[xShell_Reports:54]ID:7:=0
[xShell_Reports:54]UUID:47:=Generate UUID:C1066
[xShell_Reports:54]Public:8:=False:C215
[xShell_Reports:54]UUID_institucion:33:=""
[xShell_Reports:54]DTS_Repositorio:45:=""
[xShell_Reports:54]timestampISO_repositorio:37:=""
[xShell_Reports:54]EnRepositorio:48:=False:C215
[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
[xShell_Reports:54]Auto_UUID:49:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
SAVE RECORD:C53([xShell_Reports:54])
UNLOAD RECORD:C212([xShell_Reports:54])

ACTcfg_LeeConfEnNuevoProc ("GuardaConfiguracion")
  //ACTcfg_LoadConfigData (8)
ACTcfg_LoadBolModels 
AL_UpdateArrays (xAL_Modelos;-2)
xALPSet_ACT_TiposdeDoc 
ACTcfg_MarkStandardDTModels 
If (Size of array:C274(atACT_ModelosDoc)>0)
	AL_SetLine (xAL_Modelos;1)
	atACT_ModelosDoc:=1
	cb_EsEstandar:=Num:C11(abACT_ModelosEsSt{1})
	_O_ENABLE BUTTON:C192(cb_EsEstandar)
Else 
	AL_SetLine (xAL_Modelos;0)
	atACT_ModelosDoc:=0
	cb_EsEstandar:=0
	_O_DISABLE BUTTON:C193(cb_EsEstandar)
End if 
IT_SetButtonState ((atACT_ModelosDoc>0);->bEditarModelo;->bGuardarModelo;->bBorrarModelo;->bDuplicarModelo)