//%attributes = {}
  //ST_RigthChars

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_RigthChars
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 10:52
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Return N Chars from a string starting from de rigth
	  //Sintaxis: st_RigthChars(text;int) -->text
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_TEXT:C284($1;$0)
C_LONGINT:C283($2)
If (Length:C16($1)<$2)
	$0:=$1
Else 
	For ($i;Length:C16($1);Length:C16($1)-$2+1;-1)
		$0:=$1[[$i]]+$0
	End for 
End if 