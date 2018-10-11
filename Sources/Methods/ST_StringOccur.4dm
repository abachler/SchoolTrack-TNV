//%attributes = {}
  //ST_StringOccur

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_StringOccur
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 10:22
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Cuenta las ocurrencias de un string en un string
	  //  Si $3 es igual a 1 (argumento opcional) la comparación se hace
	  //  usando códigos ASCII, 
	  //  Si $3 tiene otro valor o no es pasado
	  //  la comparación se hace sin distinguir mayusculas ni diacriticos
	  //Sintaxis: st_StringOccur(string;text;[int]) -->Numero de ocurrencias
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($i;$3;$0)
If (Count parameters:C259=3)
	$Ascii:=0
Else 
	$ascii:=$3
End if 
$text:=$2
While (Position:C15($1;$text)>0)
	If ($ascii=1)
		$equal:=True:C214
		$text2:=Substring:C12($text;Position:C15($1;$text);Length:C16($1))
		For ($i;1;Length:C16($2))
			If ($1[[$i]]#$text2[[$i]])
				$equal:=False:C215
			End if 
		End for 
		If ($equal)
			$0:=$0+1
		End if 
	Else 
		$0:=$0+1
	End if 
	$text:=Substring:C12($text;Position:C15($1;$text)+Length:C16($1)+1)
End while 

