  //[Alumnos].Input.Pestaña2



Case of 
	: (Form event:C388=On Load:K2:1)
		
	: (Form event:C388=On Clicked:K2:4)
		AL_ExitCell (xALP_ComentariosAlumno)
		$page:=Selected list items:C379(Self:C308->)
		Case of 
			: ($page=1)
				AL_RemoveArrays (xALP_ComentariosAlumno;1;30)
				AL_PaginaObservaciones (1)
			: ($page=2)
				AL_RemoveArrays (xALP_ComentariosAlumno;1;30)
				AL_PaginaObservaciones (2)
			: ($page=3)
				AL_RemoveArrays (xALP_ComentariosAlumno;1;30)
				al_LoadECursos (xALP_ComentariosAlumno;1)
				AL_UpdateArrays (xALP_ComentariosAlumno;-2)
		End case 
End case 
