//%attributes = {}
  //Metodo: dbu_SubAsg_A_Asignaturas
  //Por abachler
  //Creada el 06/02/2008, 18:29:01
  // ----------------------------------------------------
  // Descripción
  // Necesita una selección previa de asignaturas
  //
  // ----------------------------------------------------
  // Parámetros
  //
  // ----------------------------------------------------

C_LONGINT:C283($l_IdAsignatura;$l_IdAsignaturaMadre;$l_IdProfesor;$l_modoControles;$l_Nivel;$recNum;$sourceID)
C_REAL:C285($r_ponderacionControl;$r_valorSiControlInferior;$r_valorSiControlSuperor)
C_TEXT:C284($t_curso;$t_nombreAsignaturaHija;$t_nombreAsignaturaMadre;$t_nombreInternoAsignaturaHija;$t_nombreNivel;$t_NombrePropiedadesEvaluacion;$t_ordenamiento;$t_referenciaPeriodo)
C_LONGINT:C283($el;$i;$iColumnas;$iControles;$iperiodos;$iSubEvals)

ARRAY LONGINT:C221($al_IdAsignaturasHijas;0)
ARRAY LONGINT:C221($al_recordNumbers;0)

ARRAY TEXT:C222($at_NombreAsignaturasHijas;0)
ARRAY TEXT:C222($at_NombreImpresion;0)

  //CUERPO
PERIODOS_Init 
EVS_LoadStyles 

CREATE SET:C116([Asignaturas:18];"Universo")  //se utiliza la selección inicial

ALL RECORDS:C47([xxSTR_Subasignaturas:83])
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[xxSTR_Subasignaturas:83]ID_Mother:6;"")
CREATE SET:C116([Asignaturas:18];"conSubasignaturas")
INTERSECTION:C121("Universo";"conSubasignaturas";"Universo")
USE SET:C118("Universo")
SET_ClearSets ("Universo";"conSubasignaturas")
KRL_RelateSelection (->[xxSTR_Subasignaturas:83]ID_Mother:6;->[Asignaturas:18]Numero:1;"")
CREATE SET:C116([xxSTR_Subasignaturas:83];"SubAsignaturas_aEliminar")

  //START TRANSACTION
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recordNumbers;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Convirtiendo subasignaturas en asignaturas consolidables..."))
For ($i;1;Size of array:C274($al_recordNumbers))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recordNumbers))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$al_recordNumbers{$i})
	
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	If (Not:C34([Asignaturas:18]Consolidacion_PorPeriodo:58))
		$t_NombrePropiedadesEvaluacion:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)
		AS_PropEval_Lectura ($t_NombrePropiedadesEvaluacion)
		COPY ARRAY:C226(alAS_EvalPropSourceID;$al_IdAsignaturasHijas)
		COPY ARRAY:C226(atAS_EvalPropSourceName;$at_NombreAsignaturasHijas)
		COPY ARRAY:C226(atAS_EvalPropPrintName;$at_NombreImpresion)
	End if 
	
	For ($iperiodos;1;viSTR_Periodos_NumeroPeriodos)
		GOTO RECORD:C242([Asignaturas:18];$al_recordNumbers{$i})
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			  //MONO CAMBIO AS_PropEval_Lectura
			  //$t_NombrePropiedadesEvaluacion:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String($iPeriodos)
			$t_NombrePropiedadesEvaluacion:="P"+String:C10($iPeriodos)
			AS_PropEval_Lectura ($t_NombrePropiedadesEvaluacion)
			COPY ARRAY:C226(alAS_EvalPropSourceID;$al_IdAsignaturasHijas)
			COPY ARRAY:C226(atAS_EvalPropSourceName;$at_NombreAsignaturasHijas)
			COPY ARRAY:C226(atAS_EvalPropPrintName;$at_NombreImpresion)
		End if 
		EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$iperiodos)
		For ($iColumnas;1;12)
			GOTO RECORD:C242([Asignaturas:18];$al_recordNumbers{$i})
			$sourceID:=$al_IdAsignaturasHijas{$iColumnas}
			If ($sourceID<0)
				ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$iPeriodos;$iColumnas;False:C215)
				ASsev_UpdateList (Record number:C243([xxSTR_Subasignaturas:83]))
				ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
				
				$t_nombreAsignaturaHija:=$at_NombreAsignaturasHijas{$iColumnas}
				$t_nombreInternoAsignaturaHija:=$at_NombreImpresion{$iColumnas}
				$l_IdAsignaturaMadre:=[Asignaturas:18]Numero:1
				$t_nombreAsignaturaMadre:=[Asignaturas:18]Asignatura:3
				$t_curso:=[Asignaturas:18]Curso:5
				$l_Nivel:=[Asignaturas:18]Numero_del_Nivel:6
				$t_nombreNivel:=[Asignaturas:18]Nivel:30
				$l_IdProfesor:=[Asignaturas:18]profesor_numero:4
				$t_ordenamiento:=String:C10([Asignaturas:18]ordenGeneral:105;"00")
				EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$iperiodos)
				
				ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$iPeriodos;$iColumnas;False:C215)
				$l_modoControles:=[xxSTR_Subasignaturas:83]ModoControles:5
				$r_ponderacionControl:=[xxSTR_Subasignaturas:83]PonderacionControlInferior:8
				$r_valorSiControlInferior:=[xxSTR_Subasignaturas:83]ValorControlSiInferior:9
				$r_valorSiControlSuperor:=[xxSTR_Subasignaturas:83]ValorControlSiSuperior:10
				If ($l_modoControles=0)
					For ($iControles;1;Size of array:C274(aRealSubEvalControles))
						aRealSubEvalControles{$iControles}:=-10
					End for 
				End if 
				SORT ARRAY:C229(aSubEvalID;aSubEvalOrden;aRealSubEval1;aRealSubEval2;aRealSubEval3;aRealSubEval4;aRealSubEval5;aRealSubEval6;aRealSubEval7;aRealSubEval8;aRealSubEval9;aRealSubEval10;aRealSubEval11;aRealSubEval12;aRealSubEvalPresentacion;aRealSubEvalControles;aRealSubEvalP1;>)
				
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=$t_nombreAsignaturaHija;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Curso:5=$t_curso;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=$l_Nivel;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]profesor_numero:4=$l_IdProfesor;*)
				QUERY:C277([Asignaturas:18]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_IdAsignaturaMadre)
				SET AUTOMATIC RELATIONS:C310(False:C215)
				
				If (Records in selection:C76([Asignaturas:18])=0)
					GOTO RECORD:C242([Asignaturas:18];$al_recordNumbers{$i})
					DUPLICATE RECORD:C225([Asignaturas:18])
					[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
					[Asignaturas:18]Asignatura:3:=$t_nombreAsignaturaHija
					[Asignaturas:18]Curso:5:=$t_curso
					[Asignaturas:18]Numero_del_Nivel:6:=$l_Nivel
					[Asignaturas:18]profesor_numero:4:=$l_IdProfesor
					[Asignaturas:18]Asignatura_No_Oficial:71:=True:C214
					[Asignaturas:18]denominacion_interna:16:=$t_nombreInternoAsignaturaHija
					[Asignaturas:18]IncideEnPromedioInterno:64:=False:C215
					[Asignaturas:18]Incide_en_promedio:27:=False:C215
					[Asignaturas:18]En_InformesInternos:14:=True:C214
					[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 0
					[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 1
					[Asignaturas:18]Incluida_en_Actas:44:=False:C215
					[Asignaturas:18]Incide_en_Asistencia:45:=False:C215
					[Asignaturas:18]Abreviación:26:=""
					[Asignaturas:18]Codigo_interno:48:=""
					[Asignaturas:18]CHILE_CodigoMineduc:41:=""
					[Asignaturas:18]Consolidacion_Madre_nombre:8:=$t_nombreAsignaturaMadre
					[Asignaturas:18]Consolidacion_Madre_Id:7:=$l_IdAsignaturaMadre
					[Asignaturas:18]ordenGeneral:105:=$t_ordenamiento+"."+String:C10($iColumnas;"#00")
					[Asignaturas:18]Consolidacion_EsConsolidante:35:=False:C215
					[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=False:C215
					[Asignaturas:18]Numero_de_alumnos:49:=0
					[Asignaturas:18]LastNumber:54:=0
					[Asignaturas:18]auto_uuid:12:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					SAVE RECORD:C53([Asignaturas:18])
				End if 
				$l_IdAsignatura:=[Asignaturas:18]Numero:1
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				
				$t_referenciaPeriodo:=String:C10(aiSTR_Periodos_Numero{$iPeriodos})
				
				AScsd_LeeReferencias ([Asignaturas:18]Numero:1)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=;$l_IdAsignaturaMadre;*)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]Periodo:3;=;$t_referenciaPeriodo)
				If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
					CREATE RECORD:C68([Asignaturas_Consolidantes:231])
					[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=$l_IdAsignatura
					[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
					[Asignaturas_Consolidantes:231]Periodo:3:=$t_referenciaPeriodo
					[Asignaturas_Consolidantes:231]Name:2:=$t_nombreAsignaturaMadre
					SAVE RECORD:C53([Asignaturas_Consolidantes:231])
				End if 
				
				alAS_EvalPropSourceID{$iColumnas}:=[Asignaturas:18]Numero:1
				atAS_EvalPropSourceName{$iColumnas}:=[Asignaturas:18]Asignatura:3
				abAS_EvalPropPrintDetail{$iColumnas}:=False:C215
				
				For ($iSubEvals;1;Size of array:C274(aSubEvalID))
					$el:=Find in array:C230(aNtaIdAlumno;aSubEvalID{$iSubEvals})
					If ($el>0)
						READ WRITE:C146([Alumnos_Calificaciones:208])
						$recNum:=EV2_CargaRegistro (aSubEvalID{$iSubEvals};[Alumnos:2]numero:1)
						If ($recNum<0)
							CREATE RECORD:C68([Alumnos_Calificaciones:208])
							[Alumnos_Calificaciones:208]ID_institucion:2:=<>gInstitucion
							[Alumnos_Calificaciones:208]Año:3:=<>gYear
							[Alumnos_Calificaciones:208]ID_Alumno:6:=aNtaIdAlumno{$el}
							[Alumnos_Calificaciones:208]ID_Asignatura:5:=[Asignaturas:18]Numero:1
							[Alumnos_Calificaciones:208]NoDeLista:10:=aNtaOrden{$el}
							[Alumnos_Calificaciones:208]NombreOficialAsignatura:7:=[Asignaturas:18]Asignatura:3
							[Alumnos_Calificaciones:208]NIvel_Numero:4:=[Asignaturas:18]Numero_del_Nivel:6
							SAVE RECORD:C53([Alumnos_Calificaciones:208])
						End if 
					End if 
					Case of 
						: ($iperiodos=1)
							[Alumnos_Calificaciones:208]P01_Eval01_Real:42:=aRealSubEval1{$el}
							[Alumnos_Calificaciones:208]P01_Eval02_Real:47:=aRealSubEval2{$el}
							[Alumnos_Calificaciones:208]P01_Eval03_Real:52:=aRealSubEval3{$el}
							[Alumnos_Calificaciones:208]P01_Eval04_Real:57:=aRealSubEval4{$el}
							[Alumnos_Calificaciones:208]P01_Eval05_Real:62:=aRealSubEval5{$el}
							[Alumnos_Calificaciones:208]P01_Eval06_Real:67:=aRealSubEval6{$el}
							[Alumnos_Calificaciones:208]P01_Eval07_Real:72:=aRealSubEval7{$el}
							[Alumnos_Calificaciones:208]P01_Eval08_Real:77:=aRealSubEval8{$el}
							[Alumnos_Calificaciones:208]P01_Eval09_Real:82:=aRealSubEval9{$el}
							[Alumnos_Calificaciones:208]P01_Eval10_Real:87:=aRealSubEval10{$el}
							[Alumnos_Calificaciones:208]P01_Eval11_Real:92:=aRealSubEval11{$el}
							[Alumnos_Calificaciones:208]P01_Eval12_Real:97:=aRealSubEval12{$el}
							[Alumnos_Calificaciones:208]P01_Presentacion_Real:102:=aRealSubEvalPresentacion{$el}
							[Alumnos_Calificaciones:208]P01_Control_Real:107:=aRealSubEvalControles{$el}
							[Alumnos_Calificaciones:208]P01_Final_Real:112:=aRealSubEvalP1{$el}
							
							[Alumnos_Calificaciones:208]P01_Eval01_Nota:43:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval01_Real:42;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval01_Puntos:44:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval01_Real:42;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval01_Simbolo:45:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval01_Real:42)
							
							[Alumnos_Calificaciones:208]P01_Eval02_Nota:48:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval02_Real:47;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval02_Puntos:49:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval02_Real:47;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval02_Simbolo:50:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval02_Real:47)
							
							[Alumnos_Calificaciones:208]P01_Eval03_Nota:53:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval03_Real:52;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval03_Puntos:54:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval03_Real:52;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval03_Simbolo:55:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval03_Real:52)
							
							[Alumnos_Calificaciones:208]P01_Eval04_Nota:58:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval04_Real:57;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval04_Puntos:59:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval04_Real:57;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval04_Simbolo:60:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval04_Real:57)
							
							[Alumnos_Calificaciones:208]P01_Eval05_Nota:63:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval05_Real:62;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval05_Puntos:64:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval05_Real:62;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval05_Simbolo:65:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval05_Real:62)
							
							[Alumnos_Calificaciones:208]P01_Eval06_Nota:68:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval06_Real:67;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval06_Puntos:69:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval06_Real:67;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval06_Simbolo:70:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval06_Real:67)
							
							[Alumnos_Calificaciones:208]P01_Eval07_Nota:73:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval07_Real:72;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval07_Puntos:74:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval07_Real:72;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval07_Simbolo:75:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval07_Real:72)
							
							[Alumnos_Calificaciones:208]P01_Eval08_Nota:78:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval08_Real:77;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval08_Puntos:79:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval08_Real:77;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval08_Simbolo:80:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval08_Real:77)
							
							[Alumnos_Calificaciones:208]P01_Eval09_Nota:83:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval09_Real:82;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval09_Puntos:84:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval09_Real:82;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval09_Simbolo:85:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval09_Real:82)
							
							[Alumnos_Calificaciones:208]P01_Eval10_Nota:88:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval10_Real:87;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval10_Puntos:89:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval10_Real:87;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval10_Simbolo:90:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval10_Real:87)
							
							[Alumnos_Calificaciones:208]P01_Eval11_Nota:93:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval11_Real:92;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval11_Puntos:94:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval11_Real:92;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval11_Simbolo:95:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval11_Real:92)
							
							[Alumnos_Calificaciones:208]P01_Eval12_Nota:98:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Eval12_Real:97;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Eval12_Puntos:99:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Eval12_Real:97;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Eval12_Simbolo:100:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Eval12_Real:97)
							
							[Alumnos_Calificaciones:208]P01_Presentacion_Nota:103:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Presentacion_Puntos:104:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Presentacion_Simbolo:105:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Presentacion_Real:102)
							
							[Alumnos_Calificaciones:208]P01_Control_Nota:108:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Control_Real:107;0;iGradesDec)
							[Alumnos_Calificaciones:208]P01_Control_Puntos:109:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Control_Real:107;0;iPointsDec)
							[Alumnos_Calificaciones:208]P01_Control_Simbolo:110:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Control_Real:107)
							
							[Alumnos_Calificaciones:208]P01_Final_Nota:113:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P01_Final_Real:112;0;iGradesDecPP)
							[Alumnos_Calificaciones:208]P01_Final_Puntos:114:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P01_Final_Real:112;0;iPointsDecPP)
							[Alumnos_Calificaciones:208]P01_Final_Simbolo:115:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Final_Real:112)
							
						: ($iperiodos=2)
							[Alumnos_Calificaciones:208]P02_Eval01_Real:117:=aRealSubEval1{$el}
							[Alumnos_Calificaciones:208]P02_Eval02_Real:122:=aRealSubEval2{$el}
							[Alumnos_Calificaciones:208]P02_Eval03_Real:127:=aRealSubEval3{$el}
							[Alumnos_Calificaciones:208]P02_Eval04_Real:132:=aRealSubEval4{$el}
							[Alumnos_Calificaciones:208]P02_Eval05_Real:137:=aRealSubEval5{$el}
							[Alumnos_Calificaciones:208]P02_Eval06_Real:142:=aRealSubEval6{$el}
							[Alumnos_Calificaciones:208]P02_Eval07_Real:147:=aRealSubEval7{$el}
							[Alumnos_Calificaciones:208]P02_Eval08_Real:152:=aRealSubEval8{$el}
							[Alumnos_Calificaciones:208]P02_Eval09_Real:157:=aRealSubEval9{$el}
							[Alumnos_Calificaciones:208]P02_Eval10_Real:162:=aRealSubEval10{$el}
							[Alumnos_Calificaciones:208]P02_Eval11_Real:167:=aRealSubEval11{$el}
							[Alumnos_Calificaciones:208]P02_Eval12_Real:172:=aRealSubEval12{$el}
							[Alumnos_Calificaciones:208]P02_Presentacion_Real:177:=aRealSubEvalPresentacion{$el}
							[Alumnos_Calificaciones:208]P02_Control_Real:182:=aRealSubEvalControles{$el}
							[Alumnos_Calificaciones:208]P02_Final_Real:187:=aRealSubEvalP1{$el}
							
							[Alumnos_Calificaciones:208]P02_Eval01_Nota:118:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval01_Real:117;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval01_Puntos:119:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval01_Real:117;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval01_Simbolo:120:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval01_Real:117)
							
							[Alumnos_Calificaciones:208]P02_Eval02_Nota:123:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval02_Real:122;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval02_Puntos:124:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval02_Real:122;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval02_Simbolo:125:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval02_Real:122)
							
							[Alumnos_Calificaciones:208]P02_Eval03_Nota:128:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval03_Real:127;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval03_Puntos:129:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval03_Real:127;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval03_Simbolo:130:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval03_Real:127)
							
							[Alumnos_Calificaciones:208]P02_Eval04_Nota:133:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval04_Real:132;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval04_Puntos:134:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval04_Real:132;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval04_Simbolo:135:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval04_Real:132)
							
							[Alumnos_Calificaciones:208]P02_Eval05_Nota:138:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval05_Real:137;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval05_Puntos:139:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval05_Real:137;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval05_Simbolo:140:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval05_Real:137)
							
							[Alumnos_Calificaciones:208]P02_Eval06_Nota:143:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval06_Real:142;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval06_Puntos:144:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval06_Real:142;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval06_Simbolo:145:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval06_Real:142)
							
							[Alumnos_Calificaciones:208]P02_Eval07_Nota:148:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval07_Real:147;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval07_Puntos:149:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval07_Real:147;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval07_Simbolo:150:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval07_Real:147)
							
							[Alumnos_Calificaciones:208]P02_Eval08_Nota:153:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval08_Real:152;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval08_Puntos:154:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval08_Real:152;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval08_Simbolo:155:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval08_Real:152)
							
							[Alumnos_Calificaciones:208]P02_Eval09_Nota:158:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval09_Real:157;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval09_Puntos:159:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval09_Real:157;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval09_Simbolo:160:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval09_Real:157)
							
							[Alumnos_Calificaciones:208]P02_Eval10_Nota:163:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval10_Real:162;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval10_Puntos:164:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval10_Real:162;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval10_Simbolo:165:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval10_Real:162)
							
							[Alumnos_Calificaciones:208]P02_Eval11_Nota:168:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval11_Real:167;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval11_Puntos:169:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval11_Real:167;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval11_Simbolo:170:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval11_Real:167)
							
							[Alumnos_Calificaciones:208]P02_Eval12_Nota:173:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Eval12_Puntos:174:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Eval12_Real:172;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Eval12_Simbolo:175:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Eval12_Real:172)
							
							[Alumnos_Calificaciones:208]P02_Presentacion_Nota:178:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Presentacion_Puntos:179:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Presentacion_Simbolo:180:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Presentacion_Real:177)
							
							[Alumnos_Calificaciones:208]P02_Control_Nota:183:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Control_Real:182;0;iGradesDec)
							[Alumnos_Calificaciones:208]P02_Control_Puntos:184:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Control_Real:182;0;iPointsDec)
							[Alumnos_Calificaciones:208]P02_Control_Simbolo:185:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Control_Real:182)
							
							[Alumnos_Calificaciones:208]P02_Final_Nota:188:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P02_Final_Real:187;0;iGradesDecPP)
							[Alumnos_Calificaciones:208]P02_Final_Puntos:189:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P02_Final_Real:187;0;iPointsDecPP)
							[Alumnos_Calificaciones:208]P02_Final_Simbolo:190:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P02_Final_Real:187)
							
						: ($iperiodos=3)
							[Alumnos_Calificaciones:208]P03_Eval01_Real:192:=aRealSubEval1{$el}
							[Alumnos_Calificaciones:208]P03_Eval02_Real:197:=aRealSubEval2{$el}
							[Alumnos_Calificaciones:208]P03_Eval03_Real:202:=aRealSubEval3{$el}
							[Alumnos_Calificaciones:208]P03_Eval04_Real:207:=aRealSubEval4{$el}
							[Alumnos_Calificaciones:208]P03_Eval05_Real:212:=aRealSubEval5{$el}
							[Alumnos_Calificaciones:208]P03_Eval06_Real:217:=aRealSubEval6{$el}
							[Alumnos_Calificaciones:208]P03_Eval07_Real:222:=aRealSubEval7{$el}
							[Alumnos_Calificaciones:208]P03_Eval08_Real:227:=aRealSubEval8{$el}
							[Alumnos_Calificaciones:208]P03_Eval09_Real:232:=aRealSubEval9{$el}
							[Alumnos_Calificaciones:208]P03_Eval10_Real:237:=aRealSubEval10{$el}
							[Alumnos_Calificaciones:208]P03_Eval11_Real:242:=aRealSubEval11{$el}
							[Alumnos_Calificaciones:208]P03_Eval12_Real:247:=aRealSubEval12{$el}
							[Alumnos_Calificaciones:208]P03_Presentacion_Real:252:=aRealSubEvalPresentacion{$el}
							[Alumnos_Calificaciones:208]P03_Control_Real:257:=aRealSubEvalControles{$el}
							[Alumnos_Calificaciones:208]P03_Final_Real:262:=aRealSubEvalP1{$el}
							
							[Alumnos_Calificaciones:208]P03_Eval01_Nota:193:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval01_Real:192;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval01_Puntos:194:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval01_Real:192;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval01_Simbolo:195:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval01_Real:192)
							
							[Alumnos_Calificaciones:208]P03_Eval02_Nota:198:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval02_Real:197;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval02_Puntos:199:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval02_Real:197;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval02_Simbolo:200:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval02_Real:197)
							
							[Alumnos_Calificaciones:208]P03_Eval03_Nota:203:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval03_Real:202;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval03_Puntos:204:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval03_Real:202;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval03_Simbolo:205:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval03_Real:202)
							
							[Alumnos_Calificaciones:208]P03_Eval04_Nota:208:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval04_Real:207;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval04_Puntos:209:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval04_Real:207;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval04_Simbolo:210:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval04_Real:207)
							
							[Alumnos_Calificaciones:208]P03_Eval05_Nota:213:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval05_Real:212;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval05_Puntos:214:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval05_Real:212;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval05_Simbolo:215:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval05_Real:212)
							
							[Alumnos_Calificaciones:208]P03_Eval06_Nota:218:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval06_Real:217;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval06_Puntos:219:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval06_Real:217;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval06_Simbolo:220:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval06_Real:217)
							
							[Alumnos_Calificaciones:208]P03_Eval07_Nota:223:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval07_Real:222;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval07_Puntos:224:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval07_Real:222;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval07_Simbolo:225:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval07_Real:222)
							
							[Alumnos_Calificaciones:208]P03_Eval08_Nota:228:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval08_Real:227;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval08_Puntos:229:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval08_Real:227;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval08_Simbolo:230:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval08_Real:227)
							
							[Alumnos_Calificaciones:208]P03_Eval09_Nota:233:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval09_Real:232;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval09_Puntos:234:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval09_Real:232;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval09_Simbolo:235:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval09_Real:232)
							
							[Alumnos_Calificaciones:208]P03_Eval10_Nota:238:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval10_Real:237;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval10_Puntos:239:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval10_Real:237;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval10_Simbolo:240:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval10_Real:237)
							
							[Alumnos_Calificaciones:208]P03_Eval11_Nota:243:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval11_Real:242;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval11_Puntos:244:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval11_Real:242;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval11_Simbolo:245:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval11_Real:242)
							
							[Alumnos_Calificaciones:208]P03_Eval12_Nota:248:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Eval12_Real:247;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Eval12_Puntos:249:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Eval12_Real:247;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Eval12_Simbolo:250:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Eval12_Real:247)
							
							[Alumnos_Calificaciones:208]P03_Presentacion_Nota:253:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Presentacion_Puntos:254:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Presentacion_Simbolo:255:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Presentacion_Real:252)
							
							[Alumnos_Calificaciones:208]P03_Control_Nota:258:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Control_Real:257;0;iGradesDec)
							[Alumnos_Calificaciones:208]P03_Control_Puntos:259:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Control_Real:257;0;iPointsDec)
							[Alumnos_Calificaciones:208]P03_Control_Simbolo:260:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Control_Real:257)
							
							[Alumnos_Calificaciones:208]P03_Final_Nota:263:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P03_Final_Real:262;0;iGradesDecPP)
							[Alumnos_Calificaciones:208]P03_Final_Puntos:264:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P03_Final_Real:262;0;iPointsDecPP)
							[Alumnos_Calificaciones:208]P03_Final_Simbolo:265:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P03_Final_Real:262)
							
						: ($iperiodos=4)
							[Alumnos_Calificaciones:208]P04_Eval01_Real:267:=aRealSubEval1{$el}
							[Alumnos_Calificaciones:208]P04_Eval02_Real:272:=aRealSubEval2{$el}
							[Alumnos_Calificaciones:208]P04_Eval03_Real:277:=aRealSubEval3{$el}
							[Alumnos_Calificaciones:208]P04_Eval04_Real:282:=aRealSubEval4{$el}
							[Alumnos_Calificaciones:208]P04_Eval05_Real:287:=aRealSubEval5{$el}
							[Alumnos_Calificaciones:208]P04_Eval06_Real:292:=aRealSubEval6{$el}
							[Alumnos_Calificaciones:208]P04_Eval07_Real:297:=aRealSubEval7{$el}
							[Alumnos_Calificaciones:208]P04_Eval08_Real:302:=aRealSubEval8{$el}
							[Alumnos_Calificaciones:208]P04_Eval09_Real:307:=aRealSubEval9{$el}
							[Alumnos_Calificaciones:208]P04_Eval10_Real:312:=aRealSubEval10{$el}
							[Alumnos_Calificaciones:208]P04_Eval11_Real:317:=aRealSubEval11{$el}
							[Alumnos_Calificaciones:208]P04_Eval12_Real:322:=aRealSubEval12{$el}
							[Alumnos_Calificaciones:208]P04_Presentacion_Real:327:=aRealSubEvalPresentacion{$el}
							[Alumnos_Calificaciones:208]P04_Control_Real:332:=aRealSubEvalControles{$el}
							[Alumnos_Calificaciones:208]P04_Final_Real:337:=aRealSubEvalP1{$el}
							
							[Alumnos_Calificaciones:208]P04_Eval01_Nota:268:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval01_Real:267;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval01_Puntos:269:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval01_Real:267;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval01_Simbolo:270:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval01_Real:267)
							
							[Alumnos_Calificaciones:208]P04_Eval02_Nota:273:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval02_Real:272;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval02_Puntos:274:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval02_Real:272;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval02_Simbolo:275:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval02_Real:272)
							
							[Alumnos_Calificaciones:208]P04_Eval03_Nota:278:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval03_Real:277;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval03_Puntos:279:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval03_Real:277;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval03_Simbolo:280:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval03_Real:277)
							
							[Alumnos_Calificaciones:208]P04_Eval04_Nota:283:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval04_Real:282;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval04_Puntos:284:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval04_Real:282;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval04_Simbolo:285:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval04_Real:282)
							
							[Alumnos_Calificaciones:208]P04_Eval05_Nota:288:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval05_Real:287;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval05_Puntos:289:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval05_Real:287;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval05_Simbolo:290:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval05_Real:287)
							
							[Alumnos_Calificaciones:208]P04_Eval06_Nota:293:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval06_Real:292;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval06_Puntos:294:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval06_Real:292;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval06_Simbolo:295:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval06_Real:292)
							
							[Alumnos_Calificaciones:208]P04_Eval07_Nota:298:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval07_Real:297;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval07_Puntos:299:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval07_Real:297;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval07_Simbolo:300:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval07_Real:297)
							
							[Alumnos_Calificaciones:208]P04_Eval08_Nota:303:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval08_Real:302;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval08_Puntos:304:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval08_Real:302;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval08_Simbolo:305:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval08_Real:302)
							
							[Alumnos_Calificaciones:208]P04_Eval09_Nota:308:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval09_Real:307;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval09_Puntos:309:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval09_Real:307;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval09_Simbolo:310:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval09_Real:307)
							
							[Alumnos_Calificaciones:208]P04_Eval10_Nota:313:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval10_Real:312;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval10_Puntos:314:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval10_Real:312;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval10_Simbolo:315:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval10_Real:312)
							
							[Alumnos_Calificaciones:208]P04_Eval11_Nota:318:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval11_Real:317;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval11_Puntos:319:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval11_Real:317;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval11_Simbolo:320:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval11_Real:317)
							
							[Alumnos_Calificaciones:208]P04_Eval12_Nota:323:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Eval12_Real:322;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Eval12_Puntos:324:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Eval12_Real:322;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Eval12_Simbolo:325:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Eval12_Real:322)
							
							[Alumnos_Calificaciones:208]P04_Presentacion_Nota:328:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Presentacion_Puntos:329:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Presentacion_Simbolo:330:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Presentacion_Real:327)
							
							[Alumnos_Calificaciones:208]P04_Control_Nota:333:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Control_Real:332;0;iGradesDec)
							[Alumnos_Calificaciones:208]P04_Control_Puntos:334:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Control_Real:332;0;iPointsDec)
							[Alumnos_Calificaciones:208]P04_Control_Simbolo:335:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P04_Control_Real:332)
							
							[Alumnos_Calificaciones:208]P04_Final_Nota:338:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P04_Final_Real:337;0;iGradesDecPP)
							[Alumnos_Calificaciones:208]P04_Final_Puntos:339:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P04_Final_Real:337;0;iPointsDecPP)
							[Alumnos_Calificaciones:208]P04_Final_Simbolo:340:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P01_Final_Real:112)
							
						: ($iperiodos=5)
							[Alumnos_Calificaciones:208]P05_Eval01_Real:342:=aRealSubEval1{$el}
							[Alumnos_Calificaciones:208]P05_Eval02_Real:347:=aRealSubEval2{$el}
							[Alumnos_Calificaciones:208]P05_Eval03_Real:352:=aRealSubEval3{$el}
							[Alumnos_Calificaciones:208]P05_Eval04_Real:357:=aRealSubEval4{$el}
							[Alumnos_Calificaciones:208]P05_Eval05_Real:362:=aRealSubEval5{$el}
							[Alumnos_Calificaciones:208]P05_Eval06_Real:367:=aRealSubEval6{$el}
							[Alumnos_Calificaciones:208]P05_Eval07_Real:372:=aRealSubEval7{$el}
							[Alumnos_Calificaciones:208]P05_Eval08_Real:377:=aRealSubEval8{$el}
							[Alumnos_Calificaciones:208]P05_Eval09_Real:382:=aRealSubEval9{$el}
							[Alumnos_Calificaciones:208]P05_Eval10_Real:387:=aRealSubEval10{$el}
							[Alumnos_Calificaciones:208]P05_Eval11_Real:392:=aRealSubEval11{$el}
							[Alumnos_Calificaciones:208]P05_Eval12_Real:397:=aRealSubEval12{$el}
							[Alumnos_Calificaciones:208]P05_Presentacion_Real:402:=aRealSubEvalPresentacion{$el}
							[Alumnos_Calificaciones:208]P05_Control_Real:407:=aRealSubEvalControles{$el}
							[Alumnos_Calificaciones:208]P05_Final_Real:412:=aRealSubEvalP1{$el}
							
							[Alumnos_Calificaciones:208]P05_Eval01_Nota:343:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval01_Real:342;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval01_Puntos:344:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval01_Real:342;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval01_Simbolo:345:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval01_Real:342)
							
							[Alumnos_Calificaciones:208]P05_Eval02_Nota:348:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval02_Real:347;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval02_Puntos:349:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval02_Real:347;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval02_Simbolo:350:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval02_Real:347)
							
							[Alumnos_Calificaciones:208]P05_Eval03_Nota:353:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval03_Real:352;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval03_Puntos:354:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval03_Real:352;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval03_Simbolo:355:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval03_Real:352)
							
							[Alumnos_Calificaciones:208]P05_Eval04_Nota:358:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval04_Real:357;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval04_Puntos:359:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval04_Real:357;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval04_Simbolo:360:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval04_Real:357)
							
							[Alumnos_Calificaciones:208]P05_Eval05_Nota:363:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval05_Real:362;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval05_Puntos:364:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval05_Real:362;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval05_Simbolo:365:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval05_Real:362)
							
							[Alumnos_Calificaciones:208]P05_Eval06_Nota:368:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval06_Real:367;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval06_Puntos:369:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval06_Real:367;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval06_Simbolo:370:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval06_Real:367)
							
							[Alumnos_Calificaciones:208]P05_Eval07_Nota:373:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval07_Real:372;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval07_Puntos:374:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval07_Real:372;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval07_Simbolo:375:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval07_Real:372)
							
							[Alumnos_Calificaciones:208]P05_Eval08_Nota:378:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval08_Real:377;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval08_Puntos:379:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval08_Real:377;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval08_Simbolo:380:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval08_Real:377)
							
							[Alumnos_Calificaciones:208]P05_Eval09_Nota:383:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval09_Real:382;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval09_Puntos:384:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval09_Real:382;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval09_Simbolo:385:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval09_Real:382)
							
							[Alumnos_Calificaciones:208]P05_Eval10_Nota:388:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval10_Real:387;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval10_Puntos:389:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval10_Real:387;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval10_Simbolo:390:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval10_Real:387)
							
							[Alumnos_Calificaciones:208]P05_Eval11_Nota:393:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval11_Real:392;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval11_Puntos:394:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval11_Real:392;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval11_Simbolo:395:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval11_Real:392)
							
							[Alumnos_Calificaciones:208]P05_Eval12_Nota:398:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Eval12_Puntos:399:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Eval12_Real:397;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Eval12_Simbolo:400:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Eval12_Real:397)
							
							[Alumnos_Calificaciones:208]P05_Presentacion_Nota:403:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Presentacion_Puntos:404:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Presentacion_Simbolo:405:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Presentacion_Real:402)
							
							[Alumnos_Calificaciones:208]P05_Control_Nota:408:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Control_Real:407;0;iGradesDec)
							[Alumnos_Calificaciones:208]P05_Control_Puntos:409:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Control_Real:407;0;iPointsDec)
							[Alumnos_Calificaciones:208]P05_Control_Simbolo:410:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Control_Real:407)
							
							[Alumnos_Calificaciones:208]P05_Final_Nota:413:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]P05_Final_Real:412;0;iGradesDecPP)
							[Alumnos_Calificaciones:208]P05_Final_Puntos:414:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]P05_Final_Real:412;0;iPointsDecPP)
							[Alumnos_Calificaciones:208]P05_Final_Simbolo:415:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]P05_Final_Real:412)
					End case 
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
				End for 
				GOTO RECORD:C242([Asignaturas:18];$al_recordNumbers{$i})
				EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$iperiodos)
			End if 
		End for 
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			AS_PropEval_Escritura ($iperiodos)
		End if 
		
	End for 
	If (Not:C34([Asignaturas:18]Consolidacion_PorPeriodo:58))
		AS_PropEval_Escritura (0)
	End if 
	
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

USE SET:C118("SubAsignaturas_aEliminar")
KRL_DeleteSelection (->[xxSTR_Subasignaturas:83])

  //CANCEL TRANSACTION
