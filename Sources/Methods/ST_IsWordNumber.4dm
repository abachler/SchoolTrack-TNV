//%attributes = {}
  //ST_IsWordNumber

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_IsWordNumber
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 09:50
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Verifica si $1 es la palabra $3 en la cadena $2
	  //Sintaxis: st_IsWordNumber(text;text;int) -->1: Si, 0:No
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($0;$3)
C_TEXT:C284($1;$2)
If ($1=ST_GetWord ($2;$3))
	$0:=1
Else 
	$0:=0
End if 
