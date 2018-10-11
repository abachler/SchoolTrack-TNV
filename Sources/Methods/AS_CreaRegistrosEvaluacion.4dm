//%attributes = {}
  //Metodo: AS_CreaRegistrosEvaluacion
  //Por abachler
  //Creada el 31/01/2008, 20:16:10
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($recNo;$idAlumno;$1;$idAsignatura;$2)
C_BOOLEAN:C305($displayProgress;$3)
$idAlumno:=$1
$idAsignatura:=$2

Case of 
	: (Count parameters:C259=3)
		$displayProgress:=$3
		$idAlumno:=$1
		$idAsignatura:=$2
	: (Count parameters:C259=2)
		$idAlumno:=$1
		$idAsignatura:=$2
	: (Count parameters:C259=1)
		$idAlumno:=$1
		$idAsignatura:=[Asignaturas:18]Numero:1
	: (Count parameters:C259=0)
		$idAlumno:=[Alumnos:2]numero:1
		$idAsignatura:=[Asignaturas:18]Numero:1
End case 

  //CUERPO
If (($idAlumno>0) & ($idAsignatura>0))
	If ($idAsignatura#[Asignaturas:18]Numero:1)
		$recNumAsignatura:=Find in field:C653([Asignaturas:18]Numero:1;$idAsignatura)
		KRL_GotoRecord (->[Asignaturas:18];$recNumAsignatura)
	End if 
	If ($idAlumno#[Alumnos:2]numero:1)
		$recNumAlumno:=Find in field:C653([Alumnos:2]numero:1;$idAlumno)
		KRL_GotoRecord (->[Alumnos:2];$recNumAlumno)
	End if 
	
	$idEstiloEvaluacion:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
	$numeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
	
	EVS_ReadStyleData ($idEstiloEvaluacion)
	PERIODOS_LoadData ($numeroNivel)
	
	  //creación de registros de evaluación tradicional
	EV2_CreaRegistrosEvaluacion ($idAsignatura;$idAlumno)
	
	
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$idAsignatura)
	  //creación de registros de evaluación en blob de subasignaturas
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		For ($periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
			AS_PropEval_Lectura ("";$periodo)
			For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
				If (alAS_EvalPropSourceID{$k}<0)
					$subEvalRecNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$periodo;$k)
					If ($subEvalRecNum<0)  //20070708 ABK
						$subID:=String:C10(alAS_EvalPropSourceID{$k})+"/"+String:C10($periodo)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$k}
						  //[xxSTR_Subasignaturas]ModoControles:=[Asignaturas]ModoControles
						  //[xxSTR_Subasignaturas]PonderacionControlInferior:=[Asignaturas]Peso_relativo_controles
						[xxSTR_Subasignaturas:83]Periodo:12:=$periodo
						[xxSTR_Subasignaturas:83]Columna:13:=$k
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						$subEvalRecNum:=Record number:C243([xxSTR_Subasignaturas:83])
						KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
						ASsev_InitArrays 
					End if 
					$el:=Find in array:C230(aSubEvalID;[Alumnos:2]numero:1)
					If ($el<0)
						$s:=Size of array:C274(aSubEvalID)+1
						AT_Insert ($s;1;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalP1)
						AT_Insert ($s;1;->aRealSubEval1;->aRealSubEval2;->aRealSubEval3;->aRealSubEval4;->aRealSubEval5;->aRealSubEval6;->aRealSubEval7;->aRealSubEval8;->aRealSubEval9;->aRealSubEval10;->aRealSubEval11;->aRealSubEval12;->aRealSubEvalP1;->aRealSubEvalControles;->aRealSubEvalPresentacion)
						aSubEvalID{$s}:=[Alumnos:2]numero:1
						aSubEvalStdNme{$s}:=[Alumnos:2]apellidos_y_nombres:40
						aSubEvalCurso{$s}:=[Alumnos:2]curso:20
						aSubEvalStatus{$s}:=[Alumnos:2]Status:50
						aSubEvalOrden{$s}:=[Asignaturas:18]LastNumber:54
						aRealSubEvalP1{$s}:=-10
						aRealSubEvalControles{$s}:=-10
						aRealSubEvalPresentacion{$s}:=-10
						For ($iParciales;1;Size of array:C274(aRealSubEvalArrPtr))
							aRealSubEvalArrPtr{$iParciales}->{$s}:=-10
						End for 
						ASsev_GuardaNomina ($subEvalRecNum)
					End if 
				End if 
			End for 
		End for 
	Else 
		AS_PropEval_Lectura 
		For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$k}<0)
				For ($periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					$subEvalRecNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$periodo;$k)
					If ($subEvalRecNum<0)  //20070708 ABK
						$subID:=String:C10(alAS_EvalPropSourceID{$k})+"/"+String:C10($periodo)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]ID_SubAsignatura:1:=$subID
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$k}
						  //[xxSTR_Subasignaturas]ModoControles:=[Asignaturas]ModoControles
						  //[xxSTR_Subasignaturas]PonderacionControlInferior:=[Asignaturas]Peso_relativo_controles
						[xxSTR_Subasignaturas:83]Periodo:12:=$periodo
						[xxSTR_Subasignaturas:83]Columna:13:=$k
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						$subEvalRecNum:=Record number:C243([xxSTR_Subasignaturas:83])
						KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
						ASsev_InitArrays 
					End if 
					$el:=Find in array:C230(aSubEvalID;[Alumnos:2]numero:1)
					If ($el<0)
						$s:=Size of array:C274(aSubEvalID)+1
						AT_Insert ($s;1;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalP1)
						AT_Insert ($s;1;->aRealSubEval1;->aRealSubEval2;->aRealSubEval3;->aRealSubEval4;->aRealSubEval5;->aRealSubEval6;->aRealSubEval7;->aRealSubEval8;->aRealSubEval9;->aRealSubEval10;->aRealSubEval11;->aRealSubEval12;->aRealSubEvalP1;->aRealSubEvalControles;->aRealSubEvalPresentacion)
						aSubEvalID{$s}:=[Alumnos:2]numero:1
						aSubEvalStdNme{$s}:=[Alumnos:2]apellidos_y_nombres:40
						aSubEvalCurso{$s}:=[Alumnos:2]curso:20
						aSubEvalStatus{$s}:=[Alumnos:2]Status:50
						aSubEvalOrden{$s}:=[Asignaturas:18]LastNumber:54
						aRealSubEvalP1{$s}:=-10
						aRealSubEvalControles{$s}:=-10
						aRealSubEvalPresentacion{$s}:=-10
						For ($iParciales;1;Size of array:C274(aRealSubEvalArrPtr))
							aRealSubEvalArrPtr{$iParciales}->{$s}:=-10
						End for 
						ASsev_GuardaNomina ($subEvalRecNum)
					End if 
				End for 
			End if 
		End for 
	End if 
	
	If ($displayProgress)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]))
	End if 
	
Else 
	  //no se especificó alumno y/o asignatura
End if 

  //LIMPIEZA