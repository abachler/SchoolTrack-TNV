//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 22-03-17, 10:00:38
  // ----------------------------------------------------
  // Método: STWA2_OWC_EvaluacionEspecial
  // Descripción
  // 
  // //Mono Ticket 172577 Evaluacion Especial
  // ----------------------------------------------------


C_TEXT:C284($uuid;$t_accion;$1;$4)
C_POINTER:C301($y_ParameterNames;$y_ParameterValues;$2;$3)
C_LONGINT:C283($l_idUsuario;$l_periodo;$l_rnAsignatura)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
$accion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")

Case of 
	: ($accion="enviaEvaluacionesEspeciales")
		  //Enviar el listado en un json de lo siguiente:
		  // id de alumno - alumnos nombres - parciales del periodo seleccionado y estilo de evaluacion de la asignatura seleccionada en STWA
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$l_rnAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsignatura"))
		
		READ ONLY:C145([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$l_rnAsignatura)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		If ($l_periodo=-1)
			$l_periodo:=viSTR_PeriodoActual_Numero
		End if 
		
		ARRAY LONGINT:C221($al_idAlumno;0)
		ARRAY TEXT:C222($at_NombreAlumno;0)
		ARRAY TEXT:C222($at_Pacial1Literal;0)
		ARRAY TEXT:C222($at_Pacial2Literal;0)
		ARRAY TEXT:C222($at_Pacial3Literal;0)
		C_POINTER:C301($y_Eval01_Literal;$y_Eval02_Literal;$y_Eval03_Literal)
		C_OBJECT:C1216($ob_estilo;$ob_periodos;$ob_raiz;$ob_icono)
		
		$y_Eval01_Literal:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval01_Literal")
		$y_Eval02_Literal:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval02_Literal")
		$y_Eval03_Literal:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval03_Literal")
		READ ONLY:C145([Alumnos_EvaluacionesEspeciales:211])
		QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5=[Asignaturas:18]Numero:1;*)
		QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]Año:3=<>gyear)
		
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SET FIELD RELATION:C919([Alumnos:2]numero:1;Automatic:K51:4;Automatic:K51:4)
		SET FIELD RELATION:C919([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4;Automatic:K51:4;Automatic:K51:4)
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]Llave_principal:1;Automatic:K51:4;Automatic:K51:4)
		
		ORDER BY:C49([Alumnos_EvaluacionesEspeciales:211];[Alumnos_Calificaciones:208]NoDeLista:10;>)
		SELECTION TO ARRAY:C260($y_Eval01_Literal->;$at_Pacial1Literal;*)
		SELECTION TO ARRAY:C260($y_Eval02_Literal->;$at_Pacial2Literal;*)
		SELECTION TO ARRAY:C260($y_Eval03_Literal->;$at_Pacial3Literal;*)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4;$al_idAlumno;*)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombreAlumno)
		
		SET FIELD RELATION:C919([Alumnos:2]numero:1;No relation:K51:5;No relation:K51:5)
		SET FIELD RELATION:C919([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4;No relation:K51:5;No relation:K51:5)
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]Llave_principal:1;No relation:K51:5;No relation:K51:5)
		
		  //Json a STWA
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		
		Case of 
			: (iEvaluationMode=Notas)
				$r_minimo:=rGradesFrom
				$r_maximo:=rGradesTo
				$l_decimales:=iGradesDec
				$t_minimoAprobacion:=String:C10(rGradesMinimum)
				$t_evaluacion:="Notas"
			: (iEvaluationMode=Puntos)
				$r_minimo:=rPointsFrom
				$r_maximo:=rPointsTo
				$l_decimales:=iGradesDec
				$t_minimoAprobacion:=String:C10(rPointsMinimum)
				$t_evaluacion:="Puntos"
			: (iEvaluationMode=Simbolos)
				$r_minimo:=0
				$r_maximo:=100
				$l_decimales:=0
				$t_evaluacion:="Simbolos"
				$t_minimoAprobacion:=sSymbolMinimum
		End case 
		
		$ob_estilo:=OB_Create 
		
		OB_SET ($ob_estilo;-><>vs_AppDecimalSeparator;"separador")
		OB_SET ($ob_estilo;->$t_evaluacion;"EvaluationMode")
		OB_SET ($ob_estilo;->$r_minimo;"minimo")
		OB_SET ($ob_estilo;->$r_maximo;"maximo")
		OB_SET ($ob_estilo;->$l_decimales;"decimales")
		OB_SET ($ob_estilo;->$t_minimoAprobacion;"minimoAprobacion")
		OB_SET ($ob_estilo;->aSymbol;"simbolos")
		
		
		$ob_periodos:=OB_Create 
		OB_SET ($ob_periodos;->atSTR_Periodos_Nombre;"periodos_nombre")
		OB_SET ($ob_periodos;->$l_periodo;"periodos_seleccionado")
		
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$al_idAlumno;"id_alumno")
		OB_SET ($ob_raiz;->$at_NombreAlumno;"alumnos")
		OB_SET ($ob_raiz;->$at_Pacial1Literal;"parcial01")
		OB_SET ($ob_raiz;->$at_Pacial2Literal;"parcial02")
		OB_SET ($ob_raiz;->$at_Pacial3Literal;"parcial03")
		
		GET PICTURE FROM LIBRARY:C565(5005;$p_iconoEditable)
		$ob_icono:=OB_Create 
		OB_SET ($ob_icono;->$p_iconoEditable;"editable")
		
		OB_SET ($ob_raiz;->$ob_estilo;"estilo")
		OB_SET ($ob_raiz;->$ob_periodos;"periodos")
		OB_SET ($ob_raiz;->$ob_icono;"iconos")
		
		
		$t_resultado:=OB_Object2Json ($ob_raiz)
		
	: ($accion="guardaEvaluacionesEspeciales")
		
		C_POINTER:C301($y_real;$y_literal;$y_puntos;$y_nota;$y_simbolo)
		C_BOOLEAN:C305($b_ok)
		C_TEXT:C284($t_Errormsg;$t_llave)
		C_OBJECT:C1216($o_respuesta)
		C_LONGINT:C283($l_nivel;$l_parcial;$l_idAlumno)
		
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"periodo"))
		$l_rnAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsignatura"))
		$l_parcial:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"parcial"))
		$t_evaluacion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"evaluacion")
		$l_idAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idAlumno"))
		
		READ ONLY:C145([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$l_rnAsignatura)
		$l_nivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]nivel_numero:29)
		$t_llave:=String:C10([Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2)+"."+String:C10(<>gyear)+"."+String:C10($l_nivel)+"."+String:C10(Abs:C99([Asignaturas:18]Numero:1))+"."+String:C10(Abs:C99($l_idAlumno))
		
		$l_recNumEva:=Find in field:C653([Alumnos_EvaluacionesEspeciales:211]Llave_principal:8;$t_llave)
		
		If ($l_recNumEva=-1)
			$t_Errormsg:="Registro de evaluación especial inexistente."
			
		Else 
			READ WRITE:C146([Alumnos_EvaluacionesEspeciales:211])
			GOTO RECORD:C242([Alumnos_EvaluacionesEspeciales:211];$l_recNumEva)
			
			If (Locked:C147([Alumnos_EvaluacionesEspeciales:211]))
				$t_Errormsg:="Registro de evaluación especial tomado por otro proceso, intete nuevamente más tarde."
				
			Else 
				
				$y_literal:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Literal")
				$y_real:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Real")
				$y_nota:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Nota")
				$y_puntos:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Puntos")
				$y_simbolo:=KRL_GetFieldPointerByName ("[Alumnos_EvaluacionesEspeciales]p0"+String:C10($l_periodo)+"_Eval"+String:C10($l_parcial;"00")+"_Simbolo")
				
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				$t_evaluacion:=EV2_Literal_Sistema ($t_evaluacion)  //MONO, si viene con el separador cambiado los num que vienen luego pueden entregar un numero mayor (5 a 50)
				
				If ($t_evaluacion#"")
					Case of 
						: (iEvaluationMode=Puntos)
							$y_real->:=EV2_Puntos_a_Real (Num:C11($t_evaluacion))
						: (iEvaluationMode=Notas)
							$y_real->:=EV2_Nota_a_Real (Num:C11($t_evaluacion))
						: (iEvaluationMode=Simbolos)
							$y_real->:=EV2_Simbolo_a_Real ($t_evaluacion)
					End case 
				Else 
					$y_real->:=-10
				End if 
				
				$y_literal->:=EV2_Real_a_Literal ($y_real->;iEvaluationMode)
				$y_nota->:=EV2_Real_a_Nota ($y_real->)
				$y_puntos->:=EV2_Real_a_Puntos ($y_real->)
				$y_simbolo->:=EV2_Real_a_Simbolo ($y_real->)
				
				SAVE RECORD:C53([Alumnos_EvaluacionesEspeciales:211])
				KRL_UnloadReadOnly (->[Alumnos_EvaluacionesEspeciales:211])
				$b_ok:=True:C214
			End if 
			
		End if 
		
		$o_respuesta:=OB_Create 
		OB_SET ($o_respuesta;->$b_ok;"ok")
		OB_SET ($o_respuesta;->$t_Errormsg;"mensaje")
		$t_resultado:=OB_Object2Json ($o_respuesta)
		
End case 

$0:=$t_resultado