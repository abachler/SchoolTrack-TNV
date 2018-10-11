//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 08-10-18, 12:29:49
  // ----------------------------------------------------
  // Método: UD_v20181008_FixSexoAlumnos
  // Descripción
  // Metodo se encarga de normalizar la letra del sexo de los alumnos a mayuscula.
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_procesoProgreso)
$l_procesoProgreso:=IT_Progress (1;0;0;"Normalizando genero de alumnos...")
ALL RECORDS:C47([Alumnos:2])
CREATE SET:C116([Alumnos:2];"$all")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
QUERY SELECTION BY FORMULA:C207([Alumnos:2];Not:C34((ST_ExactlyEqual ([Alumnos:2]Sexo:49;"F")=1)))
CREATE SET:C116([Alumnos:2];"$f_minuscula")
USE SET:C118("$all")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
QUERY SELECTION BY FORMULA:C207([Alumnos:2];Not:C34((ST_ExactlyEqual ([Alumnos:2]Sexo:49;"M")=1)))
CREATE SET:C116([Alumnos:2];"$m_minuscula")
UNION:C120("$f_minuscula";"$m_minuscula";"$all")
READ WRITE:C146([Alumnos:2])
USE SET:C118("$all")
APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Sexo:49:=Uppercase:C13([Alumnos:2]Sexo:49))
KRL_UnloadReadOnly (->[Alumnos:2])
SET_ClearSets ("$all";"$f_minuscula";"$m_minuscula")
$l_procesoProgreso:=IT_Progress (-1;$l_procesoProgreso)