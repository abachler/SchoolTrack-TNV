//%attributes = {}
  // Método: ST_String_Is_Numeric
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/10, 07:45:14
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($1;$text)
C_BOOLEAN:C305($0)
$text:=$1

  // Código principal
If ((Num:C11($text)>0) & (Length:C16(String:C10(Num:C11($text)))=Length:C16($text)))
	$0:=True:C214
End if 



