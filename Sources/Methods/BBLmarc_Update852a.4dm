//%attributes = {}
  //BBLmarc_Update852a

$newName:=$1

READ WRITE:C146([BBL_ItemMarcFields:205])
QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]SubFieldRef:3="852a")
APPLY TO SELECTION:C70([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]Dato:6:=$newName)
KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])