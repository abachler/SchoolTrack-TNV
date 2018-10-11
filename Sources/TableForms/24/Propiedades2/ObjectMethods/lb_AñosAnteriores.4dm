LISTBOX GET CELL POSITION:C971(lb_AñosAnteriores;$col;$row)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If ($col>1)
			LBX_EditItem_byColNum ("lb_AñosAnteriores";$col;$row)
		End if 
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: ($col=2)
				If (as_NombreYearDC{$row}#"")
					If (Not:C34(ab_ModificadoDC{$row}))
						ab_ModificadoDC{$row}:=True:C214
					End if 
				Else 
					BEEP:C151
					as_NombreYearDC{$row}:=as_NombreYearDC{0}
				End if 
			: ($col=3)
				If (ad_TerminoDC{$row}#!00-00-00!)
					If (ad_InicioDC{$row}#!00-00-00!)
						If (ad_InicioDC{$row}>ad_TerminoDC{$row})
							BEEP:C151
							ad_InicioDC{$row}:=ad_InicioDC{0}
						Else 
							If (Not:C34(ab_ModificadoDC{$row}))
								ab_ModificadoDC{$row}:=True:C214
							End if 
						End if 
					Else 
						If (Not:C34(ab_ModificadoDC{$row}))
							ab_ModificadoDC{$row}:=True:C214
						End if 
					End if 
				Else 
					If (Not:C34(ab_ModificadoDC{$row}))
						ab_ModificadoDC{$row}:=True:C214
					End if 
				End if 
			: ($col=4)
				If (ad_InicioDC{$row}#!00-00-00!)
					If (ad_TerminoDC{$row}#!00-00-00!)
						If (ad_InicioDC{$row}>ad_TerminoDC{$row})
							BEEP:C151
							ad_TerminoDC{$row}:=ad_TerminoDC{0}
						Else 
							If (Not:C34(ab_ModificadoDC{$row}))
								ab_ModificadoDC{$row}:=True:C214
							End if 
						End if 
					Else 
						If (Not:C34(ab_ModificadoDC{$row}))
							ab_ModificadoDC{$row}:=True:C214
						End if 
					End if 
				Else 
					If (Not:C34(ab_ModificadoDC{$row}))
						ab_ModificadoDC{$row}:=True:C214
					End if 
				End if 
		End case 
End case 