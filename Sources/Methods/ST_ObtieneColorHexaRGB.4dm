//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 25-07-18, 11:51:27
  // ----------------------------------------------------
  // Método: ST_ObtieneColorHexaRGB
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($ref_color)
C_OBJECT:C1216($o_raiz)
C_LONGINT:C283($l_posicion;$l_largo;$l_total;$l_indice;$l_valor)
C_TEXT:C284($t_color)

$t_accion:=$1
$b_calculaHexa:=True:C214
$l_total:=0

Case of 
	: ($t_accion="AbrePaletaColores")
		$ref_color:=Select RGB color:C956(16580095;"Seleccione color")
		
	: ($t_accion="colorRandom")
		$ref_color:=(Random:C100*10)
		
	: ($t_accion="RGB a Hexa")
		$y_refColor:=$2
		$ref_color:=$y_refColor->
		
	: ($t_accion="Hexa a RGB")
		$y_refColor:=$2
		$t_color:=$y_refColor->
		$b_calculaHexa:=False:C215
		$l_largo:=Length:C16($t_color)
		
		For ($l_indice;1;$l_largo)
			Case of 
				: ($t_color[[$l_indice]]="A")
					$l_valor:=10
				: ($t_color[[$l_indice]]="B")
					$l_valor:=11
				: ($t_color[[$l_indice]]="C")
					$l_valor:=12
				: ($t_color[[$l_indice]]="D")
					$l_valor:=13
				: ($t_color[[$l_indice]]="E")
					$l_valor:=14
				: ($t_color[[$l_indice]]="F")
					$l_valor:=15
				Else 
					$l_valor:=Num:C11($t_color[[$l_indice]])
			End case 
			$l_posicion:=$l_largo-$l_indice
			$l_total:=$l_total+($l_valor*(16^$l_posicion))
		End for 
		$ref_color:=$l_total
		
End case 

If ($b_calculaHexa)
	$t_color:=String:C10($ref_color;"&x")
	$t_color:=Replace string:C233(String:C10($t_color;"&x");"0x";"")
	$t_color:="000000"+$t_color
	$t_color:="#"+Substring:C12($t_color;Length:C16($t_color)-5;Length:C16($t_color))
End if 

OB SET:C1220($o_raiz;"Hexa";$t_color)
OB SET:C1220($o_raiz;"RGB";$ref_color)

$0:=$o_raiz
