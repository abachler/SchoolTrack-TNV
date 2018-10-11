//%attributes = {}
  // WDW_OpenFormWindow(punteroTabla:&Y; nombreFormulario:&L;refPosicion&L;tipoVentana:&L {;tituloVentana:&T {;metodoCierre:&T}})
  // Por: Alberto Bachler Klein: 31-10-15, 12:30:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($l_abajo;$l_altoFormulario;$l_altoPantalla;$l_altoPantallaeight;$l_alturaPaleta;$l_anchoFormulario;$l_anchoPantalla;$l_anchoPantallaidth;$l_arriba;$l_botonMouse)
C_LONGINT:C283($l_derecha;$l_izquierda;$l_mouseX;$l_mouseY;$l_parametros;$l_posicion;$l_posicionAbajo;$l_posicionArriba;$l_posicionDerecha;$l_PosicionH)
C_LONGINT:C283($l_posicionIzquierda;$l_posicionV;$l_RefPosicionArriba;$l_RefPosicionIzquierda;$l_refVentana;$l_tipoAbsoluto;$l_tipoVentana)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_metodoCierreVentana;$t_nombreFormulario;$t_tituloVentana)

If (False:C215)
	C_LONGINT:C283(WDW_OpenFormWindow ;$0)
	C_POINTER:C301(WDW_OpenFormWindow ;$1)
	C_TEXT:C284(WDW_OpenFormWindow ;$2)
	C_LONGINT:C283(WDW_OpenFormWindow ;$3)
	C_LONGINT:C283(WDW_OpenFormWindow ;$4)
End if 

$l_parametros:=Count parameters:C259
$y_tabla:=$1
$t_nombreFormulario:=$2
If (($3=8) | ($3=9) | ($3<0))
	GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo;Frontmost window:C447)
	If ($l_izquierda=0)
		$3:=-2
	End if 
	
	If ((Undefined:C82($l_izquierda)) & (Undefined:C82($l_arriba)) & (Undefined:C82($l_derecha)) & (Undefined:C82($l_abajo)))
		$l_abajo:=Screen height:C188-Menu bar height:C440
		$l_derecha:=Screen width:C187
	Else 
		If (($l_izquierda=0) & ($l_arriba=0) & ($l_derecha=0) & ($l_abajo=0))
			$l_abajo:=Screen height:C188-Menu bar height:C440
			$l_derecha:=Screen width:C187
		End if 
	End if 
	$l_posicion:=$3
Else 
	$l_abajo:=Screen height:C188-Menu bar height:C440
	$l_derecha:=Screen width:C187
	$l_posicion:=$3
End if 

$l_alturaPaleta:=0
$l_RefPosicionIzquierda:=$l_izquierda
$l_RefPosicionArriba:=$l_arriba

If (Not:C34(Is nil pointer:C315($y_tabla)))
	FORM GET PROPERTIES:C674($y_tabla->;$t_nombreFormulario;$l_anchoFormulario;$l_altoFormulario)
Else 
	FORM GET PROPERTIES:C674($t_nombreFormulario;$l_anchoFormulario;$l_altoFormulario)
End if 

$l_tipoVentana:=0
$t_tituloVentana:=""
$t_metodoCierreVentana:=""
If ($l_parametros>=4)
	$l_tipoVentana:=$4
	If ($l_parametros>=5)
		$t_tituloVentana:=$5
		If ($l_parametros=6)
			$t_metodoCierreVentana:=$6
		End if 
	End if 
End if 


  //****CUERPO****
If ($l_tipoVentana=4)  //forcing type 8 (with zoom box) when type 4 is requested
	  //$l_tipoVentana:=4
End if 
If ($l_tipoVentana=5)
	  //$l_tipoVentana:=-1984
End if 
$l_tipoAbsoluto:=Abs:C99($l_tipoVentana)
Case of   //setting windows coordinates
	: (($l_tipoVentana=0) | ($l_tipoAbsoluto=4) | ($l_tipoAbsoluto=8) | ($l_tipoVentana=16))
		$l_posicionIzquierda:=4
		$l_posicionArriba:=50+$l_alturaPaleta
		$l_posicionDerecha:=$l_derecha
		$l_posicionAbajo:=$l_abajo
		
	: ($l_tipoVentana=1)
		$l_posicionIzquierda:=10
		$l_posicionArriba:=30+$l_alturaPaleta
		$l_posicionDerecha:=$l_derecha-10
		$l_posicionAbajo:=$l_abajo-10
		
	: ($l_tipoVentana=2)
		$l_posicionIzquierda:=3
		$l_posicionArriba:=3+$l_alturaPaleta
		$l_posicionDerecha:=$l_derecha-3
		$l_posicionAbajo:=$l_abajo-3
		
	: ($l_tipoVentana=3)
		$l_posicionIzquierda:=3
		$l_posicionArriba:=23
		$l_posicionDerecha:=$l_derecha-10
		$l_posicionAbajo:=$l_abajo-10
		
	: ($l_tipoVentana=5)
		$l_posicionIzquierda:=10
		$l_posicionArriba:=46+$l_alturaPaleta
		$l_posicionDerecha:=$l_derecha-10
		$l_posicionAbajo:=$l_abajo-10
		
	: ((($l_tipoAbsoluto>=Palette form window:K39:9) & ($l_tipoAbsoluto<=1999)) | (($l_tipoAbsoluto>=700) & ($l_tipoAbsoluto<=799)) | (($l_tipoAbsoluto>=14000) & ($l_tipoAbsoluto<=14015)))
		$l_posicionIzquierda:=3
		$l_posicionArriba:=36+$l_alturaPaleta
		$l_posicionDerecha:=$l_derecha
		$l_posicionAbajo:=$l_abajo
		If ($l_tipoVentana<0)
			$l_tipoVentana:=-1984
		Else 
			$l_tipoVentana:=$l_tipoAbsoluto  //1984
		End if 
		
	Else 
		$l_posicionIzquierda:=10
		$l_posicionArriba:=46+$l_alturaPaleta
		$l_posicionDerecha:=$l_derecha
		$l_posicionAbajo:=$l_abajo
End case 

Case of   //setting window position
		
	: ($l_posicion=-2)  //centered on screen (jhb)
		$l_anchoPantalla:=Screen width:C187
		$l_altoPantalla:=Screen height:C188-Menu bar height:C440
		$l_PosicionH:=($l_anchoPantalla\2)-($l_anchoFormulario/2)
		$l_posicionV:=($l_altoPantalla\2)-($l_altoFormulario/2)
		
		
	: ($l_posicion=-1)  //centered over parent window
		$l_PosicionH:=(($l_derecha-$l_izquierda)/2)-($l_anchoFormulario/2)+$l_izquierda
		$l_posicionV:=(($l_abajo-$l_arriba)/2)-($l_altoFormulario/2)+$l_arriba
		
	: ($l_posicion=0)  //Centered     modificación especial para SCHOOLTRACK
		$l_anchoPantallaidth:=Screen width:C187
		$l_altoPantallaeight:=Screen height:C188-Menu bar height:C440
		If ($l_anchoPantallaidth>=792)
			$l_anchoPantalla:=792
			$l_altoPantalla:=520
		Else 
			$l_anchoPantalla:=624
			$l_altoPantalla:=410
		End if 
		$l_PosicionH:=($l_anchoPantalla\2)-($l_anchoFormulario/2)
		$l_posicionV:=($l_altoPantalla\2)-($l_altoFormulario/2)
		
	: ($l_posicion=1)  //Stacked
		If (($l_anchoFormulario+$l_RefPosicionIzquierda)>$l_derecha) | (($l_altoFormulario+$l_RefPosicionArriba)>$l_abajo)
			$l_RefPosicionIzquierda:=2
			$l_RefPosicionArriba:=40+$l_alturaPaleta
		End if 
		$l_PosicionH:=$l_RefPosicionIzquierda
		$l_posicionV:=$l_RefPosicionArriba
		$l_RefPosicionIzquierda:=$l_RefPosicionIzquierda+20
		$l_RefPosicionArriba:=$l_RefPosicionArriba+15
		
	: ($l_posicion=2)  //Upper left corner
		$l_PosicionH:=$l_posicionIzquierda
		$l_posicionV:=$l_posicionArriba
		  //$x2:=$l_PosicionH+$l_anchoFormulario
		  //$y2:=$l_posicionV+$l_altoFormulario
		
	: ($l_posicion=3)  //Upper right corner
		$l_PosicionH:=$l_derecha-$l_anchoFormulario-10
		$l_posicionV:=$l_posicionArriba+20
		  //$x2:=$l_PosicionH+$l_anchoFormulario
		  //$y2:=$l_posicionV+$l_altoFormulario
		
	: ($l_posicion=4)  //Lower left corner
		$l_PosicionH:=2
		$l_posicionV:=$l_abajo-$l_altoFormulario-20
		$x2:=$l_PosicionH+$l_anchoFormulario
		$y2:=$l_posicionV+$l_altoFormulario
		
	: (($l_posicion=5) | ($l_posicion=-5))  //Lower right corner
		$l_PosicionH:=$l_derecha-$l_anchoFormulario-20
		$l_posicionV:=$l_abajo-$l_altoFormulario-20
		  //$x2:=$l_PosicionH+$l_anchoFormulario
		  //$y2:=$l_posicionV+$l_altoFormulario
		
	: ($l_posicion=6)  //1/3 from top & centered (courtesy of Vance Miller)
		$l_abajo:=$l_abajo\3
		$l_derecha:=$l_derecha\3
		$l_PosicionH:=$l_derecha-($l_anchoFormulario\2)
		$l_posicionV:=$l_abajo-($l_altoFormulario\2)
		
	: ($l_posicion=7)  //Click related (courtesy of Alberto Bächler)
		GET MOUSE:C468($l_mouseX;$l_mouseY;$l_botonMouse;*)
		$l_mouseX:=$l_mouseX+10
		$l_mouseY:=$l_mouseY+10
		$l_PosicionH:=$l_mouseX
		$l_posicionV:=$l_mouseY
		If ($l_PosicionH<($l_RefPosicionIzquierda))
			$l_PosicionH:=$l_RefPosicionIzquierda
		End if 
		If (($l_PosicionH+$l_anchoFormulario)>$l_derecha)
			$l_PosicionH:=$l_derecha-$l_anchoFormulario
		End if 
		If ($l_posicionV<($l_RefPosicionArriba))
			$l_posicionV:=$l_RefPosicionArriba
		End if 
		If (($l_posicionV+$l_altoFormulario)>$l_abajo)
			$l_posicionV:=$l_abajo-$l_altoFormulario
		End if 
		
	: ($l_posicion=8)  //Upper right related to window (courtesy of Alberto Bächler)
		$l_PosicionH:=$l_derecha-$l_anchoFormulario  // -70
		$l_posicionV:=$l_posicionArriba
		
	: ($l_posicion=9)  //Lower right related to window (courtesy of Alberto Bächler)
		$l_PosicionH:=$l_derecha-$l_anchoFormulario
		$l_posicionV:=$l_abajo-$l_altoFormulario
		
	: ($l_posicion=10)  //Top, centered horizontally on parent window
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo;Frontmost window:C447)
		$l_PosicionH:=(($l_derecha-$l_izquierda)/2)-($l_anchoFormulario/2)+$l_izquierda
		$l_posicionV:=$l_arriba
		
End case 


If ($l_posicionV<$l_posicionArriba)
	$l_posicionV:=$l_posicionArriba
End if 

If ($l_PosicionH<$l_posicionIzquierda)
	$l_PosicionH:=$l_posicionIzquierda
End if 


If (SYS_IsMacintosh )
	$l_tipoVentana:=Abs:C99($l_tipoVentana)  // las ventanas flotantes bloquean la aplicación en MacOS y 4D v13 o superior
End if 

If ($l_tipoVentana>0)
	If (Not:C34(Is nil pointer:C315($y_tabla)))
		$l_refVentana:=Open form window:C675($y_tabla->;$t_nombreFormulario;$l_tipoVentana;$l_PosicionH;$l_posicionV)
	Else 
		$l_refVentana:=Open form window:C675($t_nombreFormulario;$l_tipoVentana;$l_PosicionH;$l_posicionV)
	End if 
Else 
	$l_refVentana:=Open window:C153($l_PosicionH;$l_posicionV;$l_PosicionH+$l_anchoFormulario;$l_posicionV+$l_altoFormulario;$l_tipoVentana)
End if 

If ($t_tituloVentana#"")
	SET WINDOW TITLE:C213($t_tituloVentana;$l_refVentana)
End if 


If ((SYS_IsWindows ) & (Window kind:C445($l_refVentana)=Regular window:K27:1))
	WDW_SetWindowIcon ($l_refVentana)
End if 

$0:=$l_refVentana









