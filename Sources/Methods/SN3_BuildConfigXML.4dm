//%attributes = {}
  //SN3_BuildConfigXML

C_POINTER:C301($1)

SET BLOB SIZE:C606($1->;0)

$xmlRef:=DOM Create XML Ref:C861("opciones")
DOM SET XML DECLARATION:C859($xmlRef;"ISO-8859-1")

  //=====  GENERALES  =====

$generalesRef:=DOM Create XML element:C865($xmlRef;"generales")
DOM_SetElementValueAndAttr ($generalesRef;"mailpj";String:C10(cb_PublicarEMailPJ);True:C214)
DOM_SetElementValueAndAttr ($generalesRef;"visibleapoacademico";String:C10(cb_ApodAcadSameApodCta);True:C214)  //MONO Ticket 191729

  //=====  SCHOOLTRACK  =====

$agendaRef:=DOM Create XML element:C865($xmlRef;"agenda")
DOM_SetElementValueAndAttr ($agendaRef;"publicar";String:C10(cb_PublicarAgenda);True:C214)
DOM_SetElementValueAndAttr ($agendaRef;"envioautomaticoalumnos";String:C10(cb_AgEnvioAutoAlu);True:C214)  //MONO 02-04-2013: opciones de envio autmatico de eventos de agenda
DOM_SetElementValueAndAttr ($agendaRef;"envioautomaticorelaciones";String:C10(cb_AgEnvioAutoRel);True:C214)
$calificacionesRef:=DOM Create XML element:C865($xmlRef;"calificaciones")
DOM_SetElementValueAndAttr ($calificacionesRef;"publicar";String:C10(cb_PublicarEvaluaciones);True:C214)
DOM_SetElementValueAndAttr ($calificacionesRef;"promediosgenerales";String:C10(cb_PublicarEvPromGralAlumno);True:C214)
$designacionRef:=DOM Create XML element:C865($calificacionesRef;"designacion")
DOM_SetElementValueAndAttr ($designacionRef;"nombreinterno";String:C10(rNombreInterno);True:C214)
DOM_SetElementValueAndAttr ($designacionRef;"nombreoficial";String:C10(rNombreOficial);True:C214)
DOM_SetElementValueAndAttr ($designacionRef;"promediointerno";String:C10(PF_Prom_Interno);True:C214)
DOM_SetElementValueAndAttr ($designacionRef;"promediooficial";String:C10(PF_Prom_Oficial);True:C214)
$resGralesAsignaturaRef:=DOM Create XML element:C865($calificacionesRef;"resgeneralesasig")
DOM_SetElementValueAndAttr ($resGralesAsignaturaRef;"publicar";String:C10(cb_PublicarResGralAsignatura);True:C214)
DOM_SetElementValueAndAttr ($resGralesAsignaturaRef;"minimo";String:C10(cb_PublicarResGralMinimo);True:C214)
DOM_SetElementValueAndAttr ($resGralesAsignaturaRef;"media";String:C10(cb_PublicarResGralMedia);True:C214)
DOM_SetElementValueAndAttr ($resGralesAsignaturaRef;"maximo";String:C10(cb_PublicarResGralMaximo);True:C214)
$columnsRef:=DOM Create XML element:C865($calificacionesRef;"columnas")
DOM_SetElementValueAndAttr ($columnsRef;"esfuerzo";String:C10(cb_PublicarEEsfuerzo);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"parciales";String:C10(cb_PublicarEParciales);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"cp";String:C10(cb_PublicarECP);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"pps";String:C10(cb_PublicarEPP);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"pa";String:C10(cb_PublicarEPA);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"ex";String:C10(cb_PublicarEExamen);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"exx";String:C10(cb_PublicarEEXX);True:C214)
DOM_SetElementValueAndAttr ($columnsRef;"nf";String:C10(cb_PublicarENF);True:C214)
$hijasRef:=DOM Create XML element:C865($calificacionesRef;"opcioneshijas")
DOM_SetElementValueAndAttr ($hijasRef;"detalle";String:C10(cb_MostrarDetalle);True:C214)
DOM_SetElementValueAndAttr ($hijasRef;"ponderacion";String:C10(cb_PublicarEPonderacion);True:C214)
DOM_SetElementValueAndAttr ($hijasRef;"ocultarparcialesmadre";String:C10(cb_OcultaParcialesMadre);True:C214)
DOM_SetElementValueAndAttr ($hijasRef;"hijasdesplegadas";String:C10(cb_HijasDesplegadas);True:C214)
$visualizacionRef:=DOM Create XML element:C865($calificacionesRef;"opcvisualizacioncalif")
DOM_SetElementValueAndAttr ($visualizacionRef;"notanum";String:C10(cb_Publicar_Cal_Nota);True:C214)
DOM_SetElementValueAndAttr ($visualizacionRef;"puntos";String:C10(cb_Publicar_Cal_Puntos);True:C214)
DOM_SetElementValueAndAttr ($visualizacionRef;"porcentaje";String:C10(cb_Publicar_Cal_Porcentaje);True:C214)
DOM_SetElementValueAndAttr ($visualizacionRef;"simbolos";String:C10(cb_Publicar_Cal_Simbolos);True:C214)
$perView:=DOM Create XML element:C865($calificacionesRef;"periodosvisibles")
$periodo1:=DOM Create XML element:C865($perView;"p1")
DOM_SetElementValueAndAttr ($periodo1;"numero";"1")
DOM_SetElementValueAndAttr ($periodo1;"visible";String:C10(Num:C11(cbOcultarPeriodo1=0));True:C214)
DOM_SetElementValueAndAttr ($periodo1;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo1))
$periodo2:=DOM Create XML element:C865($perView;"p2")
DOM_SetElementValueAndAttr ($periodo2;"numero";"2")
DOM_SetElementValueAndAttr ($periodo2;"visible";String:C10(Num:C11(cbOcultarPeriodo2=0));True:C214)
DOM_SetElementValueAndAttr ($periodo2;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo2))
$periodo3:=DOM Create XML element:C865($perView;"p3")
DOM_SetElementValueAndAttr ($periodo3;"numero";"3")
DOM_SetElementValueAndAttr ($periodo3;"visible";String:C10(Num:C11(cbOcultarPeriodo3=0));True:C214)
DOM_SetElementValueAndAttr ($periodo3;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo3))
$periodo4:=DOM Create XML element:C865($perView;"p4")
DOM_SetElementValueAndAttr ($periodo4;"numero";"4")
DOM_SetElementValueAndAttr ($periodo4;"visible";String:C10(Num:C11(cbOcultarPeriodo4=0));True:C214)
DOM_SetElementValueAndAttr ($periodo4;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo4))
$periodo5:=DOM Create XML element:C865($perView;"p5")
DOM_SetElementValueAndAttr ($periodo5;"numero";"5")
DOM_SetElementValueAndAttr ($periodo5;"visible";String:C10(Num:C11(cbOcultarPeriodo5=0));True:C214)
DOM_SetElementValueAndAttr ($periodo5;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo5))

  //MONO TICKET 209421
$conductaRef:=DOM Create XML element:C865($xmlRef;"conducta")
DOM_SetElementValueAndAttr ($conductaRef;"publicar";String:C10(cb_PublicarConducta);True:C214)
$anotacionesRef:=DOM Create XML element:C865($conductaRef;"anotaciones")
DOM_SetElementValueAndAttr ($anotacionesRef;"publicar";String:C10(cb_PublicarAnotaciones);True:C214)
DOM_SetElementValueAndAttr ($anotacionesRef;"observaciones";String:C10(cb_PublicarAnotObs);True:C214)
DOM_SetElementValueAndAttr ($anotacionesRef;"profesor";String:C10(cb_PublicarAnotAutor);True:C214)
DOM_SetElementValueAndAttr ($anotacionesRef;"emailprofesor";String:C10(cb_PublicarAMailProf);True:C214)
DOM_SetElementValueAndAttr ($anotacionesRef;"positivas";String:C10(cb_PublicarAnotacionesPositivas);True:C214)
DOM_SetElementValueAndAttr ($anotacionesRef;"negativas";String:C10(cb_PublicarAnotacionesNegativas);True:C214)
DOM_SetElementValueAndAttr ($anotacionesRef;"neutras";String:C10(cb_PublicarAnotacionesNeutras);True:C214)
$castigosRef:=DOM Create XML element:C865($conductaRef;"castigos")
DOM_SetElementValueAndAttr ($castigosRef;"publicar";String:C10(cb_PublicarCastigos);True:C214)
DOM_SetElementValueAndAttr ($castigosRef;"observaciones";String:C10(cb_PublicarCastigosObs);True:C214)
DOM_SetElementValueAndAttr ($castigosRef;"profesor";String:C10(cb_PublicarCastigosProfesor);True:C214)
DOM_SetElementValueAndAttr ($castigosRef;"emailprofesor";String:C10(cb_PublicarCMailProf);True:C214)
$suspensionesRef:=DOM Create XML element:C865($conductaRef;"suspensiones")
DOM_SetElementValueAndAttr ($suspensionesRef;"publicar";String:C10(cb_PublicarSuspensiones);True:C214)
DOM_SetElementValueAndAttr ($suspensionesRef;"observaciones";String:C10(cb_PublicarSuspObs);True:C214)
DOM_SetElementValueAndAttr ($suspensionesRef;"profesor";String:C10(cb_PublicarSuspProfesor);True:C214)
DOM_SetElementValueAndAttr ($suspensionesRef;"emailprofesor";String:C10(cb_PublicarSMailProf);True:C214)
$condicionalidadRef:=DOM Create XML element:C865($conductaRef;"condicionalidad")
DOM_SetElementValueAndAttr ($condicionalidadRef;"publicar";String:C10(cb_PublicarCondicionalidad);True:C214)

  //MONO TICKET 209421
$asistenciaRef:=DOM Create XML element:C865($xmlRef;"asistencia")
DOM_SetElementValueAndAttr ($asistenciaRef;"publicar";String:C10(cb_PublicarAsistencia);True:C214)
$inasistenciasRef:=DOM Create XML element:C865($asistenciaRef;"inasistencias")
DOM_SetElementValueAndAttr ($inasistenciasRef;"publicar";String:C10(cb_PublicarInasistencias);True:C214)
DOM_SetElementValueAndAttr ($inasistenciasRef;"inasistenciaporatrasos";String:C10(cb_PublicarInaxAtraso);True:C214)
$atrasosRef:=DOM Create XML element:C865($asistenciaRef;"atrasos")
DOM_SetElementValueAndAttr ($atrasosRef;"publicar";String:C10(cb_PublicarAtrasos);True:C214)
DOM_SetElementValueAndAttr ($atrasosRef;"observaciones";String:C10(cb_PublicarAtrasosObs);True:C214)
DOM_SetElementValueAndAttr ($atrasosRef;"intersesiones";String:C10(cb_PublicarAtrasosInter);True:C214)
$porcAsistRef:=DOM Create XML element:C865($asistenciaRef;"porcasistencia")
DOM_SetElementValueAndAttr ($porcAsistRef;"publicar";String:C10(cb_PublicarPctAsistencia);True:C214)
  //*******************************************************************************************//

$compañerosRef:=DOM Create XML element:C865($xmlRef;"companeros")
DOM_SetElementValueAndAttr ($compañerosRef;"publicar";String:C10(cb_PublicarCompaneros);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"publicarnivel";String:C10(cb_PublicarCompNivel);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"publicarcolegio";String:C10(cb_PublicarCompColegio);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"email";String:C10(cb_PublicarCompEMail);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"telefono";String:C10(cb_PublicarCompTelefono);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"celular";String:C10(cb_PublicarCompCelular);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"direccion";String:C10(cb_PublicarCompDireccion);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"cumpleanos";String:C10(cb_PublicarCompCumpleanos);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"emailmadre";String:C10(cb_PublicarCompEMailM);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"celularmadre";String:C10(cb_PublicarCompCelularM);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"emailpadre";String:C10(cb_PublicarCompEMailP);True:C214)
DOM_SetElementValueAndAttr ($compañerosRef;"celularpadre";String:C10(cb_PublicarCompCelularP);True:C214)

$horarioRef:=DOM Create XML element:C865($xmlRef;"horario")
DOM_SetElementValueAndAttr ($horarioRef;"publicar";String:C10(cb_PublicarHorario);True:C214)
DOM_SetElementValueAndAttr ($horarioRef;"verbloques";String:C10(cb_vernumbloques);True:C214)  //MONO  01-07-2013: ver num bloque en vez de hora 

$obsRef:=DOM Create XML element:C865($xmlRef;"observaciones")
DOM_SetElementValueAndAttr ($obsRef;"publicar";String:C10(cb_PublicarObservaciones);True:C214)
DOM_SetElementValueAndAttr ($obsRef;"obspj";String:C10(cb_PublicarObsPJ);True:C214)
DOM_SetElementValueAndAttr ($obsRef;"obsasignaturas";String:C10(cb_PublicarObsAsignaturas);True:C214)
$perView:=DOM Create XML element:C865($obsRef;"periodosvisibles")
$periodo1:=DOM Create XML element:C865($perView;"p1")
DOM_SetElementValueAndAttr ($periodo1;"numero";"1")
DOM_SetElementValueAndAttr ($periodo1;"visible";String:C10(Num:C11(cbOcultarPeriodo1_Obs=0));True:C214)
DOM_SetElementValueAndAttr ($periodo1;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo1_Obs))
$periodo2:=DOM Create XML element:C865($perView;"p2")
DOM_SetElementValueAndAttr ($periodo2;"numero";"2")
DOM_SetElementValueAndAttr ($periodo2;"visible";String:C10(Num:C11(cbOcultarPeriodo2_Obs=0));True:C214)
DOM_SetElementValueAndAttr ($periodo2;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo2_Obs))
$periodo3:=DOM Create XML element:C865($perView;"p3")
DOM_SetElementValueAndAttr ($periodo3;"numero";"3")
DOM_SetElementValueAndAttr ($periodo3;"visible";String:C10(Num:C11(cbOcultarPeriodo3_Obs=0));True:C214)
DOM_SetElementValueAndAttr ($periodo3;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo3_Obs))
$periodo4:=DOM Create XML element:C865($perView;"p4")
DOM_SetElementValueAndAttr ($periodo4;"numero";"4")
DOM_SetElementValueAndAttr ($periodo4;"visible";String:C10(Num:C11(cbOcultarPeriodo4_Obs=0));True:C214)
DOM_SetElementValueAndAttr ($periodo4;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo4_Obs))
$periodo5:=DOM Create XML element:C865($perView;"p5")
DOM_SetElementValueAndAttr ($periodo5;"numero";"5")
DOM_SetElementValueAndAttr ($periodo5;"visible";String:C10(Num:C11(cbOcultarPeriodo5_Obs=0));True:C214)
DOM_SetElementValueAndAttr ($periodo5;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo5_Obs))


$saludRef:=DOM Create XML element:C865($xmlRef;"salud")
DOM_SetElementValueAndAttr ($saludRef;"publicar";String:C10(cb_PublicarEnfermeria);True:C214)
DOM_SetElementValueAndAttr ($saludRef;"visitas";String:C10(cb_PublicarVisitas);True:C214)
DOM_SetElementValueAndAttr ($saludRef;"visitasviejas";String:C10(cb_PublicarVisitasViejas);True:C214)
DOM_SetElementValueAndAttr ($saludRef;"controles";String:C10(cb_PublicarCM);True:C214)

$planesRef:=DOM Create XML element:C865($xmlRef;"planes")
DOM_SetElementValueAndAttr ($planesRef;"publicar";String:C10(cb_PublicarPlanes);True:C214)
  //MONO 13-03-2012: Se agrega opción para publicación de archivos adjuntos de planes de clases
DOM_SetElementValueAndAttr ($planesRef;"soloadjuntosyreferencias";String:C10(cb_PublicarAdjuntosPlanes);True:C214)
  //MONO  01-07-2013: detalle de publicación planes de clases
DOM_SetElementValueAndAttr ($planesRef;"publicanotaalumno";String:C10(cb_PC_Notasalalumno);True:C214)
DOM_SetElementValueAndAttr ($planesRef;"publicaobjetivos";String:C10(cb_PC_Objetivos);True:C214)
DOM_SetElementValueAndAttr ($planesRef;"publicacontenidos";String:C10(cb_PC_Contenidos);True:C214)
DOM_SetElementValueAndAttr ($planesRef;"publicaactividades";String:C10(cb_PC_Actividades);True:C214)
DOM_SetElementValueAndAttr ($planesRef;"publicatareas";String:C10(cb_PC_Tareas);True:C214)
DOM_SetElementValueAndAttr ($planesRef;"publicaevaluacion";String:C10(cb_PC_Evaluacion);True:C214)

$aprendizajesRef:=DOM Create XML element:C865($xmlRef;"aprendizajes")
DOM_SetElementValueAndAttr ($aprendizajesRef;"publicar";String:C10(cb_PublicarAE);True:C214)
DOM_SetElementValueAndAttr ($aprendizajesRef;"fechas";String:C10(cb_PublicarFechas);True:C214)
$perView:=DOM Create XML element:C865($aprendizajesRef;"periodosvisibles")
$periodo1:=DOM Create XML element:C865($perView;"p1")
DOM_SetElementValueAndAttr ($periodo1;"numero";"1")
DOM_SetElementValueAndAttr ($periodo1;"visible";String:C10(Num:C11(cbOcultarPeriodo1_Ap=0));True:C214)
DOM_SetElementValueAndAttr ($periodo1;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo1_Ap))
$periodo2:=DOM Create XML element:C865($perView;"p2")
DOM_SetElementValueAndAttr ($periodo2;"numero";"2")
DOM_SetElementValueAndAttr ($periodo2;"visible";String:C10(Num:C11(cbOcultarPeriodo2_Ap=0));True:C214)
DOM_SetElementValueAndAttr ($periodo2;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo2_Ap))
$periodo3:=DOM Create XML element:C865($perView;"p3")
DOM_SetElementValueAndAttr ($periodo3;"numero";"3")
DOM_SetElementValueAndAttr ($periodo3;"visible";String:C10(Num:C11(cbOcultarPeriodo3_Ap=0));True:C214)
DOM_SetElementValueAndAttr ($periodo3;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo3_Ap))
$periodo4:=DOM Create XML element:C865($perView;"p4")
DOM_SetElementValueAndAttr ($periodo4;"numero";"4")
DOM_SetElementValueAndAttr ($periodo4;"visible";String:C10(Num:C11(cbOcultarPeriodo4_Ap=0));True:C214)
DOM_SetElementValueAndAttr ($periodo4;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo4_Ap))
$periodo5:=DOM Create XML element:C865($perView;"p5")
DOM_SetElementValueAndAttr ($periodo5;"numero";"5")
DOM_SetElementValueAndAttr ($periodo5;"visible";String:C10(Num:C11(cbOcultarPeriodo5_Ap=0));True:C214)
DOM_SetElementValueAndAttr ($periodo5;"visibledesde";SN3_MakeDateInmune2LocalFormat (vdHastaPeriodo5_Ap))

$actividadesRef:=DOM Create XML element:C865($xmlRef;"actividades")
DOM_SetElementValueAndAttr ($actividadesRef;"publicar";String:C10(cb_PublicarAct);True:C214)

  //===== PROFESORES  ===== 
$profesoresRef:=DOM Create XML element:C865($xmlRef;"profesores")  //MONO 06-11-13: pub profesores
DOM_SetElementValueAndAttr ($profesoresRef;"publicar";String:C10(cb_PublicarProfesores);True:C214)
DOM_SetElementValueAndAttr ($profesoresRef;"nomostrarmail";String:C10(cb_ProfesorNoMostrarMail);True:C214)  //MONO 22-05-14: opcion email profe


  //===== ACCOUNTRACK  =====

$avisosRef:=DOM Create XML element:C865($xmlRef;"avisos")
DOM_SetElementValueAndAttr ($avisosRef;"publicar";String:C10(cb_PublicarAvisos);True:C214)
DOM_SetElementValueAndAttr ($avisosRef;"saldoanterior";String:C10(cb_PublicarSaldoAnterior);True:C214)
DOM_SetElementValueAndAttr ($avisosRef;"intereses";String:C10(cb_PublicarIntereses);True:C214)
DOM_SetElementValueAndAttr ($avisosRef;"detalle";String:C10(cb_PublicarDetalleAvisos);True:C214)
DOM_SetElementValueAndAttr ($avisosRef;"publicarpdf";String:C10(cb_PublicarPDF);True:C214)

$pagosRef:=DOM Create XML element:C865($xmlRef;"pagos")
DOM_SetElementValueAndAttr ($pagosRef;"publicar";String:C10(cb_PublicarPagos);True:C214)
DOM_SetElementValueAndAttr ($pagosRef;"disponible";String:C10(cb_PublicarDisponible);True:C214)
DOM_SetElementValueAndAttr ($pagosRef;"formadepago";String:C10(cb_PublicarForma);True:C214)

$boletasRef:=DOM Create XML element:C865($xmlRef;"documentostributarios")
DOM_SetElementValueAndAttr ($boletasRef;"publicar";String:C10(cb_PublicarBoletas);True:C214)

  //===== MEDIATRCK  =====

$prestamosRef:=DOM Create XML element:C865($xmlRef;"prestamos")
DOM_SetElementValueAndAttr ($prestamosRef;"publicar";String:C10(cb_PublicarPrestamos);True:C214)
DOM_SetElementValueAndAttr ($prestamosRef;"alertar";String:C10(cb_AlertarAtrasos);True:C214)
DOM_SetElementValueAndAttr ($prestamosRef;"dias";String:C10(vl_DiasAlertaPrestamos;"###0");True:C214)

  //===== FOTOGRAFIAS  =====

$fotografiasRef:=DOM Create XML element:C865($xmlRef;"fotografias")
DOM_SetElementValueAndAttr ($fotografiasRef;"publicar";String:C10(cb_PublicarFotografias);True:C214)
DOM_SetElementValueAndAttr ($fotografiasRef;"alumnos";String:C10(cb_PublicarFotosAlumno);True:C214)
DOM_SetElementValueAndAttr ($fotografiasRef;"pj";String:C10(cb_PublicarFotoPJ);True:C214)
DOM_SetElementValueAndAttr ($fotografiasRef;"profesores";String:C10(cb_PublicarFotoProfesores);True:C214)
DOM_SetElementValueAndAttr ($fotografiasRef;"companeros";String:C10(cb_PublicarFotoCompaneros);True:C214)

  //===== COMUNICACIONES  =====

$comsRef:=DOM Create XML element:C865($xmlRef;"comunicaciones")
DOM_SetElementValueAndAttr ($comsRef;"publicar";String:C10(cb_PublicarComunicaciones);True:C214)
DOM_SetElementValueAndAttr ($comsRef;"solocicloactual";String:C10(cb_CommCicloActual);True:C214)

  //===== INFORMES =====
  //MONO 06-11-13: pub informes
$informesRef:=DOM Create XML element:C865($xmlRef;"informes")
DOM_SetElementValueAndAttr ($informesRef;"publicar";String:C10(cb_PublicarInformes);True:C214)

  //===== SESIONES =====
  //SESIONES//MONO 22-05-14: pub sesiones
$sesionesRef:=DOM Create XML element:C865($xmlRef;"sesiones")
DOM_SetElementValueAndAttr ($sesionesRef;"publicar";String:C10(cb_PublicarSesiones);True:C214)

  // MATERIAL DOCENTE 
  //ASM 20160406
$materialDocenteRef:=DOM Create XML element:C865($xmlRef;"MaterialDocente")
DOM_SetElementValueAndAttr ($materialDocenteRef;"publicar";String:C10(cb_PublicarMaterial);True:C214)
DOM_SetElementValueAndAttr ($materialDocenteRef;"fecha_desde";String:C10(vd_fecha_desde);True:C214)

  // HOME NOTICIAS TICKET 198851
$homeRef:=DOM Create XML element:C865($xmlRef;"homeNoticias")
DOM_SetElementValueAndAttr ($homeRef;"publicar";String:C10(cb_PublicarHome);True:C214)
DOM_SetElementValueAndAttr ($homeRef;"link";vt_linkHome;True:C214)

DOM EXPORT TO VAR:C863($xmlRef;$1->)
DOM CLOSE XML:C722($xmlRef)