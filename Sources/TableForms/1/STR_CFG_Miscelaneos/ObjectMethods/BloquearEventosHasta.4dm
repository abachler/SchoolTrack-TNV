PREF_Set (0;"BloquearEventosAsigHasta";String:C10(Self:C308->))
If (Self:C308->>!00-00-00!)
	CD_Dlog (0;"Esta Configuración no afectará a los usuarios del grupo de Administración")
End if 