//%attributes = {}
  // IT_AutoResizeForm()
  // Por: Alberto Bachler: 09/10/13, 10:13:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_objeto)
C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_indiceObjeto;$l_izquierda;$l_limiteAbajo;$l_limiteArriba;$l_limiteDerecha;$l_limitederecho;$l_limiteIzquierda)
C_LONGINT:C283($l_MargenIzquierdo;$l_paginaActual;$l_PosicionUltimoObjeto_Abajo;$l_PosicionUltimoObjeto_Derecha;$l_redimensionamientoH;$l_redimensionamientoV)

ARRAY LONGINT:C221($al_PaginaObjetos;0)
ARRAY POINTER:C280($ay_objetos;0)
ARRAY TEXT:C222($at_nombreObjetos;0)

$l_limiteIzquierda:=10
$l_limiteDerecha:=Screen width:C187(*)
$l_limiteArriba:=Menu bar height:C440+20
$l_limiteAbajo:=Screen height:C188(*)-20

FORM GET OBJECTS:C898($at_nombreObjetos;$ay_objetos;$al_PaginaObjetos)
SORT ARRAY:C229($al_PaginaObjetos;$at_nombreObjetos)

$l_paginaActual:=FORM Get current page:C276
$l_indiceObjeto:=Find in array:C230($al_PaginaObjetos;$l_paginaActual)

$l_PosicionUltimoObjeto_Abajo:=0
$l_PosicionUltimoObjeto_Derecha:=0
$l_MargenIzquierdo:=Screen width:C187


GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
For ($i_objeto;$l_indiceObjeto;Size of array:C274($al_PaginaObjetos))
	If ($al_PaginaObjetos{$i_objeto}=$l_paginaActual)
		OBJECT GET COORDINATES:C663(*;$at_nombreObjetos{$i_objeto};$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		If ($l_izquierda<$l_MargenIzquierdo)
			$l_MargenIzquierdo:=$l_izquierda
		End if 
		If ($l_derecha>$l_PosicionUltimoObjeto_Derecha)
			$l_PosicionUltimoObjeto_Derecha:=$l_derecha
		End if 
		If ($l_abajo>$l_PosicionUltimoObjeto_Abajo)
			$l_PosicionUltimoObjeto_Abajo:=$l_abajo
		End if 
	Else 
		$i_objeto:=Size of array:C274($al_PaginaObjetos)
	End if 
End for 

GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
$l_PosicionUltimoObjeto_Derecha:=$l_PosicionUltimoObjeto_Derecha+$l_izquierdaVentana
$l_PosicionUltimoObjeto_Abajo:=$l_PosicionUltimoObjeto_Abajo+$l_arribaVentana

GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
If ($l_PosicionUltimoObjeto_Derecha>$l_Derecha)
	$l_redimensionamientoH:=$l_PosicionUltimoObjeto_Derecha-$l_Derecha+$l_MargenIzquierdo
Else 
	$l_redimensionamientoH:=$l_Derecha-$l_PosicionUltimoObjeto_Derecha+$l_MargenIzquierdo
End if 
If ($l_PosicionUltimoObjeto_Abajo>$l_Abajo)
	$l_redimensionamientoV:=$l_PosicionUltimoObjeto_Abajo-$l_abajo+80
Else 
	$l_redimensionamientoV:=$l_abajo-$l_PosicionUltimoObjeto_Abajo+80
End if 

If (($l_redimensionamientoH#0) | ($l_redimensionamientoV#0))
	Case of 
		: (($l_izquierda-(Int:C8($l_redimensionamientoH/2))<$l_limiteIzquierda) & ($l_derecha+(Int:C8($l_redimensionamientoH/2))>$l_limiteDerecha))
			  // el formulario no puede ser expandido más alla de los límites de la pantalla principal
			$l_izquierda:=$l_limiteIzquierda
			$l_derecha:=$l_limiteDerecha
		: (($l_izquierda-(Int:C8($l_redimensionamientoH/2))>$l_limiteIzquierda) & ($l_derecha+(Int:C8($l_redimensionamientoH/2))<$l_limiteDerecha))
			$l_izquierda:=$l_izquierda-Int:C8($l_redimensionamientoH/2)
			$l_derecha:=$l_derecha+Int:C8($l_redimensionamientoH/2)
		: ($l_izquierda-(Int:C8($l_redimensionamientoH/2))<$l_limiteIzquierda)
			$l_derecha:=$l_derecha+($l_redimensionamientoH-($l_limiteIzquierda-$l_izquierda))
			$l_izquierda:=$l_limiteIzquierda
		: ($l_derecha-(Int:C8($l_redimensionamientoH/2))>$l_limitederecho)
			$l_izquierda:=$l_izquierda+($l_redimensionamientoH-($l_derecha-$l_limitederecha))
			$l_derecha:=$l_limiteDerecha
	End case 
	
	Case of 
		: (($l_arriba-(Int:C8($l_redimensionamientoH/2))<$l_limiteArriba) & ($l_abajo+(Int:C8($l_redimensionamientoH/2))>$l_limiteAbajo))
			  // el formulario no puede ser expandido más alla de los límites de la pantalla principal
			$l_arriba:=$l_limiteArriba
			$l_abajo:=$l_limiteAbajo
		: (($l_arriba-(Int:C8($l_redimensionamientoH/2))>$l_limiteArriba) & ($l_abajo+(Int:C8($l_redimensionamientoH/2))<$l_limiteAbajo))
			$l_arriba:=$l_arriba-Int:C8($l_redimensionamientoH/2)
			$l_abajo:=$l_abajo+Int:C8($l_redimensionamientoH/2)
		: ($l_arriba-(Int:C8($l_redimensionamientoH/2))<$l_limiteArriba)
			$l_abajo:=$l_abajo+($l_redimensionamientoH-($l_limiteArriba-$l_arriba))
			$l_arriba:=$l_limiteArriba
		: ($l_abajo-(Int:C8($l_redimensionamientoH/2))>$l_limitederecho)
			$l_arriba:=$l_arriba+($l_redimensionamientoH-($l_abajo-$l_limiteAbajo))
			$l_abajo:=$l_limiteAbajo
	End case 
	
	SET WINDOW RECT:C444($l_arriba;$l_arriba;$l_derecha;$l_abajo)
End if 