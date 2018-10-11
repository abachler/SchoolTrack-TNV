$text:=AT_array2text (->atACT_DocsPopup)
$choice:=Pop up menu:C542($text)
If ($choice>0)
	vtACT_WTipoDoc:=atACT_DocsPopup{$choice}
	  //vlACT_WTipoDoc:=alACT_DocsIDs{$choice}
	vtACT_WTipoDocID:=atACT_DocsIDs{$choice}
	vlACT_WCatDoc:=alACT_DocsCatsIDs{$choice}
	vbACT_WAfectaDoc:=abACT_DocsAfectos{$choice}
End if 