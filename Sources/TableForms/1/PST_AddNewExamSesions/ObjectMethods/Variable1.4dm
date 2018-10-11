READ ONLY:C145([ADT_SesionesDeExamenes:123])
QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]Date_Session:2=vdPST_NewSesionDate)
If (Records in selection:C76([ADT_SesionesDeExamenes:123])#0)
	OK:=CD_Dlog (0;__ ("Ya existe una sesión de exámenes programada en esta fecha.\r¿Desea crear otra sesión en la misma fecha?");__ ("");__ ("Sí");__ ("No"))
	If (OK=2)
		vdPST_NewSesionDate:=!00-00-00!
		GOTO OBJECT:C206(vdPST_NewSesionDate)
	End if 
End if 