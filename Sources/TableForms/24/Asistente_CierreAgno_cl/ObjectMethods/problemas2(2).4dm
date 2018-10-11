<>iptMenu:=2

$vy_currentTable:=yBWR_currentTable  //20101102 RCH Dentro de AL_RecalcFinalSituation se ocupa un set de alumnos...
yBWR_currentTable:=->[Alumnos:2]

QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
CREATE SET:C116([Alumnos:2];"$RecordSet_Table"+String:C10(Table:C252(->[Alumnos:2])))
AL_RecalcFinalSituation 
  //USE SET("RecordSet_Table"+String(Table(yBWR_currentTable)))
  //QUERY SELECTION([Alumnos];[Alumnos]Situacion_final#"P")


QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
CREATE SET:C116([Alumnos:2];"Alumnos")
vi_TotalAlumnos:=Records in selection:C76([Alumnos:2])
USE SET:C118("Alumnos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P")
vi_alumnosPromovidos:=Records in selection:C76([Alumnos:2])
USE SET:C118("Alumnos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="R")
vi_alumnosReprobados:=Records in selection:C76([Alumnos:2])
USE SET:C118("Alumnos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="Y")
vi_alumnosRetirados:=Records in selection:C76([Alumnos:2])
USE SET:C118("Alumnos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="X")
vi_alumnosEspeciales:=Records in selection:C76([Alumnos:2])
USE SET:C118("Alumnos")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??")
vi_alumnosPendientes:=Records in selection:C76([Alumnos:2])
_O_ENABLE BUTTON:C192(bPrev)
If (vi_AlumnosPendientes>0)
	_O_DISABLE BUTTON:C193(bNext)
	OBJECT SET VISIBLE:C603(*;"problemas2@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"problemas2@";False:C215)
	_O_ENABLE BUTTON:C192(bNext)
End if 

yBWR_currentTable:=$vy_currentTable