//%attributes = {}
  // AL_ProcesaNombres()
  // Por: Alberto Bachler: 13/02/13, 11:08:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------


C_BOOLEAN:C305($b_nombreComunActualizado;$b_nombreOficialActualizado;$b_nombresModificados;$b_desactivarConfirmacion)
C_LONGINT:C283($l_OpcionUsuario)
C_TEXT:C284($t_mensaje;$t_nuevoNombreComun)

$b_desactivarConfirmacion:=False:C215
If (Count parameters:C259=1)
	$b_desactivarConfirmacion:=$1
End if 

If (Type:C295(at_ExcepcionesFormato)=Is undefined:K8:13)
	ST_LoadModuleFormatExceptions ("SchoolTrack")
End if 

[Alumnos:2]apellidos_y_nombres:40:=Replace string:C233([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+" "+[Alumnos:2]Nombres:2;"  ";" ")
[Alumnos:2]apellidos_y_nombres:40:=ST_Format (->[Alumnos:2]apellidos_y_nombres:40)

If ((Old:C35([Alumnos:2]Nombre_oficial:48)="") | (<>viSTR_UD_NombresComun_Oficial=1))
	[Alumnos:2]Nombre_oficial:48:=[Alumnos:2]apellidos_y_nombres:40
	[Alumnos:2]Nombre_oficial:48:=ST_Format (->[Alumnos:2]Nombre_oficial:48)
	$b_nombreOficialActualizado:=True:C214
End if 

If ((Old:C35([Alumnos:2]Nombre_Común:30)="") | (<>viSTR_UD_NombresComun_Oficial=1))
	[Alumnos:2]Nombre_Común:30:=ST_ClearSpaces (ST_GetWord ([Alumnos:2]Nombres:2;1)+" "+[Alumnos:2]Apellido_paterno:3)
	[Alumnos:2]Nombre_Común:30:=ST_Format (->[Alumnos:2]Nombre_Común:30)
	$b_nombreComunActualizado:=True:C214
End if 

If ((FORM Get current page:C276>0) & (Not:C34($b_desactivarConfirmacion)))
	  // si el metodo es llamado desde un formulario pregunatmos al usuario si desea actualizar los nombres comun y oficial despus de haber modifcado apellidos o nombres
	
	If (([Alumnos:2]Nombre_oficial:48#"") & (Not:C34($b_nombreOficialActualizado)))
		$b_nombresModificados:=(([Alumnos:2]Nombres:2#Old:C35([Alumnos:2]Nombres:2)) & (Old:C35([Alumnos:2]Nombres:2)#""))
		$b_nombresModificados:=$b_nombresModificados | (([Alumnos:2]Apellido_paterno:3#Old:C35([Alumnos:2]Apellido_paterno:3)) & (Old:C35([Alumnos:2]Apellido_paterno:3)#""))
		$b_nombresModificados:=$b_nombresModificados | (([Alumnos:2]Apellido_materno:4#Old:C35([Alumnos:2]Apellido_materno:4)) & (Old:C35([Alumnos:2]Apellido_materno:4)#""))
		If ($b_nombresModificados)
			$l_OpcionUsuario:=CD_Dlog (0;__ ("El nombre oficial del alumno es diferente de los datos ingresados.\r¿Desea reemplazar el nombre oficial con los nuevos datos ingresados?");__ ("");__ ("No");__ ("Si"))
			If ($l_OpcionUsuario=2)
				[Alumnos:2]Nombre_oficial:48:=[Alumnos:2]apellidos_y_nombres:40
				[Alumnos:2]Nombre_oficial:48:=ST_Format (->[Alumnos:2]Nombre_oficial:48)
			End if 
		End if 
	End if 
	
	$t_nuevoNombreComun:=ST_GetWord ([Alumnos:2]Nombres:2;1)+" "+[Alumnos:2]Apellido_paterno:3
	If (([Alumnos:2]Nombre_Común:30#"") & ($t_nuevoNombreComun#[Alumnos:2]Nombre_Común:30) & (Not:C34($b_nombreComunActualizado)))
		$b_nombresModificados:=(([Alumnos:2]Nombres:2#Old:C35([Alumnos:2]Nombres:2)) & (Old:C35([Alumnos:2]Nombres:2)#""))
		$b_nombresModificados:=$b_nombresModificados | (([Alumnos:2]Apellido_paterno:3#Old:C35([Alumnos:2]Apellido_paterno:3)) & (Old:C35([Alumnos:2]Apellido_paterno:3)#""))
		If ($b_nombresModificados)
			$t_mensaje:=__ ("El nombre común registrado para el alumno es distinto del primer nombre y del primer apellido.\r¿Desea establecer $t_nuevoNombreComun como nombre común?")
			$t_mensaje:=Replace string:C233($t_mensaje;"$t_nuevoNombreComun";$t_nuevoNombreComun)
			$l_OpcionUsuario:=CD_Dlog (0;$t_mensaje;__ ("");__ ("No");__ ("Si"))
			If ($l_OpcionUsuario=2)
				[Alumnos:2]Nombre_Común:30:=$t_nuevoNombreComun
				[Alumnos:2]Nombre_Común:30:=ST_Format (->[Alumnos:2]Nombre_Común:30)
			End if 
		End if 
	End if 
End if 
