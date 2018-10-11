  // [BBL_Préstamos].Consola.Botón1()
  // Por: Alberto Bachler: 03/10/13, 17:58:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_posicion)
C_TEXT:C284($t_modoBusqueda;$t_tip)

OBJECT GET COORDINATES:C663(*;"botonBusqueda";$l_izquierda;$l_arriba;$l_Derecha;$l_abajo)
POST CLICK:C466($l_izquierda+3;$l_arriba+1)