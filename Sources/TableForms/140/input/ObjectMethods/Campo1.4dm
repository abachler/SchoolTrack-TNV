Case of 
	: ((Old:C35(Self:C308->)) & (Self:C308->=False:C215))
		If (([Familia_RegistroEventos:140]ID_Owner:7#<>lUSR_RelatedTableUserID) & ([Familia_RegistroEventos:140]ID_Owner:7#0))
			If (USR_IsGroupMember_by_GrpID (-15001))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Familia_RegistroEventos:140]ID_Autor:9)
				If (Records in selection:C76([Profesores:4])=0)
					OK:=CD_Dlog (0;__ ("La persona que registró este evento privado (")+[Familia_RegistroEventos:140]Registrado_por:5+__ (") ya no existe en la base de datos.\r¿Desea quitarle el atributo Privado?");__ ("");__ ("Si");__ ("No"))
					If (OK=2)
						Self:C308->:=Old:C35(Self:C308->)
					End if 
				Else 
					CD_Dlog (0;__ ("Usted no es la persona que registró este evento.\r\rNo puede quitarle el atributo Privado."))
				End if 
			Else 
				CD_Dlog (0;__ ("Usted no es la persona que registró este evento.\r\rNo puede quitarle el atributo Privado."))
				Self:C308->:=Old:C35(Self:C308->)
			End if 
		Else 
			[Familia_RegistroEventos:140]ID_Owner:7:=0
		End if 
	: ((Old:C35(Self:C308->)=False:C215) & (Self:C308->) & (Not:C34(Is new record:C668([Familia_RegistroEventos:140]))))
		If (USR_IsGroupMember_by_GrpID (-15001))
			OK:=CD_Dlog (0;__ ("Si usted marca este evento como privado sólo su autor podrá editarlo.\r¿Desea usted marcar este evento como privado?");__ ("");__ ("No");__ ("Si"))
			If (OK=1)
				Self:C308->:=Old:C35(Self:C308->)
			End if 
		Else 
			If (([Familia_RegistroEventos:140]ID_Autor:9#<>lUSR_RelatedTableUserID))
				CD_Dlog (0;__ ("Usted no es la persona que registró este evento.\r\rNo puede establecer este atributo."))
				Self:C308->:=Old:C35(Self:C308->)
			End if 
		End if 
End case 

If ([Familia_RegistroEventos:140]Privada:8)
	[Familia_RegistroEventos:140]ID_Owner:7:=<>lUSR_RelatedTableUserID
Else 
	[Familia_RegistroEventos:140]ID_Owner:7:=0
End if 