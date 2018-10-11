Case of 
	: ((Old:C35(Self:C308->)) & (Self:C308->=False:C215))
		If (([Alumnos_EventosPersonales:16]ID_Owner:2#<>lUSR_RelatedTableUserID) & ([Alumnos_EventosPersonales:16]ID_Owner:2#0))
			If (USR_IsGroupMember_by_GrpID (-15001))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosPersonales:16]ID_Autor:11)
				If (Records in selection:C76([Profesores:4])=0)
					OK:=CD_Dlog (0;__ ("La persona que registró este evento privado (")+[Alumnos_EventosPersonales:16]Autor:8+__ (") ya no existe en la base de datos.\r¿Desea quitarle el atributo Privado?");__ ("");__ ("Si");__ ("No"))
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
			[Alumnos_EventosPersonales:16]ID_Owner:2:=0
		End if 
	: ((Old:C35(Self:C308->)=False:C215) & (Self:C308->) & (Not:C34(Is new record:C668([Alumnos_EventosPersonales:16]))))
		If (USR_IsGroupMember_by_GrpID (-15001))
			OK:=CD_Dlog (0;__ ("Si usted marca este evento como privado sólo su autor podrá editarlo.\r¿Desea usted marcar este evento como privado?");__ ("");__ ("No");__ ("Si"))
			If (OK=1)
				Self:C308->:=Old:C35(Self:C308->)
			End if 
		Else 
			If (([Alumnos_EventosPersonales:16]ID_Autor:11#<>lUSR_RelatedTableUserID))
				CD_Dlog (0;__ ("Usted no es la persona que registró este evento.\r\rNo puede establecer este atributo."))
				Self:C308->:=Old:C35(Self:C308->)
			End if 
		End if 
End case 

If ([Alumnos_EventosPersonales:16]Privada:9)
	[Alumnos_EventosPersonales:16]ID_Owner:2:=<>lUSR_RelatedTableUserID
Else 
	[Alumnos_EventosPersonales:16]ID_Owner:2:=0
End if 