//%attributes = {}
  //QA_EliminaHistoricos


vQR_Long1:=Num:C11(Request:C163("Eliminar registros históricos del año: ";String:C10(<>gYear);"Eliminar";"Cancelar"))

QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=vQR_Long1)
KRL_DeleteSelection (->[Alumnos_Calificaciones:208])

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=vQR_Long1)
KRL_DeleteSelection (->[Alumnos_SintesisAnual:210])

QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=vQR_Long1)
KRL_DeleteSelection (->[Alumnos_Historico:25])

QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5=vQR_Long1)
KRL_DeleteSelection (->[Asignaturas_Historico:84])

QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3=vQR_Long1)
KRL_DeleteSelection (->[Asignaturas_SintesisAnual:202])

QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=vQR_Long1)
KRL_DeleteSelection (->[Cursos_SintesisAnual:63])

QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=vQR_Long1)
KRL_DeleteSelection (->[Cursos_SintesisAnual:63])