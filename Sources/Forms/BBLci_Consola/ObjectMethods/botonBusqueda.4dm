  // [BBL_Préstamos].Consola.Botón 3D()
  // Por: Alberto Bachler: 29/09/13, 18:31:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_Arriba;$l_derecha;$l_izquierda;$l_modoBusqueda)
C_TEXT:C284($t_Tip)


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		$t_Tip:=__ ("Haga clic para seleccionar un modo de búsqueda o utilice las teclas flecha arriba/flecha abajo para cambiarlo.")
		IT_MuestraTip ($t_tip)
	: (Form event:C388=On Clicked:K2:4)
		MNU_EliminaMarcasMenu (vt_RefMenuModoBusqueda)
		$l_modoBusquedaActual:=Find in array:C230(al_refModoBusquedaObjeto;vl_RefCampoBusqueda_BBLci)
		SET MENU ITEM MARK:C208(vt_RefMenuModoBusqueda;$l_modoBusquedaActual;Char:C90(18))
		$l_desfasePosicion:=IT_Objeto_Alto (OBJECT Get name:C1087(Object current:K67:2))
		$l_refCampoBusqueda:=MNU_PopupMenuDinamico (vt_RefMenuModoBusqueda;$l_desfasePosición)
		If ($l_refCampoBusqueda>0)
			vl_RefCampoBusqueda_BBLci:=$l_refCampoBusqueda
			BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
		End if 
		GOTO OBJECT:C206(vt_InstruccionConsola_BBL)
End case 
