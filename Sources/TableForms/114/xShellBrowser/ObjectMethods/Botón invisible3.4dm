$menuItems:=AT_array2text (->atBWR_CommandsPopup)

$choice:=Pop up menu:C542($menuItems)

If ($choice>0)
	KRL_ExecuteMethod (atBWR_MethodsPopup{$choice})
End if 