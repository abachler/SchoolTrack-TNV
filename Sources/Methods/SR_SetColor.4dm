//%attributes = {}
  // SR_SetColor()
  // Por: Alberto Bachler K.: 14-08-15, 18:09:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($err;$l_colorFondoAzul;$l_colorFondoRojo;$l_colorFondoVerde;$l_colorHexa;$l_colorTextoAzul;$l_colorTextoRojo;$l_colorTextoVerde)
C_TEXT:C284($t_colorFondo;$t_colorTexto;$t_colorFondoHexa;$t_colorTextoHexa)


If (False:C215)
	C_TEXT:C284(SR_SetColor ;$1)
	C_TEXT:C284(SR_SetColor ;$2)
End if 

Case of 
	: (Count parameters:C259=2)
		$t_colorTexto:=$1
		$t_colorFondo:=$2
	: (Count parameters:C259=1)
		$t_colorTexto:=$1
		$t_colorFondo:="White"
	: (Count parameters:C259=0)
		$t_colorTexto:="black"
		$t_colorFondo:="White"
End case 

SR_SetObjectColor ($t_colorTexto;$t_colorFondo)


