//%attributes = {"publishedSoap":true}
  //WS_DatosDemo

  //`xShell, Alberto Bachler
  //Metodo: WS_GetFamilyData
  //Por abachler
  //Creada el 05/11/2003, 16:53:03
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_TEXT:C284($1;$2;$3;$4;$schoolID;$userName;$password;$tipo_Persona;$status;vtWS_ErrorString)
C_LONGINT:C283($logged)

ARRAY TEXT:C222(atWS_RUT;0)
ARRAY TEXT:C222(atWS_Nombres;0)
ARRAY TEXT:C222(atWS_ApellidoPaterno;0)
ARRAY TEXT:C222(atWS_ApellidoMaterno;0)
ARRAY DATE:C224(adWS_FechaNacimiento;0)
ARRAY TEXT:C222(atWS_Mail;0)
ARRAY TEXT:C222(atWS_Sexo;0)

ARRAY TEXT:C222(atWS_RUT_alumno;0)
ARRAY TEXT:C222(atWS_RUT_apoderadoAcademico;0)
ARRAY TEXT:C222(atWS_RUT_apoderadoCuentas;0)

ARRAY TEXT:C222(atWS_Cursos_Rut;0)
ARRAY TEXT:C222(atWS_Cursos_Curso;0)
ARRAY TEXT:C222(atWS_Cursos_AbrevAsignatura;0)
ARRAY TEXT:C222(atWS_Cursos_CodigoAsignatura;0)
ARRAY LONGINT:C221(alWS_Cursos_Nivel;0)

ARRAY TEXT:C222(atWS_Asignaturas_Asignatura;0)
ARRAY TEXT:C222(atWS_asignaturas_Interno;0)
ARRAY TEXT:C222(atWS_Asignaturas_Abreviacion;0)
ARRAY TEXT:C222(atWS_asignaturas_codigo;0)
ARRAY TEXT:C222(atWS_asignaturas_Curso;0)
ARRAY TEXT:C222(atWS_asignaturas_RUTProfesor;0)
ARRAY LONGINT:C221(alWS_asignaturas_Nivel;0)


  //****SOAP INPUTS****
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"identificadorColegio")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"usuario")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"datosRequeridos")

  //****INICIALIZACIONES****
$schoolID:=$1
$userName:=$2
$password:=$3
$clase_datos:=$4

vtWS_ErrorString:=""

  //****SOAP OUTPUTS****
SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"mensajeError")


  //PERSONAS
SOAP DECLARATION:C782(atWS_RUT;Text array:K8:16;SOAP output:K46:2;"P_arr_RUT")
SOAP DECLARATION:C782(atWS_Nombres;Text array:K8:16;SOAP output:K46:2;"P_arr_Nombres")
SOAP DECLARATION:C782(atWS_ApellidoPaterno;Text array:K8:16;SOAP output:K46:2;"P_arr_Paterno")
SOAP DECLARATION:C782(atWS_ApellidoMaterno;Text array:K8:16;SOAP output:K46:2;"P_arr_Materno")
SOAP DECLARATION:C782(atWS_Mail;Text array:K8:16;SOAP output:K46:2;"P_arreglo_Mail")
SOAP DECLARATION:C782(adWS_FechaNacimiento;Date array:K8:20;SOAP output:K46:2;"P_arr_FechaNacimiento")
SOAP DECLARATION:C782(atWS_Sexo;Text array:K8:16;SOAP output:K46:2;"P_arr_Sexo")


  //ALUMNOS-APODERADOS
SOAP DECLARATION:C782(atWS_RUT_apoderadoAcademico;Text array:K8:16;SOAP output:K46:2;"AA_arr_RUT_Academico")
SOAP DECLARATION:C782(atWS_RUT_apoderadoCuentas;Text array:K8:16;SOAP output:K46:2;"AA_arr_RUT_Cuentas")
SOAP DECLARATION:C782(atWS_RUT_alumno;Text array:K8:16;SOAP output:K46:2;"AA_arr_RUT_alumno")



  //ASIGNATURAS
SOAP DECLARATION:C782(atWS_Asignaturas_Asignatura;Text array:K8:16;SOAP output:K46:2;"C_arr_Asignatura")
SOAP DECLARATION:C782(atWS_asignaturas_Interno;Text array:K8:16;SOAP output:K46:2;"C_arr_NombreInterno")
SOAP DECLARATION:C782(atWS_Asignaturas_Abreviacion;Text array:K8:16;SOAP output:K46:2;"C_arr_Abreviacion")
SOAP DECLARATION:C782(atWS_asignaturas_codigo;Text array:K8:16;SOAP output:K46:2;"C_arr_codigo")
SOAP DECLARATION:C782(atWS_asignaturas_Curso;Text array:K8:16;SOAP output:K46:2;"C_arr_curso")
SOAP DECLARATION:C782(atWS_asignaturas_RUTProfesor;Text array:K8:16;SOAP output:K46:2;"C_arr_rutProfesor")
SOAP DECLARATION:C782(alWS_asignaturas_Nivel;LongInt array:K8:19;SOAP output:K46:2;"C_arr_NumeroNivel")



  //****CUERPO****

vtWS_ErrorString:=""

If ($schoolID="92215")
	vs_Name:=$userName
	vs_Password:=$password
	$isSU:=USR_IsSuperUser (vs_Name;vs_Password)
	If ($isSU)
		$logged:=1
	Else 
		$logged:=USR_ProcessLogin 
	End if 
	If ($logged=1)
		If (($clase_datos="Personas") | ($clase_datos="todo"))
			QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Status:50="Oyente";*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Status:50="En Trámite")
			SELECTION TO ARRAY:C260([Alumnos:2]RUT:5;$atWS_RUT;[Alumnos:2]Nombres:2;$atWS_Nombres;[Alumnos:2]Apellido_paterno:3;$atWS_ApellidoPaterno;[Alumnos:2]Apellido_materno:4;$atWS_ApellidoMaterno;[Alumnos:2]Fecha_de_nacimiento:7;$adWS_FechaNacimiento;[Alumnos:2]eMAIL:68;$atWS_Mail;[Alumnos:2]Sexo:49;$atWS_Sexo)
			AT_MergeArrays (->$atWS_RUT;->atWS_RUT)
			AT_MergeArrays (->$atWS_Nombres;->atWS_Nombres)
			AT_MergeArrays (->$atWS_ApellidoPaterno;->atWS_ApellidoPaterno)
			AT_MergeArrays (->$atWS_ApellidoMaterno;->atWS_ApellidoMaterno)
			AT_MergeArrays (->$adWS_FechaNacimiento;->adWS_FechaNacimiento)
			AT_MergeArrays (->$atWS_Mail;->atWS_Mail)
			AT_MergeArrays (->$atWS_Sexo;->atWS_Sexo)
			
			QUERY:C277([Personas:7]; | [Personas:7]Inactivo:46=False:C215)
			SELECTION TO ARRAY:C260([Personas:7]RUT:6;$atWS_RUT;[Personas:7]Nombres:2;$atWS_Nombres;[Personas:7]Apellido_paterno:3;$atWS_ApellidoPaterno;[Personas:7]Apellido_materno:4;$atWS_ApellidoMaterno;[Personas:7]Fecha_de_nacimiento:5;$adWS_FechaNacimiento;[Personas:7]eMail:34;$atWS_Mail;[Personas:7]Sexo:8;$atWS_Sexo)
			AT_MergeArrays (->$atWS_RUT;->atWS_RUT)
			AT_MergeArrays (->$atWS_Nombres;->atWS_Nombres)
			AT_MergeArrays (->$atWS_ApellidoPaterno;->atWS_ApellidoPaterno)
			AT_MergeArrays (->$atWS_ApellidoMaterno;->atWS_ApellidoMaterno)
			AT_MergeArrays (->$adWS_FechaNacimiento;->adWS_FechaNacimiento)
			AT_MergeArrays (->$atWS_Mail;->atWS_Mail)
			AT_MergeArrays (->$atWS_Sexo;->atWS_Sexo)
			
			QUERY:C277([Profesores:4]; | [Profesores:4]Inactivo:62=False:C215)
			SELECTION TO ARRAY:C260([Profesores:4]RUT:27;$atWS_RUT;[Profesores:4]Nombres:2;$atWS_Nombres;[Profesores:4]Apellido_paterno:3;$atWS_ApellidoPaterno;[Profesores:4]Apellido_materno:4;$atWS_ApellidoMaterno;[Profesores:4]Fecha_de_nacimiento:6;$adWS_FechaNacimiento;[Profesores:4]eMail_Personal:61;$atWS_Mail;[Profesores:4]Sexo:5;$atWS_Sexo)
			AT_MergeArrays (->$atWS_RUT;->atWS_RUT)
			AT_MergeArrays (->$atWS_Nombres;->atWS_Nombres)
			AT_MergeArrays (->$atWS_ApellidoPaterno;->atWS_ApellidoPaterno)
			AT_MergeArrays (->$atWS_ApellidoMaterno;->atWS_ApellidoMaterno)
			AT_MergeArrays (->$adWS_FechaNacimiento;->adWS_FechaNacimiento)
			AT_MergeArrays (->$atWS_Mail;->atWS_Mail)
			AT_MergeArrays (->$atWS_Sexo;->atWS_Sexo)
		End if 
		
		If (($clase_datos="Alumnos-Apoderados") | ($clase_datos="todo"))
			  //busqueda de alumnos
			QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Status:50="Oyente";*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Status:50="En Trámite")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIDAlumnos;[Alumnos:2]RUT:5;atWS_RUT_alumno;[Alumnos:2]Apoderado_académico_Número:27;$alWS_IDacademico_alumno;[Alumnos:2]Apoderado_Cuentas_Número:28;$alWS_IDcuentas_alumno)
			AT_RedimArrays (Size of array:C274($aIDAlumnos);->atWS_RUT_apoderadoAcademico;->atWS_RUT_apoderadoCuentas)
			
			  //apoderados académicos relacionados
			QRY_QueryWithArray (->[Personas:7]No:1;->$alWS_IDacademico_alumno)
			SELECTION TO ARRAY:C260([Personas:7]RUT:6;$aRutAcademico;[Personas:7]No:1;$alWS_IDacademico)
			
			  //apoderados de cuentas relacionados
			QRY_QueryWithArray (->[Personas:7]No:1;->$alWS_IDcuentas_alumno)
			SELECTION TO ARRAY:C260([Personas:7]RUT:6;$aRutCuentas;[Personas:7]No:1;$alWS_IDcuentas)
			
			  //construcción de los arreglos de retorno
			For ($i;1;Size of array:C274($aIDAlumnos))
				$el:=Find in array:C230($alWS_IDacademico;$alWS_IDacademico_alumno{$i})
				If ($el>0)
					atWS_RUT_apoderadoAcademico{$i}:=$aRutAcademico{$el}
				End if 
				
				$el:=Find in array:C230($alWS_IDcuentas;$alWS_IDcuentas_alumno{$i})
				If ($el>0)
					atWS_RUT_apoderadoCuentas{$i}:=$aRutCuentas{$el}
				End if 
			End for 
		End if 
		
		If (($clase_datos="Cursos") | ($clase_datos="todo"))
			ALL RECORDS:C47([Asignaturas:18])
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;atWS_Asignaturas_Asignatura;[Asignaturas:18]denominacion_interna:16;atWS_asignaturas_Interno;[Asignaturas:18]Abreviación:26;atWS_Asignaturas_Abreviacion;[Asignaturas:18]Codigo_interno:48;atWS_asignaturas_codigo;[Asignaturas:18]Curso:5;atWS_asignaturas_Curso;[Asignaturas:18]Numero_del_Nivel:6;alWS_asignaturas_Nivel;[Profesores:4]RUT:27;atWS_asignaturas_RUTProfesor)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 

  //****LIMPIEZA****