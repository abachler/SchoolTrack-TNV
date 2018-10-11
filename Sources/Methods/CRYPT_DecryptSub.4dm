//%attributes = {}
  //CRYPT_DecryptSub

  // Method: CRYPT_DecryptSous
  //==============================================================
  //
  // Converted from C by Serge Thibault <logiciels.magellan@netaxis.qc.ca>
  // Optimized by Bruno Legay <blegay@pobox.com>
  //
  //==============================================================

_O_C_STRING:C293(8;$0)
_O_C_STRING:C293(8;$1)
C_LONGINT:C283($2)  //◊kEncryptKey0
C_LONGINT:C283($3)  //◊kEncryptKey1
C_LONGINT:C283($4)  //◊kEncryptKey2
C_LONGINT:C283($5)  //◊kEncryptKey3

C_LONGINT:C283($y;$z;$vl_Sum;$dummy;$vl_Len;$vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3;$vl_Delta)

_O_C_STRING:C293(8;$va_Crypted)

If (Count parameters:C259=5)
	$va_Crypted:=$1
	$vl_Key0:=$2  //◊kEncryptKey0
	$vl_Key1:=$3  //◊kEncryptKey1
	$vl_Key2:=$4  //◊kEncryptKey2
	$vl_Key3:=$5  //◊kEncryptKey3
	
	$vl_Delta:=0x9E3779B9
	
	$vl_Len:=Length:C16($va_Crypted)
	If ($vl_Len<8)
		$va_Crypted:=$va_Crypted+((8-$vl_Len)*Char:C90(NUL ASCII code:K15:1))
	End if 
	
	$y:=(Character code:C91($va_Crypted[[1]]) << 24)+(Character code:C91($va_Crypted[[2]]) << 16)+(Character code:C91($va_Crypted[[3]]) << 8)+Character code:C91($va_Crypted[[4]])
	$z:=(Character code:C91($va_Crypted[[5]]) << 24)+(Character code:C91($va_Crypted[[6]]) << 16)+(Character code:C91($va_Crypted[[7]]) << 8)+Character code:C91($va_Crypted[[8]])
	
	If (($y#0) | ($z#0))
		$vl_Sum:=$vl_Delta << 5
		For ($i;1;32)
			$z:=$z-((($y << 4)+$vl_Key2) ^| ($y+$vl_Sum) ^| (($y >> 5)+$vl_Key3))
			$dummy:=$dummy  // to correct a 4D Compiler bug (PC version only)
			$y:=$y-((($z << 4)+$vl_Key0) ^| ($z+$vl_Sum) ^| (($z >> 5)+$vl_Key1))
			$vl_Sum:=$vl_Sum-$vl_Delta
		End for 
		
		$0:=Char:C90($y >> 24)+Char:C90(($y & 0x00FF0000) >> 16)+Char:C90(($y & 0xFF00) >> 8)+Char:C90($y & 0x00FF)
		$0:=$0+Char:C90($z >> 24)+Char:C90(($z & 0x00FF0000) >> 16)+Char:C90(($z & 0xFF00) >> 8)+Char:C90($z & 0x00FF)
	End if 
End if 
