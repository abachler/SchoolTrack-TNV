//%attributes = {}
  //ST_ClearPonct

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_ClearPonct
	  //Autor: Alberto Bachler
	  //Creada el 15/5/96 a 17:50
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Elimina los signos de puntuación (,;:.) de una expresión texto
	  //Sintaxis: st_ClearPonct(text) -->text
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_TEXT:C284($1;$0)
$0:=$1
$0:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233($0;".";"");",";"");";";"");":";"")
$0:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233($0;"?";"");"¿";"");"!";"");"¡";"")