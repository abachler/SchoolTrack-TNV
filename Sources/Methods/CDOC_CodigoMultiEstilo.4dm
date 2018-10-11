//%attributes = {}
  // CDOC_CodigoMultiEstilo()
  // Por: Alberto Bachler: 18/04/13, 18:18:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_Codigo;$t_codigoMultiEstilo;$t_texto_remover)

If (False:C215)
	C_TEXT:C284(CDOC_CodigoMultiEstilo ;$0)
	C_TEXT:C284(CDOC_CodigoMultiEstilo ;$1)
End if 
$t_Codigo:=$1



$t_codigo:=Replace string:C233($t_codigo;"\r";"\r"+Char:C90(10))
  //CODE HIGHLIGHT ($t_codigo;$t_codigoMultiEstilo;"4dus";"xhtml")

$t_texto_remover:="<!-- Generator: GNU source-highlight 3.1.6"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"by Lorenzo Bettini"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"http://www.lorenzobettini.it"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"http://www.gnu.org/software/src-highlite -->"+Char:C90(10)
$t_texto_remover:=$t_texto_remover+"<pre><tt>"
$t_codigoMultiEstilo:=Replace string:C233($t_codigoMultiEstilo;$t_texto_remover;"")
$t_codigoMultiEstilo:=Replace string:C233($t_codigoMultiEstilo;"</tt></pre>";"")
$t_codigoMultiEstilo:=Replace string:C233($t_codigoMultiEstilo;"span style=\"color: #808080\">//";"span style=\"color: #D81E05\">//")
$t_codigoMultiEstilo:=Replace string:C233($t_codigoMultiEstilo;"span style=\"color: #808080\">[";"span style=\"font-weight:bold;color: #9A1900\">[")
$t_codigoMultiEstilo:=Replace string:C233($t_codigoMultiEstilo;"span style=\"color: #9A1900\">[";"span style=\"font-weight:bold;color: #9A1900\">[")

$0:=$t_codigoMultiEstilo
