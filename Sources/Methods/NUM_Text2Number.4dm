//%attributes = {}
  //Metodo: Método: NUM_text2Number
  //Por abachler
  //Creada el 09/06/2006, 10:16:18
  // ----------------------------------------------------
  // Descripción
  // Convierte un string a numero sólo si no contiene el caracter "e" entre dos cifras 
  // Remplaza la función NUM de 4D que convierte 10E2 como 100
  // ----------------------------------------------------
  // Parámetros
  // $1: &TEXT, texto a convertir 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_REAL:C285($0)
C_TEXT:C284($1;$text)
$text:=$1

  //CUERPO
$text:=Replace string:C233($text;"e";"")
$text:=Replace string:C233($text;"E";"")
If ((Position:C15("e";$text)>0) | (Position:C15("E";$text)>0))
	$0:=0
Else 
	$0:=Num:C11($text)
End if 



  //LIMPIEZA
