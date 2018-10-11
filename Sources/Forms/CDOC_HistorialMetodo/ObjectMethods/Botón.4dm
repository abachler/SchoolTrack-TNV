  // CDOC_HistorialMetodo.Botón()
  // Por: Alberto Bachler: 17/04/13, 18:24:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$t_codigoToken:=""
$t_codigo:=at_Modificaciones_Codigo{1}
$t_codigo:=Replace string:C233($t_codigo;"\r";"\r"+Char:C90(10))
TEXT TO BLOB:C554($t_codigo;$x_Data;Mac text without length:K22:10)
  //$t_codigo:=Convert to text($x_data;"utf-8")
ARRAY TEXT:C222($at_testigo;0)
AT_Text2Array (->$at_testigo;$t_codigo;"\r")

  //CODE HIGHLIGHT ($t_codigo;$t_codigoToken;"4dus";"xhtml")

$t_texto_remover:="<!-- Generator: GNU source-highlight 3.1.6"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"by Lorenzo Bettini"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"http://www.lorenzobettini.it"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"http://www.gnu.org/software/src-highlite -->"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"<pre><tt>"
$t_codigoToken:=Replace string:C233($t_codigoToken;$t_texto_remover;"")
$t_codigoToken:=Replace string:C233($t_codigoToken;"</tt></pre>";"")
$t_codigoToken:=Replace string:C233($t_codigoToken;"span style=\"color: #808080\">//";"span style=\"color: #D81E05\">//")
$t_codigoToken:=Replace string:C233($t_codigoToken;"span style=\"color: #808080\">[";"span style=\"font-weight:bold;color: #9A1900\">[")
$t_codigoToken:=Replace string:C233($t_codigoToken;"span style=\"color: #9A1900\">[";"span style=\"font-weight:bold;color: #9A1900\">[")

SET TEXT TO PASTEBOARD:C523($t_codigoToken)
vt_multiEstilo:=$t_codigoToken


AT_Text2Array (->at_CodigoActual_Codigo;$t_codigoToken;Char:C90(10))
ARRAY LONGINT:C221(al_CodigoActual_linea;Size of array:C274(at_CodigoActual_Codigo))
$l_ancho:=0
vt_testigo:=""
For ($i;1;Size of array:C274(al_CodigoActual_linea))
	al_CodigoActual_linea{$i}:=$i
	$l_caracteres:=Length:C16(at_CodigoActual_Codigo{$i})
	If ($l_caracteres>$l_ancho)
		vt_testigo:=at_CodigoActual_Codigo{$i}
		$l_ancho:=$l_caracteres
	End if 
End for 