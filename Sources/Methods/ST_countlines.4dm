//%attributes = {}
  //ST_countlines


  //`xShell, Alberto Bachler
  //Metodo: ST_countlines
  //Por abachler
  //Creada el 13/02/1998, 16:12:09
  //Modificaciones:
If ("DESCRIPCION"="")
	  //cuenta las lineas de un texto utilizando el retorno de carro como separador de líneas
End if 

  //****DECLARACIONES****
C_LONGINT:C283($0)
C_TEXT:C284($1)

  //****INICIALIZACIONES****
$cr:=Char:C90(Carriage return:K15:38)
$0:=0
$text:=$1

  //****CUERPO****
If ($text#"")
	$0:=1
	While (Position:C15($cr;$text)>0)
		$0:=$0+1
		$text:=Substring:C12($text;Position:C15($cr;$text)+1)
	End while 
End if 


  //****LIMPIEZA****


