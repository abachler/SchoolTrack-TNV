//%attributes = {}
  // IT_LeeGeometriaObjetos()
  // Por: Alberto Bachler: 08/11/13, 11:45:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_izquierda)



ARRAY TEXT:C222(at_Objetos_nombre;0)
ARRAY POINTER:C280(ay_Objectos_puntero;0)
ARRAY LONGINT:C221(al_Objectos_página;0)
FORM GET OBJECTS:C898(at_Objetos_nombre;ay_Objectos_puntero;al_Objectos_página)
ARRAY LONGINT:C221(al_Objectos_izquierda;0)
ARRAY LONGINT:C221(al_Objectos_Arriba;0)
ARRAY LONGINT:C221(al_Objectos_Derecha;0)
ARRAY LONGINT:C221(al_Objectos_Abajo;0)
ARRAY BOOLEAN:C223(ab_Objectos_Visible;0)
SORT ARRAY:C229(al_Objectos_página;at_Objetos_nombre;ay_Objectos_puntero)
For ($i;1;Size of array:C274(at_Objetos_nombre))
	OBJECT GET COORDINATES:C663(*;at_Objetos_nombre{$i};$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	APPEND TO ARRAY:C911(al_Objectos_izquierda;$l_izquierda)
	APPEND TO ARRAY:C911(al_Objectos_Arriba;$l_arriba)
	APPEND TO ARRAY:C911(al_Objectos_Derecha;$l_derecha)
	APPEND TO ARRAY:C911(al_Objectos_Abajo;$l_abajo)
	APPEND TO ARRAY:C911(ab_Objectos_Visible;OBJECT Get visible:C1075(*;at_Objetos_nombre{$i}))
End for 

GET WINDOW RECT:C443(vl_IzquierdaVentana;vl_arribaVentana;vl_derechaVentana;vl_abajoVentana)

