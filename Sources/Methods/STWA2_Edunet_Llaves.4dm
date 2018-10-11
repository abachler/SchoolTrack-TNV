//%attributes = {}
C_TEXT:C284($url;$1)
C_TEXT:C284($llave;$llavePriv;$0)

$url:=$1
$llavePriv:="a1cae0c88ed37c3a6705c36b466b0423306f0a6c"

C_BLOB:C604($blob)
CONVERT FROM TEXT:C1011($url;"utf-8";$blob)
$res:=SHA1 ($blob;Crypto HEX)
CONVERT FROM TEXT:C1011($res+$llavePriv;"utf-8";$blob)
$llave:=SHA1 ($blob;Crypto HEX)

$0:=$llave