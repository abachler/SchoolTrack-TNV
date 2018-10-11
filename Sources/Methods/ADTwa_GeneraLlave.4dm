//%attributes = {}
  //ADTwa_GeneraLlave
C_BLOB:C604($blob)
C_TEXT:C284($t_hash;$t_llavePrivada;$t_md5;$t_montoPagado;$t_rutsAlumnos;$t_rutsAlumnos2;$t_string2hash;$t_timeStamp)

If ((<>gRolBD="") | (<>gCountryCode=""))
	STR_ReadGlobals 
End if 

$t_rutsAlumnos:=$1
$t_timeStamp:=$2
$t_montoPagado:=$3

$t_rutsAlumnos2:=Replace string:C233($t_rutsAlumnos;",";"")

$t_llavePrivada:=Replace string:C233($t_rutsAlumnos;",";<>gRolBD)+<>gRolBD
$t_md5:=$t_montoPagado+<>gRolBD
CONVERT FROM TEXT:C1011($t_md5;"utf-8";$blob)
$t_md5:=MD5 ($blob;Crypto HEX)

$t_string2hash:=$t_llavePrivada+$t_md5
CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
$t_hash:=SHA1 ($blob;Crypto HEX)

$t_string2hash:=$t_hash+$t_rutsAlumnos2+$t_timeStamp
CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
$t_hash:=SHA1 ($blob;Crypto HEX)

  //SET TEXT TO PASTEBOARD($t_hash)
$0:=$t_hash