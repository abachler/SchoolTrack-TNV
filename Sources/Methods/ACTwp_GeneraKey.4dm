//%attributes = {}
  //ACTwp_GeneraKey

C_TEXT:C284($t_string2hash;$t_md5;$t_string2hash;$t_hash;$0;$t_pub;$1)
C_BLOB:C604($blob)

$t_pub:=$1

If ((<>gCountryCode="") | (<>gRolBD=""))
	STR_ReadGlobals 
End if 

$t_countryCode:=<>gCountryCode
$t_RBD:=<>gRolBD
If (Not:C34(Is compiled mode:C492))
	If (Count parameters:C259>=2)
		$t_countryCode:=$2
	End if 
	If (Count parameters:C259>=3)
		$t_RBD:=$3
	End if 
End if 

$t_string2hash:=$t_pub+Substring:C12($t_countryCode;1;1)+$t_RBD+Substring:C12($t_countryCode;2;1)+$t_pub
CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
$t_md5:=MD5 ($blob;Crypto HEX)
$t_string2hash:=$t_md5
CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
$t_hash:=SHA1 ($blob;Crypto HEX)

  //SET TEXT TO PASTEBOARD($t_hash)

$0:=$t_hash