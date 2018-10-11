//%attributes = {}
  // Método: EV2_CalculoALT_PromediosFinales
  //
  // 
  // por Alberto Bachler Klein
  // creación 13/07/17, 11:13:23
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_LONGINT:C283($1;$l_recNum)
C_REAL:C285(vrEVS_PonderacionB1;vrEVS_PonderacionB2;vrEVS_PonderacionB3;vrEVS_PonderacionB4;vrEVS_PonderacionB5)
C_REAL:C285(vrEVS_PonderacionT1;vrEVS_PonderacionT2;vrEVS_PonderacionT3)
C_REAL:C285(vrEVS_PonderacionS1;vrEVS_PonderacionS2;$ponderacion)
C_BOOLEAN:C305(vb_RecalcularTodo;$b_calificacionesModificadas)

$l_recNum:=$1
Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
End case 


If ($l_recNum>=0)
	$estiloActual:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
	
	RELATE ONE:C42([Alumnos_Calificaciones:208]Llave_principal:1)
	RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
	
	
	AS_PropEval_Lectura   //agregado ASM ticket 126102
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	If ([Asignaturas:18]Resultado_no_calculado:47=False:C215)
		PERIODOS_LoadData ([Alumnos_Calificaciones:208]NIvel_Numero:4)
		
		
		  //AS_LeeOpcionesExamenes 
		EV2_Examenes_LeeConfigExamenes 
		EV2_CalculoALT_PromedioAnual 
		EV2_CalculoALT_PromedioFinal 
		EV2_CalculoALT_NotaOficial (iPrintActa)
		
		
		  // nos aseguramos que el registro sea almacenado si alguna calificación ha sido modificada
		  // sin importar cambios en los promedios
		$b_calificacionesModificadas:=EV2_CalificacionesModificadas  | vb_RecalcularTodo
		  //$b_calificacionesModificadas:=$b_calificacionesModificadas | EV2_AprobacionReprobacion 
		If ($b_calificacionesModificadas | vb_RecalcularTodo)
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
		End if 
		EVS_ReadStyleData ($estiloActual)
		
		
		$0:=$b_calificacionesModificadas
	End if 
End if 
