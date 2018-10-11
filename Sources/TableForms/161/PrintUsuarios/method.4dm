Case of 
	: (Form event:C388=On Load:K2:1)
		$plErr:=PL_SetArraysNam (xPLP_Fact;1;4;"SN3_TipoUsuario";"SN3_AyNUsuarios";"SN3_LoginUsuarios";"SN3_PasswordUsuarios")
		If ($plErr=0)
			PL_SetHdrOpts (xPLP_Fact;2;0)
			PL_SetHeaders (xPLP_Fact;1;4;"Tipo";"Nombre";"Nombre de Usuario";"Contraseña")
			PL_SetWidths (xPLP_Fact;1;4;80;200;128;128)
			PL_SetHdrStyle (xPLP_Fact;0;"Tahoma";10;1)
			PL_SetStyle (xPLP_Fact;0;"Tahoma";9;0)
			PL_SetFrame (xPLP_Fact;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (xPLP_Fact;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
		End if 
	: (Form event:C388=On Printing Footer:K2:20)
		sPage:="- "+String:C10(Printing page:C275)+" -"
		sPrintDate:="Impreso el "+String:C10(Current date:C33(*);7)+" a las "+String:C10(Current time:C178(*);2)+" por "+<>tUSR_CurrentUser
End case 