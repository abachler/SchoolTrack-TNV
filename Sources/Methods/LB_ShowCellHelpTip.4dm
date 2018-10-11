//%attributes = {}
  // Método: LB_ShowCellHelpTip (textoTip:T {
  //
  //
  // por Alberto Bachler Klein
  // creación 01/04/17, 17:31:25
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_usarPosicionMouse)
C_LONGINT:C283($l_abajo;$l_abajoV;$l_alto;$l_ancho;$l_arriba;$l_arribaM;$l_arribaV;$l_boton;$l_columna;$l_derecha)
C_LONGINT:C283($l_derechaV;$l_fila;$l_izquierda;$l_izquierdaM;$l_izquierdaV)
C_POINTER:C301($y_tip)
C_TEXT:C284($t_helpText;$t_tipObjectName)


If (False:C215)
	C_TEXT:C284(LB_ShowCellHelpTip ;$1)
	C_BOOLEAN:C305(LB_ShowCellHelpTip ;$2)
End if 

$t_helpText:="\r"+$1+"\r"
$t_tipObjectName:="tip"

$b_usarPosicionMouse:=True:C214
If (Count parameters:C259=2)
	$b_usarPosicionMouse:=$2
End if 
$y_tip:=OBJECT Get pointer:C1124(Object named:K67:5;$t_tipObjectName)
$y_tip->:=$t_helpText


LB_GetCellMouseOver (->$l_columna;->$l_fila)
OBJECT GET BEST SIZE:C717(*;"tip";$l_ancho;$l_alto;300)
  //GET WINDOW RECT($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV)
GET MOUSE:C468($l_izquierdaM;$l_arribaM;$l_boton)
OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV)
GET WINDOW RECT:C443($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV;Frontmost window:C447)
LISTBOX GET CELL COORDINATES:C1330(*;OBJECT Get name:C1087(Object current:K67:2);$l_columna;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)

If ($b_usarPosicionMouse)
	$l_izquierda:=$l_izquierdaM+15
	$l_arriba:=$l_arribaM+15
	$l_derecha:=$l_izquierda
	$l_abajo:=$l_arriba
End if 

  //$l_abajoV:=$l_abajoV+LISTBOX Get headers height(*;OBJECT Get name(Object current))
$l_abajoV:=$l_abajoV-$l_arribaV
Case of 
	: ((($l_abajo+$l_alto)>$l_abajoV) & (($l_izquierda+5+$l_ancho)>$l_derechaV))
		$l_arriba:=$l_abajoV-$l_alto
		$l_izquierda:=$l_izquierda-$l_ancho
		
	: (($l_abajo+$l_alto)>$l_abajoV)
		$l_arriba:=$l_abajoV-$l_alto
		$l_izquierda:=$l_derecha  //+15
		
	: (($l_izquierda+$l_ancho)>$l_derechaV)
		$l_izquierda:=$l_izquierda-$l_ancho
		  //$l_arriba:=$l_abajo+15
		
	Else 
		If ($b_usarPosicionMouse)
			  //$l_izquierda:=$l_izquierdaM+15
			  //$l_arriba:=$l_arribaM+15
		Else 
			$l_izquierda:=$l_derecha  //+15
			$l_arriba:=$l_arriba+15
		End if 
		
End case 
$l_derecha:=$l_izquierda+$l_ancho
$l_abajo:=$l_arriba+$l_alto

  //OBJECT SET COORDINATES(*;"tip";$l_derecha-5;$l_abajo-5;$l_derecha+$l_ancho+5;$l_abajo+$l_alto+5)
OBJECT SET COORDINATES:C1248(*;"tip";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
OBJECT SET VISIBLE:C603(*;"tip";True:C214)




