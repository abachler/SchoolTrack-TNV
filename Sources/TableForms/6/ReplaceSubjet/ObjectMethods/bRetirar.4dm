  //[xxSTR_Niveles].ReplaceSubjet.bRetirar


QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=vl_SrcSubject)


START TRANSACTION:C239
OK:=EV2_EliminaEvaluaciones (vl_SrcSubject;->aIDStudent2Transfer)

If (OK=1)
	VALIDATE TRANSACTION:C240
	AS_CreaTareasRecalculos (vl_SrcSubject;->aIDStudent2Transfer)
Else 
	OK:=0
	CANCEL TRANSACTION:C241
End if 

