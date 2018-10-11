//%attributes = {}
  // TMT_DetallesSesion()
  // Por: Alberto Bachler: 24/05/13, 11:40:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_DATE:C307($d_FechaSesion)
C_LONGINT:C283($l_IdAsignatura;$l_recNumSesion)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY TEXT:C222($at_NombresAusentes;0)
If (False:C215)
	C_LONGINT:C283(TMT_LeeDetallesSesion ;$1)
End if 

$l_recNumSesion:=$1
KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$l_recNumSesion)

$d_FechaSesion:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
vt_fechaSesion:="Sesión del "+String:C10($d_FechaSesion;System date long:K1:3)+", "+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)+__ ("ª hora")

QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos)
QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnos)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombresAusentes)
SORT ARRAY:C229($at_NombresAusentes;>)
vt_alumnosAusentes:=AT_array2text (->$at_NombresAusentes;"\r")

$l_IdAsignatura:=[Asignaturas:18]Numero:1
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;=;$l_IdAsignatura;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;=;$d_FechaSesion;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]hasData:8;=;True:C214)
vt_Info:=[Asignaturas_RegistroSesiones:168]Actividades:7

If (KRL_EsEventoEnInterfazUsuario )
	OBJECT SET FONT STYLE:C166(*;"TipoInfo@";Plain:K14:1)
	OBJECT SET FONT STYLE:C166(*;"TipoInfo_Actividades";Bold:K14:2)
End if 

