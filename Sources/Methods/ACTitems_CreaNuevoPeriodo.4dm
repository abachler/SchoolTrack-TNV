//%attributes = {}
  //ACTitems_CreaNuevoPeriodo

AL_SetSort (xALP_Items;0)
AL_UpdateArrays (xALP_Items;0)
C_LONGINT:C283($l_idItemOrg;$l_idItem)
$l_idItemOrg:=[xxACT_Items:179]ID:1
$l_idItem:=ACTitems_DuplicaCargo ($l_idItemOrg)
If ($l_idItemOrg#$l_idItem)
	ACTcfgit_OpcionesGenerales ("DuplicaItemsTramosParaItem";->$l_idItemOrg;->$l_idItem)  //20131002 RCH para duplicar tramos
End if 
KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
PREF_Set (0;"ACT_pref_filtroItems";[xxACT_Items:179]Periodo:42)
ACTitems_FiltroPeriodo ("CreaLista")
AL_UpdateArrays (xALP_Items;-2)
ACTitems_SeleccionaLinea ($l_idItem)
