//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 23-02-18, 17:19:19
  // ----------------------------------------------------
  // Método: UD_v20180223_ReparaSubAsignatur
  // Descripción
  // 
  //Recorre las subasignaturas, Identifica las subasignaturas con perdida de notas.
  //Recupera, desde la madre, el promedio de la subasignatura, insertando este en la subasignatura asociado a la celda
  // 
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($i;$j;$l_columna;$l_idAsignaturaMadre;$l_indice;$l_indice2;$l_indiceCal;$l_periodo;$l_posicion;$l_proc)
C_LONGINT:C283($l_tipo)
C_POINTER:C301($y_calificacion)
C_TEXT:C284($t_mensaje;$t_texto)

ARRAY LONGINT:C221($al_RecNumCalificaciones;0)
ARRAY REAL:C219($ar_ParcialAlumno;0)
ARRAY REAL:C219($ar_promedioAlumno;0)
ARRAY REAL:C219($ar_temporalSubEval;0)

ARRAY LONGINT:C221($al_RecNumSA;0)
ARRAY LONGINT:C221($al_recNumSAReparar;0)
ARRAY LONGINT:C221(aSubEvalID;0)


READ ONLY:C145([xxSTR_Subasignaturas:83])
ALL RECORDS:C47([xxSTR_Subasignaturas:83])

SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83];$al_RecNumSA)
$l_proc:=IT_Progress (1;0;0;"Revisando subasignaturas...")
For ($l_indice;1;Size of array:C274($al_RecNumSA))
	GOTO RECORD:C242([xxSTR_Subasignaturas:83];$al_RecNumSA{$l_indice})
	ASsev_InitArrays 
	
	  //busco asignatura
	READ ONLY:C145([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[xxSTR_Subasignaturas:83]ID_Mother:6)
	
	  //leo estilo de evaluación
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	
	ARRAY POINTER:C280(aSubEvalArrPtr;12)
	ARRAY POINTER:C280(aRealSubEvalArrPtr;12)
	ARRAY TEXT:C222(aRealSubEvalArrNames;12)
	For ($i;1;12)
		aSubEvalArrPtr{$i}:=Get pointer:C304("aSubEval"+String:C10($i))
		aRealSubEvalArrPtr{$i}:=Get pointer:C304("aRealSubEval"+String:C10($i))
	End for 
	
	If (OB Is defined:C1231([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalID"))
		OB GET ARRAY:C1229([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalID";aSubEvalID)
		For ($j;1;Size of array:C274(aSubEvalArrPtr))
			$l_tipo:=OB Get type:C1230([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEval"+String:C10($j))
			If ($l_tipo=Is undefined:K8:13)
				APPEND TO ARRAY:C911($al_recNumSAReparar;$al_RecNumSA{$l_indice})
				$j:=Size of array:C274(aSubEvalArrPtr)+1
			Else   //MONO Ticket 202205
				OB GET ARRAY:C1229([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEval"+String:C10($j);$ar_temporalSubEval)
				If (Size of array:C274($ar_temporalSubEval)#(Size of array:C274(aSubEvalID)))
					APPEND TO ARRAY:C911($al_recNumSAReparar;$al_RecNumSA{$l_indice})
					$j:=Size of array:C274(aSubEvalArrPtr)+1
				End if 
			End if 
			
		End for 
	End if 
	IT_Progress (0;$l_proc;$l_indice/Size of array:C274($al_RecNumSA))
End for 
IT_Progress (-1;$l_proc)

If (Size of array:C274($al_recNumSAReparar)>0)
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	$l_proc:=IT_Progress (1;0;0;"Reparando obj de subasignaturas...")
	For ($l_indice;1;Size of array:C274($al_recNumSAReparar))
		$l_proc:=IT_Progress (0;$l_proc;$l_indice/Size of array:C274($al_recNumSAReparar);"Reparando obj de subasignaturas...")
		GOTO RECORD:C242([xxSTR_Subasignaturas:83];$al_recNumSAReparar{$l_indice})
		OB GET ARRAY:C1229([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalID";aSubEvalID)
		AT_Initialize (->$ar_temporalSubEval)
		AT_RedimArrays (Size of array:C274(aSubEvalID);->$ar_temporalSubEval)
		For ($i;1;Size of array:C274($ar_temporalSubEval))
			$ar_temporalSubEval{$i}:=-10
		End for 
		For ($l_indice2;1;12)
			OB SET ARRAY:C1227([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEval"+String:C10($l_indice2);$ar_temporalSubEval)
		End for 
		SAVE RECORD:C53([xxSTR_Subasignaturas:83])
		
		  //busco la asignatura Madre
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([Alumnos:2])
		$l_periodo:=[xxSTR_Subasignaturas:83]Periodo:12
		$l_columna:=[xxSTR_Subasignaturas:83]Columna:13
		$l_idAsignaturaMadre:=[xxSTR_Subasignaturas:83]ID_Mother:6
		$y_calificacion:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($l_periodo)+"_Eval"+String:C10($l_columna;"00")+"_Real")  //MONO Ticket 202205
		If (Not:C34(Is nil pointer:C315($y_calificacion)))  //MONO TICKET 205169
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[xxSTR_Subasignaturas:83]ID_Mother:6)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$al_RecNumCalificaciones)
			
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[xxSTR_Subasignaturas:83]ID_Mother:6)
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			
			For ($l_indiceCal;1;Size of array:C274($al_RecNumCalificaciones))
				$l_proc:=IT_Progress (0;$l_proc;$l_indice/Size of array:C274($al_recNumSAReparar);"Reparando obj de subasignaturas...";$l_indiceCal/Size of array:C274($al_RecNumCalificaciones);"Reparando asignatura "+[Asignaturas:18]Asignatura:3)
				GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNumCalificaciones{$l_indiceCal})
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Calificaciones:208]ID_Alumno:6)
				
				$l_posicion:=Find in array:C230(aSubEvalID;[Alumnos_Calificaciones:208]ID_Alumno:6)
				If ($l_posicion>0)
					OB GET ARRAY:C1229([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEval1";$ar_ParcialAlumno)
					OB GET ARRAY:C1229([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEvalP1";$ar_promedioAlumno)
					$ar_ParcialAlumno{$l_posicion}:=$y_calificacion->
					$ar_promedioAlumno{$l_posicion}:=$y_calificacion->
					OB SET ARRAY:C1227([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEval1";$ar_ParcialAlumno)
					OB SET ARRAY:C1227([xxSTR_Subasignaturas:83]o_Data:21;"aRealSubEvalP1";$ar_promedioAlumno)
					SAVE RECORD:C53([xxSTR_Subasignaturas:83])
					AT_Initialize (->$ar_ParcialAlumno;->$ar_promedioAlumno)
					$t_mensaje:="Subasignaturas: Reparación objeto parciales en subasignatura: '"+[xxSTR_Subasignaturas:83]Name:2+"' "+"\r"
					$t_mensaje:=$t_mensaje+"Asignatura Madre: "+[Asignaturas:18]Asignatura:3+", ID SchoolTrack: "+String:C10([Asignaturas:18]Numero:1)+"\r"
					$t_mensaje:=$t_mensaje+"periodo modificado: "+atSTR_Periodos_Nombre{$l_periodo}+"\r"
					$t_mensaje:=$t_mensaje+"columna modificada: "+String:C10($l_columna)+"\r"
					$t_mensaje:=$t_mensaje+"Alumno Modificado: "+[Alumnos:2]apellidos_y_nombres:40+" ,ID SchoolTrack: "+String:C10([Alumnos:2]numero:1)
					LOG_RegisterEvt ($t_mensaje)
				End if 
			End for 
		Else 
			  //MONO TICKET 205169
			$t_mensaje:=__ ("Reparación de subasigantura: subasignatura no utilizada en su asigantura, no es considerada en la reparación. Subasignatura id ^0";String:C10([xxSTR_Subasignaturas:83]ID:19))
			LOG_RegisterEvt ($t_mensaje)
		End if 
		$l_proc:=IT_Progress (-1;$l_proc)
	End for 
	KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
End if 