//%attributes = {}
  //AL_CalculaSituacionFinal_ar 

C_LONGINT:C283($1;$idAlumno;$observacionActaEmpieza;$observacionActaTermina)
C_BOOLEAN:C305($succes;$promocionAutomatica)
C_LONGINT:C283($recuperacionReprobadas;$subsanacionReprobadas)
C_TEXT:C284($observacionActa;$situacionFinal)
C_LONGINT:C283($totalReprobadas;$reprobadasCiclosAnteriores;$reprobadasCiclosActual)

If (Count parameters:C259=1)
	$idAlumno:=$1
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno;True:C214)
	
	If (OK=1)
		$succes:=True:C214
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno;True:C214)
		If (OK=1)
			$succes:=True:C214
		End if 
	End if 
Else 
	$succes:=True:C214
End if 

$comentarioSituacionFinal:=""


If (($succes) & (Records in selection:C76([Alumnos:2])=1))
	  //lectura de parametros de evaluación del nivel del alumno
	
	
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
	If (([xxSTR_Niveles:6]EsNIvelActivo:30) & (Not:C34([xxSTR_Niveles:6]EsNivelSistema:10)))
		
		$promocionAutomatica:=[xxSTR_Niveles:6]Promoción_auto:18
		EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
		
		
		
		
		$recNum:=Record number:C243([Alumnos:2])
		
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		CREATE SET:C116([Alumnos_Calificaciones:208];"Evaluaciones")
		
		
		USE SET:C118("Evaluaciones")
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36="P")
		CREATE SET:C116([Alumnos_Calificaciones:208];"EvaluacionesPendientes")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		
		KRL_GotoRecord (->[Alumnos:2];$recNum)
		
		
		
		
		
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno;True:C214)
		
		
		$observacionActaEmpieza:=Position:C15("[";[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9)
		$observacionActaTermina:=Position:C15("]";[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9)
		If (($observacionActaEmpieza>0) & ($observacionActaTermina>0))
			$observacionActa:=Substring:C12([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9;$observacionActaEmpieza;($observacionActaTermina-$observacionActaEmpieza+1))
		End if 
		
		[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:=""
		  //[Alumnos_SintesisAnual]ObservacionesActas_cl:=""
		[Alumnos_SintesisAnual:210]SituacionFinal:8:=""
		
		KRL_GotoRecord (->[Alumnos:2];$recNum)
		
		$evaluarSituacionFinal:=False:C215
		Case of 
			: ([Alumnos:2]Status:50="Oyente")
				$comentarioSituacionFinal:="Oyente. No figura en actas"
				$situacionFinal:="X"
				
			: ([Alumnos:2]Status:50="En Trámite")
				$situacionFinal:="X"
				$comentarioSituacionFinal:="En Tramite. No figura en actas"
				
			: ([Alumnos:2]Status:50="Promovido anticipadamente")
				$situacionFinal:="P"
				$comentarioSituacionFinal:="Promovido anticipadamente"
				
			: ([Alumnos:2]Status:50="Retirado@")
				$situacionFinal:="Y"
				$comentarioSituacionFinal:="Retirado el: "+String:C10([Alumnos:2]Fecha_de_retiro:42;7)
				
			: ($promocionAutomatica)
				$situacionFinal:="P"
				
			: (Records in set:C195("EvaluacionesPendientes")>0)
				$situacionFinal:="??"
				$comentarioSituacionFinal:="***PENDIENTE***"
				
			: (Records in set:C195("Evaluaciones")>0)
				$evaluarSituacionFinal:=True:C214
				
				
			Else 
				$situacionFinal:="X"
				$comentarioSituacionFinal:="No hay información que permita evaluar la situación final"
				
		End case 
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		
		
		
		If ($evaluarSituacionFinal)
			READ WRITE:C146([Alumnos:2])
			KRL_GotoRecord (->[Alumnos:2];$recNum;False:C215)
			
			  //busqueda de asignaturas reprobadas en ciclos anteriores(desde 7º a 12º)en los que el alumno fue promovido
			READ ONLY:C145([Alumnos_SintesisAnual:210])
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-$idAlumno;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;>=;7;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;<;[Alumnos:2]nivel_numero:29;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P")
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]Año:2;$aYears)
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			READ ONLY:C145([Alumnos_Calificaciones:208])
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;=;-$idAlumno;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Reprobada:9;=;True:C214;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Asignaturas_Historico:84]Incluida_En_Actas:7;=;True:C214)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QRY_QueryWithArray (->[Alumnos_Calificaciones:208]Año:3;->$aYears;True:C214)
			
			$reprobadasCiclosAnteriores:=Records in selection:C76([Alumnos_Calificaciones:208])
			
			
			
			  //asignaturas reprobadas ciclo actual
			READ ONLY:C145([Alumnos_Calificaciones:208])
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;=;$idAlumno;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Reprobada:9;=;True:C214;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & ;[Asignaturas:18]Incluida_en_Actas:44;=;True:C214)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			
			$reprobadasCiclosActual:=Records in selection:C76([Alumnos_Calificaciones:208])
			
			
			
			$totalReprobadas:=$reprobadasCiclosAnteriores+$reprobadasCiclosActual
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno)
			Case of 
					  //ABK 20111122
					  //modificación solicitada en ticket Nº 95338 por Hector Rojo
					  //la asistencia no se toma en consideración para la promoción
					
					  //: (($totalreprobadas>2) & ([Alumnos_SintesisAnual]PorcentajeAsistencia<85))
					  //: ($totalreprobadas>2)
					  //$comentarioSituacionFinal:="Reprobado por no haber aprobado dos o más asignaturas (incluyendo ciclos anterior"+"es"+") y % de asistencia inferior al 85%"
					  //$situacionFinal:="R"
					  //: ([Alumnos_SintesisAnual]PorcentajeAsistencia<85)
					  //$comentarioSituacionFinal:="Reprobado por asistencia inferior al 85%"
					  //$situacionFinal:="R"
				: (((<>gRegion="Capital Federal") | (<>gRegion="Distrito Federal")) & ($totalreprobadas>2))
					$comentarioSituacionFinal:="Reprobado por no haber aprobado dos o más asignaturas (incluyendo ciclos anterior"+"es"+")"
					$situacionFinal:="R"
					
				: (((<>gRegion#"Capital Federal") & (<>gRegion#"Distrito Federal")) & ($totalreprobadas>3))
					$comentarioSituacionFinal:="Reprobado por no haber aprobado tres o más asignaturas (incluyendo ciclos anterior"+"es"+")"
					$situacionFinal:="R"
					
				Else 
					$situacionFinal:="P"
			End case 
			
			
			
			
			
		End if 
		
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno;True:C214)
		If ($observacionActa#"")
			[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9:=$observacionActa
		End if 
		[Alumnos_SintesisAnual:210]SituacionFinal:8:=$situacionFinal
		[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:=$comentarioSituacionFinal
		[Alumnos_SintesisAnual:210]Promovido:91:=([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
	End if 
End if 
$0:=$succes