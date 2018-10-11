If (([Alumnos_EventosOrientacion:21]Asunto:3#"") & ([Alumnos_EventosOrientacion:21]Fecha:2#!00-00-00!))
	$el:=Find in array:C230(at_Profesores_Nombres;[Alumnos_EventosOrientacion:21]Registrada_por:8)
	If ($el>0)
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{$el})
		[Alumnos_EventosOrientacion:21]Autor_Numero:10:=[Profesores:4]Numero:1
	End if 
	KRL_SaveRecord (->[Alumnos_EventosOrientacion:21])
	CANCEL:C270
Else 
	CD_Dlog (0;__ ("Para poder guardar este registro es necesario que ingrese como mínimo una fecha y un asunto."))
End if 