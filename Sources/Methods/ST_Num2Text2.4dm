//%attributes = {}
  // ST_Num2Text2()
  // Por: Alberto Bachler: 17/04/13, 12:08:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_REAL:C285($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($b_forzarCeroEnPalabras;$b_usarSeparadoresLiterales;$b_usarSignosSeparadores)
C_LONGINT:C283($i;$l_posicionSeparador)
C_REAL:C285($r_numero)
C_TEXT:C284($t_decimalEnTexto;$t_Idioma;$t_numeroEnTexto;$t_resultado;$t_separador;$t_tempDecimal)

If (False:C215)
	C_TEXT:C284(ST_Num2Text2 ;$0)
	C_REAL:C285(ST_Num2Text2 ;$1)
	C_TEXT:C284(ST_Num2Text2 ;$2)
	C_BOOLEAN:C305(ST_Num2Text2 ;$3)
	C_BOOLEAN:C305(ST_Num2Text2 ;$4)
End if 

$r_numero:=$1
$t_Idioma:=$2
$b_usarSignosSeparadores:=True:C214
Case of 
	: (Count parameters:C259=4)
		$b_forzarCeroEnPalabras:=$4
		$b_usarSeparadoresLiterales:=$3
		
	: (Count parameters:C259=3)
		$b_usarSeparadoresLiterales:=$3
		
End case 

Case of 
	: ($b_usarSeparadoresLiterales)
		If (<>tXS_RS_DecimalSeparator=",")
			$t_separador:=" coma "
		Else 
			$t_separador:=" punto "
		End if 
	: ((Count parameters:C259=2) & (<>vtXS_CountryCode="cl"))
		If (<>tXS_RS_DecimalSeparator=",")
			$t_separador:=", "
		Else 
			$t_separador:=". "
		End if 
	: ((Count parameters:C259=2) & (<>vtXS_CountryCode#"cl"))
		If (<>tXS_RS_DecimalSeparator=",")
			$t_separador:=" coma "
		Else 
			$t_separador:=" punto "
		End if 
	Else 
		If (<>tXS_RS_DecimalSeparator=",")
			$t_separador:=" coma "
		Else 
			$t_separador:=" punto "
		End if 
End case 

$t_numeroEnTexto:=String:C10($r_numero)

$l_posicionSeparador:=Position:C15(<>tXS_RS_DecimalSeparator;$t_numeroEnTexto)
$t_decimalEnTexto:=""
If ($l_posicionSeparador>0)
	$t_decimalEnTexto:=Substring:C12($t_numeroEnTexto;$l_posicionSeparador+1)
	$t_numeroEnTexto:=Substring:C12($t_numeroEnTexto;1;$l_posicionSeparador-1)
End if 

Case of 
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Unidades")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Decenas")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Centenas")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Miles")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Decenas de Mil")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Centenas de Mil")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Millones")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Decenas de Millon")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Centenas de Millon")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
	: (ST_Num2Text_Mantisa ($t_numeroEnTexto)="Billones")
		$t_resultado:=ST_Num2Text_Traductor ($t_numeroEnTexto;ST_Num2Text_Mantisa ($t_numeroEnTexto);$t_Idioma)
End case 
If ($t_resultado[[1]]=" ")
	$t_resultado:=Substring:C12($t_resultado;2)
End if 

$t_tempDecimal:=""
Case of 
	: (($t_decimalEnTexto="") & ($b_forzarCeroEnPalabras))
		$t_resultado:=$t_resultado+$t_separador+ST_Num2Text_Traductor ("0";"Unidades";$t_Idioma)
		
	: ($t_decimalEnTexto#"")
		$t_tempDecimal:=$t_separador
		For ($i;1;Length:C16($t_decimalEnTexto))
			$t_tempDecimal:=$t_tempDecimal+ST_Num2Text_Traductor ($t_decimalEnTexto[[$i]];"Unidades";$t_Idioma)+" "
		End for 
		$t_tempDecimal:=Substring:C12($t_tempDecimal;1;Length:C16($t_tempDecimal)-1)
		$t_resultado:=$t_resultado+$t_tempDecimal
End case 

$0:=$t_resultado

