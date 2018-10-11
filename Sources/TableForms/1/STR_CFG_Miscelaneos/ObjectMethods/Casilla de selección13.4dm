If (Self:C308->=1)
	CD_Dlog (0;__ ("Esta preferencia no tendrá efecto sobre a los usuarios que pertenecen a un grupo con permisos de modificación o eliminación de asistencia y/o calificaciones."))
End if 
PREF_Set (0;"NoModificarNotas";String:C10(Self:C308->))