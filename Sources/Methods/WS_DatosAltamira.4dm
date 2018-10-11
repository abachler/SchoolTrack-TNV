//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  //WS_DatosAltamira



  //****DECLARACIONES****
C_TEXT:C284($1;$2;$3;$4;$5;$schoolID;$userName;$password;$tipo_Persona;$status;vtWS_ErrorString)
C_BLOB:C604(vxWS_Blob1;vxWS_Blob2;vxWS_Blob3;vxWS_Blob4;$blob;$compressedBlob)
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
SOAP DECLARATION:C782($5;Is text:K8:3;SOAP input:K46:1;"formatoArchivos")

  //****INICIALIZACIONES****
$schoolID:=$1
$userName:=$2
$password:=$3
$clase_datos:=$4
$formatoArchivos:=$5
vtWS_ErrorString:=""

  //****SOAP OUTPUTS****
SOAP DECLARATION:C782(vxWS_Blob1;Is BLOB:K8:12;SOAP output:K46:2;"datos")
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


  //ALUMNOS-ASIGNATURAS
SOAP DECLARATION:C782(atWS_Cursos_Rut;Text array:K8:16;SOAP output:K46:2;"AC_arr_RUT_Alumno")
SOAP DECLARATION:C782(atWS_Cursos_Curso;Text array:K8:16;SOAP output:K46:2;"AC_arr_Curso")
SOAP DECLARATION:C782(alWS_Cursos_Nivel;LongInt array:K8:19;SOAP output:K46:2;"AC_arr_Nivel")
SOAP DECLARATION:C782(atWS_Cursos_AbrevAsignatura;Text array:K8:16;SOAP output:K46:2;"AC_arr_Abreviacion")
SOAP DECLARATION:C782(atWS_Cursos_CodigoAsignatura;Text array:K8:16;SOAP output:K46:2;"AC_arr_Codigo")


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
If (($schoolID=<>gRolBD) & ($schoolID="92215") | ($schoolID=<>gRolBD) & ($schoolID="CHMD"))
	vs_Name:=$userName
	vs_Password:=$password
	$logged:=USR_ProcessLogin 
	
	If ($logged=1)
		If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
			$folderPath:=Get 4D folder:C485(Database folder:K5:14)+"Datos_Altamira"+Folder separator:K24:12
			SYS_DeleteFolder ($folderPath)
			SYS_CreatePath ($folderPath)
		End if 
		
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
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;7)
				AT_Inc (0)
				$aElementsNames{AT_Inc }:="rut"
				$aElementsNames{AT_Inc }:="nombres"
				$aElementsNames{AT_Inc }:="paterno"
				$aElementsNames{AT_Inc }:="materno"
				$aElementsNames{AT_Inc }:="fechaNacimiento"
				$aElementsNames{AT_Inc }:="email"
				$aElementsNames{AT_Inc }:="sexo"
				ARRAY POINTER:C280($aArrayPointers;7)
				AT_Inc (0)
				$aArrayPointers{AT_Inc }:=->atWS_RUT
				$aArrayPointers{AT_Inc }:=->atWS_Nombres
				$aArrayPointers{AT_Inc }:=->atWS_ApellidoPaterno
				$aArrayPointers{AT_Inc }:=->atWS_ApellidoMaterno
				$aArrayPointers{AT_Inc }:=->adWS_FechaNacimiento
				$aArrayPointers{AT_Inc }:=->atWS_Mail
				$aArrayPointers{AT_Inc }:=->atWS_Sexo
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+"personas.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"PERSONAS")
					XML_CreateSaxElements ($docRef;"persona";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+"personas.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
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
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;3)
				AT_Inc (0)
				$aElementsNames{AT_Inc }:="rut_alumno"
				$aElementsNames{AT_Inc }:="rut_ApoderadoAcademico"
				$aElementsNames{AT_Inc }:="rut_ApoderadoCuenta"
				ARRAY POINTER:C280($aArrayPointers;3)
				AT_Inc (0)
				$aArrayPointers{AT_Inc }:=->atWS_RUT
				$aArrayPointers{AT_Inc }:=->atWS_Nombres
				$aArrayPointers{AT_Inc }:=->atWS_ApellidoPaterno
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+"Alumnos_Apoderados.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"ALUMNOS-APODERADOS")
					XML_CreateSaxElements ($docRef;"alumno";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+"Alumnos_Apoderados.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Alumnos-Cursos") | ($clase_datos="todo"))
			QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Status:50="Oyente";*)
			QUERY:C277([Alumnos:2]; | [Alumnos:2]Status:50="En Trámite")
			EV2_Calificaciones_SeleccionAL 
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$aDummy;[Alumnos:2]RUT:5;atWS_Cursos_Rut;[Alumnos:2]curso:20;atWS_Cursos_Curso;[Alumnos:2]nivel_numero:29;alWS_Cursos_Nivel;[Asignaturas:18]Abreviación:26;atWS_Cursos_AbrevAsignatura;[Asignaturas:18]Codigo_interno:48;atWS_Cursos_CodigoAsignatura)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;5)
				AT_Inc (0)
				$aElementsNames{AT_Inc }:="rut_alumno"
				$aElementsNames{AT_Inc }:="curso"
				$aElementsNames{AT_Inc }:="nivel"
				$aElementsNames{AT_Inc }:="abreviacionAsignatura"
				$aElementsNames{AT_Inc }:="codigoAsignatura"
				ARRAY POINTER:C280($aArrayPointers;5)
				AT_Inc (0)
				$aArrayPointers{AT_Inc }:=->atWS_Cursos_Rut
				$aArrayPointers{AT_Inc }:=->atWS_Cursos_Curso
				$aArrayPointers{AT_Inc }:=->alWS_Cursos_Nivel
				$aArrayPointers{AT_Inc }:=->atWS_Cursos_AbrevAsignatura
				$aArrayPointers{AT_Inc }:=->atWS_Cursos_CodigoAsignatura
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+"Alumnos_Asignaturas.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"ALUMNOS-ASIGNATURAS")
					XML_CreateSaxElements ($docRef;"alumno-asignatura";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+"Alumnos_Asignaturas.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If (($clase_datos="Cursos") | ($clase_datos="todo"))
			ALL RECORDS:C47([Asignaturas:18])
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;atWS_Asignaturas_Asignatura;[Asignaturas:18]denominacion_interna:16;atWS_asignaturas_Interno;[Asignaturas:18]Abreviación:26;atWS_Asignaturas_Abreviacion;[Asignaturas:18]Codigo_interno:48;atWS_asignaturas_codigo;[Asignaturas:18]Curso:5;atWS_asignaturas_Curso;[Asignaturas:18]Numero_del_Nivel:6;alWS_asignaturas_Nivel;[Profesores:4]RUT:27;atWS_asignaturas_RUTProfesor)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			
			If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
				ARRAY TEXT:C222($aElementsNames;7)
				AT_Inc (0)
				$aElementsNames{AT_Inc }:="asignatura_codigo"
				$aElementsNames{AT_Inc }:="asignatura_oficial"
				$aElementsNames{AT_Inc }:="asignatura_interno"
				$aElementsNames{AT_Inc }:="asignatura_abreviacion"
				$aElementsNames{AT_Inc }:="asignatura_nivel"
				$aElementsNames{AT_Inc }:="asignatura_curso"
				$aElementsNames{AT_Inc }:="asignatura_rutProfesor"
				ARRAY POINTER:C280($aArrayPointers;7)
				AT_Inc (0)
				$aArrayPointers{AT_Inc }:=->atWS_asignaturas_codigo
				$aArrayPointers{AT_Inc }:=->atWS_Asignaturas_Asignatura
				$aArrayPointers{AT_Inc }:=->atWS_asignaturas_Interno
				$aArrayPointers{AT_Inc }:=->atWS_Asignaturas_Abreviacion
				$aArrayPointers{AT_Inc }:=->alWS_asignaturas_Nivel
				$aArrayPointers{AT_Inc }:=->atWS_asignaturas_Curso
				$aArrayPointers{AT_Inc }:=->atWS_asignaturas_RUTProfesor
				
				If (Position:C15("xml";$formatoArchivos)>0)
					$filepath:=$folderPath+"Asignaturas.xml"
					$DocRef:=Create document:C266($filepath)
					XML_OpenSAX_Root ($DocRef;"ASIGNATURAS")
					XML_CreateSaxElements ($docRef;"asignatura";->$aElementsNames;->$aArrayPointers)
					SAX CLOSE XML ELEMENT:C854($DocRef)
					CLOSE DOCUMENT:C267($DocRef)
				End if 
				
				If (Position:C15("txt";$formatoArchivos)>0)
					$filepath:=$folderPath+"Asignaturas.txt"
					AT_Arrays2TextFile ($filepath;->$aElementsNames;->$aArrayPointers)
				End if 
			End if 
		End if 
		
		If ((Position:C15("txt";$formatoArchivos)>0) | (Position:C15("xml";$formatoArchivos)>0))
			$b_archivoComprimido:=SYS_CompresionDescompresion ($folderPath;"";"";->$t_resultado)
			If ($b_archivoComprimido)
				DOCUMENT TO BLOB:C525($t_resultado;vxWS_Blob1)
			End if 
		End if 
		
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 

  //****LIMPIEZA****