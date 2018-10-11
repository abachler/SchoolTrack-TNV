//%attributes = {}
  //CU_LoadArrays

READ ONLY:C145([Cursos:3])
QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesActivos)
CREATE SET:C116([Cursos:3];"normales")
QUERY:C277([Cursos:3];[Cursos:3]Curso:1;=;"@ADT")
CREATE SET:C116([Cursos:3];"admision")
DIFFERENCE:C122("normales";"admision";"normales")
USE SET:C118("normales")
SET_ClearSets ("normales";"admision";"normales")
ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1)
ARRAY TEXT:C222(<>aCursos;0)
ARRAY LONGINT:C221(<>aCUNivNo;0)
ARRAY TEXT:C222(<>aCUNivNme;0)
ARRAY TEXT:C222(<>aCUSection;0)
SELECTION TO ARRAY:C260([Cursos:3]Curso:1;<>aCursos;[Cursos:3]Nivel_Numero:7;<>aCUNivNo;[Cursos:3]Ciclo:5;<>aCUSection;[Cursos:3]Nivel_Nombre:10;<>aCUNivNme)
ARRAY TEXT:C222(aClassSel;0)
