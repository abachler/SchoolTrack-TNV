//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): asepulveda
  // Fecha y hora: 10-06-14, 15:09:58
  // ----------------------------------------------------
  // Método: AS_VerificaNombreHijaEnMadre
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

$l_IDAsignaturaHija:=$1

QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_IDAsignaturaHija)

  //Busco consolidantes
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5=[Asignaturas:18]Numero:1)
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;"")
SELECTION TO ARRAY:C260([Asignaturas:18];$al_RNAsigMadres)

For ($l_indice;1;Size of array:C274($al_RNAsigMadres))
	GOTO RECORD:C242([Asignaturas:18];$al_RNAsigMadres{$l_indice})
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		For ($l_IndicePeriodo;1;Size of array:C274(atSTR_Periodos_Nombre))
			GOTO RECORD:C242([Asignaturas:18];$al_RNAsigMadres{$l_indice})
			  //$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String($l_IndicePeriodo)
			  //MONO CAMBIO AS_PropEval_Lectura
			$t_NombreRegistroPropiedades:="P"+String:C10($l_IndicePeriodo)
			AS_PropEval_Lectura ($t_NombreRegistroPropiedades)
			For ($l_indiceHijas;1;Size of array:C274(alAS_EvalPropSourceID))
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$l_indiceHijas})
				If (Records in selection:C76([Asignaturas:18])>0)
					atAS_EvalPropSourceName{$l_indiceHijas}:=[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]"
				End if 
			End for 
			  //AS_PropEval_Escritura ($t_NombreRegistroPropiedades)
			AS_PropEval_Escritura ($l_IndicePeriodo)  //MONO CAMBIO AS_PropEval_Escritura
		End for 
	Else 
		  //MONO CAMBIO AS_PropEval_Lectura
		  //$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
		AS_PropEval_Lectura ("Anual")
		For ($l_indiceHijas;1;Size of array:C274(alAS_EvalPropSourceID))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$l_indiceHijas})
			If (Records in selection:C76([Asignaturas:18])>0)
				atAS_EvalPropSourceName{$l_indiceHijas}:=[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]"
			End if 
		End for 
		  //AS_PropEval_Escritura ($t_NombreRegistroPropiedades)
		AS_PropEval_Escritura (0)  //MONO CAMBIO AS_PropEval_Escritura
	End if 
	
End for 

$0:=True:C214
