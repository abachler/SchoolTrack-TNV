$text:=AT_array2text (->aTiposArchivosText)
$found:=Find in array:C230(aTiposArchivosText;vTipo)
If ($found=-1)
	$found:=1
End if 
$choice:=Pop up menu:C542($text;$found)
If ($choice#0)
	vTipo:=aTiposArchivosText{$choice}
	vlACT_Tipo:=alACT_FormasdePagoID{$choice}
	[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=vlACT_Tipo
	[xxACT_ArchivosBancarios:118]Tipo:6:=vTipo
End if 