//%attributes = {}
  //XCRwa_GeneraLlave

C_BLOB:C604($blob)
C_TEXT:C284($t_hash;$t_llavePrivada;$t_md5;$t_montoPagado;$t_string2hash;$t_uuidAl)

If ((<>gRolBD="") | (<>gCountryCode=""))
	STR_ReadGlobals 
End if 

$t_uuidApdo:=$1
$t_uuidAl:=$2

$t_md5:=$t_uuidApdo+ST_Uppercase (<>gRolBD)
CONVERT FROM TEXT:C1011($t_md5;"utf-8";$blob)
$t_md5:=MD5 ($blob;Crypto HEX)

$t_md52:=$t_uuidAl+ST_Uppercase (<>gCountryCode)
CONVERT FROM TEXT:C1011($t_md52;"utf-8";$blob)
$t_md52:=MD5 ($blob;Crypto HEX)

$t_string2hash:=$t_md5+$t_md52
CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
$t_hash:=SHA1 ($blob;Crypto HEX)

$0:=$t_hash