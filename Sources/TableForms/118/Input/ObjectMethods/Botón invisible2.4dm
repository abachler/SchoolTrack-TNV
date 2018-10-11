$text:=AT_array2text (->atACT_BankName)
$found:=Find in array:C230(atACT_BankName;vTipo)
If ($found=-1)
	$found:=1
End if 
$choice:=Pop up menu:C542($text;$found)
If ($choice#0)
	vBanco:=atACT_BankName{$choice}
	[xxACT_ArchivosBancarios:118]CodBancoAsociado:12:=<>gCountryCode+"."+atACT_BankID{$choice}
End if 