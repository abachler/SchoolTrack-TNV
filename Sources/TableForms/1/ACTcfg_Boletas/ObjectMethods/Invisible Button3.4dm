$text:=AT_array2text (->atACT_Categorias)

$choice:=Pop up menu:C542($text)

If ($choice>0)
	vtACT_CatVR:=atACT_Categorias{$choice}
	vlACT_CatVR:=alACT_IDsCats{$choice}
End if 