//%attributes = {}
  // BBLci_EditaItem()
  // Por: Alberto Bachler K.: 28-01-14, 11:36:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_PICTURE:C286(pSave;pCancel;pFirst;pNext;pPrev;pLast;pPrint;pDelete;pInfos)

vlBWR_CurrentModuleRef:=$1
vsBWR_CurrentModule:=$2
yBWR_currentTable:=$3
$l_recNumRegistroSeleccionado:=$4
If (USR_checkRights ("M";->[BBL_Items:61]))
	vbXS_inBrowser:=False:C215
	vb_RecordInInputForm:=True:C214
	vlBWR_BrowsingMethod:=BWR Browsing Disabled
	BBL_InitVariables 
	BBL_LeeConfiguracion 
	MNU_CreateDevSubMenu 
	BWR_LoadFormReportsArrays (yBWR_currentTable)
	dhBWR_LoadLists (vsBWR_CurrentModule)
	WDW_OpenFormWindow (yBWR_currentTable;"Input";-1;4;__ ("");"WDW_CloseDlog")
	GOTO RECORD:C242(yBWR_currentTable->;$l_recNumRegistroSeleccionado)
	BWR_ModifyRecord (yBWR_currentTable;"Input")
	CLOSE WINDOW:C154
	vb_RecordInInputForm:=False:C215
Else 
	$l_ignorar:=CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para editar los registros de la tabla:\r")+XSvs_nombreTablaLocal_puntero (->[BBL_Items:61]))
End if 

