  //[xxSTR_Niveles].ReplaceSubjet.bTransferirConEvaluaciones
C_LONGINT:C283($registrosSubAsignaturas)

READ ONLY:C145([xxSTR_Subasignaturas:83])
SET QUERY DESTINATION:C396(Into variable:K19:4;$registrosSubAsignaturas)
QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=vl_SrcSubject)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($registrosSubAsignaturas>0)
	$t_mensaje:=__ ("Los alumnos seleccionados tienen evaluaciones en sub-asignaturas.\r")
	$t_mensaje:=$t_mensaje+__ ("Serán transferidos al curso de destino conservando sólo los promedios de las sub-asignaturas, no así el detalle de las evaluaciones registradas en las sub-asignaturas de las asignaturas del curso de origen.\r\r")
	$t_mensaje:=$t_mensaje+__ ("¿Desea continuar con la transferencia de alumnos?")
	$r:=ModernUI_Notificacion (__ ("Transferencia de alumnos a otro curso");$t_mensaje;__ ("Cancelar");__ ("Continuar"))
Else 
	$r:=2
End if 

If ($r=2)
	START TRANSACTION:C239
	$l_recNumAsignaturaActual:=Record number:C243([Asignaturas:18])
	OK:=EV2_TransfiereEvaluaciones (vl_SrcSubject;aPErepId{aPERep};->aIDStudent2Transfer)
	$l_idDestino:=aPErepId{aPERep}
	
	
	If (ok=1)
		VALIDATE TRANSACTION:C240
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_idDestino)
		ASsev_Parcial_a_Subasignatura 
		KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignaturaActual;True:C214)
		AS_CreaTareasRecalculos (aPErepId{aPERep};->aIDStudent2Transfer)
		AS_CreaTareasRecalculos (vl_SrcSubject;->aIDStudent2Transfer)
	Else 
		CD_Dlog (0;__ ("La operación no pudo ser llevada a término satisfactoriamente.\rNinguna modificación fue registrada.\rPor favor inténtelo nuevamente mas tarde."))
		CANCEL TRANSACTION:C241
	End if 
End if 





