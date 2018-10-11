//%attributes = {}
  //ST_StripPreceed

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_StripPreceed
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 3:36 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
$k:=0
For ($i;1;Length:C16($1))
	If ($1[[$i]]#$2)
		$i:=Length:C16($1)+1  //Force loop to end
	Else 
		$k:=$k+1  //Counter to track amount of spaces    
	End if 
End for 
$0:=Delete string:C232($1;1;$k)