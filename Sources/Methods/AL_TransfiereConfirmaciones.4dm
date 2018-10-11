//%attributes = {}
C_POINTER:C301($1)

C_BOOLEAN:C305($b_nivelDestinoEsSubAnual;$b_nivelOrigenEsSubAnual;$b_transferir)
C_LONGINT:C283($i;$l_evaluaciones;$l_evaluacionesAprendizaje;$l_idAlumno;$l_mensajes;$l_nivelDestino;$l_nivelOrigen;$l_subasignaturasDestino;$l_subasignaturasOrigen;$l_transferidos)
C_TEXT:C284($t_confirmacion;$t_cursoDestino;$t_cursoOrigen;$t_mensaje;$t_nivelDestinoNombre;$t_nivelOrigenNombre;$t_titulo)

ARRAY LONGINT:C221($al_idAlumnosDestino;0)
ARRAY LONGINT:C221($al_idAlumnosOrigen;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_mensajes;0)

COPY ARRAY:C226($1->;$al_idAlumnosOrigen)

$t_cursoOrigen:=$2
$t_cursoDestino:=$3

ARRAY TEXT:C222($atSTR_CursoOrigen;0)
ARRAY TEXT:C222($atSTR_CursoDestino;0)
QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$atSTR_CursoOrigen;[Cursos:3]Curso:1;$atSTR_CursoDestino)

INSERT IN ARRAY:C227($atSTR_CursoDestino;Size of array:C274($atSTR_CursoDestino)+1;3)
$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-2}:="Admisión"
$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-1}:="Retirados"
$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)}:="Egresados"

ARRAY TEXT:C222($at_preguntas;0)
ARRAY BOOLEAN:C223($ab_necesitarespuesta;0)

Case of 
	: ($t_cursoDestino=$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-1})
		APPEND TO ARRAY:C911($at_preguntas;"Los alumnos retirados perderán toda la información del año académico actual.")
		APPEND TO ARRAY:C911($ab_necesitarespuesta;False:C215)
	: ($t_cursoDestino=$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)})
		APPEND TO ARRAY:C911($at_preguntas;"Los alumnos egresados manualmente no conservarán el histórico de este año.")
		APPEND TO ARRAY:C911($ab_necesitarespuesta;False:C215)
	Else 
		READ ONLY:C145([Alumnos:2])
		
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_cursoDestino)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_idAlumnosDestino)
		
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_evaluacionesAprendizaje)
		QUERY WITH ARRAY:C644([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;$al_idAlumnosOrigen)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([xxSTR_Subasignaturas:83])
		QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID_Alumno:6;$al_idAlumnosOrigen)
		
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas)
		REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_subasignaturasOrigen)
		QUERY WITH ARRAY:C644([xxSTR_Subasignaturas:83]ID_Mother:6;$al_IdAsignaturas)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID_Alumno:6;$al_idAlumnosDestino)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas)
		REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_subasignaturasDestino)
		QUERY WITH ARRAY:C644([xxSTR_Subasignaturas:83]ID_Mother:6;$al_IdAsignaturas)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID_Alumno:6;$al_idAlumnosOrigen)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_evaluaciones)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If ($l_evaluaciones>0)
			APPEND TO ARRAY:C911($at_preguntas;"Las evaluaciones registradas solo se transferirán a las asignaturas del curso de destino si su nombre oficial e interno es estrictamente igual al nombre oficial e interno de la asignatura de origen.")
			APPEND TO ARRAY:C911($ab_necesitarespuesta;False:C215)
		End if 
		
		If ($l_evaluacionesAprendizaje>0)
			APPEND TO ARRAY:C911($at_preguntas;"Las evaluaciones de aprendizajes esperados solo serán conservadas en las asignaturas del curso de destino si las matrices de evaluación son las mismas que las utilizadas en las asignaturas del curso de origen.")
			APPEND TO ARRAY:C911($ab_necesitarespuesta;False:C215)
		End if 
		
		If ($l_subasignaturasOrigen>0)
			APPEND TO ARRAY:C911($at_preguntas;"El detalle de las evaluaciones en las subasignaturas no será transferido. Solo se transfieren los promedios de las subasignaturas")
			APPEND TO ARRAY:C911($ab_necesitarespuesta;False:C215)
		End if 
		
		If ($l_subasignaturasDestino>0)
			APPEND TO ARRAY:C911($at_preguntas;"Si alguna de las evaluaciones parciales de una asignatura está configurada como subasignatura en la asignatura de destino, esa evaluación será inscrita en esa subasignatura")
			APPEND TO ARRAY:C911($ab_necesitarespuesta;False:C215)
		End if 
End case 

Case of 
	: ($t_cursoOrigen=$atSTR_CursoOrigen{Size of array:C274($atSTR_CursoOrigen)-2})  //admision
		$l_nivelOrigen:=Nivel_AdmisionDirecta
		$t_nivelOrigenNombre:="Admisión"
		$b_nivelOrigenEsSubAnual:=False:C215
	: ($t_cursoOrigen=$atSTR_CursoOrigen{Size of array:C274($atSTR_CursoOrigen)-1})  //retirados
		$l_nivelOrigen:=Nivel_Retirados
		$t_nivelOrigenNombre:="Retirados"
		$b_nivelOrigenEsSubAnual:=False:C215
	: ($t_cursoOrigen=$atSTR_CursoOrigen{Size of array:C274($atSTR_CursoOrigen)})  //egresados
		$l_nivelOrigen:=Nivel_Egresados
		$t_nivelOrigenNombre:="Egresados"
		$b_nivelOrigenEsSubAnual:=False:C215
	Else 
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoOrigen)
		$l_nivelOrigen:=[Cursos:3]Nivel_Numero:7
		$t_nivelOrigenNombre:=[Cursos:3]Nivel_Nombre:10
		$b_nivelOrigenEsSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelOrigen;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
End case 
<>vl_srcClass:=Record number:C243([Cursos:3])


Case of 
	: ($t_cursoDestino=$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-2})  //admision
		$l_nivelDestino:=Nivel_AdmisionDirecta
		$t_nivelDestinoNombre:="Admisión"
		$b_nivelDestinoEsSubAnual:=False:C215
	: ($t_cursoDestino=$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-1})  //retirados
		$l_nivelDestino:=Nivel_Retirados
		$t_nivelDestinoNombre:="Retirados"
		$b_nivelDestinoEsSubAnual:=False:C215
	: ($t_cursoDestino=$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)})  //egresados
		$l_nivelDestino:=Nivel_Egresados
		$t_nivelDestinoNombre:="Egresados"
		$b_nivelDestinoEsSubAnual:=False:C215
	Else 
		READ WRITE:C146([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoDestino)
		$l_nivelDestino:=[Cursos:3]Nivel_Numero:7
		$t_nivelDestinoNombre:=[Cursos:3]Nivel_Nombre:10
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
		<>vl_dstClass:=Record number:C243([Cursos:3])
		ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;<)
		[Cursos:3]Numero_de_Alumnos:11:=Records in selection:C76([Alumnos:2])
		[Cursos:3]LastNumber:12:=[Alumnos:2]no_de_lista:53
		SAVE RECORD:C53([Cursos:3])
		KRL_ReloadAsReadOnly (->[Cursos:3])
		$b_nivelDestinoEsSubAnual:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelDestino;->[xxSTR_Niveles:6]Es_Nivel_SubAnual:50)
End case 

APPEND TO ARRAY:C911($at_preguntas;"En caso de que algunos alumnos no puedan ser transferidos por estar siendo utilizados por otros usuarios, ¿desea registrar sólo las transferencias exitosas? Si la respuesta es no se cancelará el proceso completo.")
APPEND TO ARRAY:C911($ab_necesitarespuesta;True:C214)
Case of 
	: ((($l_nivelDestino-$l_nivelOrigen)=-1) & ($b_nivelDestinoEsSubAnual))  //El nivel de destino es inmediatamente inferior al nivel de origen y éste es un nivel subanual
		APPEND TO ARRAY:C911($at_preguntas;"Los alumnos seleccionados pueden haber cursado "+$t_nivelDestinoNombre+". La información de "+$t_nivelOrigenNombre+" será eliminada, pero se mantendrá la información que pudiese haber sido registrada en "+$t_nivelDestinoNombre+". ¿Está seguro que desea transferir los alumnos seleccionados a "+$t_cursoDestino+"?")
		APPEND TO ARRAY:C911($ab_necesitarespuesta;True:C214)
	: ((($l_nivelDestino-$l_nivelOrigen)=1) & ($b_nivelOrigenEsSubAnual))  //El nivel de destino es inmediatamente superior al nivel de origen y éste es un nivel subanual
		APPEND TO ARRAY:C911($at_preguntas;"El nivel académico de destino es consecutivo al nivel actual y se permite a los alumnos del nivel actual cursar dos o más niveles en el mismo ciclo anual. ¿Está seguro que desea transferir los alumnos seleccionados a "+$t_cursoDestino+"?")
		APPEND TO ARRAY:C911($ab_necesitarespuesta;True:C214)
	: (($l_nivelOrigen#$l_nivelDestino) & ($l_nivelOrigen>-1000))
		APPEND TO ARRAY:C911($at_preguntas;"¿Está seguro que desea transferir los alumnos seleccionados a un nivel académico distinto del que se encuentra actualmente? Al hacer esta transferencia se perderán definitivamente las evaluaciones registradas para estos alumnos en las asignaturas "+"cursadas en "+$t_nivelOrigenNombre+".")
		APPEND TO ARRAY:C911($ab_necesitarespuesta;True:C214)
	Else 
		APPEND TO ARRAY:C911($at_preguntas;"¿Desea continuar con el proceso?")
		APPEND TO ARRAY:C911($ab_necesitarespuesta;True:C214)
End case 
C_OBJECT:C1216($obj)
OB SET ARRAY:C1227($obj;"mensajes";$at_preguntas)
OB SET ARRAY:C1227($obj;"requiererespuesta";$ab_necesitarespuesta)
$0:=JSON Stringify:C1217($obj)