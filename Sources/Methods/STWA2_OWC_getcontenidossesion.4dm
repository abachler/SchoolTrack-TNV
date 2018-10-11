//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:55:20
  // ----------------------------------------------------
  // Método: STWA2_OWC_getcontenidossesion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
If (KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$rn;False:C215))
	  //20160609 ASM  para enviar las inasistencias
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
	SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos)
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnos)
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombresAusentes)
	SORT ARRAY:C229($at_NombresAusentes;>)
	vt_alumnosAusentes:=AT_array2text (->$at_NombresAusentes;"\r")
	
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->[Asignaturas_RegistroSesiones:168]Contenidos:6;"contenidos")
	OB_SET ($ob_raiz;->[Asignaturas_RegistroSesiones:168]Actividades:7;"actividades")
	OB_SET ($ob_raiz;->[Asignaturas_RegistroSesiones:168]Observacion:12;"observaciones")
	OB_SET ($ob_raiz;->vt_alumnosAusentes;"alumnoaunsentes")
	$json:=OB_Object2Json ($ob_raiz)
	
Else 
	$json:=STWA2_JSON_SendError (-60007)
End if 

$0:=$json