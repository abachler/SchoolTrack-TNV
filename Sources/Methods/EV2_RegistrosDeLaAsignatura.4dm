//%attributes = {}
  // MÉTODO: EV2_RegistrosDeLaAsignatura
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 15:39:12
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Crea selecciones con los registros de las tablas [Alumnos_Calificaciones y [Alumnos_ComplementoEvaluacion] vinculados a la asignatura
  // cuyo ID es pasado en $1. Si se pasa 1 solo argumento se asume que se trata de una asignatura del año actual.
  // Los parametros opcionales permiten crear selecciones con registros de años anteriores.
  //
  // PARÁMETROS
  // EV2_RegistrosDeLaAsignatura(ID_asignatura{;año{;ID_Insititucion}})
  // $1: ID_asignatura: Longint
  // $2: Año: Longint
  // $3: ID_Insititucion: Longint
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_año;$l_IdAsignatura;$l_IdInstitucion;$l_RecNum)
C_TEXT:C284($t_Key)

If (False:C215)
	C_LONGINT:C283(EV2_RegistrosDeLaAsignatura ;$1)
	C_LONGINT:C283(EV2_RegistrosDeLaAsignatura ;$2)
	C_LONGINT:C283(EV2_RegistrosDeLaAsignatura ;$3)
End if 



  // CODIGO PRINCIPAL
$l_IdAsignatura:=$1
$l_año:=<>gYear
$l_IdInstitucion:=<>gInstitucion
$b_lecturaEscritura:=False:C215
Case of 
	: (Count parameters:C259=4)
		$b_lecturaEscritura:=$4
	: (Count parameters:C259=3)
		$l_IdInstitucion:=$3
		$l_año:=$2
	: (Count parameters:C259=2)
		$l_año:=$2
End case 

If ($b_lecturaEscritura)
	READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
	READ WRITE:C146([Alumnos_Calificaciones:208])
Else 
	READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
	READ ONLY:C145([Alumnos_Calificaciones:208])
End if 



  // creo la seleccion de [Alumnos_ComplementoEvaluacion]
$t_Key:=String:C10($l_IdInstitucion)+"."+String:C10($l_año)+"."+String:C10(Abs:C99($l_IdAsignatura))


QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]LLave_Asignatura:56;=;$t_key;*)
If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
	QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & [Alumnos:2]ocultoEnNominas:89=False:C215)
Else 
	QUERY:C277([Alumnos_ComplementoEvaluacion:209])
End if 

  // establezco el ordenamiento por defecto
SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;Automatic:K51:4;Structure configuration:K51:2)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Alumnos_Calificaciones:208]NIvel_Numero:4)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos_Calificaciones:208]NoDeLista:10;>)
				Else 
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos_Calificaciones:208]NoDeLista:10;>)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					Else 
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]apellidos_y_nombres:40;>)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					Else 
						ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]apellidos_y_nombres:40;>)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;<;[Alumnos:2]apellidos_y_nombres:40;>)
				Else 
					ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]Sexo:49;>;[Alumnos:2]apellidos_y_nombres:40;>)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos_Calificaciones:208]NoDeLista:10;>)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		Else 
			ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]apellidos_y_nombres:40;>)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]apellidos_y_nombres:40;>)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //Else 
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]apellidos_y_nombres;>)
  //End if 
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos_Calificaciones]NoDeLista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]apellidos_y_nombres;>)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //Else 
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]apellidos_y_nombres;>)
  //End if 
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos_Calificaciones]NoDeLista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Sexo;<;[Alumnos]apellidos_y_nombres;>)
  //End case 
  //End if 
SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;Structure configuration:K51:2;Structure configuration:K51:2)
CUT NAMED SELECTION:C334([Alumnos_ComplementoEvaluacion:209];"$complementos")


  // creo la selección de [Alumnos_Calificaciones]
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
If (Count parameters:C259=1)
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5;=;$l_IdAsignatura;*)
	If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
		QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos:2]ocultoEnNominas:89=False:C215)
	Else 
		QUERY:C277([Alumnos_Calificaciones:208])
	End if 
Else 
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Asignatura:494;=;$t_Key;*)
	If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
		QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos:2]ocultoEnNominas:89=False:C215)
	Else 
		QUERY:C277([Alumnos_Calificaciones:208])
	End if 
End if 

  // establezco el ordenamiento por defecto
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Alumnos_Calificaciones:208]NIvel_Numero:4)
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
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;<;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					Else 
						ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;<;[Alumnos:2]apellidos_y_nombres:40;>)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					Else 
						ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]Sexo:49;>;[Alumnos:2]apellidos_y_nombres:40;>)
					End if 
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
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		Else 
			ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //Else 
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]apellidos_y_nombres;>)
  //End if 
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos_Calificaciones]NoDeLista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]apellidos_y_nombres;>)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;<;[Alumnos]curso;>;[Alumnos]apellidos_y_nombres;>)
  //Else 
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;<;[Alumnos]apellidos_y_nombres;>)
  //End if 
  //: (<>gOrdenNta=1)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;<;[Alumnos_Calificaciones]NoDeLista;>)
  //: (<>gOrdenNta=2)
  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Sexo;<;[Alumnos]apellidos_y_nombres;>)
  //End case 
  //End if 
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)

USE NAMED SELECTION:C332("$complementos")
$l_RecNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_SintesisAnual:202]LLavePrimaria:5;->$t_Key)
