//%attributes = {}
  //Metodo: Método: WS_DatosMackay
  //Por jaime
  //Creada el 29/10/2010, 08:54:40

C_TEXT:C284(al_Rut;al_ApPaterno;al_ApMaterno;al_Nombres;al_Email;al_FechaNacimiento;al_Telefono;al_Celular;al_Direccion;al_Sector;al_Comuna;al_Curso)
C_TEXT:C284(ac_Rut;ac_ApPaterno;ac_ApMaterno;ac_Nombres;ac_Email;ac_FechaNacimiento;ac_Telefono;ac_Celular;ac_Direccion;ac_Comuna;ac_Profesion;ac_Empresa;ac_Cargo;ac_TelefonoTrabajo;ac_Religion;ac_EstadoCivil)
C_TEXT:C284(padre_Rut;padre_ApPaterno;padre_ApMaterno;padre_Nombres;padre_Email;padre_FechaNacimiento;padre_Telefono;padre_Celular;padre_Direccion;padre_Comuna;padre_Profesion;padre_Empresa;padre_Cargo;padre_TelefonoTrabajo;padre_Religion;padre_EstadoCivil)
C_TEXT:C284(madre_Rut;madre_ApPaterno;madre_ApMaterno;madre_Nombres;madre_Email;madre_FechaNacimiento;madre_Telefono;madre_Celular;madre_Direccion;madre_Comuna;madre_Profesion;madre_Empresa;madre_Cargo;madre_TelefonoTrabajo;madre_Religion;madre_EstadoCivil)

C_TEXT:C284($1;$2;$3;$4)
C_TEXT:C284($schoolID;$userName;$password;$rut_alumno)

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"identificadorcolegio")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"usuario")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"rutalumno")

SOAP DECLARATION:C782(al_Rut;Is text:K8:3;SOAP output:K46:2;"al_Rut")
SOAP DECLARATION:C782(al_ApPaterno;Is text:K8:3;SOAP output:K46:2;"al_ApPaterno")
SOAP DECLARATION:C782(al_ApMaterno;Is text:K8:3;SOAP output:K46:2;"al_ApMaterno")
SOAP DECLARATION:C782(al_Nombres;Is text:K8:3;SOAP output:K46:2;"al_Nombres")
SOAP DECLARATION:C782(al_Email;Is text:K8:3;SOAP output:K46:2;"al_Email")
SOAP DECLARATION:C782(al_FechaNacimiento;Is text:K8:3;SOAP output:K46:2;"al_FechaNacimiento")
SOAP DECLARATION:C782(al_Telefono;Is text:K8:3;SOAP output:K46:2;"al_Telefono")
SOAP DECLARATION:C782(al_Celular;Is text:K8:3;SOAP output:K46:2;"al_Celular")
SOAP DECLARATION:C782(al_Direccion;Is text:K8:3;SOAP output:K46:2;"al_Direccion")
SOAP DECLARATION:C782(al_Sector;Is text:K8:3;SOAP output:K46:2;"al_Sector")
SOAP DECLARATION:C782(al_Comuna;Is text:K8:3;SOAP output:K46:2;"al_Comuna")
SOAP DECLARATION:C782(al_Curso;Is text:K8:3;SOAP output:K46:2;"al_Curso")

SOAP DECLARATION:C782(ac_Rut;Is text:K8:3;SOAP output:K46:2;"ac_Rut")
SOAP DECLARATION:C782(ac_ApPaterno;Is text:K8:3;SOAP output:K46:2;"ac_ApPaterno")
SOAP DECLARATION:C782(ac_ApMaterno;Is text:K8:3;SOAP output:K46:2;"ac_ApMaterno")
SOAP DECLARATION:C782(ac_Nombres;Is text:K8:3;SOAP output:K46:2;"ac_Nombres")
SOAP DECLARATION:C782(ac_Email;Is text:K8:3;SOAP output:K46:2;"ac_Email")
SOAP DECLARATION:C782(ac_FechaNacimiento;Is text:K8:3;SOAP output:K46:2;"ac_FechaNacimiento")
SOAP DECLARATION:C782(ac_Telefono;Is text:K8:3;SOAP output:K46:2;"ac_Telefono")
SOAP DECLARATION:C782(ac_Celular;Is text:K8:3;SOAP output:K46:2;"ac_Celular")
SOAP DECLARATION:C782(ac_Direccion;Is text:K8:3;SOAP output:K46:2;"ac_Direccion")
SOAP DECLARATION:C782(ac_Comuna;Is text:K8:3;SOAP output:K46:2;"ac_Comuna")
SOAP DECLARATION:C782(ac_Profesion;Is text:K8:3;SOAP output:K46:2;"ac_Profesion")
SOAP DECLARATION:C782(ac_Empresa;Is text:K8:3;SOAP output:K46:2;"ac_Empresa")
SOAP DECLARATION:C782(ac_Cargo;Is text:K8:3;SOAP output:K46:2;"ac_Cargo")
SOAP DECLARATION:C782(ac_TelefonoTrabajo;Is text:K8:3;SOAP output:K46:2;"ac_TelefonoTrabajo")
SOAP DECLARATION:C782(ac_Religion;Is text:K8:3;SOAP output:K46:2;"ac_Religion")
SOAP DECLARATION:C782(ac_EstadoCivil;Is text:K8:3;SOAP output:K46:2;"ac_EstadoCivil")

SOAP DECLARATION:C782(padre_Rut;Is text:K8:3;SOAP output:K46:2;"padre_Rut")
SOAP DECLARATION:C782(padre_ApPaterno;Is text:K8:3;SOAP output:K46:2;"padre_ApPaterno")
SOAP DECLARATION:C782(padre_ApMaterno;Is text:K8:3;SOAP output:K46:2;"padre_ApMaterno")
SOAP DECLARATION:C782(padre_Nombres;Is text:K8:3;SOAP output:K46:2;"padre_Nombres")
SOAP DECLARATION:C782(padre_Email;Is text:K8:3;SOAP output:K46:2;"padre_Email")
SOAP DECLARATION:C782(padre_FechaNacimiento;Is text:K8:3;SOAP output:K46:2;"padre_FechaNacimiento")
SOAP DECLARATION:C782(padre_Telefono;Is text:K8:3;SOAP output:K46:2;"padre_Telefono")
SOAP DECLARATION:C782(padre_Celular;Is text:K8:3;SOAP output:K46:2;"padre_Celular")
SOAP DECLARATION:C782(padre_Direccion;Is text:K8:3;SOAP output:K46:2;"padre_Direccion")
SOAP DECLARATION:C782(padre_Comuna;Is text:K8:3;SOAP output:K46:2;"padre_Comuna")
SOAP DECLARATION:C782(padre_Profesion;Is text:K8:3;SOAP output:K46:2;"padre_Profesion")
SOAP DECLARATION:C782(padre_Empresa;Is text:K8:3;SOAP output:K46:2;"padre_Empresa")
SOAP DECLARATION:C782(padre_Cargo;Is text:K8:3;SOAP output:K46:2;"padre_Cargo")
SOAP DECLARATION:C782(padre_TelefonoTrabajo;Is text:K8:3;SOAP output:K46:2;"padre_TelefonoTrabajo")
SOAP DECLARATION:C782(padre_Religion;Is text:K8:3;SOAP output:K46:2;"padre_Religion")
SOAP DECLARATION:C782(padre_EstadoCivil;Is text:K8:3;SOAP output:K46:2;"padre_EstadoCivil")

SOAP DECLARATION:C782(madre_Rut;Is text:K8:3;SOAP output:K46:2;"madre_Rut")
SOAP DECLARATION:C782(madre_ApPaterno;Is text:K8:3;SOAP output:K46:2;"madre_ApPaterno")
SOAP DECLARATION:C782(madre_ApMaterno;Is text:K8:3;SOAP output:K46:2;"madre_ApMaterno")
SOAP DECLARATION:C782(madre_Nombres;Is text:K8:3;SOAP output:K46:2;"madre_Nombres")
SOAP DECLARATION:C782(madre_Email;Is text:K8:3;SOAP output:K46:2;"madre_Email")
SOAP DECLARATION:C782(madre_FechaNacimiento;Is text:K8:3;SOAP output:K46:2;"madre_FechaNacimiento")
SOAP DECLARATION:C782(madre_Telefono;Is text:K8:3;SOAP output:K46:2;"madre_Telefono")
SOAP DECLARATION:C782(madre_Celular;Is text:K8:3;SOAP output:K46:2;"madre_Celular")
SOAP DECLARATION:C782(madre_Direccion;Is text:K8:3;SOAP output:K46:2;"madre_Direccion")
SOAP DECLARATION:C782(madre_Comuna;Is text:K8:3;SOAP output:K46:2;"madre_Comuna")
SOAP DECLARATION:C782(madre_Profesion;Is text:K8:3;SOAP output:K46:2;"madre_Profesion")
SOAP DECLARATION:C782(madre_Empresa;Is text:K8:3;SOAP output:K46:2;"madre_Empresa")
SOAP DECLARATION:C782(madre_Cargo;Is text:K8:3;SOAP output:K46:2;"madre_Cargo")
SOAP DECLARATION:C782(madre_TelefonoTrabajo;Is text:K8:3;SOAP output:K46:2;"madre_TelefonoTrabajo")
SOAP DECLARATION:C782(madre_Religion;Is text:K8:3;SOAP output:K46:2;"madre_Religion")
SOAP DECLARATION:C782(madre_EstadoCivil;Is text:K8:3;SOAP output:K46:2;"madre_EstadoCivil")

SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"mensajeError")

$schoolID:=$1
$userName:=$2
$password:=$3
$rut_alumno:=$4

vtWS_ErrorString:=""
If (($schoolID=<>gRolBD) & ($schoolID="17884"))
	vs_Name:=$userName
	vs_Password:=$password
	$logged:=USR_ProcessLogin 
	If ($logged=1)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([Familia:78])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		$rnAlumno:=Find in field:C653([Alumnos:2]RUT:5;$rut_alumno)
		If ($rnAlumno#-1)
			KRL_GotoRecord (->[Alumnos:2];$rnAlumno)
			al_Rut:=[Alumnos:2]RUT:5
			al_ApPaterno:=[Alumnos:2]Apellido_paterno:3
			al_ApMaterno:=[Alumnos:2]Apellido_materno:4
			al_Nombres:=[Alumnos:2]Nombres:2
			al_Email:=[Alumnos:2]eMAIL:68
			al_FechaNacimiento:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
			al_Telefono:=[Alumnos:2]Telefono:17
			al_Celular:=[Alumnos:2]Celular:95
			al_Direccion:=[Alumnos:2]Direccion:12
			al_Sector:=[Alumnos:2]Sector_Domicilio:80
			al_Comuna:=[Alumnos:2]Comuna:14
			al_Curso:=[Alumnos:2]curso:20
			$rnApoCta:=Find in field:C653([Personas:7]No:1;[Alumnos:2]Apoderado_Cuentas_Número:28)
			If ($rnApoCta#-1)
				KRL_GotoRecord (->[Personas:7];$rnApoCta)
				ac_Rut:=[Personas:7]RUT:6
				ac_ApPaterno:=[Personas:7]Apellido_paterno:3
				ac_ApMaterno:=[Personas:7]Apellido_materno:4
				ac_Nombres:=[Personas:7]Nombres:2
				ac_Email:=[Personas:7]eMail:34
				ac_FechaNacimiento:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
				ac_Telefono:=[Personas:7]Telefono_domicilio:19
				ac_Celular:=[Personas:7]Celular:24
				ac_Direccion:=[Personas:7]Direccion:14
				ac_Comuna:=[Personas:7]Comuna:16
				ac_Profesion:=[Personas:7]Profesion:13
				ac_Empresa:=[Personas:7]Empresa:20
				ac_Cargo:=[Personas:7]Cargo:21
				ac_TelefonoTrabajo:=[Personas:7]Telefono_profesional:29
				ac_Religion:=[Personas:7]Religión:9
				ac_EstadoCivil:=[Personas:7]Estado_civil:10
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
				ac_Parentesco:=[Familia_RelacionesFamiliares:77]Parentesco:6
			End if 
			$rnFamilia:=Find in field:C653([Familia:78]Numero:1;[Alumnos:2]Familia_Número:24)
			If ($rnFamilia#-1)
				KRL_GotoRecord (->[Familia:78];$rnFamilia)
				$rnPadre:=Find in field:C653([Personas:7]No:1;[Familia:78]Padre_Número:5)
				$rnMadre:=Find in field:C653([Personas:7]No:1;[Familia:78]Madre_Número:6)
				If ($rnPadre#-1)
					KRL_GotoRecord (->[Personas:7];$rnPadre)
					padre_Rut:=[Personas:7]RUT:6
					padre_ApPaterno:=[Personas:7]Apellido_paterno:3
					padre_ApMaterno:=[Personas:7]Apellido_materno:4
					padre_Nombres:=[Personas:7]Nombres:2
					padre_Email:=[Personas:7]eMail:34
					padre_Parentesco:="Padre"
					padre_FechaNacimiento:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
					padre_Telefono:=[Personas:7]Telefono_domicilio:19
					padre_Celular:=[Personas:7]Celular:24
					padre_Direccion:=[Personas:7]Direccion:14
					padre_Comuna:=[Personas:7]Comuna:16
					padre_Profesion:=[Personas:7]Profesion:13
					padre_Empresa:=[Personas:7]Empresa:20
					padre_Cargo:=[Personas:7]Cargo:21
					padre_TelefonoTrabajo:=[Personas:7]Telefono_profesional:29
					padre_Religion:=[Personas:7]Religión:9
					padre_EstadoCivil:=[Personas:7]Estado_civil:10
				End if 
				If ($rnMadre#-1)
					KRL_GotoRecord (->[Personas:7];$rnMadre)
					madre_Rut:=[Personas:7]RUT:6
					madre_ApPaterno:=[Personas:7]Apellido_paterno:3
					madre_ApMaterno:=[Personas:7]Apellido_materno:4
					madre_Nombres:=[Personas:7]Nombres:2
					madre_Email:=[Personas:7]eMail:34
					madre_Parentesco:="Madre"
					madre_FechaNacimiento:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
					madre_Telefono:=[Personas:7]Telefono_domicilio:19
					madre_Celular:=[Personas:7]Celular:24
					madre_Direccion:=[Personas:7]Direccion:14
					madre_Comuna:=[Personas:7]Comuna:16
					madre_Profesion:=[Personas:7]Profesion:13
					madre_Empresa:=[Personas:7]Empresa:20
					madre_Cargo:=[Personas:7]Cargo:21
					madre_TelefonoTrabajo:=[Personas:7]Telefono_profesional:29
					madre_Religion:=[Personas:7]Religión:9
					madre_EstadoCivil:=[Personas:7]Estado_civil:10
				End if 
			End if 
		Else 
			vtWS_ErrorString:="Alumno no existe en la base de datos (Error -3)"
		End if 
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 