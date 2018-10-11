  //MONO Ticket 174967 Status Alumnos
C_POINTER:C301($y_StatusAlumnoAlias;$y_StatusAlumnoVisible)
$y_StatusAlumnoAlias:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumnoAlias")
$y_StatusAlumnoVisible:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumnoVisible")
COPY ARRAY:C226($y_StatusAlumnoAlias->;<>at_StatusAlumnoAlias)
COPY ARRAY:C226($y_StatusAlumnoVisible->;<>ab_StatusAlumnoVisible)
ST_StatusAlumnoPrefSet (-><>at_StatusAlumnoAlias;-><>ab_StatusAlumnoVisible)
  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
$y_displayEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"displayEvaGral")
OB_SET (o_nomEvaGral;$y_displayEvaGral;String:C10(<>al_NumeroNivelesActivos{l_lbNivPosSel})+".display")
LOC_ObjNombreColumnasEval ("actualizar";->o_nomEvaGral)
o_nomEvaGral:=OB_Create 