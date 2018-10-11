//%attributes = {}
  // Método: IT_GetTextDimensions (text:T ; nombreHojaEstilo:T {; tamaño:T {; estilo:T {;  nombreFuente:T}}}) --> resultado:O
  // devuelve las dimensiones de un texto en un objeto (atributos: "font", "width", "height") 
  // de acuerdo a los argumentos pasados
  // 
  // por Alberto Bachler Klein
  // creación 29/03/17, 11:12:32
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_LONGINT:C283($l_estilo;$l_height;$l_ignora;$l_tamaño;$l_width)
C_PICTURE:C286($p_imagen)
C_TEXT:C284($t_fontname;$t_ignora;$t_nombreEstilo;$t_refObjetoSVG;$t_refSVG;$t_Texto)
C_OBJECT:C1216($o_dimensiones)


If (False:C215)
	C_OBJECT:C1216(IT_GetTextDimensions ;$0)
	C_TEXT:C284(IT_GetTextDimensions ;$1)
	C_TEXT:C284(IT_GetTextDimensions ;$2)
	C_LONGINT:C283(IT_GetTextDimensions ;$3)
	C_LONGINT:C283(IT_GetTextDimensions ;$4)
	C_TEXT:C284(IT_GetTextDimensions ;$5)
End if 

$t_Texto:=$1
$t_nombreEstilo:=$2
Case of 
	: (Count parameters:C259=5)
		$t_fontname:=$5
		$l_estilo:=$4
		$l_tamaño:=$3
	: (Count parameters:C259=4)
		$l_estilo:=$4
		$l_tamaño:=$3
	: (Count parameters:C259=3)
		$l_tamaño:=$3
End case 

If (($t_nombreEstilo#"") & ($t_fontname=""))
	GET STYLE SHEET INFO:C1256($t_nombreEstilo;$t_fontname;$l_ignora;$l_estilo)
End if 

If (($t_nombreEstilo#"") & ($l_tamaño=0))
	GET STYLE SHEET INFO:C1256($t_nombreEstilo;$t_ignora;$l_tamaño;$l_ignora)
End if 

If (($t_nombreEstilo#"") & ($l_estilo=0))
	GET STYLE SHEET INFO:C1256($t_nombreEstilo;$t_ignora;$l_ignora;$l_estilo)
End if 

$t_refSVG:=SVG_New 
$t_refObjetoSVG:=SVG_New_text ($t_refSVG;$t_Texto;0;0;$t_fontname;$l_tamaño;$l_estilo)
$p_imagen:=SVG_Export_to_picture ($t_refSVG)
SVG_CLEAR ($t_refSVG)
PICTURE PROPERTIES:C457($p_imagen;$l_width;$l_height)

OB SET:C1220($o_dimensiones;"font";$t_fontname)
OB SET:C1220($o_dimensiones;"width";$l_width)
OB SET:C1220($o_dimensiones;"height";$l_height)

$0:=$o_dimensiones





















