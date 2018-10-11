ARRAY LONGINT:C221($alACT_Years;0)
For ($i;(Year of:C25(Current date:C33(*))-5);(Year of:C25(Current date:C33(*))+5))
	APPEND TO ARRAY:C911($alACT_Years;$i)
End for 

$choice:=IT_PopUpMenu (->$alACT_Years;->vlACTp_MatriculaYear)
If ($choice>0)
	vlACTp_MatriculaYear:=$alACT_Years{$choice}
End if 