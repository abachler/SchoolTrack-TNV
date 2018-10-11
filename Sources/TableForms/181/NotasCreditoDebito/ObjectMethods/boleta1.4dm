If (Form event:C388=On Data Change:K2:15)
	  //20120504 RCH No se pueden colocar montos negativos
	If (atACT_referencia#2)  //para los que corrigen textos no se puede ingresar monto 
		If (Self:C308-><0)
			Self:C308->:=0
		Else 
			If (Self:C308->>vr_MaxAfecto)
				  //Self->:=0
				Self:C308->:=vr_MaxAfecto
			End if 
		End if 
	Else 
		Self:C308->:=0
	End if 
End if 