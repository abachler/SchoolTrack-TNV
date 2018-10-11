//%attributes = {}
  // AL_TransfiereSeleccion()
  //
  //
  // creado por: Alberto Bachler Klein: 01-12-16, 10:36:11
  // -----------------------------------------------------------
C_POINTER:C301($1)

C_BOOLEAN:C305($b_nivelDestinoEsSubAnual;$b_nivelOrigenEsSubAnual;$b_transferir)
C_LONGINT:C283($i;$l_evaluaciones;$l_evaluacionesAprendizaje;$l_idAlumno;$l_mensajes;$l_nivelDestino;$l_nivelOrigen;$l_subasignaturasDestino;$l_subasignaturasOrigen;$l_transferidos)
C_TEXT:C284($t_confirmacion;$t_cursoDestino;$t_cursoOrigen;$t_mensaje;$t_nivelDestinoNombre;$t_nivelOrigenNombre;$t_titulo)

ARRAY LONGINT:C221($al_idAlumnosDestino;0)
ARRAY LONGINT:C221($al_idAlumnosOrigen;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_mensajes;0)



If (False:C215)
	C_POINTER:C301(AL_TransfiereSeleccion ;$1)
End if 

COPY ARRAY:C226($1->;$al_idAlumnosOrigen)

$t_cursoOrigen:=atSTR_CursoOrigen{atSTR_CursoOrigen}
$t_cursoDestino:=atSTR_CursoDestino{atSTR_CursoDestino}


Case of 
	: (atSTR_CursoDestino=(Size of array:C274(atSTR_CursoDestino)-1))
		$t_mensaje:=__ ("Los alumnos retirados perderán toda la información del año académico actual.\r\r¿Desea Ud. continuar?")
		$b_transferir:=(ModernUI_Notificacion (__ ("Retiro de alumnos");$t_mensaje;__ ("No");__ ("Continuar"))=2)
		
	: (atSTR_CursoDestino=(Size of array:C274(atSTR_CursoDestino)))
		$t_mensaje:=__ ("Los alumnos egresados manualmente no conservarán el histórico de este año.\r\r¿Desea Ud. continuar?")
		$b_transferir:=(ModernUI_Notificacion (__ ("Egreso de alumnos");$t_mensaje;__ ("No");__ ("Continuar"))=2)
		
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
		
		
		
		$t_titulo:=__ ("Usted se apresta a transferir los alumnos seleccionados desde ^0 a ^1.")
		$t_titulo:=Replace string:C233($t_titulo;"^0";$t_cursoOrigen)
		$t_titulo:=Replace string:C233($t_titulo;"^1";$t_cursoDestino)
		
		$l_mensajes:=0
		If ($l_evaluaciones>0)
			APPEND TO ARRAY:C911($at_mensajes;__ ("Las evaluaciones registradas solo se transferirán a las asignaturas del curso de destino si su nombre oficial e interno es estrictamente igual al nombre oficial e interno de la asignatura de origen."))
		End if 
		
		If ($l_evaluacionesAprendizaje>0)
			APPEND TO ARRAY:C911($at_mensajes;__ ("Las evaluaciones de aprendizajes esperados solo serán conservadas en las asignaturas del curso de destino si las matrices de evaluación son las mismas que las utilizadas en las asignaturas del curso de origen."))
		End if 
		
		If ($l_subasignaturasOrigen>0)
			APPEND TO ARRAY:C911($at_mensajes;__ ("El detalle de las evaluaciones en las sub-asignaturas no será transferido. Solo se transfieren los promedios de las sub-asignaturas"))
		End if 
		
		If ($l_subasignaturasDestino>0)
			APPEND TO ARRAY:C911($at_mensajes;__ ("Si alguna de las evaluaciones parciales de una asignatura está configurada como subasignatura en la asignatura de destino, esa evaluación será inscrita en esa sub-asignatura"))
		End if 
		
		$t_mensaje:=""
		Case of 
			: (Size of array:C274($at_mensajes)=0)
				$t_mensaje:=""
			: (Size of array:C274($at_mensajes)=1)
				$t_mensaje:=$at_mensajes{1}
				
			: (Size of array:C274($at_mensajes)>1)
				$t_titulo:=$t_titulo+"\r\r"+__ ("Tenga en consideración que: ")
				For ($i;1;Size of array:C274($at_mensajes))
					$t_mensaje:=$t_mensaje+"• "+$at_mensajes{$i}+"\r\r"
				End for 
		End case 
		
		If ($t_mensaje#"")
			$t_confirmacion:=__ ("¿Desea continuar con las transferencia de estos alumnos?")
			IT_SetTextStyle_Bold (->$t_confirmacion)
			IT_SetTextSize (->$t_confirmacion;13)
			$b_transferir:=(ModernUI_Notificacion ($t_titulo;$t_mensaje+"\r\r"+$t_confirmacion;__ ("No");__ ("Continuar"))=2)
		Else 
			$b_transferir:=True:C214
		End if 
		
End case 



If ($b_transferir)
	$t_cursoOrigen:=atSTR_CursoOrigen{atSTR_CursoOrigen}
	$t_cursoDestino:=atSTR_CursoDestino{atSTR_CursoDestino}
	
	Case of 
		: (atSTR_CursoOrigen=(Size of array:C274(atSTR_CursoOrigen)-2))  //admision
			$l_nivelOrigen:=Nivel_AdmisionDirecta
			$t_nivelOrigenNombre:="Admisión"
			$b_nivelOrigenEsSubAnual:=False:C215
		: (atSTR_CursoOrigen=(Size of array:C274(atSTR_CursoOrigen)-1))  //retirados
			$l_nivelOrigen:=Nivel_Retirados
			$t_nivelOrigenNombre:="Retirados"
			$b_nivelOrigenEsSubAnual:=False:C215
		: (atSTR_CursoOrigen=Size of array:C274(atSTR_CursoOrigen))  //egresados
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
		: (atSTR_CursoDestino=(Size of array:C274(atSTR_CursoDestino)-2))  //admision
			$l_nivelDestino:=Nivel_AdmisionDirecta
			$t_nivelDestinoNombre:="Admisión"
			$b_nivelDestinoEsSubAnual:=False:C215
		: (atSTR_CursoDestino=(Size of array:C274(atSTR_CursoDestino)-1))  //retirados
			$l_nivelDestino:=Nivel_Retirados
			$t_nivelDestinoNombre:="Retirados"
			$b_nivelDestinoEsSubAnual:=False:C215
		: (atSTR_CursoDestino=Size of array:C274(atSTR_CursoDestino))  //egresados
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
	
	
	Case of 
		: ((($l_nivelDestino-$l_nivelOrigen)=-1) & ($b_nivelDestinoEsSubAnual))  //El nivel de destino es inmediatamente inferior al nivel de origen y éste es un nivel subanual
			OK:=CD_Dlog (0;__ ("Los alumnos seleccionados pueden haber cursado ")+$t_nivelDestinoNombre+__ (".\r\rLa información de ")+$t_nivelOrigenNombre+__ (" será eliminada pero se mantendrá la información que pudiese haber sido registrada en ")+$t_nivelDestinoNombre+__ (".\r\r¿Está seguro que desea transferir los alumnos seleccionados a ")+atSTR_CursoDestino{atSTR_CursoDestino}+__ ("?");__ ("");__ ("Continuar");__ ("Cancelar"))
			
		: ((($l_nivelDestino-$l_nivelOrigen)=1) & ($b_nivelOrigenEsSubAnual))  //El nivel de destino es inmediatamente superior al nivel de origen y éste es un nivel subanual
			OK:=CD_Dlog (0;__ ("El nivel académico de destino es consecutivo al nivel actual y se permite a los alumnos del nivel actual cursar dos o más niveles en el mismo ciclo anual.\r\r¿Está seguro que desea transferir los alumnos seleccionados a ")+atSTR_CursoDestino{atSTR_CursoDestino}+__ ("?");__ ("");__ ("Continuar");__ ("Cancelar"))
			
		: (($l_nivelOrigen#$l_nivelDestino) & ($l_nivelOrigen>-1000))
			OK:=CD_Dlog (0;__ ("¿Está seguro que desea transferir los alumnos seleccionados a un nivel académico distinto del que se encuentra actualmente?\r\rAl hacer esta transferencia se perderán definitivamente las evaluaciones registradas para estos alumnos en las asignaturas"+" "+"cursadas en ")+$t_nivelOrigenNombre;__ ("");__ ("Aceptar");__ ("Cancelar"))
		Else 
			OK:=1
	End case 
	
	If (OK=1)
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
		
		
		START TRANSACTION:C239
		
		C_LONGINT:C283($l_correctas)  //20180608 RCH 
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
			$l_correctas:=$l_correctas+$l_transferidos
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		READ ONLY:C145([Alumnos:2])  //RCH 20100927 Quedaba un registro de alumno cargado...
		  //If ($l_transferidos=1)
		If ($l_correctas=Size of array:C274($al_idAlumnosOrigen))
			If ($l_nivelOrigen#$l_nivelDestino)
				vb_ReasignaNoFolio_co:=True:C214
			End if 
			READ WRITE:C146([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoOrigen)
			  //$l_nivelDestino:=[Cursos]Nivel_Numero
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;<)
			[Cursos:3]Numero_de_Alumnos:11:=Records in selection:C76([Alumnos:2])
			[Cursos:3]LastNumber:12:=[Alumnos:2]no_de_lista:53
			SAVE RECORD:C53([Cursos:3])
			KRL_ReloadAsReadOnly (->[Cursos:3])
			VALIDATE TRANSACTION:C240
		Else 
			If ($l_correctas>0)
				OK:=CD_Dlog (0;__ ("Uno o mas alumnos no pudieron ser transferidos  debido a que algunos registros estaban siendo utilizados por otros usuarios.\rPuede registrar las transferencias exitosas o cancelar todo.\r¿Desea registrar las transferencias exitosas?");__ ("");__ ("Sí");__ ("No"))
				If (ok=1)
					If ($l_nivelOrigen#$l_nivelDestino)
						vb_ReasignaNoFolio_co:=True:C214
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
					CANCEL TRANSACTION:C241
				End if 
			Else 
				CANCEL TRANSACTION:C241
				CD_Dlog (0;"Alumno(s) no transferido(s).")
			End if 
		End if 
		
		SET_ClearSets ("AsignaturasDestino";"AsignaturasOrigen")
		
		
		AL_UpdateArrays (xALP_Trans1;0)
		AL_UpdateArrays (xALP_Trans2;0)
		Case of 
			: ($l_nivelDestino=Nivel_Egresados)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Egresados)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
			: ($l_nivelDestino=Nivel_Retirados)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Retirados)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
			: ($l_nivelDestino=Nivel_AdmisionDirecta)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
			Else 
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_cursoDestino)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aPlantel)
		End case 
		AL_UpdateArrays (xALP_Trans2;-2)
		
		
		Case of 
			: ($l_nivelOrigen=Nivel_Egresados)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Egresados)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
			: ($l_nivelOrigen=Nivel_Retirados)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_Retirados)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
			: ($l_nivelOrigen=Nivel_AdmisionDirecta)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;=;Nivel_AdmisionDirecta)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
			: (atSTR_CursoOrigen>1)
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_cursoOrigen)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID;[Alumnos:2]Situacion_final:33;<>aStatPromo)
		End case 
		AL_UpdateArrays (xALP_Trans1;-2)
	End if 
End if 

