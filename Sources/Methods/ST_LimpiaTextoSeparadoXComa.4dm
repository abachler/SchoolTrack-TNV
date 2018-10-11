//%attributes = {}
  //ST_LimpiaTextoSeparadoXComa 
  //Se usa para reemplazar columnas que puedan tener una coma en el valor. La coma hace que se considere otra columna. Si viene entre comillas, se considerará un solo dato

C_TEXT:C284($t_text;$0;$t_textoFinal;$1;$t_caracter)
C_BOOLEAN:C305($b_textoEncontrado)
C_LONGINT:C283($l_indice)

$t_text:=$1

$b_textoEncontrado:=False:C215
$t_textoFinal:=""
For ($l_indice;1;Length:C16($t_text))
	$t_caracter:=$t_text[[$l_indice]]
	Case of 
		: ($t_caracter=Char:C90(34))
			$b_textoEncontrado:=Not:C34($b_textoEncontrado)
		: ($b_textoEncontrado)
			  //$t_textoFinal:=$t_textoFinal+Replace string($t_caracter;",";"")
			$t_textoFinal:=$t_textoFinal+Replace string:C233(Replace string:C233($t_caracter;",";"");";";".")  //20170404 RCH
		Else 
			$t_textoFinal:=$t_textoFinal+$t_caracter
	End case 
End for 
$0:=$t_textoFinal
