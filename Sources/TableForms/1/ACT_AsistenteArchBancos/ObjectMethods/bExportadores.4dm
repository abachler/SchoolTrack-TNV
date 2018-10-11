$text:=AT_array2text (->atACT_ABArchivoNombre)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	vExportador:=atACT_ABArchivoNombre{$choice}
	vlACT_Exportador:=alACT_ABArchivoID{$choice}
End if 
If (vlACT_Exportador#0)
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 