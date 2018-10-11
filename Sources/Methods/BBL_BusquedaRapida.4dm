//%attributes = {}
  // BBL_BusquedaRapida()
  // Por: Alberto Bachler K.: 16-12-14, 09:37:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_abajo;$l_abajoModo;$l_abajoSep;$l_ancho;$l_anchoModo;$l_arriba;$l_arribaModo;$l_arribaSep;$l_derecha;$l_ignorado)
C_LONGINT:C283($l_izquierda)
C_TEXT:C284($t_accion)


If (False:C215)
	C_TEXT:C284(BBL_BusquedaRapida ;$1)
End if 

If (Count parameters:C259=1)
	$t_accion:=$1
End if 

Case of 
	: ($t_accion="")
		WDW_OpenFormWindow (->[BBL_Items:61];"Busqueda";-1;Plain form window:K39:10)
		DIALOG:C40([BBL_Items:61];"Busqueda")
		CLOSE WINDOW:C154
		
	: ($t_accion="ajustesBarraEstado")
		OBJECT GET BEST SIZE:C717(*;"tipoBusqueda";$l_ancho;$l_ignorado;300)
		OBJECT GET BEST SIZE:C717(*;"modoComparacion";$l_anchoModo;$l_ignorado;300)
		OBJECT GET COORDINATES:C663(*;"tipoBusqueda";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_derecha:=$l_izquierda+$l_ancho
		OBJECT SET COORDINATES:C1248(*;"tipoBusqueda";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		OBJECT GET COORDINATES:C663(*;"separadorCondicion";$l_ignorado;$l_arribaSep;$l_ignorado;$l_abajoSep)
		$l_derecha:=$l_derecha+20
		OBJECT SET COORDINATES:C1248(*;"separadorCondicion";$l_derecha;$l_arribaSep;$l_derecha;$l_abajoSep)
		OBJECT GET COORDINATES:C663(*;"modoComparacion";$l_ignorado;$l_arribaModo;$l_ignorado;$l_abajoModo)
		$l_izquierda:=$l_derecha+20
		$l_derecha:=$l_izquierda+$l_anchoModo  //+10
		OBJECT SET COORDINATES:C1248(*;"modoComparacion";$l_izquierda;$l_arribaModo;$l_derecha;$l_abajoModo)
End case 

