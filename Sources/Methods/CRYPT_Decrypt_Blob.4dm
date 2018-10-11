//%attributes = {}
  //Méthode : CRYPT_Decrypt_Blob
  //==============================================================
  //
  //
  //BLE (Bruno Legay)
  //Vendredi 12 Février 1999  18:44:07 
  //1998 © A&C Consulting
  //==============================================================


C_POINTER:C301($1)  //Pointer to the blob to be decrypted
C_POINTER:C301($2)  //Pointer to the decrypted blob
C_LONGINT:C283($3)  //◊kEncryptKey0
C_LONGINT:C283($4)  //◊kEncryptKey1
C_LONGINT:C283($5)  //◊kEncryptKey2
C_LONGINT:C283($6)  //◊kEncryptKey3

C_POINTER:C301($vp_BlobCryptePtr)
C_POINTER:C301($vp_BlobADecrypterPtr)

C_LONGINT:C283($i;$vl_Len;$vl_Over8)
C_LONGINT:C283($vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3;$vl_Offset;$vl_OffsetOut;$vl_OffsetHeader;$vl_TailleDeBlobe)
_O_C_STRING:C293(2;$va_BlobVers)
_O_C_STRING:C293(4;$va_BlobType)
_O_C_STRING:C293(8;$va_Temp)

If (Count parameters:C259=7)
	$vl_Key0:=$3
	$vl_Key1:=$4
	$vl_Key2:=$5
	$vl_Key3:=$6
Else 
	$vl_Key0:=<>vl_CRYPT_kEncryptKey0
	$vl_Key1:=<>vl_CRYPT_kEncryptKey1
	$vl_Key2:=<>vl_CRYPT_kEncryptKey2
	$vl_Key3:=<>vl_CRYPT_kEncryptKey3
End if 

$vp_BlobCryptePtr:=$1
$vp_BlobADecrypterPtr:=$2

$vl_Len:=BLOB size:C605($vp_BlobCryptePtr->)
If ($vl_Len>=10)  //The header is at least 8 bytes
	
	$vl_OffsetHeader:=0
	$va_BlobType:=BLOB to text:C555($vp_BlobCryptePtr->;Mac text without length:K22:10;$vl_OffsetHeader;4)  //Extracting BLOB type
	$va_BlobVers:=BLOB to text:C555($vp_BlobCryptePtr->;Mac text without length:K22:10;$vl_OffsetHeader;2)  //Extracting BLOB version
	
	If (($va_BlobType="CRPT") & ($va_BlobVers="10"))  //type of BLOB and version are OK
		$vl_TailleDeBlobe:=BLOB to longint:C551($vp_BlobCryptePtr->;Macintosh byte ordering:K22:2;$vl_OffsetHeader)  //Extracting decrypted Blob size
		
		$vl_Over8:=$vl_TailleDeBlobe%8
		If ($vl_Over8=0)  //The size of the decrypted Blob is a multiple of 8
			SET BLOB SIZE:C606($vp_BlobADecrypterPtr->;$vl_TailleDeBlobe;0)
		Else   //The size of the decrypted Blob was not a multiple of 8
			SET BLOB SIZE:C606($vp_BlobADecrypterPtr->;($vl_TailleDeBlobe-$vl_Over8)+8;0)  //So we make it a multiple of 8
		End if 
		
		$vl_OffsetOut:=0
		For ($i;$vl_OffsetHeader;$vl_Len-1;8)
			$vl_Offset:=$i
			$va_Temp:=BLOB to text:C555($vp_BlobCryptePtr->;Mac text without length:K22:10;$vl_Offset;8)  //Copy the 8 encrypted bytes from the source BLOB into a text
			$va_Temp:=CRYPT_DecryptSub ($va_Temp;$vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3)  //Decrypt 8 bytes
			TEXT TO BLOB:C554($va_Temp;$vp_BlobADecrypterPtr->;Mac text without length:K22:10;$vl_OffsetOut)  //Place the 8 decrypted bytes in the destination BLOB
		End for 
		
		If ($vl_Over8#0)  //The size of the decrypted Blob was not a multiple of 8
			SET BLOB SIZE:C606($vp_BlobADecrypterPtr->;$vl_TailleDeBlobe)  //We need to resize it to its actual size
		End if 
		
	End if 
	
End if 

