IT_Clairvoyance (Self:C308;->aCursosPK;"")
If (Self:C308->#"")
	If (([ADT_Candidatos:49]Situación_final:16="Aceptado y@") & (Old:C35([ADT_Candidatos:49]Situación_final:16)#"Aceptado y@"))
		If ([ADT_Candidatos:49]Curso:37#"")
			[Alumnos:2]curso:20:=[ADT_Candidatos:49]Curso:37
			GetStudNivel 
		End if 
	Else 
		If (([ADT_Candidatos:49]Situación_final:16#"Aceptado y@") & (Old:C35([ADT_Candidatos:49]Situación_final:16)="Aceptado y@"))
			[ADT_Candidatos:49]Curso:37:=""
			[Alumnos:2]curso:20:="POST"
			GetStudNivel 
		End if 
	End if 
	OBJECT SET VISIBLE:C603(*;"lista_espera@";[ADT_Candidatos:49]Situación_final:16="En lista de espera")
	OBJECT SET VISIBLE:C603(*;"curso@";[ADT_Candidatos:49]Situación_final:16="Aceptado@")
	If ([ADT_Candidatos:49]Situación_final:16#("Aceptado@"))
		[ADT_Candidatos:49]Curso:37:=""
	End if 
	REDRAW:C174([ADT_Candidatos:49]Situación_final:16)
End if 

