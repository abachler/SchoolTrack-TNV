//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-08-18, 17:34:52
  // ----------------------------------------------------
  // Método: LOG_RegistroDetalle
  // Descripción
  //
  // $1 = En el primer parametro se indica la tabla.
  // $2 = En El segundo parametro el titulo inicial (desde donde se está realizando el cambio)
  // Validaciones: Si el registro es un nuevo registro, y no se pasa el segundo parametro se agregará siempre el titulo "Creación de registro:" 
  //
  // Parámetros
  // ----------------------------------------------------


$y_tabla:=$1
$t_origenEvt:="Modificación de registro: "

If (Count parameters:C259=2)
	$t_origenEvt:=$2
End if 

Case of 
	: (Table:C252($y_tabla)=Table:C252(->[Alumnos:2]))
		If (Is new record:C668($y_tabla->))
			If (Count parameters:C259<2)
				$t_origenEvt:="Creación de registro: "
			End if 
			$t_mensaje:=$t_origenEvt+"Se crea nuevo registro de alumnos. ID Schooltrack: "+String:C10([Alumnos:2]numero:1)
			LOG_RegisterEvt ($t_mensaje)
		Else 
			  //verifico el sexo del alumno para que el mensaje sea inclusivo (por si acaso)
			If ([Alumnos:2]Sexo:49="M")
				$t_mensajeSexo:="del alumno"
			Else 
				$t_mensajeSexo:="de la alumna"
			End if 
			
			If (Old:C35([Alumnos:2]Apellido_paterno:3)#[Alumnos:2]Apellido_paterno:3)
				$t_mensaje:=$t_origenEvt+"El apellido paterno "+$t_mensajeSexo+" "+Old:C35([Alumnos:2]apellidos_y_nombres:40)+". ID Schooltrack:"+String:C10([Alumnos:2]numero:1)+". cambio de "+Old:C35([Alumnos:2]Apellido_paterno:3)+" a "+[Alumnos:2]Apellido_paterno:3
				LOG_RegisterEvt ($t_mensaje)
			End if 
			
			If (Old:C35([Alumnos:2]Apellido_materno:4)#[Alumnos:2]Apellido_materno:4)
				$t_mensaje:=$t_origenEvt+"El apellido materno "+$t_mensajeSexo+" "+Old:C35([Alumnos:2]apellidos_y_nombres:40)+", ID Schooltrack: "+String:C10([Alumnos:2]numero:1)+", cambio de "+Old:C35([Alumnos:2]Apellido_materno:4)+" a "+[Alumnos:2]Apellido_materno:4
				LOG_RegisterEvt ($t_mensaje)
			End if 
			
			If (Old:C35([Alumnos:2]Nombres:2)#[Alumnos:2]Nombres:2)
				$t_mensaje:=$t_origenEvt+"Los nombres "+$t_mensajeSexo+" "+Old:C35([Alumnos:2]apellidos_y_nombres:40)+", ID Schooltrack: "+String:C10([Alumnos:2]numero:1)+", cambio de "+Old:C35([Alumnos:2]Nombres:2)+" a "+[Alumnos:2]Nombres:2
				LOG_RegisterEvt ($t_mensaje)
			End if 
			
			If (Old:C35([Alumnos:2]RUT:5)#[Alumnos:2]RUT:5)
				$t_mensaje:=$t_origenEvt+"El Identificador nacional "+$t_mensajeSexo+" "+Old:C35([Alumnos:2]apellidos_y_nombres:40)+", ID Schooltrack: "+String:C10([Alumnos:2]numero:1)+", cambio de "+Old:C35([Alumnos:2]RUT:5)+" a "+[Alumnos:2]RUT:5
				LOG_RegisterEvt ($t_mensaje)
			End if 
			
			If (Old:C35([Alumnos:2]Sexo:49)#[Alumnos:2]Sexo:49)
				If (Old:C35([Alumnos:2]Sexo:49)="M")
					$t_mensajeSexo:="del alumno"
				Else 
					$t_mensajeSexo:="de la alumna"
				End if 
				$t_mensaje:=$t_origenEvt+"El sexo "+$t_mensajeSexo+" "+Old:C35([Alumnos:2]apellidos_y_nombres:40)+", ID Schooltrack: "+String:C10([Alumnos:2]numero:1)+", cambio de "+Old:C35([Alumnos:2]Sexo:49)+" a "+[Alumnos:2]Sexo:49
				LOG_RegisterEvt ($t_mensaje)
			End if 
			
		End if 
		
End case 
