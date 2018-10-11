  // Metodos y Comandos.hl_comandos()
  // Por: Alberto Bachler: 23/02/13, 19:00:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$l_RefItemSeleccionado;$t_NombreItemSeleccionado)
GET LIST ITEM PARAMETER:C985(Self:C308->;$l_RefItemSeleccionado;"Sintaxis";$t_sintaxis)
GET LIST ITEM PARAMETER:C985(Self:C308->;$l_RefItemSeleccionado;"Descripcion";$t_descripcion)
$t_helpTip:=$t_sintaxis+"\r"+$t_descripcion
OBJECT GET COORDINATES:C663(Self:C308->;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
API Create Tip ($t_helpTip;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)


