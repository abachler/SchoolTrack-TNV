//%attributes = {}
  //dbu_UpdAsgProfs

QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Asignaturas:18]profesor_numero:4)
[Asignaturas:18]profesor_nombre:13:=[Profesores:4]Apellidos_y_nombres:28
If ([Asignaturas:18]profesor_firmante_Nombre:34="")
	[Asignaturas:18]profesor_firmante_Nombre:34:=[Asignaturas:18]profesor_nombre:13
	[Asignaturas:18]profesor_firmante_numero:33:=[Asignaturas:18]profesor_numero:4
End if 