//%attributes = {}
  //Méthode : CRYPT_Encrypt_Blob
  //==============================================================
  //
  //
  //BLE (Bruno Legay)
  //Vendredi 12 Février 1999  18:11:46 
  //1998 © A&C Consulting
  //==============================================================

C_POINTER:C301($1)  //`Pointer to the blob to be encrypted
C_POINTER:C301($2)  //Pointer to the crypted blob
C_LONGINT:C283($3)  //◊kEncryptKey0
C_LONGINT:C283($4)  //◊kEncryptKey1
C_LONGINT:C283($5)  //◊kEncryptKey2
C_LONGINT:C283($6)  //◊kEncryptKey3
C_LONGINT:C283($7)  //◊kEncryptMax

C_POINTER:C301($vp_BlobACrypterPtr)
C_POINTER:C301($vp_BlobCryptePtr)

C_LONGINT:C283($i;$vl_Len;$vl_Over8)
C_LONGINT:C283($vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3;$vl_Max;$vl_Offset;$vl_OffsetOut;$vl_OffsetHeader)
_O_C_STRING:C293(8;$va_Temp)

If (Count parameters:C259=7)
	$vl_Key0:=$3
	$vl_Key1:=$4
	$vl_Key2:=$5
	$vl_Key3:=$6
	$vl_Max:=$7
Else 
	$vl_Key0:=<>vl_CRYPT_kEncryptKey0
	$vl_Key1:=<>vl_CRYPT_kEncryptKey1
	$vl_Key2:=<>vl_CRYPT_kEncryptKey2
	$vl_Key3:=<>vl_CRYPT_kEncryptKey3
	$vl_Max:=<>vl_CRYPT_kEncryptMax
End if 

$vp_BlobACrypterPtr:=$1
$vp_BlobCryptePtr:=$2

$vl_Len:=BLOB size:C605($vp_BlobACrypterPtr->)
If ($vl_Len<=$vl_Max)
	If ($vl_Len>0)
		
		  //First we place a header in the BLOB
		SET BLOB SIZE:C606($vp_BlobCryptePtr->;0)
		$vl_OffsetHeader:=0
		
		TEXT TO BLOB:C554("CRPT";$vp_BlobCryptePtr->;Mac text without length:K22:10;$vl_OffsetHeader)  //Type of BLOB
		TEXT TO BLOB:C554("10";$vp_BlobCryptePtr->;Mac text without length:K22:10;$vl_OffsetHeader)  //Version of CRYPT
		LONGINT TO BLOB:C550($vl_Len;$vp_BlobCryptePtr->;Macintosh byte ordering:K22:2;$vl_OffsetHeader)  //Size of decrypted Blob
		
		$vl_Over8:=$vl_Len%8
		If ($vl_Over8=0)  //The size of the BLOB to encrypt is a multiple of 8
			SET BLOB SIZE:C606($vp_BlobCryptePtr->;$vl_OffsetHeader+$vl_Len;0)
		Else   //The size of the BLOB to encrypt is not a multiple of 8, "round it"
			SET BLOB SIZE:C606($vp_BlobACrypterPtr->;$vl_Len-$vl_Over8+8;0)
			SET BLOB SIZE:C606($vp_BlobCryptePtr->;$vl_OffsetHeader+(($vl_Len-$vl_Over8)+8);0)
		End if 
		
		$vl_OffsetOut:=$vl_OffsetHeader
		For ($i;0;$vl_Len-1;8)
			$vl_Offset:=$i
			$va_Temp:=BLOB to text:C555($vp_BlobACrypterPtr->;Mac text without length:K22:10;$vl_Offset;8)  //Copy 8 bytes to encrypt from the source BLOB into a text
			$va_Temp:=CRYPT_EncryptSub ($va_Temp;$vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3)  //Encrypt 8 bytes
			TEXT TO BLOB:C554($va_Temp;$vp_BlobCryptePtr->;Mac text without length:K22:10;$vl_OffsetOut)  //Copy the 8 encrypted bytes into the encrypted BLOB
		End for 
		
		If ($vl_Over8#0)  //Resize the Source blob to its original size
			SET BLOB SIZE:C606($vp_BlobACrypterPtr->;$vl_Len)
		End if 
		
	End if 
Else 
	ALERT:C41("The size of this blob exceed the maximum size("+String:C10($vl_Max)+") of blob to encrypt.")
End if 
