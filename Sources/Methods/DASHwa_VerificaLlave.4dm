//%attributes = {}
  //DASHwa_VerificaLlave

C_TEXT:C284($1;$2;$3;$t_param1;$t_param2;$t_text1_MD5;$t_MD5_1;$t_text2_MD5;$t_MD5_2;$t_text_SHA1;$t_SHA1;$t_llave)
C_BOOLEAN:C305($0;$b_autorizado)

If ((<>gRolBD="") | (<>gCountryCode=""))
	STR_ReadGlobals 
End if 

$t_param1:=$1
$t_param2:=$2
$t_llave:=$3

If (($t_param1#"") & ($t_param2#""))
	
	$t_text1_MD5:=$t_param1+ST_Uppercase (<>gRolBD)
	$t_MD5_1:=Generate digest:C1147($t_text1_MD5;MD5 digest:K66:1)
	
	$t_text2_MD5:=$t_param2+ST_Uppercase (<>gCountryCode)
	$t_MD5_2:=Generate digest:C1147($t_text2_MD5;MD5 digest:K66:1)
	
	$t_text_SHA1:=$t_MD5_1+$t_MD5_2
	$t_SHA1:=Generate digest:C1147($t_text_SHA1;SHA1 digest:K66:2)
	
	If ($t_SHA1=$t_llave)
		$b_autorizado:=True:C214
	End if 
End if 

$0:=$b_autorizado