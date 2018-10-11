//%attributes = {}
  //XML_Gen_CleanXML

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 19:33:56
  // ----------------------------------------------------
  // Método: XML_CleanXML
  // Descripción
  // Clean a XMLTagName
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($0;$vt_Result_XMLTagName)
C_TEXT:C284($1;$vt_Source_XMLTagName)
$vt_Source_XMLTagName:=$1
$vt_Result_XMLTagName:=""
C_LONGINT:C283($vt_Source_XMLTagName_Length)
$vt_Source_XMLTagName_Length:=Length:C16($vt_Source_XMLTagName)
C_BOOLEAN:C305($vb_Continue)
$vb_Continue:=True:C214
  // Verify that source name is not empty.
If ($vt_Source_XMLTagName_Length=0)  // Test for empty string (invalid)
	$vt_Result_XMLTagName:=""
	$vb_Continue:=False:C215
End if 
  // Verify that first character is legal.
If ($vb_Continue)
	  // Valid first characters for an XML name are (Inclusive)
	  // A-Z a-z _ :
	  // The colon has a very specific use and meaning so don't use it unless you know how and why.
	C_LONGINT:C283($vl_FirstChar_ascii)
	$vl_FirstChar_ascii:=Character code:C91($vt_Source_XMLTagName[[1]])
	Case of 
		: ($vl_FirstChar_ascii>=65) & ($vl_FirstChar_ascii<=90)  // A-Z are valid first characters.
			$vt_Result_XMLTagName:=$vt_Source_XMLTagName[[1]]
		: ($vl_FirstChar_ascii>=97) & ($vl_FirstChar_ascii<=122)  // a-z are valid first characters.
			$vt_Result_XMLTagName:=$vt_Source_XMLTagName[[1]]
		: ($vl_FirstChar_ascii=95) | ($vl_FirstChar_ascii=58)  // Underscore (95) and Colon (58) may be valid.
			$vt_Result_XMLTagName:=$vt_Source_XMLTagName[[1]]
		Else 
			$vt_Result_XMLTagName:=""
			$vb_Continue:=False:C215  // Bad first character, terminate.
	End case 
End if 
  // Remove any illegal following characters.
If ($vb_Continue)
	  // Valid body characters for an XML name are (Inclusive)
	  // A-Z a-z _ : - . 0-9
	  // The colon has a very specific use and meaning so don't use it unless you know how and why.
	C_LONGINT:C283($vl_Index)
	C_LONGINT:C283($vl_ascii)
	For ($vl_Index;2;$vt_Source_XMLTagName_Length)
		$vl_ascii:=Character code:C91($vt_Source_XMLTagName[[$vl_Index]])
		Case of 
			: ($vl_ascii>=65) & ($vl_ascii<=90)  // A-Z are valid body characters.
				$vt_Result_XMLTagName:=$vt_Result_XMLTagName+$vt_Source_XMLTagName[[$vl_Index]]
			: ($vl_ascii>=97) & ($vl_ascii<=122)  // a-z are valid body characters.
				$vt_Result_XMLTagName:=$vt_Result_XMLTagName+$vt_Source_XMLTagName[[$vl_Index]]
			: ($vl_ascii=95) | ($vl_ascii=58)  // Underscore (95) and Colon (58) are valid body characters.
				$vt_Result_XMLTagName:=$vt_Result_XMLTagName+$vt_Source_XMLTagName[[$vl_Index]]
			: ($vl_ascii=45) | ($vl_ascii=46)  // Hyphen (45) and Period (46) are valid body characters.
				$vt_Result_XMLTagName:=$vt_Result_XMLTagName+$vt_Source_XMLTagName[[$vl_Index]]
			: ($vl_ascii>=48) & ($vl_ascii<=57)  // 0-9 are valid body characters.
				$vt_Result_XMLTagName:=$vt_Result_XMLTagName+$vt_Source_XMLTagName[[$vl_Index]]
			Else 
				  // Bad character, don't include it.
		End case 
	End for 
End if 
  // Verify that name doesn't start with XML.
If (Length:C16($vt_Result_XMLTagName)>=3)
	  // Note: 4D's string comparisons are not case-sensitive, so the same result
	  // could be achieved with this line of code:
	  // If ($vt_Result_XMLTagName="xml@")
	  // I've taken this more pedantic approach to make the rule explicit.
	C_LONGINT:C283($vl_CharOne_ascii)
	C_LONGINT:C283($vl_CharTwo_ascii)
	C_LONGINT:C283($vl_CharThree_ascii)
	$vl_CharOne_ascii:=Character code:C91($vt_Result_XMLTagName[[1]])
	$vl_CharTwo_ascii:=Character code:C91($vt_Result_XMLTagName[[2]])
	$vl_CharThree_ascii:=Character code:C91($vt_Result_XMLTagName[[3]])
	If ($vl_CharOne_ascii=88) | ($vl_CharOne_ascii=120)  // 'X' or 'x'
		If ($vl_CharTwo_ascii=77) | ($vl_CharTwo_ascii=109)  // 'M' or 'm'
			If ($vl_CharThree_ascii=76) | ($vl_CharThree_ascii=108)  // 'L' or 'l'
				$vt_Result_XMLTagName:=""  // Name is bad. Would need to call routine recursively after trim if didn't clear here.
				$vb_Continue:=False:C215
			End if 
		End if 
	End if 
End if 
$0:=$vt_Result_XMLTagName