  //[xxSTR_Niveles].ReplaceSubjet.bTransferirSinEvaluaciones



C_LONGINT:C283($i)

QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=vl_SrcSubject)
$nombreInternoOrigen:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5

READ WRITE:C146([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=aPErepId{aPERep})
$nombreInternoDestino:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5

START TRANSACTION:C239
$pId:=IT_UThermometer (1;0;__ ("Transfiriendo alumnos sin evaluaciones a ")+$nombreInternoDestino)
  //ACTUALIZACIÓN CONTADORES EN ASIGNATURA DE DESTINO
READ WRITE:C146([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=aPErepId{aPERep})
$nombreInternoDestino:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)

ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10;<)
If (([Asignaturas:18]Numero_de_alumnos:49#Records in selection:C76([Alumnos_Calificaciones:208])) | ([Asignaturas:18]LastNumber:54#[Alumnos_Calificaciones:208]NoDeLista:10))
	KRL_GotoRecord (->[Asignaturas:18];Record number:C243([Asignaturas:18]);True:C214)
	[Asignaturas:18]LastNumber:54:=[Alumnos_Calificaciones:208]NoDeLista:10
	[Asignaturas:18]Numero_de_alumnos:49:=Records in selection:C76([Alumnos_Calificaciones:208])
	SAVE RECORD:C53([Asignaturas:18])
End if 
OK:=EV2_EliminaEvaluaciones (vl_SrcSubject;->aIDStudent2Transfer)

If (OK=1)
	For ($i;1;Size of array:C274(aIDStudent2Transfer))
		AS_CreaRegistrosEvaluacion (aIDStudent2Transfer{$i};aPErepId{aPERep})
	End for 
	UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
End if 

$pId:=IT_UThermometer (-2;$pId)


If (OK=1)
	READ ONLY:C145([Alumnos:2])
	For ($i;1;Size of array:C274(aIDStudent2Transfer))
		$recNum:=Find in field:C653([Alumnos:2]numero:1;aIDStudent2Transfer{$i})
		If ($recNum>=0)
			GOTO RECORD:C242([Alumnos:2];$recNum)
			LOG_RegisterEvt ([Alumnos:2]apellidos_y_nombres:40+" ("+[Alumnos:2]curso:20+") transferido sin evaluaciones desde "+$nombreInternoOrigen+" a "+$nombreInternoDestino)
		End if 
	End for 
	OK:=1
End if 




If (OK=1)
	VALIDATE TRANSACTION:C240
	AS_CreaTareasRecalculos (vl_SrcSubject;->aIDStudent2Transfer)
Else 
	OK:=0
	CANCEL TRANSACTION:C241
End if 