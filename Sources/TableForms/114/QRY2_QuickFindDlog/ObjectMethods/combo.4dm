If (Form event:C388=On Clicked:K2:4)
	vtQRY_ValorLiteral:=popChoice{0}
Else 
	IT_Clairvoyance (->popChoice{0};->popChoice)
	vtQRY_ValorLiteral:=popChoice{0}
End if 