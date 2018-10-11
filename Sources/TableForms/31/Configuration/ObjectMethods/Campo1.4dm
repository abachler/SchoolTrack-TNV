  // [Colegio].Configuration.Campo1()
  // Por: Alberto Bachler K.: 01-04-14, 15:30:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305($vb_modificar)
IT_clairvoyanceOnFields2 (Self:C308;->[Profesores:4]Apellidos_y_nombres:28)

If (Form event:C388=On Data Change:K2:15)
	
	If ([Colegio:31]Director_NombreCompleto:13#"")
		
		If (Records in selection:C76([Profesores:4])=1)
			If ([Profesores:4]Inactivo:62)
				$ignore:=CD_Dlog (0;__ ("El director seleccionado está inactivado.\rSelecione un profesor activo o active el director seleccionado."))
				GOTO OBJECT:C206([Colegio:31]Director_NombreCompleto:13)
				$vb_modificar:=False:C215
			Else 
				$vb_modificar:=True:C214
			End if 
		Else 
			$ignore:=CD_Dlog (0;__ ("No hay ningún director en la base de datos cuyos apellidos y nombre comience con \"")+Get edited text:C655+"\"")
			GOTO OBJECT:C206([Colegio:31]Director_NombreCompleto:13)
			$vb_modificar:=False:C215
		End if 
		
		If ($vb_modificar)
			[Colegio:31]Director_ApellidoMaterno:19:=[Profesores:4]Apellido_materno:4
			[Colegio:31]Director_ApellidoPaterno:18:=[Profesores:4]Apellido_paterno:3
			[Colegio:31]Director_Nombres:20:=[Profesores:4]Nombres:2
			[Colegio:31]Director_NombreCompleto:13:=ST_ClearSpaces ([Colegio:31]Director_Nombres:20+" "+[Colegio:31]Director_ApellidoPaterno:18+" "+[Colegio:31]Director_ApellidoMaterno:19)
			[Colegio:31]Director_RUN:28:=[Profesores:4]RUT:27
			[Colegio:31]Director_IdFuncionario:61:=[Profesores:4]Numero:1
		Else 
			[Colegio:31]Director_ApellidoMaterno:19:=""
			[Colegio:31]Director_ApellidoPaterno:18:=""
			[Colegio:31]Director_NombreCompleto:13:=""
			[Colegio:31]Director_Nombres:20:=""
			[Colegio:31]Director_RUN:28:=""
			[Colegio:31]Director_IdFuncionario:61:=0
		End if 
	Else 
		[Colegio:31]Director_ApellidoMaterno:19:=""
		[Colegio:31]Director_ApellidoPaterno:18:=""
		[Colegio:31]Director_NombreCompleto:13:=""
		[Colegio:31]Director_Nombres:20:=""
		[Colegio:31]Director_RUN:28:=""
		[Colegio:31]Director_IdFuncionario:61:=0
	End if 
End if 