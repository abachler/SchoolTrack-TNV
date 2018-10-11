//%attributes = {}
  // IT_Confirmacion_AgregaTagValor()
  // Por: Alberto Bachler: 07/06/13, 15:48:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($0)

C_TEXT:C284($t_tag;$t_valor)

If (False:C215)
	C_TEXT:C284(IT_Confirmacion_AgregaTagValor ;$1)
	C_TEXT:C284(IT_Confirmacion_AgregaTagValor ;$2)
End if 

$t_tag:=$1
$t_valor:=$2

APPEND TO ARRAY:C911(at_Confirmacion_Tags;$t_tag)
APPEND TO ARRAY:C911(at_Confirmacion_Valor;$t_valor)

$0:=0