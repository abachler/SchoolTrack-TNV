//%attributes = {}
  // LB_GetMouseOverCell()
  //
  //
  // creado por: Alberto Bachler Klein: 22-02-16, 16:41:04
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($bottom;$i;$j;$k;$l_abajo;$l_altoEncabezado;$l_altoFila;$l_altoPie;$l_altoScrollHorizontal;$l_arriba)
C_LONGINT:C283($l_boton;$l_derecha;$l_desfase;$l_fila;$l_izquierda;$l_mouseX;$l_mouseY;$l_posicion)
C_POINTER:C301($y_columna;$y_fila;$y_listbox)

ARRAY LONGINT:C221($al_columnasVisibles;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY POINTER:C280($ay_variablesColumna;0)
ARRAY POINTER:C280($ay_variablesEncabezado;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)
ARRAY TEXT:C222($at_nombresPie;0)
ARRAY TEXT:C222($at_variablesPie;0)


If (False:C215)
	C_POINTER:C301(LB_GetMouseOverCell ;$1)
	C_POINTER:C301(LB_GetMouseOverCell ;$2)
	C_POINTER:C301(LB_GetMouseOverCell ;$3)
End if 


$y_listbox:=$1
$y_columna:=$2
$y_fila:=$3


  // obtengo la posición del mouse
GET MOUSE:C468($l_mouseX;$l_mouseY;$l_boton)

  // nombres de las columnas
LISTBOX GET ARRAYS:C832($y_listbox->;$at_nombreColumnas;$at_nombreEncabezados;$ay_variablesColumna;\
$ay_variablesEncabezado;$al_columnasVisibles;$al_estilos;$at_nombresPie;$at_variablesPie)

  // obtengo la fila sobre la que se encuentra el mouse
OBJECT GET COORDINATES:C663($y_listbox->;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_altoFila:=LISTBOX Get rows height:C836($y_listbox->;lk pixels:K53:22)
$l_altoEncabezado:=LISTBOX Get property:C917($y_listbox->;_o_lk header height:K53:5)
$l_altoPie:=LISTBOX Get property:C917($y_listbox->;_o_lk footer height:K53:21)
$l_altoScrollHorizontal:=LISTBOX Get property:C917($y_listbox->;lk hor scrollbar height:K53:7)

If (($l_mouseX>$l_izquierda) & ($l_mouseX<$l_derecha) & ($l_mouseY>($l_arriba+$l_altoEncabezado)) & ($l_mouseY<($l_abajo-$l_altoPie-$l_altoScrollHorizontal)))
	$l_posicion:=LISTBOX Get property:C917($y_listbox->;_o_lk ver scrollbar position:K53:11)
	$l_desfase:=Mod:C98($l_posicion;$l_altoFila)
	$l_mouseY:=$l_mouseY+$l_desfase
	$l_fila:=Int:C8((($l_mouseY-$l_arriba-$l_altoEncabezado)/$l_altoFila))+Int:C8(($l_posicion/$l_altoFila))+1
Else 
	$l_fila:=-1
End if 
$y_fila->:=$l_fila

  // obtengo la columna sobre la que se encuentra el mouse
For ($i;1;Size of array:C274($at_nombreColumnas))
	OBJECT GET COORDINATES:C663(*;$at_nombreColumnas{$i};$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	If (($l_mouseX>=$l_izquierda) & ($l_mouseX<=$l_derecha))
		$y_columna->:=$i
		$i:=Size of array:C274($at_nombreColumnas)
	End if 
End for 


