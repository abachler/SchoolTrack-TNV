//%attributes = {}
  // IT_SeleccionCampo()
  // Por: Alberto Bachler K.: 12-02-15, 09:56:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)

C_LONGINT:C283($l_abajoLista;$l_abajoObjeto;$l_abajoVentana;$l_arribaLista;$l_arribaObjeto;$l_arribaVentana;$l_derechaLista;$l_derechaObjeto;$l_derechaVentana;$l_izquierdaLista)
C_LONGINT:C283($l_izquierdaObjeto;$l_izquierdaVentana;$l_largoTexto;$l_refVentana)
C_POINTER:C301($y_objeto;$y_tabla)


If (False:C215)
	C_TEXT:C284(IT_SeleccionCampo ;$0)
	C_POINTER:C301(IT_SeleccionCampo ;$1)
End if 

vy_campoSeleccion:=$1
vt_TextoBuscado:=Get edited text:C655

$y_objeto:=OBJECT Get pointer:C1124(Object current:K67:2)

$y_tabla:=Table:C252(Table:C252(vy_campoSeleccion))
  //SET QUERY DESTINATION(Into named selection;"$seleccionPredictivo")
QUERY:C277($y_tabla->;vy_campoSeleccion->;=;vt_TextoBuscado+"@")
ORDER BY:C49($y_tabla->;vy_campoSeleccion->;>)
  //SET QUERY DESTINATION(Into current selection)
CUT NAMED SELECTION:C334($y_tabla->;"$seleccionPredictivo")
LISTBOX SORT COLUMNS:C916(*;"lb_lista";1;>)


GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
OBJECT GET COORDINATES:C663($y_objeto->;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
$l_izquierdaLista:=$l_izquierdaVentana+$l_izquierdaObjeto  // window left + object left
$l_arribaLista:=$l_arribaVentana+$l_arribaObjeto  // windows top + object top
$l_derechaLista:=$l_izquierdaLista+($l_derechaObjeto-$l_izquierdaObjeto)  // 450  // suggested Left position + floating window width
$l_abajoLista:=$l_arribaLista+120  // suggested top position + floating window height
$l_refVentana:=Open window:C153($l_izquierdaLista;$l_arribaLista;$l_derechaLista;$l_abajoLista;Pop up window:K34:14)
DIALOG:C40("SeleccionValor")
CLOSE WINDOW:C154($l_refVentana)

GOTO OBJECT:C206($y_objeto->)
$l_largoTexto:=Length:C16($y_objeto->)+1
HIGHLIGHT TEXT:C210($y_objeto->;$l_largoTexto;$l_largoTexto)

If (OK=1)
	$0:=vt_TextoBuscado
End if 



