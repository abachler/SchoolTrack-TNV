//%attributes = {}
  // BBLci_InfoCampoBusqueda(varTexto:&Y; varCampo:Y)
  // Por: Alberto Bachler: 01/10/13, 09:50:15
  //  ---------------------------------------------
  // retorna el texto de ayuda  mostrar y un puntero sobre el campo objeto de busqueda
  // en las variables pasadas como puntero
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_arriba;$l_derecha;$l_derechaFondo;$l_izquierda;$l_izquierdaVar;$l_posicion;$l_refModoBusqueda)
C_POINTER:C301($y_Campo;$y_textoAyuda)

If (False:C215)
	C_LONGINT:C283(BBLci_InfoCampoBusqueda ;$1)
	C_POINTER:C301(BBLci_InfoCampoBusqueda ;$2)
	C_POINTER:C301(BBLci_InfoCampoBusqueda ;$3)
End if 

$l_refModoBusqueda:=$1
$y_textoAyuda:=$2
$y_Campo:=$3
$l_posicion:=Find in array:C230(al_RefModoBusqueda_BBLci;$l_refModoBusqueda)
If ($l_posicion>0)
	$y_textoAyuda->:=at_nombreCampo_BBLci{$l_posicion}
	$y_Campo->:=ay_Campo_BBLci{$l_posicion}
End if 
OBJECT SET TITLE:C194(*;"botonBusqueda";$y_textoAyuda->)
GOTO OBJECT:C206(vt_InstruccionConsola_BBL)
OBJECT GET BEST SIZE:C717(*;"botonBusqueda";$l_ancho;$l_alto)

OBJECT GET COORDINATES:C663(*;"botonBusqueda";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_derecha:=$l_izquierda+$l_ancho
IT_SetNamedObjectRect ("botonBusqueda";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)

$l_derechaFondo:=$l_derecha+10
OBJECT GET COORDINATES:C663(*;"fondoBusqueda";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
IT_SetNamedObjectRect ("fondoBusqueda";$l_izquierda;$l_arriba;$l_derechaFondo;$l_abajo)

$l_izquierdaVar:=$l_derechaFondo+5
OBJECT GET COORDINATES:C663(vt_InstruccionConsola_BBL;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
IT_SetObjectRect (->vt_InstruccionConsola_BBL;$l_izquierdaVar;$l_arriba;$l_derecha;$l_abajo)

