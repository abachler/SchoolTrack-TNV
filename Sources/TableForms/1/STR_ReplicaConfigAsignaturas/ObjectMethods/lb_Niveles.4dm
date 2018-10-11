QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=<>al_NumeroNivelesActivos{<>at_NombreNivelesActivos})
SELECTION TO ARRAY:C260([Cursos:3]Curso:1;at_CursoOrigen)
SORT ARRAY:C229(at_CursoOrigen;>)
COPY ARRAY:C226(at_CursoOrigen;at_CursosDestino)

LISTBOX SELECT ROW:C912(lb_Cursos;0;lk remove from selection:K53:3)
LISTBOX SELECT ROW:C912(lb_CursosDestino;0;lk remove from selection:K53:3)
LISTBOX SELECT ROW:C912(lb_Asignaturas;0;lk remove from selection:K53:3)

