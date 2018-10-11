//%attributes = {}
  //ST_Mac2UTF8

C_LONGINT:C283($LSourceIndex)
C_LONGINT:C283($LDestIndex)
C_LONGINT:C283($LByte)
C_LONGINT:C283($LSourceTextLength)
C_LONGINT:C283($LCurrentChar)
C_TEXT:C284($tSourceText;$1)
C_TEXT:C284($tDestText;$0)
C_BOOLEAN:C305($convertSpaces;$2)

$tSourceText:=_O_Mac to ISO:C519($1)

If (Count parameters:C259=2)
	$convertSpaces:=$2
Else 
	$convertSpaces:=False:C215
End if 

$LSourceTextLength:=Length:C16($tSourceText)

If ($LSourceTextLength>0x0000)
	$tDestText:=30000*Char:C90(Space:K15:42)  // Pre-size destination text var
	$LDestIndex:=0x0001  // Initialize destination text index
	$LSourceIndex:=0x0001  // Initialize source text index
	  //
	While ($LSourceIndex<=$LSourceTextLength) & ($LDestIndex<MAXTEXTLENBEFOREV11:K35:3)
		$LCurrentChar:=Character code:C91($tSourceText[[$LSourceIndex]])  // Copy to local for clarity
		  //
		If ($LCurrentChar<=0x007F)  // One-byte char (no conversion necessary)
			$tDestText[[$LDestIndex]]:=$tSourceText[[$LSourceIndex]]
			$LDestIndex:=$LDestIndex+0x0001  // Increment destination text index
			$LSourceIndex:=$LSourceIndex+0x0001  // Increment source text index
			  //
		Else   // Convert to a two byte sequence
			  // All UCS chars between 0x0080 and 0x07FF must be stored in the 5 least
			  // significant bits of the first byte and the 6 least significant bits of the
			  // second byte. Therefore, only the 2 least significant bits of the
			  // first byte will be used in this conversion.
			  //
			  // Construct first byte of two-byte sequence.
			  // 3 leftmost bits of first byte must be 110, therefore, resulting value will be
			  // between 0xC0 and 0xFD. Get 2 most significant bits from char to convert and
			  // store in first byte, along with the multi-byte prefix.
			$LByte:=0x00C0 | ($LCurrentChar >> 6)
			  //$tDestText≤$LDestIndex≥:=Char($LByte)
			$tDestText:=Insert string:C231($tDestText;"%"+Substring:C12(String:C10($LByte;"&x");5);$LDestIndex)
			$LDestIndex:=$LDestIndex+0x0003  // Increment destination text index
			  //
			  // Construct second byte of two-byte sequence.
			  // 2 leftmost bits of second byte must be 10, therefore, resulting value will be
			  // between 0x80 and 0xBF. Get 6 least significant bits from char to convert and
			  // store in second byte, along with the multi-byte prefix.
			$LByte:=0x0080 | ($LCurrentChar & 0x003F)
			  //$tDestText≤$LDestIndex≥:=Char($LByte)
			$tDestText:=Insert string:C231($tDestText;"%"+Substring:C12(String:C10($LByte;"&x");5);$LDestIndex)
			$LDestIndex:=$LDestIndex+0x0003  // Increment destination text index
			  //
			  // Increment source text index
			$LSourceIndex:=$LSourceIndex+0x0001
		End if   // ($LCurrentChar<=0x007F)
		  //
	End while   // ($LSourceIndex<=$LSourceTextLength) & ($LDestIndex<MAXTEXTLEN )
	  //
	  // Trim destination text to actual size used
	$0:=Substring:C12($tDestText;0x0001;$LDestIndex-0x0001)
	If ($convertSpaces)
		$0:=Replace string:C233($0;" ";"%20")
	End if 
Else   // Source text is empty string.
	$0:=""
End if   // ($LSourceTextLength>0x0000)