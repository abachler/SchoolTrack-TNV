//%attributes = {}
  // ASrs_SinRegistroAsistencia()
If (False:C215)
	  // Por: Alberto Bachler K.: 10-06-14, 17:02:17
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
	
	
End if 

$d_fechaInicio:=$1
$d_fechaFin:=$1
If (Count parameters:C259=2)
	$d_fechaFin:=$2
End if 
$b_incidePctAsist:=True:C214
If (Count parameters:C259=3)
	$d_fechaFin:=$2
	$b_incidePctAsist:=$3
End if 

$y_fechaSesion_ad:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_nombreAsignatura_at:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura")
$y_nivel_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nivel")
$y_curso_at:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")
$y_profesor_at:=OBJECT Get pointer:C1124(Object named:K67:5;"profesor")
$y_hora_ai:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")
$y_emailProfesor_at:=OBJECT Get pointer:C1124(Object named:K67:5;"email")
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"numeroNivel")
$y_idProfesor_al:=OBJECT Get pointer:C1124(Object named:K67:5;"idProfesor")
$y_hora_ai:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")

ARRAY LONGINT:C221($y_idProfesor_al->;0)
ARRAY LONGINT:C221($y_nivelNumero_al->;0)
ARRAY INTEGER:C220($y_hora_ai->;0)

ARRAY LONGINT:C221($al_noNivel;0)
ARRAY LONGINT:C221($al_noAsig;0)

If ($d_fechaInicio#!00-00-00!)
	If ($d_fechaFin=!00-00-00!)
		$d_fechaFin:=$d_fechaInicio
	End if 
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>=;$d_fechaInicio;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaFin;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Impartida:5=True:C214;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18=False:C215;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & [Asignaturas:18]Incide_en_Asistencia:45=$b_incidePctAsist)
	  //MONO: filtro a las asignaturas de los niveles que usan asistencia por hora detallada (AttendanceMode=2)
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;"")
	KRL_RelateSelection (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;"")
	QUERY SELECTION:C341([xxSTR_Niveles:6];[xxSTR_Niveles:6]AttendanceMode:3=2)
	SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_noNivel)
	QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero_del_Nivel:6;$al_noNivel)
	SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_noAsig)
	QUERY SELECTION WITH ARRAY:C1050([Asignaturas_RegistroSesiones:168]ID_Asignatura:2;$al_noAsig)
	
Else 
	REDUCE SELECTION:C351([Asignaturas_RegistroSesiones:168];0)
End if 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$y_fechaSesion_ad->;[Asignaturas_RegistroSesiones:168]Hora:4;$y_hora_ai->;[Asignaturas:18]denominacion_interna:16;$y_nombreAsignatura_at->;[Asignaturas:18]Nivel:30;$y_nivel_at->;[Asignaturas:18]Curso:5;$y_curso_at->;[Asignaturas:18]profesor_nombre:13;$y_profesor_at->;[Asignaturas:18]profesor_numero:4;$y_idProfesor_al->;[Asignaturas:18]Numero_del_Nivel:6;$y_nivelNumero_al->;[Profesores:4]eMail_profesional:38;$y_emailProfesor_at->)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AT_MultiLevelSort (">>>>";$y_profesor_at;$y_nivelNumero_al;$y_curso_at;$y_nombreAsignatura_at;$y_fechaSesion_ad;$y_hora_ai;$y_emailProfesor_at;$y_idProfesor_al;$y_nivel_at)

ARRAY POINTER:C280($ay_jerarquia;0)
APPEND TO ARRAY:C911($ay_jerarquia;$y_profesor_at)
APPEND TO ARRAY:C911($ay_jerarquia;$y_nivel_at)
APPEND TO ARRAY:C911($ay_jerarquia;$y_curso_at)
LISTBOX SET HIERARCHY:C1098(*;"listaSesiones";True:C214;$ay_jerarquia)
