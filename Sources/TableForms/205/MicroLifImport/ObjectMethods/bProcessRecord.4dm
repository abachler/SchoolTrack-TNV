ARRAY TEXT:C222($aRecord;0)
$delim:=Char:C90(94)
vtBBL_CurrentRecord:=Replace string:C233(Replace string:C233(vtBBL_CurrentRecord;Char:C90(10);"");"\r";"")
AT_Text2Array (->$aRecord;vtBBL_CurrentRecord;$delim)
$hdr:=Find in array:C230($aRecord;"LDR@")
If ($hdr>0)
	DELETE FROM ARRAY:C228($aRecord;$hdr)
End if 
For ($i;1;9)
	$ref:=String:C10($i;"000")+"@"
	$hdr:=Find in array:C230($aRecord;$ref)
	If ($hdr>0)
		DELETE FROM ARRAY:C228($aRecord;$hdr)
	End if 
End for 
SORT ARRAY:C229($aRecord;>)
_O_ARRAY STRING:C218(3;asBBL_MarcField;0)
_O_ARRAY STRING:C218(4;asBBL_MarcFieldSubField;0)
_O_ARRAY STRING:C218(2;asBBL_MarcIndicator;0)
_O_ARRAY STRING:C218(1;asBBL_MarcSubField;0)
ARRAY TEXT:C222(atBBL_MarcFieldData;0)
ARRAY TEXT:C222($aMARCSpecialLabel;0)
For ($i;1;Size of array:C274($aRecord))
	$sMARCField:=Substring:C12($aRecord{$i};1;3)
	$iMarcField:=Num:C11($sMARCField)
	If ($iMARCfield>0)
		$indicadores:=Substring:C12($aRecord{$i};4;2)
		$content:=Substring:C12($aRecord{$i};6)
		ARRAY TEXT:C222($aSubfieldsContents;0)
		AT_Text2Array (->$aSubfieldsContents;$content;"_")
		For ($iSubField;1;Size of array:C274($aSubfieldsContents))
			If ($aSubfieldsContents{$iSubField}#"")
				$subfieldRef:=Substring:C12($aSubfieldsContents{$iSubField};1;1)
				$subFieldContent:=Substring:C12($aSubfieldsContents{$iSubField};2)
				APPEND TO ARRAY:C911(asBBL_MarcField;$sMARCField)
				APPEND TO ARRAY:C911(asBBL_MarcFieldSubField;$sMARCField+$subfieldRef)
				APPEND TO ARRAY:C911(asBBL_MarcIndicator;$indicadores)
				APPEND TO ARRAY:C911(asBBL_MarcSubField;$subfieldRef)
				APPEND TO ARRAY:C911(atBBL_MarcFieldData;$subFieldContent)
			End if 
		End for 
	Else 
		  //trace
	End if 
End for 