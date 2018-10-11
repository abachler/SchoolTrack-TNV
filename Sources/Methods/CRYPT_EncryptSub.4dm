//%attributes = {}
  //CRYPT_EncryptSub

  // Method: CRYPT_EncryptSous
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

C_LONGINT:C283($y;$z;$vl_Sum;$vl_Len;$vl_Key0;$vl_Key1;$vl_Key2;$vl_Key3;$vl_Delta)

If (Count parameters:C259=5)
	$va_Source:=$1
	$vl_Key0:=$2  //◊kEncryptKey0
	$vl_Key1:=$3  //◊kEncryptKey1
	$vl_Key2:=$4  //◊kEncryptKey2
	$vl_Key3:=$5  //◊kEncryptKey3
	
	$vl_Delta:=0x9E3779B9
	
	$vl_Len:=Length:C16($va_Source)
	If ($vl_Len<8)
		$va_Source:=$va_Source+((8-$vl_Len)*Char:C90(NUL ASCII code:K15:1))
	End if 
	
	$y:=(Character code:C91($va_Source[[1]]) << 24)+(Character code:C91($va_Source[[2]]) << 16)+(Character code:C91($va_Source[[3]]) << 8)+Character code:C91($va_Source[[4]])
	$z:=(Character code:C91($va_Source[[5]]) << 24)+(Character code:C91($va_Source[[6]]) << 16)+(Character code:C91($va_Source[[7]]) << 8)+Character code:C91($va_Source[[8]])
	
	$vl_Sum:=0
	For ($i;1;32)
		$vl_Sum:=$vl_Sum+$vl_Delta
		$y:=$y+((($z << 4)+$vl_Key0) ^| ($z+$vl_Sum) ^| (($z >> 5)+$vl_Key1))
		$z:=$z+((($y << 4)+$vl_Key2) ^| ($y+$vl_Sum) ^| (($y >> 5)+$vl_Key3))
	End for 
	
	$0:=Char:C90($y >> 24)+Char:C90(($y & 0x00FF0000) >> 16)+Char:C90(($y & 0xFF00) >> 8)+Char:C90($y & 0x00FF)
	$0:=$0+Char:C90($z >> 24)+Char:C90(($z & 0x00FF0000) >> 16)+Char:C90(($z & 0xFF00) >> 8)+Char:C90($z & 0x00FF)
End if 
