$text:=AT_array2text (->atACTwiz_Categorias)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vtACT_Documento:=atACTwiz_Categorias{$choice}
	vlACT_idDocumento:=alACTwiz_Categorias{$choice}
	POST KEY:C465(Character code:C91("+");256)
End if 