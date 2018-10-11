//%attributes = {}
  //EVS_RecalAsignaturas

  //OldIndicador:=""
  //EvStyleID:=0
  //
  //xblob:=$1
  //
  //BLOB_Blob2Vars (->xblob;0;->OldIndicador;->EvStyleID)
  //
  //READ ONLY([Alumnos_ComplementoEvaluacion])
  //QUERY([Asignaturas];[Asignaturas]Numero_de_EstiloEvaluacion=EvStyleID)
  //KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion]ID_Asignatura;->[Asignaturas]Numero)
  //QUERY SELECTION([Alumnos_ComplementoEvaluacion];[Alumnos_ComplementoEvaluacion]Año=◊gYear)
  //QUERY SELECTION([Alumnos_ComplementoEvaluacion];[Alumnos_ComplementoEvaluacion]P01_Esfuerzo=OldIndicador;*)
  //QUERY SELECTION([Alumnos_ComplementoEvaluacion]; | [Alumnos_ComplementoEvaluacion]P02_Esfuerzo=OldIndicador;*)
  //QUERY SELECTION([Alumnos_ComplementoEvaluacion]; | [Alumnos_ComplementoEvaluacion]P03_Esfuerzo=OldIndicador;*)
  //QUERY SELECTION([Alumnos_ComplementoEvaluacion]; | [Alumnos_ComplementoEvaluacion]P04_Esfuerzo=OldIndicador;*)
  //QUERY SELECTION([Alumnos_ComplementoEvaluacion]; | [Alumnos_ComplementoEvaluacion]P05_Esfuerzo=OldIndicador)
  //KRL_RelateSelection (->[Asignaturas]Numero;->[Alumnos_ComplementoEvaluacion]ID_Asignatura;"")
  //
  //
  //ARRAY BOOLEAN($aRegistraEsfuerzo;Records in selection([Asignaturas]))
  //ARRAY BOOLEAN($aPonderaEsfuerzo;Records in selection([Asignaturas]))
  //$registra:=(cb_EvaluaEsfuerzo=1)
  //$pondera:=(AT_GetSumArray (->aFactorEsfuerzo)>0)
  //AT_Populate (->$aRegistraEsfuerzo;->$registra)
  //AT_Populate (->$aPonderaEsfuerzo;->$pondera)
  //KRL_Array2Selection (->$aRegistraEsfuerzo;->[Asignaturas]Ingresa_Esfuerzo;->$aPonderaEsfuerzo;->[Asignaturas]Pondera_Esfuerzo)
  //AS_RecalcAverages 
  //UNLOAD RECORD([Asignaturas])
  //READ ONLY([Asignaturas])
  //
  //$0:=True