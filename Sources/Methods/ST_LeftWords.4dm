//%attributes = {}
  //ST_LeftWords

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_LeftWords
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 10:57
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Return N words from a text starting from the left
	  //Sintaxis: st_LeftWords(text;int) -->text
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($2;$words)
C_TEXT:C284($1;$0)
If (Count parameters:C259=3)
	$delim:=$3
Else 
	$delim:=" "
End if 

$words:=ST_CountWords ($1;0;$delim)
If ($2>$words)
	$0:=$1
Else 
	For ($i;1;$2)
		$0:=$0+$delim+ST_GetWord ($1;$i;$delim)
	End for 
	$0:=Substring:C12($0;2)
End if 