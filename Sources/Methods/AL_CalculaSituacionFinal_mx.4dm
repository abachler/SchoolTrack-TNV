//%attributes = {}
  //AL_CalculaSituacionFinal_mx

C_LONGINT:C283($1;$idAlumno;$observacionActaEmpieza;$observacionActaTermina)
C_BOOLEAN:C305($succes;$promocionAutomatica)
C_TEXT:C284($observacionActa;$situacionFinal)


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
		$id_Alumno:=[Alumnos:2]numero:1
		
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
		
		
		
		
		
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->$idAlumno)
		
		
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
				$situacionFinal:="P"
				$comentarioSituacionFinal:=""
				
		End case 
		  //SAVE RECORD([Alumnos_SintesisAnual])
		
		
		
		If ($evaluarSituacionFinal)
			$situacionFinal:="P"
			$comentarioSituacionFinal:=""
		End if 
		
		READ WRITE:C146([Alumnos:2])
		KRL_GotoRecord (->[Alumnos:2];$recNum;False:C215)
		
		
		
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