//%attributes = {}
  // STWA2_AJAX_ListaAsignaturas()
  // Por: Alberto Bachler Klein: 18-11-15, 17:20:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_esAdministrador;$b_mostrarProfesor)
C_LONGINT:C283($i;$l_IdProfesor;$l_recNumAsignatura;$l_userId)
C_TEXT:C284($t_currentOnErrorMethod;$t_json;$t_uuid)
C_OBJECT:C1216($o_objeto)

ARRAY LONGINT:C221($al_Alumnos;0)
ARRAY LONGINT:C221($al_AttMode;0)
ARRAY LONGINT:C221($al_IDMatriz;0)
ARRAY LONGINT:C221($al_IdProfesores;0)
ARRAY TEXT:C222($at_nivel;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY POINTER:C280($ay_Arreglos;0)
ARRAY POINTER:C280($ay_Campos;0)
ARRAY REAL:C219($ar_Aprobacion;0)
ARRAY TEXT:C222($at_Abreviacion;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY TEXT:C222($at_Nombre;0)
ARRAY TEXT:C222($at_Nombres;0)
ARRAY TEXT:C222($at_Orden;0)
ARRAY TEXT:C222($at_Profesor;0)
ARRAY TEXT:C222($at_Promedio;0)
ARRAY TEXT:C222($at_PromedioOF;0)
ARRAY OBJECT:C1221($ao_Opciones;0)  //Mono Ticket 172577 Evaluacion Especial

If (False:C215)
	C_TEXT:C284(STWA2_AJAX_ListaAsignaturas ;$1)
End if 

$t_uuid:=$1

If (Count parameters:C259=2)
	$l_IdProfesor:=$2
Else 
	$l_IdProfesor:=STWA2_Session_GetProfID ($uuid)
End if 

If (Util_isValidUUID ($t_uuid))
	  //$l_IdProfesor:=STWA2_Session_GetProfID ($t_uuid)
	$l_userId:=STWA2_Session_GetUserSTID ($t_uuid)
	$b_esAdministrador:=USR_IsGroupMember_by_GrpID (-15001;$l_userId)
End if 

READ ONLY:C145([Asignaturas:18])

$t_currentOnErrorMethod:=Method called on error:C704
ON ERR CALL:C155("STWerr_DataErrorHandler")

  // MOD Ticket N° 209394 PA 20180621
  //AS_ConfAsignaturaNoVisibleSTWA ("filtrarAsignaturas")
QUERY SELECTION BY ATTRIBUTE:C1424([Asignaturas:18];[Asignaturas:18]Opciones:57;"NoMostrarEnSTWA";=;False:C215)  //20170709 ASM Ticket 211159
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Curso:5;>;[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]Numero_del_Nivel:6;>)

APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]ordenGeneral:105)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]Abreviación:26)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]Nivel:30)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]Curso:5)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]denominacion_interna:16)
APPEND TO ARRAY:C911($ay_Campos;->[Profesores:4]Apellidos_y_nombres:28)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]Numero_de_alumnos:49)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]PromedioFinal_texto:53)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]PromedioFinalOficial_texto:67)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]PorcentajeAprobados:103)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18])
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]EVAPR_IdMatriz:91)
APPEND TO ARRAY:C911($ay_Campos;->[xxSTR_Niveles:6]AttendanceMode:3)
APPEND TO ARRAY:C911($ay_Campos;->[Asignaturas:18]Opciones:57)  //Mono Ticket 172577 Evaluacion Especial

APPEND TO ARRAY:C911($at_Nombres;"Orden")
APPEND TO ARRAY:C911($at_Nombres;"Abreviacion")
APPEND TO ARRAY:C911($at_Nombres;"Nivel")
APPEND TO ARRAY:C911($at_Nombres;"Curso")
APPEND TO ARRAY:C911($at_Nombres;"Nombre")
APPEND TO ARRAY:C911($at_Nombres;"Profesor")
APPEND TO ARRAY:C911($at_Nombres;"Alumnos")
APPEND TO ARRAY:C911($at_Nombres;"Promedio")
APPEND TO ARRAY:C911($at_Nombres;"PromedioOF")
APPEND TO ARRAY:C911($at_Nombres;"Aprobacion")
APPEND TO ARRAY:C911($at_Nombres;"RecNums")
APPEND TO ARRAY:C911($at_Nombres;"IDMatriz")
APPEND TO ARRAY:C911($at_Nombres;"AttMode")
APPEND TO ARRAY:C911($at_Nombres;"Opciones")  //Mono Ticket 172577 Evaluacion Especial

APPEND TO ARRAY:C911($ay_Arreglos;->$at_Orden)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_Abreviacion)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_nivel)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_Curso)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_Nombre)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_Profesor)
APPEND TO ARRAY:C911($ay_Arreglos;->$al_Alumnos)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_Promedio)
APPEND TO ARRAY:C911($ay_Arreglos;->$at_PromedioOF)
APPEND TO ARRAY:C911($ay_Arreglos;->$ar_Aprobacion)
APPEND TO ARRAY:C911($ay_Arreglos;->$al_recNums)
APPEND TO ARRAY:C911($ay_Arreglos;->$al_IDMatriz)
APPEND TO ARRAY:C911($ay_Arreglos;->$al_AttMode)
APPEND TO ARRAY:C911($ay_Arreglos;->$ao_Opciones)  //Mono Ticket 172577 Evaluacion Especial


For ($i;1;Size of array:C274($ay_Arreglos))
	SELECTION TO ARRAY:C260($ay_Campos{$i}->;$ay_Arreglos{$i}->;*)
End for 
SELECTION TO ARRAY:C260


For ($i;1;Size of array:C274($al_recNums))
	GOTO RECORD:C242([Asignaturas:18];$al_recNums{$i})
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Asignaturas:18]profesor_numero:4)
	$al_AttMode{$i}:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)
	$at_Profesor{$i}:=[Profesores:4]Apellidos_y_nombres:28
	If ($l_IdProfesor#[Asignaturas:18]profesor_numero:4)
		$b_mostrarProfesor:=True:C214
	End if 
End for 

$l_recNumAsignatura:=STWA2_AsignaturaActual ($l_IdProfesor)

$ob_objeto:=OB_Create 
$ob_objeto:=OB_ArraysToObject ($ob_objeto;->$at_Nombres;->$ay_Arreglos)
OB_SET ($ob_objeto;->$b_mostrarProfesor;"mostrarprofe")
OB_SET ($ob_objeto;->$l_recNumAsignatura;"currentAsig")
$t_json:=OB_Object2Json ($ob_objeto)
ON ERR CALL:C155($t_currentOnErrorMethod)
$0:=$t_json


