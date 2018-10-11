IT_Clairvoyance (Self:C308;->aMethodNames)

If (Form event:C388=On Losing Focus:K2:8)
	If (Self:C308->#"")
		If (API Does Method Exist (Self:C308->)=1)
			$element:=Selected list items:C379(hl_QuickFindFields)
			If ($element>0)
				atVS_QFSpecialRelationMethod{$element}:=Self:C308->
			End if 
			XS_Settings ("SavePanelColumnSettings")
		Else 
			$ignore:=CD_Dlog (0;__ ("El metodo no existe.\r\rPor favor ingrese el nombre de un método válido."))
		End if 
	Else 
		$element:=Selected list items:C379(hl_QuickFindFields)
		If ($element>0)
			atVS_QFSpecialRelationMethod{$element}:=Self:C308->
		End if 
		XS_Settings ("SavePanelColumnSettings")
	End if 
End if 