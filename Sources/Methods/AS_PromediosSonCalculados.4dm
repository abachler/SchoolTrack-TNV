//%attributes = {}
  // MÉTODO: AS_PromediosSonCalculados
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 10/12/11, 11:59:20
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Retorna TRUE cuando se cumplen las tres siguientes condiciones:
  //  - el atributo [Asignaturas]Resultado_no_calculado es FALSE
  //  - el atributo [MPA_AsignaturasMatrices]Convertir_a_Notas de la matriz de evaluación asignada a la asignatura es FALSE
  //  - el modo de calculo del resultado definido en el estilo de evaluación asociado
  //
  // PARÁMETROS
  // $b_PromediosCalculables:=AS_PromediosSonCalculados({ID_Asignatura})
  // $1: --> Longint: ID de la asignatura
  // $0: <--Boolean: promedios son editables
  // Si el parametro ID_Asignatura es omitido se leen los atributos del registro en memoria
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_Conversion_a_notas;$b_ResultadoNoCalculado)
C_LONGINT:C283($l_EstiloEvaluacionActual;$l_ID_EstiloEvaluacion;$l_ID_MatrizEvaluacion;$l_IdAsignatura;$l_modoCalculoResultados)

If (False:C215)
	C_BOOLEAN:C305(AS_PromediosSonCalculados ;$0)
	C_LONGINT:C283(AS_PromediosSonCalculados ;$1)
End if 


  // CODIGO PRINCIPAL
If (Count parameters:C259=1)
	$l_IdAsignatura:=$1
Else 
	$l_IdAsignatura:=[Asignaturas:18]Numero:1
End if 

If (Asserted:C1132($l_IdAsignatura>0;"No se puede determinar para que asignatura se intenta obtener la propiedad 'Promedios son calculados'"))
	
	
	If ($l_IdAsignatura#[Asignaturas:18]Numero:1)
		$b_ResultadoNoCalculado:=KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]Resultado_no_calculado:47)
		$l_ID_MatrizEvaluacion:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]EVAPR_IdMatriz:91)
		$l_ID_EstiloEvaluacion:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	Else 
		$l_ID_EstiloEvaluacion:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
		$b_ResultadoNoCalculado:=[Asignaturas:18]Resultado_no_calculado:47
		$l_ID_MatrizEvaluacion:=[Asignaturas:18]EVAPR_IdMatriz:91
	End if 
	
	If (vlEVS_CurrentEvStyleID#$l_ID_EstiloEvaluacion)
		$l_EstiloEvaluacionActual:=vlEVS_CurrentEvStyleID
		EVS_ReadStyleData ($l_ID_EstiloEvaluacion)
		$l_modoCalculoResultados:=iResults
		EVS_ReadStyleData ($l_EstiloEvaluacionActual)
	Else 
		$l_modoCalculoResultados:=iResults
	End if 
	
	$b_Conversion_a_notas:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_ID_MatrizEvaluacion;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
	
	If ((($b_Conversion_a_notas=False:C215) & ($b_ResultadoNoCalculado=False:C215)) & ($l_modoCalculoResultados#3))
		$0:=True:C214
	End if 
End if 