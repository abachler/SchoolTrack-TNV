SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_ItemNamesRep;[xxACT_Items:179]ID:1;alACT_ItemsIDsRep)

$text:=AT_array2text (->atACT_ItemNamesRep)
$choice:=Pop up menu:C542($text)
If ($choice>0)
	vsACT_ItemSelected:=atACT_ItemNamesRep{$choice}
	vlACT_RefItem:=alACT_ItemsIDsRep{$choice}
End if 
