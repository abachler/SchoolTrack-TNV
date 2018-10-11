//%attributes = {}
  //Metodo: ST_TrimLeadingChars
  //Por abachler
  //Creada el 12/09/2006, 15:49:58
  // ----------------------------------------------------
  // Descripción
  // Elimina de las ocurrencias iniciales de un caractere determinado 
  //
  // ----------------------------------------------------
  // Parámetros
  // $1: texto
  // $2: caracter a eliminar
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($1;$2;$text;$charToDelete)

  //CUERPO
$text:=$1


If ($text#"")
	$charToDelete:=$2
	$test:=True:C214
	While ($test)
		If ($text[[1]]=$charToDelete)
			$text:=Substring:C12($text;2)
			$test:=(Length:C16($text)>0)
		Else 
			$test:=False:C215
		End if 
	End while 
End if 
$0:=$text

  //LIMPIEZA


