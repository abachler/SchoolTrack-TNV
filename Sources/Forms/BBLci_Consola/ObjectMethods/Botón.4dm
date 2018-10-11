  // [BBL_Préstamos].Consola.Botón()
  // Por: Alberto Bachler: 03/10/13, 17:50:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_posicion)
C_TEXT:C284($t_modoBusqueda;$t_tip)

$t_modoBusqueda:=OBJECT Get title:C1068(*;"botonBusqueda")
$t_modoBusqueda:=Replace string:C233($t_modoBusqueda;": ";"")
$l_posicion:=Find in array:C230(at_nombreCampoObjeto;$t_modoBusqueda)
If ($l_posicion>0)
	If ($l_posicion=Size of array:C274(at_nombreCampoObjeto))
		$l_posicion:=1
	Else 
		$l_posicion:=$l_posicion+1
	End if 
	If (at_nombreCampoObjeto{$l_posicion}="(-")
		$l_posicion:=$l_posicion+1
	End if 
End if 

vl_RefCampoBusqueda_BBLci:=al_refModoBusquedaObjeto{$l_posicion}
BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
  //OBJECT SET TITLE(*;"tip";$t_tip)
  //  //OBJECT SET VISIBLE(*;"tip";True)
  //OBJECT SET TITLE(*;"tip";$t_tip)
  //GOTO OBJECT(vt_InstruccionConsola_BBL)

