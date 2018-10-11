//%attributes = {}
  // Método: EV2_CalculoALT_CalculoPromedios
  //
  // 
  // por Alberto Bachler Klein
  // creación 13/07/17, 09:03:32
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_calcularPromedioFinal;$b_EsAsignaturaMadre;$b_finalModificado;$b_promediosModificados)
C_LONGINT:C283($l_EstiloEvaluacion;$l_NumeroNivel;$l_Periodo;$l_recordNumber;$l_asignaturasHijas)

If (False:C215)
	C_BOOLEAN:C305(EV2_Calculos ;$0)
	C_LONGINT:C283(EV2_Calculos ;$1)
	C_LONGINT:C283(EV2_Calculos ;$2)
End if 

  //BMK_LocalExecutionTimer (True)

$l_recordNumber:=$1
$l_Periodo:=$2


Case of 
	: (iEvaluationMode=Notas)
		$l_modoAlternativo:=Puntos
	: (iEvaluationMode=Puntos)
		$l_modoAlternativo:=Notas
End case 


KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recordNumber;True:C214)
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)  // cargo el registro de asignaturas para leer sus propiedades
$l_NumeroNivel:=[Asignaturas:18]Numero_del_Nivel:6
$l_EstiloEvaluacion:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
$b_EsAsignaturaMadre:=(Find in field:C653([Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;[Asignaturas:18]Numero:1)>No current record:K29:2)
If (($b_EsAsignaturaMadre) & ([Asignaturas:18]Consolidacion_EsConsolidante:35=False:C215))
	KRL_ReloadInReadWriteMode (->[Asignaturas:18])
	[Asignaturas:18]Consolidacion_EsConsolidante:35:=True:C214
	SAVE RECORD:C53([Asignaturas:18])
End if 
$b_EsAsignaturaMadre:=[Asignaturas:18]Consolidacion_EsConsolidante:35 | [Asignaturas:18]Consolidacion_ConSubasignaturas:31

PERIODOS_LoadData ($l_NumeroNivel)
EVS_ReadStyleData ($l_EstiloEvaluacion)
AS_PropEval_Lectura ("";$l_Periodo)


If (AS_PromediosSonCalculados )
	
	If ($l_Periodo>0)
		$b_promediosModificados:=EV2_CalculoALT_PromedioPeriodo ($l_recordNumber;$l_Periodo)
		  // si el número de período pasado en $2 es superior a 0 se calculan los promedios del período
	End if 
	
	$b_finalModificado:=EV2_CalculoALT_PromediosFinales ($l_recordNumber)
	
	  //$b_aprobacionModificada:=EV2_AprobacionReprobacion 
	
	  // nos aseguramos de almacenar el registro si hubo cambios en la aprobación o cambios en calificaciones aunque no hayan cambios en los promedios
	  //If ($b_aprobacionModificada | EV2_CalificacionesModificadas )
	  //SAVE RECORD([Alumnos_Calificaciones])
	  //KRL_ReloadAsReadOnly (->[Alumnos_Calificaciones])
	  //End if 
	
	  // si la asignatura es una asignatura hija
	  //If (([Asignaturas]Nivel_Jerarquico>0) & ($b_finalModificado | $b_promediosModificados))
	  //EV2_LanzaProcesoConsolidacion ([Alumnos_Calificaciones]ID_Asignatura;[Alumnos_Calificaciones]ID_Alumno;$l_Periodo)
	  //End if 
	
	
	
	$0:=($b_finalModificado | $b_promediosModificados)
	
End if 

  //BMK_LocalExecutionTimer (False)


