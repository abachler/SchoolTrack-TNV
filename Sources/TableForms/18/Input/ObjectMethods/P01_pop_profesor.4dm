If (USR_checkRights ("M";->[Asignaturas:18]))
	If (at_Profesores_Nombres>0)
		[Asignaturas:18]profesor_numero:4:=al_Profesores_ID{at_Profesores_Nombres}
		[Asignaturas:18]profesor_nombre:13:=at_Profesores_Nombres{at_Profesores_Nombres}
		READ ONLY:C145([Profesores:4])
		If ([Asignaturas:18]profesor_firmante_numero:33=0)
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{at_Profesores_Nombres})
			[Asignaturas:18]profesor_firmante_Nombre:34:=[Profesores:4]Nombres_apellidos:40
			[Asignaturas:18]Habilitacion_del_profesor:37:=[Profesores:4]Habilitacion_MinEduc:26
			[Asignaturas:18]profesor_firmante_numero:33:=[Profesores:4]Numero:1
		End if 
		
		RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
		If ([Asignaturas:18]profesor_numero:4#Old:C35([Asignaturas:18]profesor_numero:4))
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]ID_Teacher:9=Old:C35([Asignaturas:18]profesor_numero:4))
			READ WRITE:C146([TMT_Horario:166])
			APPLY TO SELECTION:C70([TMT_Horario:166];[TMT_Horario:166]ID_Teacher:9:=[Asignaturas:18]profesor_numero:4)
			UNLOAD RECORD:C212([TMT_Horario:166])
			READ ONLY:C145([TMT_Horario:166])
		End if 
		
		SAVE RECORD:C53([Asignaturas:18])
		
	End if 
Else 
	CD_Dlog (0;__ ("Usted no está autorizado para modificar este registro."))
	$el:=Find in array:C230(al_Profesores_ID;[Asignaturas:18]profesor_numero:4)
	If ($el>0)
		at_Profesores_Nombres:=$el
	End if 
End if 