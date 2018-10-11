//%attributes = {}
  // Method: CRYPT_Decrypt
  //==============================================================
  //
  // Converted from C by Serge Thibault <logiciels.magellan@netaxis.qc.ca>
  // Optimized by Bruno Legay <blegay@pobox.com>
  //
  //   $1 -> Encrypted text
  //   $0 <- Decrypted text
  //==============================================================

  // CRYPT_Decrypt
  //   $1: string to decrypt

C_TEXT:C284($0)  //Decrypted text
C_TEXT:C284($1)  //Text to be decrypted
C_LONGINT:C283($2)  //◊vl_CRYPT_kEncryptKey0
C_LONGINT:C283($3)  //◊vl_CRYPT_kEncryptKey1
C_LONGINT:C283($4)  //◊vl_CRYPT_kEncryptKey2
C_LONGINT:C283($5)  //◊vl_CRYPT_kEncryptKey3

C_LONGINT:C283($i;$vl_Len;$p)
C_LONGINT:C283($vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3)

If (Count parameters:C259=5)
	$vl_Key0:=$2
	$vl_Key1:=$3
	$vl_Key2:=$4
	$vl_Key3:=$5
Else 
	$vl_Key0:=<>vl_CRYPT_kEncryptKey0  //estos valores se setean en CRYPT_Init
	$vl_Key1:=<>vl_CRYPT_kEncryptKey1
	$vl_Key2:=<>vl_CRYPT_kEncryptKey2
	$vl_Key3:=<>vl_CRYPT_kEncryptKey3
End if 

$vl_Len:=Length:C16($1)
If ($vl_Len>0)
	
	For ($i;1;$vl_Len;8)
		$0:=$0+CRYPT_DecryptSub (Substring:C12($1;$i;8);$vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3)
	End for 
	
	$p:=Position:C15(Char:C90(NUL ASCII code:K15:1);$0)
	Case of 
		: ($p>1)
			$0:=Substring:C12($0;1;$p-1)
		: ($p=1)
			$0:=""
	End case 
End if 