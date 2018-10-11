//%attributes = {}
  //UD_vSTX_InicializaAprendizajes

READ WRITE:C146([MPA_DefinicionEjes:185])
ALL RECORDS:C47([MPA_DefinicionEjes:185])
DELETE SELECTION:C66([MPA_DefinicionEjes:185])

READ WRITE:C146([MPA_DefinicionDimensiones:188])
ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
DELETE SELECTION:C66([MPA_DefinicionDimensiones:188])

READ WRITE:C146([MPA_DefinicionCompetencias:187])
ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
DELETE SELECTION:C66([MPA_DefinicionCompetencias:187])

READ WRITE:C146([MPA_AsignaturasMatrices:189])
ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
DELETE SELECTION:C66([MPA_AsignaturasMatrices:189])

READ WRITE:C146([MPA_ObjetosMatriz:204])
ALL RECORDS:C47([MPA_ObjetosMatriz:204])
DELETE SELECTION:C66([MPA_ObjetosMatriz:204])

READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
DELETE SELECTION:C66([Alumnos_EvaluacionAprendizajes:203])

