//%attributes = {}
  // IT_DistribuyeObjetos_Horizontal()
  // Por: Alberto Bachler Klein: 23-10-15, 09:52:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($i;$l_abajo;$l_alineacion;$l_altoOptimo;$l_anchoOptimo;$l_arriba;$l_deplazamiento;$l_derecha;$l_izquierda;$l_posicionDerecha)
C_TEXT:C284($t_nombreObjetos)

ARRAY LONGINT:C221($al_Paginas;0)
ARRAY LONGINT:C221($al_Posiciones;0)
ARRAY LONGINT:C221($l_posicionInicial_H;0)
ARRAY LONGINT:C221($l_posicionInicial_V;0)
ARRAY POINTER:C280($ay_objetos;0)
ARRAY TEXT:C222($at_objetos;0)
ARRAY TEXT:C222($at_objetosForm;0)



If (False:C215)
	C_TEXT:C284(IT_DistribuyeObjetos_Horizontal ;$1)
	C_LONGINT:C283(IT_DistribuyeObjetos_Horizontal ;$2)
	C_LONGINT:C283(IT_DistribuyeObjetos_Horizontal ;$3)
	C_LONGINT:C283(IT_DistribuyeObjetos_Horizontal ;$4)
	C_LONGINT:C283(IT_DistribuyeObjetos_Horizontal ;$5)
End if 


$t_nombreObjetos:=$1
$l_deplazamiento:=$2


$l_posicionInicial_H:=-1
$l_posicionInicial_V:=-1
$l_alineacion:=0


If (ST_CountWords ($t_nombreObjetos;0;";")=1)
	FORM GET OBJECTS:C898($at_objetosForm;$ay_objetos;$al_Paginas)
	$at_objetosForm{0}:=$t_nombreObjetos
	AT_SearchArray (->$at_objetosForm;"=";->$al_Posiciones)
	SORT ARRAY:C229($al_Posiciones;>)
	For ($i;1;Size of array:C274($al_posiciones))
		APPEND TO ARRAY:C911($at_objetos;$at_objetosForm{$al_posiciones{$i}})
	End for 
Else 
	AT_Text2Array (->$at_objetos;$t_nombreObjetos;";")
End if 

If (Size of array:C274($at_objetos)>0)
	$l_posicionDerecha:=0
	Case of 
		: (Count parameters:C259=5)
			$l_alineacion:=$3
			$l_posicionInicial_H:=$4
			$l_posicionInicial_V:=$5
			
		: (Count parameters:C259=4)
			$l_alineacion:=$3
			$l_posicionInicial_H:=$4
			$l_posicionInicial_V:=$5
			
		: (Count parameters:C259=3)
			$l_alineacion:=$3
			$l_posicionInicial_H:=$4
			$l_posicionInicial_V:=$5
	End case 
	
	OBJECT GET COORDINATES:C663(*;$at_objetos{1};$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	OBJECT GET BEST SIZE:C717(*;$at_objetos{1};$l_anchoOptimo;$l_altoOptimo)
	$l_izquierdaRef:=Choose:C955($l_posicionInicial_H#$l_izquierda;$l_posicionInicial_H;$l_izquierda)
	$l_arribaRef:=Choose:C955($l_posicionInicial_V#$l_arriba;$l_posicionInicial_V;$l_arriba)
	IT_SetNamedObjectRect ($at_objetos{1};$l_izquierdaRef;$l_arribaRef;$l_izquierdaRef+$l_anchoOptimo;$l_arribaRef+$l_altoOptimo)
	$l_posicionDerecha:=$l_izquierda+$l_anchoOptimo
	
	OBJECT GET COORDINATES:C663(*;$at_objetos{1};$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	Case of 
		: ($l_alineacion<=1)  // arriba
			$l_posicionArriba:=$l_arriba
		: ($l_alineacion=2)  // centro
			$l_posicionArriba:=$l_arriba
			$l_posicionCentro:=$l_arriba+Int:C8(($l_abajo-$l_arriba)/2)
		: ($l_alineacion=3)  // abajo
			$l_posicionAbajo:=$l_abajo
	End case 
	
	
	
	For ($i;2;Size of array:C274($at_objetos))
		OBJECT GET COORDINATES:C663(*;$at_objetos{$i};$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		OBJECT GET BEST SIZE:C717(*;$at_objetos{$i};$l_anchoOptimo;$l_altoOptimo)
		If (($l_izquierda-$l_posicionDerecha)#$l_deplazamiento)
			$l_izquierda:=$l_posicionDerecha+$l_deplazamiento
		End if 
		$l_derecha:=$l_izquierda+$l_anchoOptimo
		$l_altoObjeto:=IT_Objeto_Alto ($at_objetos{$i})
		
		Case of 
			: ($l_alineacion<=1)  // arriba
				$l_arriba:=$l_posicionArriba
				$l_abajo:=$l_arriba+$l_altoOptimo
			: ($l_alineacion=2)  // centro
				$l_abajo:=$l_posicionCentro+Int:C8($l_altoObjeto/2)
				$l_arriba:=$l_posicionCentro-Int:C8($l_altoObjeto/2)
			: ($l_alineacion=3)  // abajo
				$l_abajo:=$l_posicionAbajo
				$l_arriba:=$l_posicionAbajo-$l_altoObjeto
			Else 
		End case 
		
		
		IT_SetNamedObjectRect ($at_objetos{$i};$l_izquierda;$l_arriba;$l_izquierda+$l_anchoOptimo;$l_abajo)
		$l_posicionDerecha:=$l_izquierda+$l_anchoOptimo
	End for 
	
End if 

