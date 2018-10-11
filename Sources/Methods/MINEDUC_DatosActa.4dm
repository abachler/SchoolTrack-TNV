//%attributes = {}
  //MINEDUC_DatosActa

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"En Trámite";*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"Oyente")

CREATE SET:C116([Alumnos:2];"Curso")
$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
$d2:=DT_GetDateFromDayMonthYear (1;5;<>gYear)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$d1)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_retiro:42>=$d2)
iMatDeb:=Records in selection:C76([Alumnos:2])
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
iMatDebH:=Records in selection:C76([Alumnos:2])
iMatDebF:=iMatDeb-iMatDebH

USE SET:C118("Curso")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="R")
iMatfin:=Records in selection:C76([Alumnos:2])
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
iMatfinH:=Records in selection:C76([Alumnos:2])
iMatfinF:=iMatfin-iMatfinH

USE SET:C118("Curso")
$d1:=DT_GetDateFromDayMonthYear (1;5;<>gYear)
$d2:=DT_GetDateFromDayMonthYear (29;11;<>gYear)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41>=$d1;*)
QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Fecha_de_Ingreso:41<=$d2)
iMatYear:=Records in selection:C76([Alumnos:2])
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
iMatYearH:=Records in selection:C76([Alumnos:2])
iMatYearF:=iMatYear-iMatYearH

USE SET:C118("Curso")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="Y")
iret:=Records in selection:C76([Alumnos:2])
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
iretH:=Records in selection:C76([Alumnos:2])
iretF:=iRet-iRetH

USE SET:C118("Curso")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="R";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="Y")
iTotalAlumnos:=Records in selection:C76([Alumnos:2])


ACTAS_Page1 