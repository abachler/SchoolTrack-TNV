$text_opt:=AT_array2text (->at_search_opt)
$choice:=Pop up menu:C542($text_opt)

If (($choice#0) & (vl_OptSearch#$choice))
	vl_OptSearch:=$choice
	PREF_Set (USR_GetUserID ;"OptSearch_ConsolaAtrasos";String:C10(vl_OptSearch))
	OBJECT SET TITLE:C194(*;"OptSearchSel";at_search_opt{$choice})
End if 
