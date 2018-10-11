//%attributes = {}
  //ST_StringOccur2
  //20180219 RCH Restaurado. Usado en informes. Ticket 198736.
If (False:C215)
	  //Copia de st_StringOccur
	  //Fecha: 06/01/2010
	  //Autor: Julia Belmar
	  //Descripción: Cuenta la cantidad de veces que aparece un string dentro de una cadena de texto
	  //Uso: ST_StringOccur2($stringaBuscar;$texto{;int}); la diferencia es que los caracteres pueden estar pegados
End if 

C_LONGINT:C283($i;$0)
$text:=$2
While (Position:C15($1;$text)>0)
	$0:=$0+1
	$text:=Substring:C12($text;Position:C15($1;$text)+Length:C16($1))
End while 