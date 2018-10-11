IT_Clairvoyance (Self:C308;->atSTRal_MotivosCastigo)
If (Form event:C388=On Losing Focus:K2:8)
	$esPositiva:=(Position:C15("+";sMotivo)#0)
	If ($esPositiva)
		$r:=CD_Dlog (1;__ ("Un comportamiento positivo no puede dar lugar a un castigo."))
		sMotivo:=""
		GOTO OBJECT:C206(sMotivo)
	End if 
End if 