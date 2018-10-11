If ([Alumnos_EventosPersonales:16]Privada:9)
	[Alumnos_EventosPersonales:16]ID_Owner:2:=<>lUSR_RelatedTableUserID
Else 
	[Alumnos_EventosPersonales:16]ID_Owner:2:=0
End if 

$el:=Find in array:C230(at_Profesores_Nombres;[Alumnos_EventosPersonales:16]Autor:8)
If ($el>0)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{$el})
	[Alumnos_EventosPersonales:16]ID_Autor:11:=[Profesores:4]Numero:1
End if 
KRL_SaveRecord (->[Alumnos_EventosPersonales:16])
