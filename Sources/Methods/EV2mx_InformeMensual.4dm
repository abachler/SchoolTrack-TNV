//%attributes = {}
  //EV2mx_InformeMensual


C_REAL:C285(vr_PromedioAcademico;vrCumuloGeneral;vr_PromedioDisciplina;vr_PromedioGeneral;vr_PromedioSector;vrNota;vrCumuloSector)
C_TEXT:C284(vs_PromedioSector;vs_PromedioGeneral;vs_PromedioDisciplina;vtUltimoSector;vs_Nota)
C_LONGINT:C283(vl_recnumAlumno;hl_MesesSel;viCountSector)

Case of 
	: ($1="Inicio")
		vl_recnumAlumno:=Record number:C243([Alumnos:2])
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		hl_MesesSel:=AT_Array2List (-><>atXS_MonthNames)
		
		SELECT LIST ITEMS BY POSITION:C381(hl_MesesSel;Month of:C24(adSTR_Periodos_Desde{vPeriodo}))
		vi_SelectedMonth:=Selected list items:C379(hl_MesesSel)
		GET LIST ITEM:C378(hl_MesesSel;*;vi_NumeroMes;vt_NombreMes)
		
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9#"@Disciplina@")
		ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		COPY NAMED SELECTION:C331([Alumnos_Calificaciones:208];"todas")
		  //SELECTION TO ARRAY([Alumnos_Calificaciones];$recNums;[Asignaturas]Denominación_interna;$aAsignaturas;[Asignaturas]Sector;$aSector)
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]Sector:9#"@Disciplina@")
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		
		EV2_ObtieneDatosPeriodoActual 
		
		vRowNumber:=0
		  //vGrupo:="Académico"
		vrCumuloSector:=0
		viCountSector:=0
		vrCumuloGeneral:=0
		viCountGeneral:=0
		vtUltimoSector:=""
		vrNota:=0
		vs_Nota:=""
		
		
	: ($1="Cuerpo")
		C_LONGINT:C283($selectedRecord)
		vRowNumber:=vRowNumber+1
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		EV2_ObtieneDatosPeriodoActual 
		If (vtUltimoSector#[Asignaturas:18]Sector:9)
			vr_PromedioSector:=Round:C94(vrCumuloSector/viCountSector;iGradesDec)
			vs_PromedioSector:=String:C10(vr_PromedioSector;vs_GradesFormat)
			vtUltimoSector:=[Asignaturas:18]Sector:9
			vrCumuloSector:=0
			viCountSector:=0
		End if 
		
		
		If ([Asignaturas:18]nivel_jerarquico:107=0)
			If ([Asignaturas:18]Consolidacion_EsConsolidante:35)
				$selectedRecord:=Selected record number:C246([Alumnos_Calificaciones:208])
				ARRAY REAL:C219(aQR_Real1;0)
				AS_PropEval_Lectura ("";vPeriodo)
				QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->alAS_EvalPropSourceID;True:C214)
				Case of 
					: (vPeriodo=1)
						$fieldPointer:=->[Alumnos_Calificaciones:208]P01_Eval01_Nota:43
					: (vPeriodo=2)
						$fieldPointer:=->[Alumnos_Calificaciones:208]P02_Eval01_Nota:118
					: (vPeriodo=3)
						$fieldPointer:=->[Alumnos_Calificaciones:208]P03_Eval01_Nota:193
					: (vPeriodo=4)
						$fieldPointer:=->[Alumnos_Calificaciones:208]P04_Eval01_Nota:268
					: (vPeriodo=5)
						$fieldPointer:=->[Alumnos_Calificaciones:208]P05_Eval01_Nota:343
				End case 
				
				SELECTION TO ARRAY:C260($fieldPointer->;aQR_Real1)
				USE NAMED SELECTION:C332("todas")
				GOTO SELECTED RECORD:C245([Alumnos_Calificaciones:208];$selectedRecord)
				RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
				$promedio:=Round:C94(AT_Mean (->aQR_Real1;3);2)
				If ($promedio>=rGradesFrom)
					[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418:=$promedio
				Else 
					[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418:=-10
				End if 
				
				
			End if 
			If ([Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418>=rGradesFrom)
				Case of 
					: ([Asignaturas:18]IncideEnPromedioInterno:64)
						vrCumuloGeneral:=vrCumuloGeneral+[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418
						viCountGeneral:=viCountGeneral+1
						vrCumuloSector:=vrCumuloSector+[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418
						viCountSector:=viCountSector+1
				End case 
			End if 
			vrNota:=[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418
		Else 
			vrNota:=[Alumnos_Calificaciones:208]PeriodoActual_Eval01_Nota:418
		End if 
		If (vrNota>=rGradesFrom)
			vs_Nota:=String:C10(vrNota;vs_GradesFormat)
		Else 
			vs_Nota:=""
		End if 
		
		If (Selected record number:C246([Alumnos_Calificaciones:208])=Records in selection:C76([Alumnos_Calificaciones:208]))
			vr_PromedioSector:=Round:C94(vrCumuloSector/viCountSector;iGradesDec)
			vs_PromedioSector:=String:C10(vr_PromedioSector;vs_GradesFormat)
		End if 
		
	: ($1="Total")
		
		
		C_REAL:C285($promedio)
		vr_PromedioAcademico:=Round:C94(vrCumuloGeneral/viCountGeneral;iGradesDec)
		vs_PromedioAcademico:=String:C10(vr_PromedioAcademico;vs_GradesFormat)
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Asignatura:3="Disciplina")
		CREATE SET:C116([Alumnos_Calificaciones:208];"Disciplina")
		RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
		AS_PropEval_Lectura ("";vPeriodo)
		QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->alAS_EvalPropSourceID)
		If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
			GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
			ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			Case of 
				: (vPeriodo=1)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Nota:43;aQR_Real1;[Alumnos_Calificaciones:208]P01_Eval01_Literal:46;aQR_Text1;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
				: (vPeriodo=2)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Nota:118;aQR_Real1;[Alumnos_Calificaciones:208]P02_Eval01_Literal:121;aQR_Text1;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
				: (vPeriodo=3)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Nota:193;aQR_Real1;[Alumnos_Calificaciones:208]P03_Eval01_Literal:196;aQR_Text1;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
				: (vPeriodo=4)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Nota:268;aQR_Real1;[Alumnos_Calificaciones:208]P04_Eval01_Literal:271;aQR_Text1;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
				: (vPeriodo=5)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Nota:343;aQR_Real1;[Alumnos_Calificaciones:208]P05_Eval01_Literal:346;aQR_Text1;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
			End case 
			$promedio:=Round:C94(AT_Mean (->aQR_Real1;3);iGradesDec)
		Else 
			USE SET:C118("Disciplina")
			CLEAR SET:C117("Disciplina")
			Case of 
				: (vPeriodo=1)
					$promedio:=[Alumnos_Calificaciones:208]P01_Eval01_Nota:43
				: (vPeriodo=2)
					$promedio:=[Alumnos_Calificaciones:208]P02_Eval01_Nota:118
				: (vPeriodo=3)
					$promedio:=[Alumnos_Calificaciones:208]P03_Eval01_Nota:193
				: (vPeriodo=4)
					$promedio:=[Alumnos_Calificaciones:208]P04_Eval01_Nota:268
				: (vPeriodo=5)
					$promedio:=[Alumnos_Calificaciones:208]P05_Eval01_Nota:343
			End case 
		End if 
		If ($promedio>rGradesFrom)
			vr_PromedioDisciplina:=$promedio
			vs_PromedioDisciplina:=String:C10(vr_PromedioDisciplina;vs_GradesFormat)
		Else 
			vr_PromedioDisciplina:=-10
			vs_PromedioDisciplina:=""
		End if 
		Case of 
			: ((vr_PromedioDisciplina>=rGradesFrom) & (vr_PromedioAcademico>=rGradesFrom))
				vr_PromedioGeneral:=Round:C94((vrCumuloGeneral+vr_PromedioDisciplina)/(viCountGeneral+1);iGradesDec)
				vs_PromedioGeneral:=String:C10(vr_PromedioGeneral;vs_GradesFormat)
			: ((vr_PromedioDisciplina<rGradesFrom) & (vr_PromedioAcademico>=rGradesFrom))
				vr_PromedioGeneral:=vr_PromedioAcademico
				vs_PromedioGeneral:=String:C10(vr_PromedioGeneral;vs_GradesFormat)
			: ((vr_PromedioDisciplina>=rGradesFrom) & (vr_PromedioAcademico<rGradesFrom))
				vr_PromedioGeneral:=vr_PromedioDisciplina
				vs_PromedioGeneral:=String:C10(vr_PromedioGeneral;vs_GradesFormat)
			Else 
				vr_PromedioGeneral:=-10
				vs_PromedioGeneral:=""
		End case 
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		
		
	: ($1="Fin")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		
End case 

