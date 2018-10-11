//%attributes = {}
  // MÉTODO: AS_fSave
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 22/12/11, 09:33:56
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Guarda el registro de asignaturas editado en el formulario imput
  // En $0 devuelve -1  si el registro no puede ser guardado; 0 si no se hicieron cambios en el registro,
  // 1 si el registro los cambios fueron almacenados
  //
  // PARÁMETROS
  // $l_resultado:=AS_fSave
  // $0: Longint
  // ----------------------------------------------------
C_LONGINT:C283($0)

C_BOOLEAN:C305($b_isNewRecord)
C_LONGINT:C283($i;$p)

ARRAY LONGINT:C221($alSTR_idsAlumnos;0)
If (False:C215)
	C_LONGINT:C283(AS_fSave ;$0)
End if 
C_BOOLEAN:C305(modNotas;modTimeTable;modObservaciones;modObjetivos)



  // CODIGO PRINCIPAL
If ((KRL_RegistroFueModificado (->[Asignaturas:18])) | (modNotas) | (modTimeTable) | (modObservaciones) | (modObjetivos))
	If (([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"") & ([Asignaturas:18]Numero_del_Nivel:6#0))
		$b_isNewRecord:=Is new record:C668([Asignaturas:18])
		
		If ($b_isNewRecord)
			AS_PropEval_Inicializa 
			AS_AsignaMatrizPorDefecto 
		End if 
		
		  // en Chile, la modificación del atributo "electiva" en asignaturas Lengua Castellan@ o matematica puede afectar la situación final del alumno
		If ((Not:C34($b_isNewRecord)) & (<>vtXS_CountryCode="cl") & (KRL_FieldChanges (->[Asignaturas:18]Electiva:11)) & (([Asignaturas:18]Asignatura:3="Lengua Castellan@") | ([Asignaturas:18]Asignatura:3="Matematica@")))
			EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
			DISTINCT VALUES:C339([Alumnos_Calificaciones:208]ID_Alumno:6;$alSTR_idsAlumnos)
			For ($i;1;Size of array:C274($alSTR_idsAlumnos))
				BM_CreateRequest ("Recalcular situación";String:C10($alSTR_idsAlumnos{$i});String:C10($alSTR_idsAlumnos{$i}))
			End for 
		End if 
		
		Case of 
			: (modNotas)
				AS_TareasPostEdicionNotas 
				
			: (modObservaciones)
				  //
			: (modObjetivos)
				AS_GuardaObjetivos 
				
			: (vbEVLG_EvaluacionesModificadas)
				If (VlEVLG_currentID>0)
					AS_EVLG_SaveEvaluaciones ([Asignaturas:18]Numero:1;vlEVLG_nivelEvaluacion;VlEVLG_currentID;vl_PeriodoSeleccionado)
				End if 
				
			Else 
				LOG_RegisterEvt ("Asignaturas - Modificación de las propiedades: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);[Asignaturas:18]Numero:1)
				SAVE RECORD:C53([Asignaturas:18])
				If ($b_isNewRecord)
					$p:=New process:C317("NIV_LoadArrays";Pila_256K)
					KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
				End if 
				
		End case 
		
		$0:=1
		RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
		
		
		
	Else 
		$0:=-1
	End if 
	
	
Else 
	$0:=0
End if 
