//%attributes = {}
  //ST_RigthWords

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_RigthWords
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 11:06
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Return N words from a text starting from the left
	  //Sintaxis: st_RigthWords(text;int) -->text
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
	For ($i;$words;$2-1)
		$0:=ST_GetWord ($1;$i;$delim)+$delim+$0
	End for 
	$0:=Substring:C12($0;1;Length:C16($0)-1)
End if 