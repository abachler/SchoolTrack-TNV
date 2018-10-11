//%attributes = {}
  //ST_CharOcurr

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_CharOcurr
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 10:04
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Cuenta las ocurrencias de un caracter en un string
	  //  Si $3 es igual a 1 (argumento opcional) la comparación se hace
	  //  usando el código ASCII, Si $3 tiene otro valor o no es pasado
	  //  la comparación se hace sin distinguir mayusculas ni diacriticos
	  //Sintaxis: st_CharOccur(string;text;[int]) -->Numero de ocurrencias
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($0;$3;$ascii)
_O_C_STRING:C293(1;$1)
C_TEXT:C284($2)

If (Count parameters:C259=3)
	$Ascii:=$3
Else 
	$ascii:=0
End if 
If ($ascii=1)
	$code:=Character code:C91($1)
	For ($i;1;Length:C16($2))
		If ($code=Character code:C91($2[[$i]]))
			$0:=$0+1
		End if 
	End for 
Else 
	For ($i;1;Length:C16($2))
		If ($1=$2[[$i]])
			$0:=$0+1
		End if 
	End for 
End if 