//%attributes = {}
  //AL_LoadHNotas


ARRAY TEXT:C222(aHAsig;0)
ARRAY TEXT:C222(aHNota1;0)
ARRAY TEXT:C222(aHNota2;0)
ARRAY TEXT:C222(aHNota3;0)
ARRAY TEXT:C222(aHNota4;0)
ARRAY TEXT:C222(aHPF;0)
ARRAY TEXT:C222(aHEx;0)
ARRAY TEXT:C222(aHNF;0)
ARRAY INTEGER:C220(aHorder;0)
ARRAY LONGINT:C221(aHID;0)
ARRAY TEXT:C222($at_EncabezadosEliminar;0)

AL_UpdateArrays (xALP_HNotasECursos;0)
ALP_RemoveAllArrays (xALP_HNotasECursos)

PERIODOS_LeeDatosHistoricos (vl_NivelSeleccionado_Historico;vl_Year_Historico)
If ((vl_NivelSeleccionado_Historico#0) & (vl_Year_Historico>0))
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;vl_NivelSeleccionado_Historico;vl_Year_Historico)
End if 
$recNumSintesisAnual:=Record number:C243([Alumnos_SintesisAnual:210])

  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
C_OBJECT:C1216($ob_displayEvalGralCol)
C_TEXT:C284($t_colNamePA;$t_colNameEX;$t_colNameEXX;$t_colNameNF;$t_colNameNO)
LOC_ObjNombreColumnasEval ("consultar";->$ob_displayEvalGralCol;[Alumnos_SintesisAnual:210]NumeroNivel:6)

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493#0;*)
If (bSoloOficiales=1)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Incluida_En_Actas:7=True:C214;*)
End if 
If (bSoloPromediables=1)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas_Historico:84]Promediable:6=True:C214;*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"";*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"X";*)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36#"EX";*)
End if 
QUERY SELECTION:C341([Alumnos_Calificaciones:208])

ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]OrdenGeneral:42;>;[Asignaturas_Historico:84]Nombre_interno:3;>)
$sortColumn:=14
$error:=0

Case of 
	: (atSTR_ModoCalificaciones=1)
		If (bNombreAsignaturasH=1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Asignatura:2;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf)
		Else 
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Nombre_interno:3;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Literal:116;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Literal:191;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Literal:266;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Literal:341;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Literal:416;aNtaP5;[Alumnos_Calificaciones:208]Anual_Literal:15;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Literal:20;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Literal:25;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;aNtaOf)
		End if 
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;1;1;"at_OrdenAsignaturas")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;2;1;"aNtaAsignatura")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;3;1;"aNtaP1")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;4;1;"aNtaP2")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;5;1;"aNtaP3")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;6;1;"aNtaP4")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;7;1;"aNtaP5")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;8;1;"aNtaPF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;9;1;"aNtaEX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;10;1;"aNtaEXX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;11;1;"aNtaF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;12;1;"aNtaOF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;13;1;"aReprobada")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;14;1;"aNtaRecNum")
		For ($i;3;12)
			AL_SetFormat (xALP_HNotasECursos;$i;"";2)
		End for 
		
		
	: (atSTR_ModoCalificaciones=2)
		If (bNombreAsignaturasH=1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Asignatura:2;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Nota:113;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Nota:12;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Nota:17;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Nota:22;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;aRealNtaOf)
		Else 
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Nombre_interno:3;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Nota:113;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Nota:12;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Nota:17;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Nota:22;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;aRealNtaOf)
		End if 
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;1;1;"at_OrdenAsignaturas")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;2;1;"aNtaAsignatura")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;3;1;"aRealNtaP1")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;4;1;"aRealNtaP2")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;5;1;"aRealNtaP3")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;6;1;"aRealNtaP4")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;7;1;"aRealNtaP5")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;8;1;"aRealNtaPF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;9;1;"aRealNtaEX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;10;1;"aRealNtaEXX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;11;1;"aRealNtaF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;12;1;"aRealNtaOF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;13;1;"aReprobada")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;14;1;"aNtaRecNum")
		For ($i;3;12)
			AL_SetFormat (xALP_HNotasECursos;$i;"###0"+<>tXS_RS_DecimalSeparator+"00;;";2)
		End for 
		
	: (atSTR_ModoCalificaciones=3)
		If (bNombreAsignaturasH=1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Asignatura:2;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Puntos:114;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Puntos:13;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;aRealNtaOf)
		Else 
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Nombre_interno:3;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Puntos:114;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Puntos:13;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;aRealNtaOf)
		End if 
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;1;1;"at_OrdenAsignaturas")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;2;1;"aNtaAsignatura")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;3;1;"aRealNtaP1")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;4;1;"aRealNtaP2")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;5;1;"aRealNtaP3")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;6;1;"aRealNtaP4")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;7;1;"aRealNtaP5")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;8;1;"aRealNtaPF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;9;1;"aRealNtaEX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;10;1;"aRealNtaEXX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;11;1;"aRealNtaF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;12;1;"aRealNtaOF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;13;1;"aReprobada")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;14;1;"aNtaRecNum")
		For ($i;3;12)
			AL_SetFormat (xALP_HNotasECursos;$i;"###0"+<>tXS_RS_DecimalSeparator+"00;;";2)
		End for 
		
		
	: (atSTR_ModoCalificaciones=4)
		If (bNombreAsignaturasH=1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Asignatura:2;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Simbolo:115;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Simbolo:190;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Simbolo:265;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Simbolo:340;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Simbolo:415;aNtaP5;[Alumnos_Calificaciones:208]Anual_Simbolo:14;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;aNtaOf)
		Else 
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Nombre_interno:3;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Simbolo:115;aNtaP1;[Alumnos_Calificaciones:208]P02_Final_Simbolo:190;aNtaP2;[Alumnos_Calificaciones:208]P03_Final_Simbolo:265;aNtaP3;[Alumnos_Calificaciones:208]P04_Final_Simbolo:340;aNtaP4;[Alumnos_Calificaciones:208]P05_Final_Simbolo:415;aNtaP5;[Alumnos_Calificaciones:208]Anual_Simbolo:14;aNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19;aNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24;aNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;aNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;aNtaOf)
		End if 
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;1;1;"at_OrdenAsignaturas")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;2;1;"aNtaAsignatura")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;3;1;"aNtaP1")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;4;1;"aNtaP2")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;5;1;"aNtaP3")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;6;1;"aNtaP4")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;7;1;"aNtaP5")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;8;1;"aNtaPF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;9;1;"aNtaEX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;10;1;"aNtaEXX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;11;1;"aNtaF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;12;1;"aNtaOF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;13;1;"aReprobada")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;14;1;"aNtaRecNum")
		For ($i;3;12)
			AL_SetFormat (xALP_HNotasECursos;$i;"";2)
		End for 
		
	: (atSTR_ModoCalificaciones=5)
		If (bNombreAsignaturasH=1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Asignatura:2;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Real:112;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Real:11;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Real:21;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOf)
		Else 
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Asignaturas_Historico:84]ID_RegistroHistorico:1;aHId;[Asignaturas_Historico:84]Nombre_interno:3;aNtaAsignatura;[Asignaturas_Historico:84]OrdenGeneral:42;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]Reprobada:9;aReprobada;[Alumnos_Calificaciones:208]P01_Final_Real:112;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Real:11;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealNtaEX;[Alumnos_Calificaciones:208]ExamenExtra_Real:21;aRealNtaEXX;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOf)
		End if 
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;1;1;"at_OrdenAsignaturas")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;2;1;"aNtaAsignatura")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;3;1;"aRealNtaP1")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;4;1;"aRealNtaP2")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;5;1;"aRealNtaP3")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;6;1;"aRealNtaP4")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;7;1;"aRealNtaP5")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;8;1;"aRealNtaPF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;9;1;"aRealNtaEX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;10;1;"aRealNtaEXX")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;11;1;"aRealNtaF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;12;1;"aRealNtaOF")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;13;1;"aReprobada")
		$error:=$error+AL_SetArraysNam (xALP_HNotasECursos;14;1;"aNtaRecNum")
		For ($i;3;12)
			AL_SetFormat (xALP_HNotasECursos;$i;"###0"+<>tXS_RS_DecimalSeparator+"0;;";1)
		End for 
		
End case 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

  //ABC193894 
  //bloqueo todas las columnas,.
For ($i;1;14)
	AL_SetEnterable (xALP_HNotasECursos;$i;0)
End for 

AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_TraceOnError;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_Compatibility;0)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_MinHdrHeight;90)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_MinRowHeight;20)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_HeaderMode;1)
AL_SetAreaRealProperty (xALP_HNotasECursos;ALP_Area_HdrIndentV;10)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_UserSort;0)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_EntryClick;2)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ClickDelay;8)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_EntryAllowArrows;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_EntryMapEnter;2)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ShowSortIndicator;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_DrawFrame;0)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ShowColDividers;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ShowRowDividers;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ColDivColor;0xFFEEEEEE)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_RowDivColor;0xFFEEEEEE)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ColumnLock;0)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_ColumnResize;0)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_SmallScrollbar;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_AltRowOptions;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_SelMultiple;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_SelPreserve;1)
AL_SetAreaLongProperty (xALP_HNotasECursos;ALP_Area_SelNoCtrlSelect;1)
  //PROPIEDADES POR DEFECTO PARA TODAS LAS COLUMNAS

AL_SetColumnTextProperty (xALP_HNotasECursos;-2;ALP_Column_HdrFontName;"Tahoma")
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_HdrStyleF;Plain:K14:1)
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_HdrSize;9)
AL_SetColumnTextProperty (xALP_HNotasECursos;-2;ALP_Column_FontName;"Tahoma")
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_StyleF;Plain:K14:1)
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_Size;9)
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_CalcHeight;1)
AL_SetColumnRealProperty (xALP_HNotasECursos;-2;ALP_Column_HdrRotation;90)
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_HdrHorAlign;2)
AL_SetColumnLongProperty (xALP_HNotasECursos;-2;ALP_Column_HdrVertAlign;2)

  //AL_SetWidths (xALP_HNotasECursos;1;1;200)
$headerAsignaturas:="Asignaturas\r("+String:C10(Size of array:C274(aNtaAsignatura))+")"
  //AL_SetHeaders (xALP_HNotasECursos;1;12;;$headerAsignaturas;;__ ("P2");__ ("P3");__ ("P4");__ ("P5");__ ("PF");__ ("EX");__ ("EXX");__ ("NF");__ ("Nota Oficial"))

AL_SetColumnTextProperty (xALP_HNotasECursos;1;ALP_Column_HeaderText;__ ("Orden"))
AL_SetColumnRealProperty (xALP_HNotasECursos;1;ALP_Column_HdrRotation;0)

AL_SetColumnTextProperty (xALP_HNotasECursos;2;ALP_Column_HeaderText;$headerAsignaturas)
AL_SetColumnRealProperty (xALP_HNotasECursos;2;ALP_Column_HdrRotation;0)

AL_SetColumnTextProperty (xALP_HNotasECursos;3;ALP_Column_HeaderText;__ ("Periodo 1"))
AL_SetColumnTextProperty (xALP_HNotasECursos;4;ALP_Column_HeaderText;__ ("Periodo 2"))
AL_SetColumnTextProperty (xALP_HNotasECursos;5;ALP_Column_HeaderText;__ ("Periodo 3"))
AL_SetColumnTextProperty (xALP_HNotasECursos;6;ALP_Column_HeaderText;__ ("Periodo 4"))
AL_SetColumnTextProperty (xALP_HNotasECursos;7;ALP_Column_HeaderText;__ ("Periodo 5"))
OB_GET ($ob_displayEvalGralCol;->$t_colNamePA;"PA")  // nombre a desplegar en la columna Promedio Anual
AL_SetColumnTextProperty (xALP_HNotasECursos;8;ALP_Column_HeaderText;$t_colNamePA)
OB_GET ($ob_displayEvalGralCol;->$t_colNameEX;"EX")  // nombre a desplegar en la columna Examen
AL_SetColumnTextProperty (xALP_HNotasECursos;9;ALP_Column_HeaderText;$t_colNameEX)
OB_GET ($ob_displayEvalGralCol;->$t_colNameEXX;"EXX")  // nombre a desplegar en la columna Examen Extra
AL_SetColumnTextProperty (xALP_HNotasECursos;10;ALP_Column_HeaderText;$t_colNameEXX)
OB_GET ($ob_displayEvalGralCol;->$t_colNameNF;"NF")  // nombre a desplegar en la columna Promedio Final
AL_SetColumnTextProperty (xALP_HNotasECursos;11;ALP_Column_HeaderText;$t_colNameNF)
OB_GET ($ob_displayEvalGralCol;->$t_colNameNO;"NO")  // nombre a desplegar en la columna Promedio Oficial
AL_SetColumnTextProperty (xALP_HNotasECursos;12;ALP_Column_HeaderText;$t_colNameNO)

AL_SetColOpts (xALP_HNotasECursos;0;0;0;2;0;0;0)
AL_GetHeaders (xALP_HNotasECursos;$at_EncabezadosEliminar)
$columnasNotas:=10
$removeEX:=True:C214
$removeEXX:=True:C214
If ((atSTR_ModoCalificaciones=1) | (atSTR_ModoCalificaciones=4))
	For ($i;1;Size of array:C274(aNtaRecNum))
		If (aNtaEX{$i}#"")
			$removeEX:=False:C215
			$i:=Size of array:C274(aNtaRecNum)
		End if 
	End for 
	
	For ($i;1;Size of array:C274(aNtaRecNum))
		If (aNtaEXX{$i}#"")
			$removeEXX:=False:C215
			$i:=Size of array:C274(aNtaRecNum)
		End if 
	End for 
	
Else 
	For ($i;1;Size of array:C274(aNtaRecNum))
		If (aRealNtaEX{$i}>-10)
			$removeEX:=False:C215
			$i:=Size of array:C274(aNtaRecNum)
		End if 
	End for 
	For ($i;1;Size of array:C274(aNtaRecNum))
		If (aRealNtaEXX{$i}>-10)
			$removeEXX:=False:C215
			$i:=Size of array:C274(aNtaRecNum)
		End if 
	End for 
End if 

If ($removeEX)
	$l_pos:=Find in array:C230($at_EncabezadosEliminar;$t_colNameEX)
	DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
	AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
	$sortColumn:=$sortColumn-3
	$columnasNotas:=$columnasNotas-3
End if 
If ($removeEXX)
	$l_pos:=Find in array:C230($at_EncabezadosEliminar;$t_colNameEXX)
	DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
	AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
	$sortColumn:=$sortColumn-1
	$columnasNotas:=$columnasNotas-1
End if 

$sortColumn:=1
$columnasNotas:=10
OBJECT GET COORDINATES:C663(xALP_HNotasECursos;$l;$t;$r;$b)
$anchoArea:=$r-$l-18
$anchoZonaNotas:=$r-$l-18-200  //200 es el ancho original para la columna asignatura
Case of 
	: (viSTR_Periodos_NumeroPeriodos=2)
		$l_pos:=Find in array:C230($at_EncabezadosEliminar;__ ("Periodo 3"))
		DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
		AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
		
		$l_pos:=Find in array:C230($at_EncabezadosEliminar;__ ("Periodo 4"))
		DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
		AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
		
		$l_pos:=Find in array:C230($at_EncabezadosEliminar;__ ("Periodo 5"))
		DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
		AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
		
		
		$columnasNotas:=$columnasNotas-3
		$anchoNotas:=Int:C8($anchoZonaNotas/$columnasNotas)
		$anchoAsignatura:=$anchoArea-($anchoNotas*$columnasNotas)
		
	: (viSTR_Periodos_NumeroPeriodos=3)
		$l_pos:=Find in array:C230($at_EncabezadosEliminar;__ ("Periodo 4"))
		DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
		AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
		
		$l_pos:=Find in array:C230($at_EncabezadosEliminar;__ ("Periodo 5"))
		DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
		AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
		
		$columnasNotas:=$columnasNotas-2
		$anchoNotas:=Int:C8($anchoZonaNotas/$columnasNotas)
		$anchoAsignatura:=$anchoArea-($anchoNotas*$columnasNotas)
		
	: (viSTR_Periodos_NumeroPeriodos=4)
		$l_pos:=Find in array:C230($at_EncabezadosEliminar;__ ("Periodo 5"))
		DELETE FROM ARRAY:C228($at_EncabezadosEliminar;$l_pos)
		AL_RemoveArrays (xALP_HNotasECursos;$l_pos;1)
		
		$columnasNotas:=$columnasNotas-1
		$anchoNotas:=Int:C8($anchoZonaNotas/$columnasNotas)
		$anchoAsignatura:=$anchoArea-($anchoNotas*$columnasNotas)
		
	: (viSTR_Periodos_NumeroPeriodos=5)
		$anchoNotas:=Int:C8($anchoZonaNotas/$columnasNotas)
		$anchoAsignatura:=$anchoArea-($anchoNotas*$columnasNotas)
End case 

ARRAY TEXT:C222($aArrayNames;0)
$err:=AL_GetArrayNames (xALP_HNotasECursos;$aArrayNames;1)
$sortColumn:=Find in array:C230($aArrayNames;"at_OrdenAsignaturas")

AL_SetWidths (xALP_HNotasECursos;1;1;40)
AL_SetWidths (xALP_HNotasECursos;2;1;$anchoAsignatura)
For ($i;3;2+$columnasNotas-1)
	AL_SetWidths (xALP_HNotasECursos;$i;1;$anchoNotas)
End for 


AL_SetStyle (xALP_HNotasECursos;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_HNotasECursos;0;"Tahoma";9;1)
AL_SetFtrStyle (xALP_HNotasECursos;0;"Tahoma";9;1)

AL_SetRowOpts (xALP_HNotasECursos;1;1;0;0;1)
AL_SetMiscOpts (xALP_HNotasECursos;0;0;"\\";0;1)
AL_SetSortOpts (xALP_HNotasECursos;1;1;0;"";1)
AL_SetDividers (xALP_HNotasECursos;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetHeight (xALP_HNotasECursos;1;4;1;4)
AL_SetScroll (xALP_HNotasECursos;0;-3)
AL_UpdateArrays (xALP_HNotasECursos;-2)


  //ALP_SetDefaultAppareance (xALP_HNotasECursos)
AL_SetLine (xALP_HNotasECursos;0)

ARRAY INTEGER:C220($array;2;0)
For ($i;1;Size of array:C274(aNtaRecNum))
	If (aReprobada{$i})
		AL_SetCellColor (xALP_HNotasECursos;1;$i;13;$i;$array;"Red";0;"";0)
	Else 
		AL_SetCellColor (xALP_HNotasECursos;1;$i;13;$i;$array;"Black";0;"";0)
	End if 
End for 

AL_SetSort (xALP_HNotasECursos;$sortColumn;1)

For ($i;1;Size of array:C274(aNtaRecNum))
	$nivelJerarquico:=ST_CountWords (at_OrdenAsignaturas{$i};1;".")
	If ($nivelJerarquico>1)
		aNtaAsignatura{$i}:=(" "*$nivelJerarquico)+aNtaAsignatura{$i}
		AL_SetRowStyle (xALP_HNotasECursos;$i;2)
	End if 
End for 

If ($recNumSintesisAnual>=0)
	$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
	GOTO RECORD:C242([Alumnos_SintesisAnual:210];$recNumSintesisAnual)
	vs_Nivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->vl_NivelSeleccionado_Historico;->[xxSTR_Niveles:6]Nivel:1)
	
	vtSTR_AL_Observaciones:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
	vtSTR_AL_LabelObservaciones:="Comentario final del profesor jefe:"
	_O_ENABLE BUTTON:C192(bModHistoric)
	OBJECT SET ENTERABLE:C238(*;"Historic@";False:C215)
	OBJECT SET VISIBLE:C603(*;"nivelhistorico@";False:C215)
Else 
	$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
	CD_Dlog (0;__ ("No hay registros históricos en el año ")+$nombreAñoEscolar+__ (" para ")+[Alumnos:2]Nombre_Común:30)
	OBJECT SET ENTERABLE:C238(*;"Historic@";False:C215)
	OBJECT SET VISIBLE:C603(*;"nivelhistorico@";False:C215)
End if 


aNtaAsignatura:=1

AL_UpdateArrays (xALP_HNotasECursos;-2)