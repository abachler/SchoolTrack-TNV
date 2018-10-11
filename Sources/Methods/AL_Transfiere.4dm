//%attributes = {}
C_POINTER:C301($1;$4)
C_TEXT:C284($0)
C_BOOLEAN:C305($b_nivelDestinoEsSubAnual;$b_nivelOrigenEsSubAnual;$b_transferir;$vb_ReasignaNoFolio_co)
C_LONGINT:C283($i;$l_evaluaciones;$l_evaluacionesAprendizaje;$l_idAlumno;$l_mensajes;$l_nivelDestino;$l_nivelOrigen;$l_subasignaturasDestino;$l_subasignaturasOrigen;$l_transferidos)
C_TEXT:C284($t_confirmacion;$t_cursoDestino;$t_cursoOrigen;$t_mensaje;$t_nivelDestinoNombre;$t_nivelOrigenNombre;$t_titulo)

ARRAY LONGINT:C221($al_idAlumnosDestino;0)
ARRAY LONGINT:C221($al_idAlumnosOrigen;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_mensajes;0)
ARRAY BOOLEAN:C223($ab_respuestas;0)

C_OBJECT:C1216($obj)



COPY ARRAY:C226($1->;$al_idAlumnosOrigen)

$t_cursoOrigen:=$2
$t_cursoDestino:=$3

ARRAY BOOLEAN:C223($ab_respuestas;Size of array:C274($4->))
For ($i;1;Size of array:C274($4->))
	$ab_respuestas{$i}:=($4->{$i}="true")
End for 

If ($ab_respuestas{Size of array:C274($ab_respuestas)})
	ARRAY TEXT:C222($atSTR_CursoOrigen;0)
	ARRAY TEXT:C222($atSTR_CursoDestino;0)
	QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$atSTR_CursoOrigen;[Cursos:3]Curso:1;$atSTR_CursoDestino)
	
	INSERT IN ARRAY:C227($atSTR_CursoDestino;Size of array:C274($atSTR_CursoDestino)+1;3)
	$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-2}:="Admisión"
	$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)-1}:="Retirados"
	$atSTR_CursoDestino{Size of array:C274($atSTR_CursoDestino)}:="Egresados"
	
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_cursoOrigen;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion:17=False:C215)
	CREATE SET:C116([Asignaturas:18];"AsignaturasOrigen")
	
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$al_recNums{$i})
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10;<)
		[Asignaturas:18]Numero_de_alumnos:49:=Records in selection:C76([Alumnos_Calificaciones:208])
		[Asignaturas:18]LastNumber:54:=[Alumnos_Calificaciones:208]NoDeLista:10
		SAVE RECORD:C53([Asignaturas:18])
		KRL_UnloadReadOnly (->[Asignaturas:18])
	End for 
	
	
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_cursoDestino;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Consolidacion_Madre_Id:7=0;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]nivel_jerarquico:107=0;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Seleccion:17=False:C215;*)
	QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Electiva:11=False:C215)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion:17=False:C215)
	CREATE SET:C116([Asignaturas:18];"AsignaturasDestino")
	
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNums;"")
	For ($i;1;Size of array:C274($al_recNums))
		READ WRITE:C146([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$al_recNums{$i})
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10;<)
		[Asignaturas:18]Numero_de_alumnos:49:=Records in selection:C76([Alumnos_Calificaciones:208])
		[Asignaturas:18]LastNumber:54:=[Alumnos_Calificaciones:208]NoDeLista:10
		SAVE RECORD:C53([Asignaturas:18])
		KRL_UnloadReadOnly (->[Asignaturas:18])
	End for 
	
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
	
	START TRANSACTION:C239
	C_LONGINT:C283($l_counter)
	ARRAY TEXT:C222($at_failedTransfers;0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Transfiriendo los alumnos seleccionados desde ")+$t_cursoOrigen+__ (" a ")+$t_cursoDestino)
	For ($i;1;Size of array:C274($al_idAlumnosOrigen))
		$l_idAlumno:=$al_idAlumnosOrigen{$i}
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno;True:C214)
		If (OK=1)
			$l_transferidos:=AL_Transfert ($t_cursoOrigen;$t_cursoDestino;$l_nivelOrigen;$l_nivelDestino)
		Else 
			$l_transferidos:=0
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_idAlumnosOrigen))
		$l_counter:=$l_counter+$l_transferidos
		If ($l_transferidos=0)
			APPEND TO ARRAY:C911($at_failedTransfers;Util_MakeUUIDCanonical (KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]auto_uuid:72)))
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	$transactionValidated:=True:C214
	READ ONLY:C145([Alumnos:2])
	If ($l_counter=Size of array:C274($al_idAlumnosOrigen))
		If ($l_nivelOrigen#$l_nivelDestino)
			$vb_ReasignaNoFolio_co:=True:C214
		End if 
		READ WRITE:C146([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoOrigen)
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;<)
		[Cursos:3]Numero_de_Alumnos:11:=Records in selection:C76([Alumnos:2])
		[Cursos:3]LastNumber:12:=[Alumnos:2]no_de_lista:53
		SAVE RECORD:C53([Cursos:3])
		KRL_ReloadAsReadOnly (->[Cursos:3])
		VALIDATE TRANSACTION:C240
	Else 
		If ($ab_respuestas{Size of array:C274($ab_respuestas)-1})
			If ($l_nivelOrigen#$l_nivelDestino)
				$vb_ReasignaNoFolio_co:=True:C214
			End if 
			READ WRITE:C146([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoOrigen)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;<)
			[Cursos:3]Numero_de_Alumnos:11:=Records in selection:C76([Alumnos:2])
			[Cursos:3]LastNumber:12:=[Alumnos:2]no_de_lista:53
			SAVE RECORD:C53([Cursos:3])
			KRL_ReloadAsReadOnly (->[Cursos:3])
			VALIDATE TRANSACTION:C240
		Else 
			$transactionValidated:=False:C215
			CANCEL TRANSACTION:C241
		End if 
	End if 
	If ($vb_ReasignaNoFolio_co)
		If (<>vtXS_CountryCode="co")
			BM_CreateRequest ("co-AsignaNumerosDeFolio")
		End if 
	End if 
	SET_ClearSets ("AsignaturasDestino";"AsignaturasOrigen")
	If ($transactionValidated)
		OB SET:C1220($obj;"error";"0")
		OB SET:C1220($obj;"mensaje";"")
		OB SET ARRAY:C1227($obj;"fallos";$at_failedTransfers)
		$0:=JSON Stringify:C1217($obj)
	Else 
		OB SET:C1220($obj;"error";"-3")
		OB SET:C1220($obj;"mensaje";"Cancelado por el usuario")
		$0:=JSON Stringify:C1217($obj)
	End if 
Else 
	OB SET:C1220($obj;"error";"-3")
	OB SET:C1220($obj;"mensaje";"Cancelado por el usuario")
	$0:=JSON Stringify:C1217($obj)
End if 