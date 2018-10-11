iconversionTable:=1
(OBJECT Get pointer:C1124(Object named:K67:5;"conversion_tabla"))->:=Choose:C955(iconversionTable=1;1;0)
(OBJECT Get pointer:C1124(Object named:K67:5;"conversion_matematica"))->:=Choose:C955(iconversionTable=0;1;0)

READ WRITE:C146([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]NotaOficial_conEstiloAsignatura:95:=True:C214)
UNLOAD RECORD:C212([Asignaturas:18])

EVS_SetModified 