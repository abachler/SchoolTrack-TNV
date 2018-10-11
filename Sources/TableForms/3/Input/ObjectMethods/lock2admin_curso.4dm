  // [Cursos].Input.lock2admin_curso
  // Por: Alberto Bachler K.: 31-03-14, 16:36:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


IT_clairvoyanceOnFields2 (Self:C308;->[Profesores:4]Apellidos_y_nombres:28)

If (Form event:C388=On Data Change:K2:15)
	If ([Cursos:3]Director:33#"")
		If (Records in selection:C76([Profesores:4])=1)
			If ([Profesores:4]Inactivo:62)
				$ignore:=CD_Dlog (0;__ ("El director de nivel seleccionado está inactivado.\rSelecione un profesor activo o active el director seleccionado."))
				[Cursos:3]Director:33:=""
				[Cursos:3]Director_IdFuncionario:42:=0
				GOTO OBJECT:C206([Cursos:3]Director:33)
			Else 
				[Cursos:3]Director:33:=ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)
				[Cursos:3]Director_IdFuncionario:42:=[Profesores:4]Numero:1
			End if 
		Else 
			[Cursos:3]Director:33:=""
			[Cursos:3]Director_IdFuncionario:42:=0
			$ignore:=CD_Dlog (0;__ ("No hay ningún funcionario en la base de datos cuyos apellidos y nombre comience con \"")+Get edited text:C655+"\"")
			GOTO OBJECT:C206([Cursos:3]Director:33)
		End if 
	Else 
		[Cursos:3]Director_IdFuncionario:42:=0
	End if 
End if 



