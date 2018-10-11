If ([Asignaturas:18]Electiva:11)
	OBJECT SET VISIBLE:C603([Asignaturas:18]Numero_del_grupo_electivo:29;True:C214)
	OBJECT SET ENTERABLE:C238([Asignaturas:18]Numero_del_grupo_electivo:29;True:C214)
Else 
	OBJECT SET VISIBLE:C603([Asignaturas:18]Numero_del_grupo_electivo:29;False:C215)
	OBJECT SET ENTERABLE:C238([Asignaturas:18]Numero_del_grupo_electivo:29;False:C215)
	[Asignaturas:18]Numero_del_grupo_electivo:29:=""
End if 