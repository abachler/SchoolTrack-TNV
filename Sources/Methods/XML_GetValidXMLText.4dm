//%attributes = {}
C_LONGINT:C283($i)
C_TEXT:C284($1;$t_texto)

C_BOOLEAN:C305($2;$cdatas)

  //El arreglo con los caracteres invalidos esta definido en el metodo
  //XML_LoadInvalidCharsArray que es llamado en dhXS_StartUp

$t_texto:=$1
$cdatas:=True:C214
If (Count parameters:C259=2)
	$cdatas:=$2
End if 

If ($cdatas)
	$t_texto:=Replace string:C233($t_texto;">";"≤![CDATA["+">"+"]]≥";*)  // reemplazo los < y > por ≤ y ≥ para no afectar los reemplazo sucesivos
	$t_texto:=Replace string:C233($t_texto;"<";"≤![CDATA["+"<"+"]]≥";*)
	$t_texto:=Replace string:C233($t_texto;"&";"≤![CDATA["+"&"+"]]≥";*)
	$t_texto:=Replace string:C233($t_texto;"'";"≤![CDATA["+"'"+"]]≥";*)
	$t_texto:=Replace string:C233($t_texto;Char:C90(34);"≤![CDATA["+Char:C90(34)+"]]≥";*)
	$t_texto:=Replace string:C233($t_texto;"≤![";"<![";*)  // reemplazo los ≤ y ≥ por < y > para no afectar los reemplazo sucesivos. prodria haber algun problema si el texto original contiene "≤![" o "]]>" (pero lo veo probable)
	$t_texto:=Replace string:C233($t_texto;"]]≥";"]]>";*)
End if 
For ($i;1;Size of array:C274(<>at_caracteresInvalidos))
	$t_texto:=Replace string:C233($t_texto;<>at_caracteresInvalidos{$i};"";*)
End for 

$0:=$t_texto