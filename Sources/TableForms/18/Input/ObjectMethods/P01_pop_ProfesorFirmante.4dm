If (at_Profesores_Nombres>0)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{at_Profesores_Nombres})
	[Asignaturas:18]profesor_firmante_Nombre:34:=[Profesores:4]Nombres_apellidos:40
	[Asignaturas:18]Habilitacion_del_profesor:37:=[Profesores:4]Habilitacion_MinEduc:26
	[Asignaturas:18]profesor_firmante_numero:33:=[Profesores:4]Numero:1
End if 