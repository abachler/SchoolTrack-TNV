PREF_Set (<>lUSR_CurrentUserID;"NombreAsignaturasHistórico";String:C10(Self:C308->))
If (Self:C308->=1)
	OBJECT SET TITLE:C194(bNombreAsignaturasH;__ ("Nombre Interno"))
Else 
	OBJECT SET TITLE:C194(bNombreAsignaturasH;__ ("Nombre Oficial"))
End if 
al_LoadHNotas 