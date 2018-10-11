//%attributes = {}
  // ACTabc_CreaArchivo()
  //
  //
  // modificado por: Alberto Bachler Klein: 13/02/17, 16:34:34
  // se conserva solo como wrapper para ACT
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TIME:C306($0)

C_TEXT:C284($t_nombreDocumento;$t_subcarpeta;$t_tipoCarpeta)



If (False:C215)
	C_TIME:C306($0)
	C_TEXT:C284(ACTabc_CreaArchivo ;$1)
	C_TEXT:C284(ACTabc_CreaArchivo ;$2)
	C_TEXT:C284(ACTabc_CreaArchivo ;$3)
End if 

$t_tipoCarpeta:=$1
$t_nombreDocumento:=$2
If (Count parameters:C259>=3)
	$t_subcarpeta:=$3
Else 
	$t_subcarpeta:="Archivos Bancarios"
End if 

$t_subRuta:=$t_subcarpeta+Folder separator:K24:12+$t_tipoCarpeta
$t_subRuta:=Replace string:C233($t_subRuta;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)

OK:=1
$0:=ACTabc_CreaDocumento ($t_subRuta;$t_nombreDocumento)

