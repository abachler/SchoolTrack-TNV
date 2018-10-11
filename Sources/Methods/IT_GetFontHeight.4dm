//%attributes = {}
  // Método: IT_GetFontHeight (nombreHojaEstilo:T {; tamaño:T {; estilo:T {;  nombreFuente:T}}}) --> altoFuente:L
  //
  //
  // por Alberto Bachler Klein
  // creación 29/03/17, 11:03:38
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_LONGINT:C283($l_alto;$l_anchoTexto;$l_estilo;$l_ignora;$l_tamaño)
C_PICTURE:C286($p_imagen)
C_TEXT:C284($t_fuente;$t_ignora;$t_nombreEstilo;$t_refObjetoSVG;$t_refSVG;$t_Texto)


If (False:C215)
	C_LONGINT:C283(IT_GetFontHeight ;$0)
	C_TEXT:C284(IT_GetFontHeight ;$1)
	C_LONGINT:C283(IT_GetFontHeight ;$2)
	C_LONGINT:C283(IT_GetFontHeight ;$3)
	C_TEXT:C284(IT_GetFontHeight ;$4)
End if 

$t_nombreEstilo:=$1
Case of 
	: (Count parameters:C259=4)
		$t_fuente:=$4
		$l_estilo:=$3
		$l_tamaño:=$2
	: (Count parameters:C259=3)
		$l_estilo:=$3
		$l_tamaño:=$2
	: (Count parameters:C259=2)
		$l_tamaño:=$2
End case 

If (($t_nombreEstilo#"") & ($t_fuente=""))
	GET STYLE SHEET INFO:C1256($t_nombreEstilo;$t_fuente;$l_ignora;$l_estilo)
End if 

If (($t_nombreEstilo#"") & ($l_tamaño=0))
	GET STYLE SHEET INFO:C1256($t_nombreEstilo;$t_ignora;$l_tamaño;$l_ignora)
End if 

If (($t_nombreEstilo#"") & ($l_tamaño=0))
	GET STYLE SHEET INFO:C1256($t_nombreEstilo;$t_ignora;$l_ignora;$l_estilo)
End if 

$t_refSVG:=SVG_New 
$t_refObjetoSVG:=SVG_New_text ($t_refSVG;"X";0;0;$t_fuente;$l_tamaño;$l_estilo)
$p_imagen:=SVG_Export_to_picture ($t_refSVG)
SVG_CLEAR ($t_refSVG)
PICTURE PROPERTIES:C457($p_imagen;$l_anchoTexto;$l_alto)


$0:=$l_alto



