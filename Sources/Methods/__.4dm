//%attributes = {}
  // Modificado por: Roberto Catalán (07-03-18)
  // Se agrega soporte para reemplazo de textos pasados como ^0....^n
  // El primer texto a reemplazar debe ser ^0, luego ^1, etc...

C_TEXT:C284($t_text;$t_translation;$t_traducido;${0})
C_LONGINT:C283($l_indice)

$t_text:=$1
$t_translation:=Get localized string:C991($t_text)

If ($t_translation#"")
	$t_traducido:=$t_translation
Else 
	$t_traducido:=$t_text
End if 

For ($l_indice;2;Count parameters:C259)
	If (Position:C15("^"+String:C10($l_indice-2);$t_traducido)>0)  //Comienza desde ^0 en adelante
		$t_traducido:=Replace string:C233($t_traducido;"^"+String:C10($l_indice-2);${$l_indice})
	End if 
End for 

$0:=$t_traducido