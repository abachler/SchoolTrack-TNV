$element:=Selected list items:C379(hl_QuickFindFields)

GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$fieldRef;$itemText)
If ($element>0)
	alVS_QFRelateFromField{$element}:=$fieldRef
	XS_Settings ("SavePanelColumnSettings")
End if 
