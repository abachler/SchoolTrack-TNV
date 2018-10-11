  // [BBL_Préstamos].Consola.Botón()
  // Por: Alberto Bachler: 03/10/13, 17:50:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_modoBusquedaActual;$l_refCampoBusqueda)
C_TEXT:C284($t_tip)

MNU_EliminaMarcasMenu (vt_RefMenuModoBusqueda)
$l_modoBusquedaActual:=Find in array:C230(al_refModoBusquedaObjeto;vl_RefCampoBusqueda_BBLci)
SET MENU ITEM MARK:C208(vt_RefMenuModoBusqueda;$l_modoBusquedaActual;Char:C90(18))
$l_refCampoBusqueda:=MNU_PopupMenuDinamico (vt_RefMenuModoBusqueda;0)
If ($l_refCampoBusqueda>0)
	vl_RefCampoBusqueda_BBLci:=$l_refCampoBusqueda
	BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
End if 
GOTO OBJECT:C206(vt_InstruccionConsola_BBL)