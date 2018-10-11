//%attributes = {}
  //SN3_ParseConfigXML

C_POINTER:C301($1;$data)

$data:=$1
BLOB_ExpandBlob_byPointer ($data)

If (BLOB size:C605($data->)>0)
	$xmlRef:=DOM Parse XML variable:C720($data->)
	cb_PublicarAgenda:=Num:C11(DOM_GetValue ($xmlRef;"opciones/agenda/publicar"))
	cb_AgEnvioAutoAlu:=Num:C11(DOM_GetValue ($xmlRef;"opciones/agenda/envioautomaticoalumnos"))  //MONO 02-04-2013: opciones de envio autmatico de eventos de agenda
	cb_AgEnvioAutoRel:=Num:C11(DOM_GetValue ($xmlRef;"opciones/agenda/envioautomaticorelaciones"))
	cb_PublicarEvaluaciones:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/publicar"))
	cb_PublicarEvPromGralAlumno:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/promediosgenerales"))
	rNombreInterno:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/designacion/nombreinterno"))
	rNombreOficial:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/designacion/nombreoficial"))
	PF_Prom_Interno:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/designacion/promediointerno"))
	PF_Prom_Oficial:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/designacion/promediooficial"))
	cb_PublicarResGralAsignatura:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/resgeneralesasig/publicar"))
	cb_PublicarResGralMinimo:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/resgeneralesasig/minimo"))
	cb_PublicarResGralMedia:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/resgeneralesasig/media"))
	cb_PublicarResGralMaximo:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/resgeneralesasig/maximo"))
	cb_PublicarEEsfuerzo:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/esfuerzo"))
	cb_PublicarEParciales:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/parciales"))
	cb_PublicarECP:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/cp"))
	cb_PublicarEPP:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/pps"))
	cb_PublicarEPA:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/pa"))
	cb_PublicarEExamen:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/ex"))
	cb_PublicarEEXX:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/exx"))
	cb_PublicarENF:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/columnas/nf"))
	cb_MostrarDetalle:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcioneshijas/detalle"))
	cb_PublicarEPonderacion:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcioneshijas/ponderacion"))
	cb_OcultaParcialesMadre:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcioneshijas/ocultarparcialesmadre"))
	cb_HijasDesplegadas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcioneshijas/hijasdesplegadas"))
	cb_Publicar_Cal_Nota:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/notanum"))
	cb_Publicar_Cal_Puntos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/puntos"))
	cb_Publicar_Cal_Porcentaje:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/porcentaje"))
	cb_Publicar_Cal_Simbolos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/simbolos"))
	cbOcultarPeriodo1:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p1/visible"))=1))
	cbOcultarPeriodo2:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p2/visible"))=1))
	cbOcultarPeriodo3:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p3/visible"))=1))
	cbOcultarPeriodo4:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p4/visible"))=1))
	cbOcultarPeriodo5:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p5/visible"))=1))
	vdHastaPeriodo1:=Date:C102(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p1/visibledesde"))
	vdHastaPeriodo2:=Date:C102(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p2/visibledesde"))
	vdHastaPeriodo3:=Date:C102(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p3/visibledesde"))
	vdHastaPeriodo4:=Date:C102(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p4/visibledesde"))
	vdHastaPeriodo5:=Date:C102(DOM_GetValue ($xmlRef;"opciones/calificaciones/periodosvisibles/p5/visibledesde"))
	
	cb_PublicarConducta:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/publicar"))  //MONO TICKET 209421
	cb_PublicarAnotaciones:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/publicar"))
	cb_PublicarAnotObs:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/observaciones"))
	cb_PublicarAnotAutor:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/profesor"))
	cb_PublicarAMailProf:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/emailprofesor"))
	cb_PublicarAnotacionesPositivas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/positivas"))
	cb_PublicarAnotacionesNegativas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/negativas"))
	cb_PublicarAnotacionesNeutras:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/neutras"))
	cb_PublicarCastigos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/castigos/publicar"))
	cb_PublicarCastigosObs:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/castigos/observaciones"))
	cb_PublicarCastigosProfesor:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/castigos/profesor"))
	cb_PublicarCMailProf:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/castigos/emailprofesor"))
	cb_PublicarSuspensiones:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/suspensiones/publicar"))
	cb_PublicarSuspObs:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/suspensiones/observaciones"))
	cb_PublicarSuspProfesor:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/suspensiones/profesor"))
	cb_PublicarSMailProf:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/suspensiones/emailprofesor"))
	cb_PublicarCondicionalidad:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/condicionalidad/publicar"))
	
	  //MONO TICKET 209421
	cb_PublicarAsistencia:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/publicar"))
	cb_PublicarInasistencias:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/inasistencias/publicar"))
	cb_PublicarAtrasos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/atrasos/publicar"))
	cb_PublicarAtrasosObs:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/atrasos/observaciones"))
	cb_PublicarAtrasosInter:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/atrasos/intersesiones"))
	cb_PublicarPctAsistencia:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/porcasistencia/publicar"))
	cb_PublicarInaxAtraso:=Num:C11(DOM_GetValue ($xmlRef;"opciones/asistencia/inasistencias/inasistenciaporatrasos"))
	
	cb_PublicarCompaneros:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/publicar"))
	cb_PublicarCompNivel:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/publicarnivel"))
	cb_PublicarCompColegio:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/publicarcolegio"))
	cb_PublicarCompEMail:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/email"))
	cb_PublicarCompTelefono:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/telefono"))
	cb_PublicarCompCelular:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/celular"))
	cb_PublicarCompDireccion:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/direccion"))
	cb_PublicarCompCumpleanos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/cumpleanos"))
	cb_PublicarCompEMailM:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/emailmadre"))
	cb_PublicarCompCelularM:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/celularmadre"))
	cb_PublicarCompEMailP:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/emailpadre"))
	cb_PublicarCompCelularP:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/celularpadre"))
	
	cb_PublicarHorario:=Num:C11(DOM_GetValue ($xmlRef;"opciones/horario/publicar"))
	cb_vernumbloques:=Num:C11(DOM_GetValue ($xmlRef;"opciones/horario/verbloques"))  //MONO  01-07-2013: ver num bloque en vez de hora 
	
	cb_PublicarObservaciones:=Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/publicar"))
	cb_PublicarObsPJ:=Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/obspj"))
	cb_PublicarObsAsignaturas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/obsasignaturas"))
	cbOcultarPeriodo1_Obs:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p1/visible"))=1))
	cbOcultarPeriodo2_Obs:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p2/visible"))=1))
	cbOcultarPeriodo3_Obs:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p3/visible"))=1))
	cbOcultarPeriodo4_Obs:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p4/visible"))=1))
	cbOcultarPeriodo5_Obs:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p5/visible"))=1))
	vdHastaPeriodo1_Obs:=Date:C102(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p1/visibledesde"))
	vdHastaPeriodo2_Obs:=Date:C102(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p2/visibledesde"))
	vdHastaPeriodo3_Obs:=Date:C102(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p3/visibledesde"))
	vdHastaPeriodo4_Obs:=Date:C102(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p4/visibledesde"))
	vdHastaPeriodo5_Obs:=Date:C102(DOM_GetValue ($xmlRef;"opciones/observaciones/periodosvisibles/p5/visibledesde"))
	
	cb_PublicarEnfermeria:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/publicar"))
	cb_PublicarVisitas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/visitas"))
	cb_PublicarVisitasViejas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/visitasviejas"))
	cb_PublicarCM:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/controles"))
	
	cb_PublicarPlanes:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicar"))
	  //MONO 13-03-2012: Se agrega opción para publicación de archivos adjuntos de planes de clases
	cb_PublicarAdjuntosPlanes:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/soloadjuntosyreferencias"))
	  //MONO  01-07-2013: detalle de publicación planes de clases
	cb_PC_Notasalalumno:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicanotaalumno"))
	cb_PC_Objetivos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicaobjetivos"))
	cb_PC_Contenidos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicacontenidos"))
	cb_PC_Actividades:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicaactividades"))
	cb_PC_Tareas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicatareas"))
	cb_PC_Evaluacion:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicaevaluacion"))
	
	cb_PublicarEMailPJ:=Num:C11(DOM_GetValue ($xmlRef;"opciones/generales/mailpj"))
	cb_ApodAcadSameApodCta:=Num:C11(DOM_GetValue ($xmlRef;"opciones/generales/visibleapoacademico"))  //MONO Ticket 191729
	
	cb_PublicarAE:=Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/publicar"))
	cb_PublicarFechas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/fechas"))
	cbOcultarPeriodo1_Ap:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p1/visible"))=1))
	cbOcultarPeriodo2_Ap:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p2/visible"))=1))
	cbOcultarPeriodo3_Ap:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p3/visible"))=1))
	cbOcultarPeriodo4_Ap:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p4/visible"))=1))
	cbOcultarPeriodo5_Ap:=Num:C11(Not:C34(Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p5/visible"))=1))
	vdHastaPeriodo1_Ap:=Date:C102(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p1/visibledesde"))
	vdHastaPeriodo2_Ap:=Date:C102(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p2/visibledesde"))
	vdHastaPeriodo3_Ap:=Date:C102(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p3/visibledesde"))
	vdHastaPeriodo4_Ap:=Date:C102(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p4/visibledesde"))
	vdHastaPeriodo5_Ap:=Date:C102(DOM_GetValue ($xmlRef;"opciones/aprendizajes/periodosvisibles/p5/visibledesde"))
	
	cb_PublicarAct:=Num:C11(DOM_GetValue ($xmlRef;"opciones/actividades/publicar"))
	cb_PublicarProfesores:=Num:C11(DOM_GetValue ($xmlRef;"opciones/profesores/publicar"))  //MONO 06-11-13: pub profesores
	cb_ProfesorNoMostrarMail:=Num:C11(DOM_GetValue ($xmlRef;"opciones/profesores/nomostrarmail"))  //MONO 22-05-14: opcion email profe
	
	  //ACT
	cb_PublicarAvisos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/avisos/publicar"))
	cb_PublicarSaldoAnterior:=Num:C11(DOM_GetValue ($xmlRef;"opciones/avisos/saldoanterior"))
	cb_PublicarIntereses:=Num:C11(DOM_GetValue ($xmlRef;"opciones/avisos/intereses"))
	cb_PublicarDetalleAvisos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/avisos/detalle"))
	cb_PublicarPDF:=Num:C11(DOM_GetValue ($xmlRef;"opciones/avisos/publicarpdf"))
	
	cb_PublicarPagos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/pagos/publicar"))
	cb_PublicarDisponible:=Num:C11(DOM_GetValue ($xmlRef;"opciones/pagos/disponible"))
	cb_PublicarForma:=Num:C11(DOM_GetValue ($xmlRef;"opciones/pagos/formadepago"))
	
	cb_PublicarBoletas:=Num:C11(DOM_GetValue ($xmlRef;"opciones/documentostributarios/publicar"))
	
	  //MT
	cb_PublicarPrestamos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/prestamos/publicar"))
	cb_AlertarAtrasos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/prestamos/alertar"))
	vl_DiasAlertaPrestamos:=Num:C11(DOM_GetValue ($xmlRef;"opciones/prestamos/dias"))
	
	  //FOTOGRAFIAS
	cb_PublicarFotografias:=Num:C11(DOM_GetValue ($xmlRef;"opciones/fotografias/publicar"))
	cb_PublicarFotosAlumno:=Num:C11(DOM_GetValue ($xmlRef;"opciones/fotografias/alumnos"))
	cb_PublicarFotoPJ:=Num:C11(DOM_GetValue ($xmlRef;"opciones/fotografias/pj"))
	cb_PublicarFotoProfesores:=Num:C11(DOM_GetValue ($xmlRef;"opciones/fotografias/profesores"))
	cb_PublicarFotoCompaneros:=Num:C11(DOM_GetValue ($xmlRef;"opciones/fotografias/companeros"))
	
	  //CMT
	cb_PublicarComunicaciones:=Num:C11(DOM_GetValue ($xmlRef;"opciones/comunicaciones/publicar"))
	cb_CommCicloActual:=Num:C11(DOM_GetValue ($xmlRef;"opciones/comunicaciones/solocicloactual"))  //MONO solo ciclo actual de comunicaciones
	
	  //INFORMES -  //MONO 06-11-13: pub informes
	cb_PublicarInformes:=Num:C11(DOM_GetValue ($xmlRef;"opciones/informes/publicar"))
	
	  //SESIONES//MONO 22-05-14: pub sesiones
	cb_PublicarSesiones:=Num:C11(DOM_GetValue ($xmlRef;"opciones/sesiones/publicar"))
	
	  //MATERIAL DOCENTE
	cb_PublicarMaterial:=Num:C11(DOM_GetValue ($xmlRef;"opciones/MaterialDocente/publicar"))
	vd_fecha_desde:=Date:C102(DOM_GetValue ($xmlRef;"opciones/MaterialDocente/fecha_desde"))
	
	  // HOME NOTICIAS TICKET 198851
	cb_PublicarHome:=Num:C11(DOM_GetValue ($xmlRef;"opciones/homeNoticias/publicar"))
	vt_linkHome:=DOM_GetValue ($xmlRef;"opciones/homeNoticias/link")
	
	DOM CLOSE XML:C722($xmlRef)
End if 