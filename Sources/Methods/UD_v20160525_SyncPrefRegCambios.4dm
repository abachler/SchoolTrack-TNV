//%attributes = {}
  //UD_v20160525_SyncPrefRegCambios
  // MONO 25-05-16: Si un Colegio tiene un módulo Condor activo, el colegio debería tener Sync,
  // por esto marcamos la preferencia para que marque modificaciones en ST para sincronización.
  // Esta preferencia tambien se marca si ejecutan el método CONDOR_ExportData
  // si se habilita un nuevo Módulo condor hay que agregarlo a esta validación,
  // esto se hizo debido a que en la intranet no están marcadas las licencias de la SYNC 
  // a la fecha de este método sólo 10 Colegio la tienen Activa y realmente son 77.
  //por favor cambiar esto si se estandariza este tema.

C_BOOLEAN:C305($b_ec;$b_inh;$b_os;$b_per;$b_pf;$b_pos;$b_rei;$b_tar)

LICENCIA_Descarga   //MONO TICKET 188993

$b_ec:=LICENCIA_VerificaModCondorAct ("Extracurriculares")
$b_inh:=LICENCIA_VerificaModCondorAct ("Inhabilidad")
$b_os:=LICENCIA_VerificaModCondorAct ("OrientacionySeguimiento")
$b_per:=LICENCIA_VerificaModCondorAct ("Personas")
$b_pf:=LICENCIA_VerificaModCondorAct ("PlanificaFacil")
$b_pos:=LICENCIA_VerificaModCondorAct ("Postulaciones")
$b_rei:=LICENCIA_VerificaModCondorAct ("Reinscripciones")
$b_tar:=LICENCIA_VerificaModCondorAct ("Tareas")

If (($b_ec) | ($b_inh) | ($b_os) | ($b_per) | ($b_pf) | ($b_pos) | ($b_rei) | ($b_tar))
	PREF_Set (0;"SYNC_RegistrarCambios";"True")
Else 
	PREF_Set (0;"SYNC_RegistrarCambios";"False")
End if 