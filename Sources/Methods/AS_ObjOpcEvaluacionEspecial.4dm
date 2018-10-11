//%attributes = {}
  //AS_ObjOpcEvaluacionEspecial
  //Definir y actualizar el objeto de opciones de la asignatura con respecto al uso de Evaluaciones Especiales
  //Evaluaciones Especiales son calificaciones paralelas a las Calificaciones estándar.
  //Utilizadas para registrar notas criteriales o simbolicas (nota de conducta, nota de participación) que no incidan en los promedios de la asignatura.
  //Actualmente estas evaluaciones están registras en [Alumnos_EvaluacionesEspeciales]
  //Mono Ticket 172577 Evaluacion Especial
C_POINTER:C301($1;$ptr_array)
ARRAY LONGINT:C221($al_recnumAsig;0)
C_BOOLEAN:C305($b_log;$b_opc;$b_opc_old;$b_save;$2;$3)
C_OBJECT:C1216($object)
C_LONGINT:C283($i;$l_idTermometro;$n)

$l_idTermometro:=IT_Progress (1;0;0;"Opciones Asignatura usar Evaluaciones Especiales:")
Case of 
	: (Count parameters:C259=0)
		READ ONLY:C145([Asignaturas:18])
		ALL RECORDS:C47([Asignaturas:18])
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnumAsig;"")
		$ptr_array:=->$al_recnumAsig
		
	: (Count parameters:C259=1)
		$ptr_array:=$1
		
	: (Count parameters:C259=2)
		$ptr_array:=$1
		$b_opc:=$2
		
	: (Count parameters:C259=3)
		$ptr_array:=$1
		$b_opc:=$2
		$b_log:=$3
		
End case 

For ($i;1;Size of array:C274($ptr_array->))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$ptr_array->{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($ptr_array->);"Opciones Asignatura usar Evaluaciones Especiales: "+[Asignaturas:18]denominacion_interna:16+" "+[Asignaturas:18]Curso:5)
	
	If (OB Is defined:C1231([Asignaturas:18]Opciones:57))
		$object:=[Asignaturas:18]Opciones:57
	Else 
		$object:=OB_Create 
	End if 
	
	$b_save:=True:C214
	If (OB Get type:C1230($object;"usaEvaluacionesEspeciales")#Is undefined:K8:13)
		OB_GET ($object;->$b_opc_old;"usaEvaluacionesEspeciales")
		$b_save:=($b_opc#$b_opc_old)
	End if 
	
	If ($b_save)
		OB_SET ($object;->$b_opc;"usaEvaluacionesEspeciales")
		[Asignaturas:18]Opciones:57:=$object
		SAVE RECORD:C53([Asignaturas:18])
		
		If ($b_opc)
			
			C_LONGINT:C283($i;$l_recNumEvalEspecial;$l_idTermometro)
			C_TEXT:C284($llaveAsig)
			ARRAY LONGINT:C221($al_rn;0)
			$llaveAsig:=String:C10(<>gInstitucion)+"."+String:C10(<>gyear)+"."+String:C10(Abs:C99([Asignaturas:18]Numero:1))
			
			READ ONLY:C145([Alumnos_Calificaciones:208])
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Asignatura:494=$llaveAsig)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_rn;"")
			
			For ($n;1;Size of array:C274($al_rn))
				
				GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_rn{$n})
				$l_recNumEvalEspecial:=KRL_FindAndLoadRecordByIndex (->[Alumnos_EvaluacionesEspeciales:211]Llave_principal:8;->[Alumnos_Calificaciones:208]Llave_principal:1)
				If ($l_recNumEvalEspecial<0)
					READ WRITE:C146([Alumnos_EvaluacionesEspeciales:211])
					CREATE RECORD:C68([Alumnos_EvaluacionesEspeciales:211])
					[Alumnos_EvaluacionesEspeciales:211]ID_Institucion:2:=[Alumnos_Calificaciones:208]ID_institucion:2
					[Alumnos_EvaluacionesEspeciales:211]Año:3:=[Alumnos_Calificaciones:208]Año:3
					[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4:=[Alumnos_Calificaciones:208]ID_Alumno:6
					[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
					[Alumnos_EvaluacionesEspeciales:211]ID_HistoricoAsignatura:6:=[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493
					[Alumnos_EvaluacionesEspeciales:211]Nivel_Numero:7:=[Alumnos_Calificaciones:208]NIvel_Numero:4
					SAVE RECORD:C53([Alumnos_EvaluacionesEspeciales:211])
					KRL_ReloadAsReadOnly (->[Alumnos_EvaluacionesEspeciales:211])
				End if 
			End for 
			
		End if 
		
		If (($b_log) & (OK=1))
			LOG_RegisterEvt ("Asignatura :"+[Asignaturas:18]denominacion_interna:16+" "+[Asignaturas:18]Curso:5+", uso de evaluación especial cambia a: "+String:C10($b_opc))
		End if 
		
	End if 
	KRL_UnloadReadOnly (->[Asignaturas:18])
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
