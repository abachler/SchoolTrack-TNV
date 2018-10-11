//%attributes = {}
  //ST_GetLine



  //`xShell, Alberto Bachler
  //Metodo: ST_GetLine
  //Por abachler
  //Creada el 13/02/2006, 16:14:14
  //Modificaciones:
If ("DESCRIPCION"="")
	  //$1: texto
	  // numero de línea a obtener
	  //retorna la línea de texto N˚ $2
End if 

  //****DECLARACIONES****


  //****INICIALIZACIONES****


  //****CUERPO****
$text:="\r"+$1+"\r"
For ($i;1;$2)
	$text:=Substring:C12($text;Position:C15("\r";$text)+1)
End for 
$0:=Substring:C12($text;1;Position:C15("\r";$text)-1)

  //****LIMPIEZA****