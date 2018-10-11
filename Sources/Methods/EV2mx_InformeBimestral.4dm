//%attributes = {}
  //EV2mx_InformeBimestral

Case of 
	: ($1="Inicio")
		C_LONGINT:C283($recNumCalificaciones;vl_recnumAlumno;vPeriodo;vRowNumber;viCountSector;viCountSectorP1;viCountSectorP2;viCountSectorP3;viCountSectorP4;viCountSectorP5;viCountSectorF)
		C_REAL:C285(vrCumuloSector;vr_PromedioSector;vrCumuloSectorP1;vrCumuloSectorP2;vrCumuloSectorP3;vrCumuloSectorP4;vrCumuloSectorP5;vr_PromedioSectorP1;vr_PromedioSectorP2;vr_PromedioSectorP3;vr_PromedioSectorP4;vr_PromedioSectorP5;vr_PromedioSectorF)
		C_TEXT:C284(vtUltimoSector;vs_PromedioSector;vs_PromedioSectorP1;vs_PromedioSectorP2;vs_PromedioSectorP3;vs_PromedioSectorP4;vs_PromedioSectorP5;vs_PromedioSectorF)
		
		vl_recnumAlumno:=Record number:C243([Alumnos:2])
		  //PERIODOS_LoadData ([Alumnos]Nivel_Número)
		  //SELECT LIST ITEMS BY POSITION(hl_MesesSel;Month of(adSTR_Periodos_Desde{vPeriodo}))
		  //vi_SelectedMonth:=Selected list items(hl_MesesSel)
		  //GET LIST ITEM(hl_MesesSel;*;vi_NumeroMes;vt_NombreMes)
		
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9#"@Disciplina@")
		ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		COPY NAMED SELECTION:C331([Alumnos_Calificaciones:208];"todas")
		  //SELECTION TO ARRAY([Alumnos_Calificaciones];$recNums;[Asignaturas]Denominación_interna;$aAsignaturas;[Asignaturas]Sector;$aSector)
		QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]Sector:9#"@Disciplina@")
		ORDER BY:C49([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		  //ARRAY TEXT(aQR_Text1;Records in selection([Alumnos_Calificaciones]))
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		
		EV2_ObtieneDatosPeriodoActual 
		
		vRowNumber:=0
		vGrupo:="Académico"
		vrCumuloSector:=0
		viCountSector:=0
		vrCumuloSectorP1:=0
		viCountSectorP1:=0
		vrCumuloSectorP2:=0
		viCountSectorP2:=0
		vrCumuloSectorP3:=0
		viCountSectorP3:=0
		vrCumuloSectorP4:=0
		viCountSectorP4:=0
		vrCumuloSectorP5:=0
		viCountSectorP5:=0
		vrCumuloSectorF:=0
		viCountSectorF:=0
		vtUltimoSector:=""
		
	: ($1="Cuerpo")
		vRowNumber:=vRowNumber+1
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		EV2_ObtieneDatosPeriodoActual 
		If (vtUltimoSector#[Asignaturas:18]Sector:9)
			vr_PromedioSector:=Round:C94(vrCumuloSector/viCountSector;iGradesDec)
			vs_PromedioSector:=String:C10(vr_PromedioSector;vs_GradesFormat)
			vr_PromedioSectorP1:=Round:C94(vrCumuloSectorP1/viCountSectorP1;iGradesDec)
			vs_PromedioSectorP1:=String:C10(vr_PromedioSectorP1;vs_GradesFormat)
			vr_PromedioSectorP2:=Round:C94(vrCumuloSectorP2/viCountSectorP2;iGradesDec)
			vs_PromedioSectorP2:=String:C10(vr_PromedioSectorP2;vs_GradesFormat)
			vr_PromedioSectorP3:=Round:C94(vrCumuloSectorP3/viCountSectorP3;iGradesDec)
			vs_PromedioSectorP3:=String:C10(vr_PromedioSectorP3;vs_GradesFormat)
			vr_PromedioSectorP4:=Round:C94(vrCumuloSectorP4/viCountSectorP4;iGradesDec)
			vs_PromedioSectorP4:=String:C10(vr_PromedioSectorP4;vs_GradesFormat)
			vr_PromedioSectorP5:=Round:C94(vrCumuloSectorP5/viCountSectorP5;iGradesDec)
			vs_PromedioSectorP5:=String:C10(vr_PromedioSectorP5;vs_GradesFormat)
			vr_PromedioSectorF:=Round:C94(vrCumuloSectorF/viCountSectorF;iGradesDec)
			vs_PromedioSectorF:=String:C10(vr_PromedioSectorF;vs_GradesFormat)
			vtUltimoSector:=[Asignaturas:18]Sector:9
			vrCumuloSector:=0
			viCountSector:=0
			vrCumuloSectorP1:=0
			viCountSectorP1:=0
			vrCumuloSectorP2:=0
			viCountSectorP2:=0
			vrCumuloSectorP3:=0
			viCountSectorP3:=0
			vrCumuloSectorP4:=0
			viCountSectorP4:=0
			vrCumuloSectorP5:=0
			viCountSectorP5:=0
			vrCumuloSectorF:=0
			viCountSectorF:=0
		End if 
		
		If ([Asignaturas:18]IncideEnPromedioInterno:64)
			If ([Alumnos_Calificaciones:208]PeriodoActual_Final_Nota:488>=rGradesFrom)
				vrCumuloSector:=vrCumuloSector+[Alumnos_Calificaciones:208]PeriodoActual_Final_Nota:488
				viCountSector:=viCountSector+1
			End if 
			If ([Alumnos_Calificaciones:208]P01_Final_Nota:113>=rGradesFrom)
				vrCumuloSectorP1:=vrCumuloSectorP1+[Alumnos_Calificaciones:208]P01_Final_Nota:113
				viCountSectorP1:=viCountSectorP1+1
			End if 
			If ([Alumnos_Calificaciones:208]P02_Final_Nota:188>=rGradesFrom)
				vrCumuloSectorP2:=vrCumuloSectorP2+[Alumnos_Calificaciones:208]P02_Final_Nota:188
				viCountSectorP2:=viCountSectorP2+1
			End if 
			If ([Alumnos_Calificaciones:208]P03_Final_Nota:263>=rGradesFrom)
				vrCumuloSectorP3:=vrCumuloSectorP3+[Alumnos_Calificaciones:208]P03_Final_Nota:263
				viCountSectorP3:=viCountSectorP3+1
			End if 
			If ([Alumnos_Calificaciones:208]P04_Final_Nota:338>=rGradesFrom)
				vrCumuloSectorP4:=vrCumuloSectorP4+[Alumnos_Calificaciones:208]P04_Final_Nota:338
				viCountSectorP4:=viCountSectorP4+1
			End if 
			If ([Alumnos_Calificaciones:208]P05_Final_Nota:413>=rGradesFrom)
				vrCumuloSectorP5:=vrCumuloSectorP5+[Alumnos_Calificaciones:208]P05_Final_Nota:413
				viCountSectorP5:=viCountSectorP5+1
			End if 
			If ([Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27>=rGradesFrom)
				vrCumuloSectorF:=vrCumuloSectorF+[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
				viCountSectorF:=viCountSectorF+1
			End if 
		End if 
		
		
		If (Selected record number:C246([Alumnos_Calificaciones:208])=Records in selection:C76([Alumnos_Calificaciones:208]))
			vr_PromedioSector:=Round:C94(vrCumuloSector/viCountSector;iGradesDec)
			vs_PromedioSector:=String:C10(vr_PromedioSector;vs_GradesFormat)
			vr_PromedioSectorP1:=Round:C94(vrCumuloSectorP1/viCountSectorP1;iGradesDec)
			vs_PromedioSectorP1:=String:C10(vr_PromedioSectorP1;vs_GradesFormat)
			vr_PromedioSectorP2:=Round:C94(vrCumuloSectorP2/viCountSectorP2;iGradesDec)
			vs_PromedioSectorP2:=String:C10(vr_PromedioSectorP2;vs_GradesFormat)
			vr_PromedioSectorP3:=Round:C94(vrCumuloSectorP3/viCountSectorP3;iGradesDec)
			vs_PromedioSectorP3:=String:C10(vr_PromedioSectorP3;vs_GradesFormat)
			vr_PromedioSectorP4:=Round:C94(vrCumuloSectorP4/viCountSectorP4;iGradesDec)
			vs_PromedioSectorP4:=String:C10(vr_PromedioSectorP4;vs_GradesFormat)
			vr_PromedioSectorP5:=Round:C94(vrCumuloSectorP5/viCountSectorP5;iGradesDec)
			vs_PromedioSectorP5:=String:C10(vr_PromedioSectorP5;vs_GradesFormat)
			vr_PromedioSectorF:=Round:C94(vrCumuloSectorF/viCountSectorF;iGradesDec)
			vs_PromedioSectorF:=String:C10(vr_PromedioSectorF;vs_GradesFormat)
		End if 
		
	: ($1="Total")
		C_LONGINT:C283($recNumCalificaciones;vl_recnumAlumno;vPeriodo)
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Asignatura:3="Disciplina")
		$recNumCalificaciones:=Record number:C243([Alumnos_Calificaciones:208])
		RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
		AS_PropEval_Lectura ("";vPeriodo)
		QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->alAS_EvalPropSourceID)
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]Sector:9;>;[Asignaturas:18]ordenGeneral:105;>)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		Case of 
			: (vPeriodo=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Literal:116;aQR_Text1;[Alumnos_Calificaciones:208]P01_Eval02_Literal:51;aQR_Text2;[Alumnos_Calificaciones:208]P01_Eval03_Literal:56;aQR_Text3;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
			: (vPeriodo=2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Final_Literal:191;aQR_Text1;[Alumnos_Calificaciones:208]P02_Eval02_Literal:126;aQR_Text2;[Alumnos_Calificaciones:208]P02_Eval03_Literal:131;aQR_Text3;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
			: (vPeriodo=3)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Final_Literal:266;aQR_Text1;[Alumnos_Calificaciones:208]P03_Eval02_Literal:201;aQR_Text2;[Alumnos_Calificaciones:208]P03_Eval03_Literal:206;aQR_Text3;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
			: (vPeriodo=4)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Final_Literal:341;aQR_Text1;[Alumnos_Calificaciones:208]P04_Eval02_Literal:276;aQR_Text2;[Alumnos_Calificaciones:208]P04_Eval03_Literal:281;aQR_Text3;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
			: (vPeriodo=5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Final_Literal:416;aQR_Text1;[Alumnos_Calificaciones:208]P05_Eval02_Literal:351;aQR_Text2;[Alumnos_Calificaciones:208]P05_Eval03_Literal:356;aQR_Text3;[Asignaturas:18]Asignatura:3;aComponentesDisciplina)
		End case 
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Literal:116;aQR_Text11;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aQR_Text12;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aQR_Text13;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aQR_Text14;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aQR_Text15;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aQR_Text20)
		
		
		GOTO RECORD:C242([Alumnos:2];vl_recnumAlumno)
		If ($recNumCalificaciones>0)
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$recNumCalificaciones)
		End if 
		EV2_ObtieneDatosPeriodoActual 
		
	: ($1="Fin")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		
End case 

