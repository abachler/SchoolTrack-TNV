$text:=AT_array2text (->atACT_ModelosDoc)

$choice:=Pop up menu:C542($text)

If ($choice>0)
	vtACT_ModRecibo:=atACT_ModelosDoc{$choice}
	vlACT_ModRecibo:=alACT_ModelosDocID{$choice}
End if 