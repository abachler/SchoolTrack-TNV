//%attributes = {}
  //ST_LeftChars

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_LeftChars
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 10:49
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: return N chars from a string starting fron the left
	  //Sintaxis: st_LeftChars(text;int) -->text
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_TEXT:C284($1;$0)
$0:=Substring:C12($1;1;$2)