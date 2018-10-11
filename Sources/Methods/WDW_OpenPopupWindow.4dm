//%attributes = {}
  // WDW_OpenPopupWindow(objeto:&Y; tabla:&Y; nombreFormulario:&T{; tipoVentana:&L)
If (False:C215)
	  // Por: Alberto Bachler: 07/10/13, 15:30:08
	  //  ---------------------------------------------
	  //
	  //
	  //  ---------------------------------------------
End if 
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_LONGINT:C283($l_abajo;$l_abajoObjeto;$l_abajoPopup;$l_abajoVentana;$l_altoPantalla;$l_alturaFormulario;$l_anchoFormulario;$l_anchoPantalla;$l_arriba;$l_arribaObjeto)
C_LONGINT:C283($l_arribaPopup;$l_arribaVentana;$l_centroH;$l_centroV;$l_derecha;$l_derechaObjeto;$l_derechaPopup;$l_derechaVentana;$l_izquierda;$l_izquierdaObjeto)
C_LONGINT:C283($l_izquierdaPopup;$l_izquierdaVentana;$l_tipoVentana)
C_POINTER:C301($y_objetoReferencia;$y_TablaFormulario)
C_TEXT:C284($t_nombreFormulario)

If (False:C215)
	C_POINTER:C301(WDW_OpenPopupWindow ;$1)
	C_POINTER:C301(WDW_OpenPopupWindow ;$2)
	C_TEXT:C284(WDW_OpenPopupWindow ;$3)
	C_LONGINT:C283(WDW_OpenPopupWindow ;$4)
End if 
$y_objetoReferencia:=$1
$y_TablaFormulario:=$2
$t_nombreFormulario:=$3

$l_tipoVentana:=Pop up window:K34:14
If (Count parameters:C259=4)
	  // se conserva solo por razones de compatibilidad
	  // una ventana popup debiera ser siempre de tipo 32 (Pop up Window), sin titulo casilla de cierre (con cierre automatico al hacer clic fuera de la ventana )
	$l_tipoVentana:=$4
End if 

If (Not:C34(Is nil pointer:C315($y_TablaFormulario)))
	FORM GET PROPERTIES:C674($y_TablaFormulario->;$t_nombreFormulario;$l_anchoFormulario;$l_alturaFormulario)
Else 
	FORM GET PROPERTIES:C674($t_nombreFormulario;$l_anchoFormulario;$l_alturaFormulario)
End if 

If (Not:C34(Is nil pointer:C315($y_objetoReferencia)))
	  // si se recibe un puntero válido en _objeto_ la ventana popup se abre a la bajo el objeto en el margen izquierdo
	GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana;Frontmost window:C447)
	OBJECT GET COORDINATES:C663($y_objetoReferencia->;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
	$l_izquierdaPopup:=$l_izquierdaVentana+$l_izquierdaObjeto
	$l_arribaPopup:=$l_arribaVentana+$l_abajoObjeto+5
	$l_derechaPopup:=$l_izquierdaPopup+$l_anchoFormulario
	$l_abajoPopup:=$l_arribaPopup+$l_alturaFormulario
Else 
	  // si el puntero es nulo la ventana se abre centrada sobre la ventana de segundo plano o al centro de la pantalla si no hay ninguna ventana abierta
	GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo;Frontmost window:C447(*))
	If (($l_izquierda=0) & ($l_derecha=0) & ($l_arriba=0) & ($l_abajo=0))
		SCREEN COORDINATES:C438($l_izquierda;$l_arriba;$l_derecha;$l_abajo;Menu bar screen:C441)
		$l_arriba:=$l_arriba+Menu bar height:C440
		$l_izquierda:=$l_izquierda+5
	End if 
	$l_anchoPantalla:=$l_derecha-$l_izquierda+1
	$l_altoPantalla:=$l_abajo-$l_arriba+1
	$l_centroH:=$l_izquierda+Int:C8($l_anchoPantalla/2)
	$l_centroV:=$l_arriba+Int:C8($l_altoPantalla/2)
	$l_izquierdaPopup:=$l_centroH-Int:C8($l_anchoFormulario/2)
	$l_arribaPopup:=$l_centroV-Int:C8($l_alturaFormulario/2)
	$l_derechaPopup:=$l_izquierdaPopup+$l_anchoFormulario
	$l_abajoPopup:=$l_arribaPopup+$l_alturaFormulario
End if 

If (($l_tipoVentana=4) | ($l_tipoVentana=8) | ($l_tipoVentana=5) | ($l_tipoVentana=16))
	$l_arribaPopup:=$l_arribaPopup+22
End if 

SCREEN COORDINATES:C438($l_izquierda;$l_arriba;$l_derecha;$l_abajo;Menu bar screen:C441)
$l_arriba:=$l_arriba+Menu bar height:C440
$l_izquierda:=$l_izquierda+5
$l_anchoPantalla:=$l_derecha-$l_izquierda+1
$l_altoPantalla:=$l_abajo-$l_arriba+1
Case of 
	: ($l_abajoPopup>$l_altoPantalla)
		$l_desplazamientoArriba:=$l_abajoPopup-$l_altoPantalla
		$l_arribaPopup:=$l_arribaPopup-$l_desplazamientoArriba-Menu bar height:C440-60
		$l_abajoPopup:=$l_abajoPopup-$l_desplazamientoArriba-Menu bar height:C440-60
	: ($l_arribaPopup<$l_altoPantalla)
		$l_desplazamientoAbajo:=$l_arribaPopup+Menu bar height:C440
End case 


If ($l_tipoVentana>0)
	If (Not:C34(Is nil pointer:C315($y_TablaFormulario)))
		$ref:=Open form window:C675($y_TablaFormulario->;$t_nombreFormulario;$l_tipoVentana;$l_izquierdaPopup;$l_arribaPopup)
	Else 
		$ref:=Open form window:C675($t_nombreFormulario;$l_tipoVentana;$l_izquierdaPopup;$l_arribaPopup)
	End if 
Else 
	$0:=Open window:C153($l_izquierdaPopup;$l_arribaPopup;$l_izquierdaPopup+$l_anchoFormulario;$l_arribaPopup+$l_alturaFormulario)
End if 

$0:=$ref