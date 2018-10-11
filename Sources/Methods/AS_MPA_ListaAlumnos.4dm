//%attributes = {}
  // AS_MPA_ListaAlumnos()
  // Por: Alberto Bachler K.: 12-05-14, 11:09:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_anchoListBox;$l_IdAlumnoActual;$l_idAsignatura)
C_POINTER:C301($y_alumnosCurso;$y_alumnosId;$y_alumnosNombre;$y_alumnosSexo)


$l_idAsignatura:=$1

If (Count parameters:C259=2)
	$l_IdAlumnoActual:=$2
End if 



SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDeLaAsignatura ($l_idAsignatura)
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;<;[Alumnos_Calificaciones:208]NoDeLista:10;>)
				Else 
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;>;[Alumnos_Calificaciones:208]NoDeLista:10;>)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;<;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
				Else 
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;<;[Alumnos:2]apellidos_y_nombres:40;>)
				Else 
					ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;>;[Alumnos:2]apellidos_y_nombres:40;>)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10;>)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos_Calificaciones]NoDeLista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]apellidos_y_nombres;>)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;>;[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;>;[Alumnos_Calificaciones]NoDeLista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;>;[Alumnos]apellidos_y_nombres;>)
  //End case 
  //End if 


$y_alumnosNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosNombre")
$y_alumnosCurso:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosCurso")
$y_alumnosId:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosId")
$y_alumnosSexo:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosSexo")

ARRAY LONGINT:C221($y_alumnosId->;0)
ARRAY TEXT:C222($y_alumnosCurso->;0)
ARRAY TEXT:C222($y_alumnosNombre->;0)
ARRAY TEXT:C222($y_alumnosSexo->;0)


SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$y_alumnosId->;[Alumnos:2]Nombre_Común:30;$y_alumnosNombre->;[Alumnos:2]curso:20;$y_alumnosCurso->;[Alumnos:2]Sexo:49;$y_alumnosSexo->)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

$l_anchoListBox:=IT_Objeto_Ancho ("lb_alumnos")-16
If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
	OBJECT SET VISIBLE:C603(*;"alumnosCurso";True:C214)
	LISTBOX SET COLUMN WIDTH:C833(*;"alumnosCurso";20)
	For ($i;1;Size of array:C274($y_alumnosCurso->))
		$y_alumnosCurso->{$i}:=Substring:C12($y_alumnosCurso->{$i};Position:C15("-";$y_alumnosCurso->{$i})+1)
	End for 
	LISTBOX SET COLUMN WIDTH:C833(*;"alumnosNombre";$l_anchoListBox-20)
Else 
	OBJECT SET VISIBLE:C603(*;"alumnosCurso";False:C215)
	LISTBOX SET COLUMN WIDTH:C833(*;"alumnosNombre";$l_anchoListBox)
End if 

OBJECT SET RGB COLORS:C628(*;"lb_alumnos";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)

