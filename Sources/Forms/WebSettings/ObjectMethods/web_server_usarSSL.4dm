If (Self:C308->=1)
	CD_Dlog (0;__ ("Recuerde activar la opción \"Activar SSL\" en las propiedades de la base.\rRecuerde que el puerto utilizado será el configurado en este panel de preferencias."))
Else 
	CD_Dlog (0;__ ("Recuerde desactivar la opción \"Activar SSL\" en las propiedades de la base."))
End if 