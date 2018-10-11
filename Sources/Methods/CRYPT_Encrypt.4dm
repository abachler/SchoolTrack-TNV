//%attributes = {}
  // Method: CRYPT_Encrypt
  //==============================================================
  //
  // Converted from C by Serge Thibault <logiciels.magellan@netaxis.qc.ca>
  // Optimized by Bruno Legay <blegay@pobox.com>
  //
  //   $1 -> Text to encrypt
  //   $0 <- Encrypted text
  //
  // Note:
  //-----
  // The maximum string length that can be handled
  // is fixed by the variable ◊vl_CRYPT_kEncryptMax.
  // Of course, this length can be changed.
  //
  //==============================================================

C_TEXT:C284($0)  //Encrypted text
C_TEXT:C284($1)  //Text to be encrypted
C_LONGINT:C283($2)  //◊vl_CRYPT_kEncryptKey0
C_LONGINT:C283($3)  //◊vl_CRYPT_kEncryptKey1
C_LONGINT:C283($4)  //◊vl_CRYPT_kEncryptKey2
C_LONGINT:C283($5)  //◊vl_CRYPT_kEncryptKey3
C_LONGINT:C283($6)  //◊vl_CRYPT_kEncryptMax

C_LONGINT:C283($i;$vl_Len;$vl_LenPad;$vl_Over8)
C_LONGINT:C283($vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3;$vl_Max)


If (Count parameters:C259=6)
	$vl_Key0:=$2
	$vl_Key1:=$3
	$vl_Key2:=$4
	$vl_Key3:=$5
	$vl_Max:=$6
Else 
	$vl_Key0:=<>vl_CRYPT_kEncryptKey0  //estos valores se setean en CRYPT_Init
	$vl_Key1:=<>vl_CRYPT_kEncryptKey1
	$vl_Key2:=<>vl_CRYPT_kEncryptKey2
	$vl_Key3:=<>vl_CRYPT_kEncryptKey3
	$vl_Max:=<>vl_CRYPT_kEncryptMax
End if 

$vl_Len:=Length:C16($1)
If ($vl_Len<=$vl_Max)
	If ($vl_Len>0)
		
		  //$1:=$1+(7*Caractere(ASCII NUL))
		
		$vl_Over8:=$vl_Len%8
		If ($vl_Over8=0)
			$0:=$vl_Len*Char:C90(NUL ASCII code:K15:1)
		Else 
			$vl_LenPad:=8-$vl_Over8
			$1:=$1+($vl_LenPad*Char:C90(NUL ASCII code:K15:1))
			$0:=($vl_Len+$vl_LenPad)*Char:C90(NUL ASCII code:K15:1)
		End if 
		
		For ($i;0;$vl_Len-1;8)
			$temp:=CRYPT_EncryptSub (Substring:C12($1;$i+1;8);$vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3)
			$0:=Change string:C234($0;$temp;$i+1)
		End for 
	End if 
Else 
	ALERT:C41("The length of this string exceed the maximum length ("+String:C10($vl_Max)+") of string to encrypt.")
End if 
