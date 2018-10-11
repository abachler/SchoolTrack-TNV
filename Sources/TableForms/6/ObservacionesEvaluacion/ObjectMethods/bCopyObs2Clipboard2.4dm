C_BLOB:C604($blob)
LIST TO BLOB:C556(hl_observaciones;$blob)
$text:=""
For ($i;1;Count list items:C380(hl_observaciones))
	GET LIST ITEM:C378(hl_observaciones;$i;$itemRef;$itemText)
	If ($itemRef<0)
		$text:=$text+String:C10($itemRef)+"\t"+$itemText+"\r"
	Else 
		$text:=$text+String:C10($itemRef)+"\t"+"\t"+$itemText+"\r"
	End if 
End for 
SET TEXT TO PASTEBOARD:C523($text)
APPEND DATA TO PASTEBOARD:C403("SAOB";$blob)
$result:=Pasteboard data size:C400("SAOB")