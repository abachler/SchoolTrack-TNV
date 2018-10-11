//%attributes = {}
  // Método: IT_GetTextHeight
  //
  //
  // por Alberto Bachler Klein
  // creación 29/03/17, 11:21:05
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_TEXT:C284($6)

C_LONGINT:C283($l_altoFuente;$l_anchoMax;$l_estilo;$l_ignora;$l_tamaño)
C_TEXT:C284($t_fuente;$t_hojaEstilo;$t_ignora;$t_Texto)

ARRAY TEXT:C222($at_arreglo;0)



If (False:C215)
	C_LONGINT:C283(IT_GetTextHeight ;$0)
	C_TEXT:C284(IT_GetTextHeight ;$1)
	C_LONGINT:C283(IT_GetTextHeight ;$2)
	C_TEXT:C284(IT_GetTextHeight ;$3)
	C_LONGINT:C283(IT_GetTextHeight ;$4)
	C_LONGINT:C283(IT_GetTextHeight ;$5)
	C_TEXT:C284(IT_GetTextHeight ;$6)
End if 

$t_Texto:=ST Get plain text:C1092($1)
$l_anchoMax:=$2
$t_hojaEstilo:=$3

Case of 
	: (Count parameters:C259=6)
		$t_fuente:=$6
		$l_estilo:=$5
		$l_tamaño:=$4
	: (Count parameters:C259=5)
		$l_estilo:=$5
		$l_tamaño:=$4
	: (Count parameters:C259=4)
		$l_tamaño:=$4
End case 


If (($t_hojaEstilo#"") & ($t_fuente=""))
	GET STYLE SHEET INFO:C1256($t_hojaEstilo;$t_fuente;$l_ignora;$l_estilo)
End if 

If (($t_hojaEstilo#"") & ($l_tamaño=0))
	GET STYLE SHEET INFO:C1256($t_hojaEstilo;$t_ignora;$l_tamaño;$l_ignora)
End if 

If (($t_hojaEstilo#"") & ($l_tamaño=0))
	GET STYLE SHEET INFO:C1256($t_hojaEstilo;$t_ignora;$l_ignora;$l_estilo)
End if 

Case of 
	: (Count parameters:C259=3)
		$l_altoFuente:=IT_GetFontHeight ($t_hojaEstilo)
	: (Count parameters:C259=4)
		$l_altoFuente:=IT_GetFontHeight ($t_hojaEstilo;$l_tamaño)
	: (Count parameters:C259=5)
		$l_altoFuente:=IT_GetFontHeight ($t_hojaEstilo;$l_tamaño;$l_estilo)
	: (Count parameters:C259=6)
		$l_altoFuente:=IT_GetFontHeight ($t_hojaEstilo;$l_tamaño;$l_estilo;$t_fuente)
End case 


TEXT TO ARRAY:C1149($t_texto;$at_arreglo;$l_anchoMax;$t_fuente;$l_tamaño;$l_estilo)

$0:=Size of array:C274($at_arreglo)*$l_altoFuente