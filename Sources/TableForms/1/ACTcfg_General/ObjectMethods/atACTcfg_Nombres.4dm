Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (Position:C15(";";Self:C308->{lb_desctoIndividual})>0)
			Self:C308->{lb_desctoIndividual}:=Replace string:C233(Self:C308->{lb_desctoIndividual};";";"_")  //se usa para separar los valores en la ficha de la Cta Cte
			CD_Dlog (0;"No es posible ingresar el caracter punto y coma.")
		End if 
End case 