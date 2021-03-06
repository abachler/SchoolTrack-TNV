//%attributes = {}
  //SN3_ModifyXMLEntry

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======

C_LONGINT:C283($1;$2;$3;$nivel;$entry)
C_BLOB:C604($data)

$nivel:=$1
$entry:=$2

If (($entry>=10000) | ($entry=AccountTrack))  // MONO 191729
	READ WRITE:C146([SN3_PublicationPrefs:161])
	QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=$nivel)
	BLOB_ExpandBlob_byPointer (->[SN3_PublicationPrefs:161]xData:2)
	SET BLOB SIZE:C606($data;0)
	$data:=[SN3_PublicationPrefs:161]xData:2
	$xmlRef:=DOM Parse XML variable:C720($data)
	Case of 
		: ($entry=SN3_DTi_EventosAgenda)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/agenda/publicar";String:C10(cb_PublicarAgenda))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/agenda/envioautomaticoalumnos";String:C10(cb_AgEnvioAutoAlu))  //MONO 02-04-2013: opciones de envio autmatico de eventos de agenda
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/agenda/envioautomaticorelaciones";String:C10(cb_AgEnvioAutoRel))
		: ($entry=SN3_DTi_Calificaciones)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/publicar";String:C10(cb_PublicarEvaluaciones))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/promediosgenerales";String:C10(cb_PublicarEvPromGralAlumno))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/designacion/nombreinterno";String:C10(rNombreInterno))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/designacion/nombreoficial";String:C10(rNombreOficial))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/designacion/promediointerno";String:C10(PF_Prom_Interno))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/designacion/promediooficial";String:C10(PF_Prom_Oficial))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/resgeneralesasig/publicar";String:C10(cb_PublicarResGralAsignatura))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/resgeneralesasig/minimo";String:C10(cb_PublicarResGralMinimo))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/resgeneralesasig/media";String:C10(cb_PublicarResGralMedia))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/resgeneralesasig/maximo";String:C10(cb_PublicarResGralMaximo))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/esfuerzo";String:C10(cb_PublicarEEsfuerzo))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/parciales";String:C10(cb_PublicarEParciales))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/cp";String:C10(cb_PublicarECP))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/pps";String:C10(cb_PublicarEPP))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/pa";String:C10(cb_PublicarEPA))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/ex";String:C10(cb_PublicarEExamen))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/exx";String:C10(cb_PublicarEEXX))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/columnas/nf";String:C10(cb_PublicarENF))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcioneshijas/detalle";String:C10(cb_MostrarDetalle))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcioneshijas/ponderacion";String:C10(cb_PublicarEPonderacion))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcioneshijas/ocultarparcialesmadre";String:C10(cb_OcultaParcialesMadre))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcioneshijas/hijasdesplegadas";String:C10(cb_HijasDesplegadas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/notanum";String:C10(cb_Publicar_Cal_Nota))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/puntos";String:C10(cb_Publicar_Cal_Puntos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/porcentaje";String:C10(cb_Publicar_Cal_Porcentaje))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/opcvisualizacioncalif/simbolos";String:C10(cb_Publicar_Cal_Simbolos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p1/visible";String:C10(Num:C11(cbOcultarPeriodo1=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p2/visible";String:C10(Num:C11(cbOcultarPeriodo2=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p3/visible";String:C10(Num:C11(cbOcultarPeriodo3=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p4/visible";String:C10(Num:C11(cbOcultarPeriodo4=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p5/visible";String:C10(Num:C11(cbOcultarPeriodo5=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p1/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo1))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p2/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo2))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p3/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo3))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p4/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo4))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/calificaciones/periodosvisibles/p5/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo5))
		: ($entry=SN3_DTi_Conducta)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/publicar";String:C10(cb_PublicarConducta))  //MONO 209421
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/publicar";String:C10(cb_PublicarAnotaciones))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/observaciones";String:C10(cb_PublicarAnotObs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/profesor";String:C10(cb_PublicarAnotAutor))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/emailprofesor";String:C10(cb_PublicarAMailProf))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/positivas";String:C10(cb_PublicarAnotacionesPositivas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/negativas";String:C10(cb_PublicarAnotacionesNegativas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/anotaciones/neutras";String:C10(cb_PublicarAnotacionesNeutras))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/castigos/publicar";String:C10(cb_PublicarCastigos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/castigos/observaciones";String:C10(cb_PublicarCastigosObs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/castigos/profesor";String:C10(cb_PublicarCastigosProfesor))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/castigos/emailprofesor";String:C10(cb_PublicarCMailProf))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/suspensiones/publicar";String:C10(cb_PublicarSuspensiones))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/suspensiones/observaciones";String:C10(cb_PublicarSuspObs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/suspensiones/profesor";String:C10(cb_PublicarSuspProfesor))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/suspensiones/emailprofesor";String:C10(cb_PublicarSMailProf))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/conducta/condicionalidad/publicar";String:C10(cb_PublicarCondicionalidad))
			
		: ($entry=10011)  //MONO 209421, ASISTENCIA
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/publicar";String:C10(cb_PublicarAsistencia))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/inasistencias/publicar";String:C10(cb_PublicarInasistencias))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/atrasos/publicar";String:C10(cb_PublicarAtrasos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/atrasos/observaciones";String:C10(cb_PublicarAtrasosObs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/atrasos/intersesiones";String:C10(cb_PublicarAtrasosInter))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/porcasistencia/publicar";String:C10(cb_PublicarPctAsistencia))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/asistencia/inasistencias/inasistenciaporatrasos";String:C10(cb_PublicarInaxAtraso))
			
			
		: ($entry=SN3_DTi_Companeros)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/publicar";String:C10(cb_PublicarCompaneros))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/email";String:C10(cb_PublicarCompEMail))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/publicarnivel";String:C10(cb_PublicarCompNivel))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/publicarcolegio";String:C10(cb_PublicarCompColegio))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/telefono";String:C10(cb_PublicarCompTelefono))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/celular";String:C10(cb_PublicarCompCelular))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/direccion";String:C10(cb_PublicarCompDireccion))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/cumpleanos";String:C10(cb_PublicarCompCumpleanos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/emailmadre";String:C10(cb_PublicarCompEMailM))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/celularmadre";String:C10(cb_PublicarCompCelularM))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/emailpadre";String:C10(cb_PublicarCompEMailP))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/companeros/celularpadre";String:C10(cb_PublicarCompCelularP))
		: ($entry=SN3_DTi_Horarios)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/horario/publicar";String:C10(cb_PublicarHorario))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/horario/verbloques";String:C10(cb_vernumbloques))  //MONO  01-07-2013: ver num bloque en vez de hora 
		: ($entry=SN3_DTi_Observaciones)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/publicar";String:C10(cb_PublicarObservaciones))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/obspj";String:C10(cb_PublicarObsPJ))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/obsasignaturas";String:C10(cb_PublicarObsAsignaturas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p1/visible";String:C10(Num:C11(cbOcultarPeriodo1_Obs=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p2/visible";String:C10(Num:C11(cbOcultarPeriodo2_Obs=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p3/visible";String:C10(Num:C11(cbOcultarPeriodo3_Obs=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p4/visible";String:C10(Num:C11(cbOcultarPeriodo4_Obs=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p5/visible";String:C10(Num:C11(cbOcultarPeriodo5_Obs=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p1/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo1_Obs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p2/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo2_Obs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p3/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo3_Obs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p4/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo4_Obs))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/observaciones/periodosvisibles/p5/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo5_Obs))
		: ($entry=SN3_DTi_Salud)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/salud/publicar";String:C10(cb_PublicarEnfermeria))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/salud/visitas";String:C10(cb_PublicarVisitas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/salud/visitasviejas";String:C10(cb_PublicarVisitasViejas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/salud/controles";String:C10(cb_PublicarCM))
		: ($entry=SN3_DTi_PlanesClase)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicar";String:C10(cb_PublicarPlanes))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/soloadjuntosyreferencias";String:C10(cb_PublicarAdjuntosPlanes))
			  //MONO  01-07-2013: detalle de publicación planes de clases
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicanotaalumno";String:C10(cb_PC_Notasalalumno))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicaobjetivos";String:C10(cb_PC_Objetivos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicacontenidos";String:C10(cb_PC_Contenidos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicaactividades";String:C10(cb_PC_Actividades))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicatareas";String:C10(cb_PC_Tareas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/planes/publicaevaluacion";String:C10(cb_PC_Evaluacion))
			
		: ($entry=SN3_DTi_CalificacionesMPA)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/publicar";String:C10(cb_PublicarAE))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/fechas";String:C10(cb_PublicarFechas))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p1/visible";String:C10(Num:C11(cbOcultarPeriodo1_Ap=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p2/visible";String:C10(Num:C11(cbOcultarPeriodo2_Ap=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p3/visible";String:C10(Num:C11(cbOcultarPeriodo3_Ap=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p4/visible";String:C10(Num:C11(cbOcultarPeriodo4_Ap=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p5/visible";String:C10(Num:C11(cbOcultarPeriodo5_Ap=0)))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p1/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo1_Ap))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p2/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo2_Ap))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p3/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo3_Ap))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p4/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo4_Ap))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/aprendizajes/periodosvisibles/p5/visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo5_Ap))
		: ($entry=SN3_DTi_CalificacionesExtraCurr)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/actividades/publicar";String:C10(cb_PublicarAct))
		: ($entry=SN3_DTi_AvisosCobranza)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/avisos/publicar";String:C10(cb_PublicarAvisos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/avisos/saldoanterior";String:C10(cb_PublicarSaldoAnterior))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/avisos/intereses";String:C10(cb_PublicarIntereses))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/avisos/detalle";String:C10(cb_PublicarDetalleAvisos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/avisos/publicarpdf";String:C10(cb_PublicarPDF))
		: ($entry=SN3_DTi_Pagos)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/pagos/publicar";String:C10(cb_PublicarPagos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/pagos/disponible";String:C10(cb_PublicarDisponible))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/pagos/formadepago";String:C10(cb_PublicarForma))
		: ($entry=SN3_DTi_DTrib)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/documentostributarios/publicar";String:C10(cb_PublicarBoletas))
		: ($entry=SN3_DTi_Prestamos)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/prestamos/publicar";String:C10(cb_PublicarPrestamos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/prestamos/alertar";String:C10(cb_AlertarAtrasos))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/prestamos/dias";String:C10(vl_DiasAlertaPrestamos;"###0"))
		: ($entry=40000)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/fotografias/publicar";String:C10(cb_PublicarFotografias))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/fotografias/alumnos";String:C10(cb_PublicarFotosAlumno))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/fotografias/pj";String:C10(cb_PublicarFotoPJ))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/fotografias/profesores";String:C10(cb_PublicarFotoProfesores))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/fotografias/companeros";String:C10(cb_PublicarFotoCompaneros))
		: ($entry=45000)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/comunicaciones/publicar";String:C10(cb_PublicarComunicaciones))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/comunicaciones/solocicloactual";String:C10(cb_CommCicloActual))  //mono solo ciclo actual
		: ($entry=46000)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/informes/publicar";String:C10(cb_PublicarInformes))
		: ($entry=10012)  //MONO 22-05-14: pub sesiones
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/sesiones/publicar";String:C10(cb_PublicarSesiones))
		: ($entry=10013)  //ASM  20160404 
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/MaterialDocente/publicar";String:C10(cb_PublicarMaterial))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/MaterialDocente/fecha_desde";SN3_MakeDateInmune2LocalFormat (vd_fecha_desde))  //20160916 RCH Se envia fecha con formato
		: ($entry=SN3_DTi_Profesores)
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/profesores/publicar";String:C10(cb_PublicarProfesores))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/profesores/nomostrarmail";String:C10(cb_ProfesorNoMostrarMail))
		: ($entry=45501)  // HOME NOTICIAS TICKET 198851
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/homeNoticias/publicar";String:C10(cb_PublicarHome))
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/homeNoticias/link";vt_linkHome)
		: ($entry=AccountTrack)  // MONO 191729
			DOM SET XML ELEMENT VALUE:C868($xmlRef;"opciones/generales/visibleapoacademico";String:C10(cb_ApodAcadSameApodCta))
	End case 
	SET BLOB SIZE:C606($data;0)
	DOM EXPORT TO VAR:C863($xmlRef;$data)
	DOM CLOSE XML:C722($xmlRef)
	[SN3_PublicationPrefs:161]xData:2:=$data
	COMPRESS BLOB:C534([SN3_PublicationPrefs:161]xData:2)
	SAVE RECORD:C53([SN3_PublicationPrefs:161])
	KRL_UnloadReadOnly (->[SN3_PublicationPrefs:161])
End if 