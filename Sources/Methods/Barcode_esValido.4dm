//%attributes = {}
  // Barcode_EsCode39Valido()
  // Por: Alberto Bachler K.: 02-12-13, 18:19:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_resultado)
C_TEXT:C284($t_codigoCorregido;$t_textoCodigo;$t_tipoCodigo)

If (False:C215)
	C_BOOLEAN:C305(Barcode_EsValido ;$0)
	C_TEXT:C284(Barcode_EsValido ;$1)
	C_TEXT:C284(Barcode_EsValido ;$2)
End if 

$t_tipoCodigo:=$1
$t_textoCodigo:=$2

$t_codigoCorregido:=Barcode_CheckCode ($t_tipoCodigo;$t_textoCodigo)
If ($t_codigoCorregido=$t_textoCodigo)
	$b_resultado:=True:C214
Else 
	$b_resultado:=False:C215
End if 

$0:=$b_resultado