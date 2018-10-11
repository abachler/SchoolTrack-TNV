//%attributes = {}
  // MÉTODO: WIZ_ReplicaAsignaturas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 13/03/12, 15:10:48
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // WIZ_ReplicaAsignaturas()
  // ----------------------------------------------------
C_BLOB:C604($x_recNumArray)
C_LONGINT:C283($i;$iCursos;$l_IdCurso;$l_IdProcesoAvance;$l_nivelOrigen;$l_recNumCurso;$l_resultadoReplica)
C_TEXT:C284($t_abreviatura;$t_asignatura;$t_letraCurso;$t_nombreCurso;$t_refPropiedadesEvaluacion)

ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
ARRAY TEXT:C222($at_CursosDestino;0)
ARRAY TEXT:C222($at_LogEvents;0)

ARRAY TEXT:C222(at_CursoOrigen;0)
ARRAY TEXT:C222(at_Secciones;0)
ARRAY TEXT:C222(at_AsignaturasOrigen;0)
ARRAY LONGINT:C221(al_RecNumAsignaturasOrigen;0)
C_TEXT:C284(vt_secciones)




  // CODIGO PRINCIPAL
vt_secciones:=""

ON ERR CALL:C155("ERR_GenericOnError")

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_ReplicaConfigAsignaturas";1;8)
DIALOG:C40([xxSTR_Constants:1];"STR_ReplicaConfigAsignaturas")
CLOSE WINDOW:C154

If (OK=1)
	ARRAY TEXT:C222($at_LogEvents;0)
	$l_nivelOrigen:=<>al_NumeroNivelesActivos{<>at_NombreNivelesActivos}
	vt_CursoOrigen:=at_CursoOrigen{at_CursoOrigen}
	
	vt_secciones:=Replace string:C233(vt_secciones;" ";"")
	vt_secciones:=ST_ClearSpaces (vt_secciones)
	AT_Text2Array (->$at_CursosDestino;vt_secciones;",")
	
	CREATE EMPTY SET:C140([Cursos:3];"cursos")
	$t_abreviatura:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelOrigen;->[xxSTR_Niveles:6]Abreviatura:19)
	For ($i;1;Size of array:C274($at_CursosDestino))
		$t_letraCurso:=$at_CursosDestino{$i}
		$t_nombreCurso:=$t_abreviatura+"-"+$at_CursosDestino{$i}
		$l_recNumCurso:=KRL_FindAndLoadRecordByIndex (->[Cursos:3]Curso:1;->$t_nombreCurso)
		If ($l_recNumCurso<0)
			CREATE RECORD:C68([Cursos:3])
			[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
			[Cursos:3]Ciclo:5:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelOrigen;->[xxSTR_Niveles:6]Sección:9)
			[Cursos:3]Curso:1:=$t_nombreCurso
			[Cursos:3]Letra_del_curso:9:=$t_letraCurso
			[Cursos:3]Letra_Oficial_del_Curso:18:=$t_letraCurso
			[Cursos:3]Nivel_Nombre:10:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelOrigen;->[xxSTR_Niveles:6]Nivel:1)
			[Cursos:3]Nivel_Numero:7:=$l_nivelOrigen
			[Cursos:3]Nombre_Oficial_Curso:15:=[Cursos:3]Curso:1
			[Cursos:3]Nombre_Oficial_Nivel:14:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelOrigen;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
			SAVE RECORD:C53([Cursos:3])
			APPEND TO ARRAY:C911($at_LogEvents;"Creación del curso "+$t_nombreCurso+" en "+[Cursos:3]Nivel_Nombre:10)
		End if 
		$at_CursosDestino{$i}:=$t_nombreCurso
		ADD TO SET:C119([Cursos:3];"cursos")
	End for 
	CU_LoadArrays 
	
	For ($i;Size of array:C274(lb_Asignaturas);1;-1)
		If (Not:C34(lb_Asignaturas{$i}))
			DELETE FROM ARRAY:C228(al_RecNumAsignaturasOrigen;$i)
		End if 
	End for 
	
	CREATE EMPTY SET:C140([Asignaturas:18];"Replicas")
	
	$l_IdProcesoAvance:=IT_UThermometer (1;0;"Replicando asignaturas...")
	ARRAY TEXT:C222(at_PropiedadesEvalReplicadas;0)
	For ($iCursos;1;Size of array:C274($at_CursosDestino))
		$t_nombreCurso:=$at_CursosDestino{$iCursos}
		$l_IdCurso:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_nombreCurso;->[Cursos:3]Numero_del_curso:6)
		
		For ($i;1;Size of array:C274(al_RecNumAsignaturasOrigen))
			KRL_GotoRecord (->[Asignaturas:18];al_RecNumAsignaturasOrigen{$i})
			$t_asignatura:=[Asignaturas:18]Asignatura:3
			If ([Asignaturas:18]nivel_jerarquico:107=0)
				
				$t_asignatura:=[Asignaturas:18]Asignatura:3
				$l_nivelOrigen:=[Asignaturas:18]Numero_del_Nivel:6
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=;$t_asignatura;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Curso:5=$t_nombreCurso;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;$l_nivelOrigen)
				
				If (Records in selection:C76([Asignaturas:18])=1)
					$t_refPropiedadesEvaluacion:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)+"/@"
					QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$t_refPropiedadesEvaluacion)
					KRL_DeleteSelection (->[XShell_FatObjects:86];False:C215)
					$t_refPropiedadesEvaluacion:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)
					QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$t_refPropiedadesEvaluacion)
					KRL_DeleteSelection (->[XShell_FatObjects:86];False:C215)
				End if 
				$l_resultadoReplica:=AS_ReplicaAsignatura (al_RecNumAsignaturasOrigen{$i};$t_nombreCurso;$l_IdCurso)
				
			End if 
		End for 
	End for 
	$l_IdProcesoAvance:=IT_UThermometer (-2;$l_IdProcesoAvance)
	
	If (cb_InscribirAlumnos=1)
		USE SET:C118("cursos")
		KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNumAlumnos;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Inscribiendo alumnos en las asignaturas replicadas")
		For ($i;1;Size of array:C274($al_recNumAlumnos))
			READ WRITE:C146([Alumnos:2])
			GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$i})
			AL_CreateGradeRecords 
			SAVE RECORD:C53([Alumnos:2])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumAlumnos))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	If (cb_RecalcularPromedios=1)
		USE SET:C118("Replicas")
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignaturas;"")
		BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturas)
		EV2dbu_Recalculos ($x_recNumArray)
	End if 
	
	For ($i;1;Size of array:C274($at_LogEvents))
		LOG_RegisterEvt ($at_LogEvents{$i})
	End for 
	
	ARRAY TEXT:C222($at_LogEvents;0)
	ON ERR CALL:C155("")
End if 