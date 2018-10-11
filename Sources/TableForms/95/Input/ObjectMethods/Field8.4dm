If (Form event:C388=On Data Change:K2:15)
	vbSpell_StopChecking:=True:C214
End if 
If (vProsSexo#"")
	vProsSexo:=Substring:C12(ST_Uppercase (vProsSexo);1;1)
End if 