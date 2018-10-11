//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:48:23
  // ----------------------------------------------------
  // Método: STWA2_OWC_conductaInit
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)

ARRAY TEXT:C222($aCursos;0)
ARRAY LONGINT:C221($aNiveles;0)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$b_cargaCursoProf:=True:C214

$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")  //20160608 ASM Ticket 149365 
PERIODOS_Init 
If (Size of array:C274(<>aCursos)=0)
	CU_LoadArrays 
End if 


  // Modificado por: Colegium-des-Pa (21-06-2017)
  //ticket 18372
If (USR_LimitedSearch ($userID))
	dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
Else 
	  //COPY ARRAY(<>aCursos;$aCursos)
	  //COPY ARRAY(<>aCUNivNo;$aNiveles)
	ALL RECORDS:C47([Asignaturas:18])
End if 

  //agrego posibles grupos
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsignaturas)

For ($i;1;Size of array:C274($al_recNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$i})
	If ((Find in array:C230($aCursos;[Asignaturas:18]Curso:5)=-1) & ([Asignaturas:18]Curso:5#"") & ([Asignaturas:18]Numero_de_alumnos:49>0) & ([Asignaturas:18]Numero_del_Nivel:6#0))
		APPEND TO ARRAY:C911($aCursos;[Asignaturas:18]Curso:5)
		APPEND TO ARRAY:C911($aNiveles;[Asignaturas:18]Numero_del_Nivel:6)
	End if 
End for 


$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aCursos;"cursos")
OB_SET ($ob_raiz;->$aCursos;"niveles")

ARRAY LONGINT:C221($attMode;0)
ARRAY LONGINT:C221($lateMode;0)
ARRAY TEXT:C222($inicios;0)
ARRAY TEXT:C222($fines;0)
For ($i;1;Size of array:C274($aCursos))
	$nivelCurso:=$aNiveles{$i}
	$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelCurso;->[xxSTR_Niveles:6]Lates_Mode:16)
	$modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelCurso;->[xxSTR_Niveles:6]AttendanceMode:3)
	APPEND TO ARRAY:C911($attMode;$modoRegistroInasistencia)
	APPEND TO ARRAY:C911($lateMode;$modoRegistroAtrasos)
	PERIODOS_LoadData ($nivelCurso)
	APPEND TO ARRAY:C911($inicios;STWA2_MakeDate4JS (vdSTR_Periodos_InicioEjercicio))
	APPEND TO ARRAY:C911($fines;STWA2_MakeDate4JS (vdSTR_Periodos_FinEjercicio))
End for 
  //20160608 ASM Ticket 149365 

If (($curso="") & (Size of array:C274($aCursos)>0))
	$curso:=$aCursos{1}
Else 
	$b_cargaCursoProf:=False:C215
End if 
If ($userID>-1)
	If ($profID#0)
		If ($b_cargaCursoProf)
			$recNum:=Find in field:C653([Cursos:3]Numero_del_profesor_jefe:2;$profID)
			If ($recNum#-1)
				$curso:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_profesor_jefe:2;->$profID;->[Cursos:3]Curso:1)
			End if 
		End if 
	End if 
End if 
OB_SET ($ob_raiz;->$curso;"curso")
OB_SET ($ob_raiz;->$attMode;"modoasistencia")
OB_SET ($ob_raiz;->$lateMode;"modoatrasos")
OB_SET ($ob_raiz;->$inicios;"inicios")
OB_SET ($ob_raiz;->$fines;"fines")

READ ONLY:C145([Alumnos:2])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$curso)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
$alumnos:=Records in selection:C76([Alumnos:2])
ARRAY LONGINT:C221($aRNAlumnos;$alumnos)
ARRAY TEXT:C222($aStatuses;$alumnos)
ARRAY TEXT:C222($aNombres;$alumnos)
ARRAY INTEGER:C220($aNoLista;$alumnos)
ARRAY LONGINT:C221($aNoListaLONG;$alumnos)
ARRAY BOOLEAN:C223($ab_condicional;0)

SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$aNombres;[Alumnos:2]Status:50;$aStatuses;[Alumnos:2]no_de_lista:53;$aNoLista;[Alumnos:2]Sexo:49;$aSexo)

LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRNAlumnos;"")
For ($i;1;Size of array:C274($aNoLista))
	$aNoListaLONG{$i}:=$aNoLista{$i}
End for 
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<   >";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
				Else 
					AT_MultiLevelSort (">   >";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<>";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
				Else 
					AT_MultiLevelSort (">>";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<>";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
				Else 
					AT_MultiLevelSort (">>";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		SORT ARRAY:C229($aNoListaLONG;$aNombres;$aRNAlumnos;$aStatuses)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		SORT ARRAY:C229($aNombres;$aRNAlumnos;$aStatuses;$aNoListaLONG)
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		SORT ARRAY:C229($aNombres;$aRNAlumnos;$aStatuses;$aNoListaLONG)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //SORT ARRAY($aNombres;$aRNAlumnos;$aStatuses;$aNoListaLONG)
  //: (<>gOrdenNta=1)
  //SORT ARRAY($aNoListaLONG;$aNombres;$aRNAlumnos;$aStatuses)
  //: (<>gOrdenNta=2)
  //SORT ARRAY($aNombres;$aRNAlumnos;$aStatuses;$aNoListaLONG)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //AT_MultiLevelSort ("<>";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
  //: (<>gOrdenNta=1)
  //AT_MultiLevelSort ("<   >";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
  //: (<>gOrdenNta=2)
  //AT_MultiLevelSort ("<>";->$aSexo;->$aNombres;->$aRNAlumnos;->$aStatuses;->$aNoListaLONG)
  //End case 
  //End if 

For ($i;1;Size of array:C274($aRNAlumnos))
	GOTO RECORD:C242([Alumnos:2];$aRNAlumnos{$i})
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
	APPEND TO ARRAY:C911($ab_condicional;[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
End for 

OB_SET ($ob_raiz;->$aRNAlumnos;"alumnosRN")
OB_SET ($ob_raiz;->$aNombres;"alumnosNombres")
OB_SET ($ob_raiz;->$aStatuses;"alumnosStatuses")
OB_SET ($ob_raiz;->$aNoListaLONG;"alumnosnoLista")
OB_SET ($ob_raiz;->$ab_condicional;"cond")
STR_LeePreferenciasConducta2 
OB_SET_Long ($ob_raiz;vi_RegistrarMinutosEnAtrasos;"atrasosRegMinutos")

ARRAY TEXT:C222($intervalos;0)
$inter:=Replace string:C233(vt_intervalos;",";";")
AT_Text2Array (->$intervalos;$inter)
OB_SET ($ob_raiz;->$intervalos;"intervalos")
OB_SET ($ob_raiz;->ATSTRAL_FALTACONV;"equivalencia")
OB_SET ($ob_raiz;-><>aLicencias;"tiposlicencia")
OB_SET ($ob_raiz;-><>at_LicenciaMotivosEspeciales;"motivoslicencia")  //156855
OB_SET ($ob_raiz;-><>vb_BloquearModifSituacionFinal;"bloqueoModSitFinal")
OB_SET_Text ($ob_raiz;STWA2_MakeDate4JS (<>vd_FechaBloqueoSchoolTrack);"fechaBloqueo")
OB_SET_Boolean ($ob_raiz;USR_checkRights ("A";->[Alumnos_Conducta:8];$userID);"permiso")

PERIODOS_LoadData (0;-1)
ARRAY TEXT:C222($aferiados;Size of array:C274(adSTR_Calendario_Feriados))
For ($i;1;Size of array:C274($aferiados))
	$aferiados{$i}:=STWA2_MakeDate4JS (adSTR_Calendario_Feriados{$i})
End for 
OB_SET ($ob_raiz;->$aferiados;"feriados")
  //If ((Size of array($aNiveles)>0) & (Size of array($aCursos)>0))
If ((Size of array:C274($aNiveles)>0) & (Size of array:C274($aCursos)>0) & (Find in array:C230($aCursos;$curso)>0))  //20180312 RCH Ticket 201184.
	$nivelCurso:=$aNiveles{Find in array:C230($aCursos;$curso)}
Else 
	$nivelCurso:=-1
End if 

PERIODOS_LoadData ($nivelCurso)

ARRAY OBJECT:C1221($aob_periodo;0)
C_OBJECT:C1216($ob_periodosCursos;$ob_periodo)
$ob_periodosCursos:=OB_Create 
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	$ob_periodo:=OB_Create 
	OB_SET_Text ($ob_periodo;STWA2_MakeDate4JS (adSTR_Periodos_Desde{$i});"inicio")
	OB_SET_Text ($ob_periodo;STWA2_MakeDate4JS (adSTR_Periodos_Hasta{$i});"fin")
	APPEND TO ARRAY:C911($aob_periodo;$ob_periodo)
	CLEAR VARIABLE:C89($ob_periodo)
End for 

OB_SET ($ob_raiz;->$aob_periodo;"periodosCurso")
$permiso:=STWA2_Priv_GetMethodAccess ("AL_EliminaInasistencia";$userID)
$multiplesAtrasos:=<>gAllowMultipleLates
OB_SET ($ob_raiz;->$permiso;"permisoeliminarinasistencias")
OB_SET ($ob_raiz;->$multiplesAtrasos;"multiplesatrasos")

C_LONGINT:C283($diasanotaciones)
$diasanotaciones:=<>vi_nd_reg_anotacion
OB_SET ($ob_raiz;->$diasanotaciones;"diasanotaciones")
C_OBJECT:C1216($ob_motivosanotacion;$ob_motTemporal)
$ob_motivosanotacion:=OB_Create 
SORT ARRAY:C229(<>aiID_Matriz;<>atSTR_Anotaciones_categorias;<>atSTR_Anotaciones_motivo;<>aiSTR_Anotaciones_puntaje;<>aiSTR_Anotaciones_motivo_puntaj)
For ($i;1;Size of array:C274(aiSTR_IDCategoria))
	ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
	ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
	For ($j;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
		If (<>aiID_Matriz{$j}=aiSTR_IDCategoria{$i})
			If (<>atSTR_Anotaciones_motivo{$j}#"")
				AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje)
				atSTR_Anotaciones_motivo{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>atSTR_Anotaciones_motivo{$j}
				aiSTR_Anotaciones_puntaje{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>aiSTR_Anotaciones_motivo_puntaj{$j}
			End if 
		End if 
	End for 
	$ob_motTemporal:=OB_Create 
	OB_SET_Text ($ob_motTemporal;at_STR_CategoriasAnot_Nombres{$i};"nombre")
	
	Case of 
		: (ai_TipoAnotacion{$i}>0)
			OB_SET_Text ($ob_motTemporal;"+";"signo")
			
		: (ai_TipoAnotacion{$i}=0)
			OB_SET_Text ($ob_motTemporal;"=";"signo")
			
		: (ai_TipoAnotacion{$i}<0)
			OB_SET_Text ($ob_motTemporal;"-";"signo")
			
	End case 
	OB_SET ($ob_motTemporal;->atSTR_Anotaciones_motivo;"motivos")
	OB_SET ($ob_motTemporal;->aiSTR_Anotaciones_puntaje;"puntajes")
	OB_SET ($ob_motivosanotacion;->$ob_motTemporal;"cat"+String:C10($i))
	
	
End for 
OB_SET ($ob_raiz;->$ob_motivosanotacion;"motivosanotacion")

C_OBJECT:C1216($ob_profesor)
$ob_profesor:=OB_Create 
$profName:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$profID;->[Profesores:4]Apellidos_y_nombres:28)
$rn:=Find in field:C653([Profesores:4]Numero:1;$profID)

OB_SET ($ob_profesor;->$profName;"nombre")
OB_SET ($ob_profesor;->$rn;"rn")
OB_SET ($ob_raiz;->atSTRal_MotivosCastigo;"motivoscastigo")
OB_SET ($ob_raiz;->atSTRal_MotivosSuspension;"motivossuspension")
OB_SET ($ob_raiz;->$ob_profesor;"profesor")

  // busco las licencias registradas para los alumnos 
ARRAY TEXT:C222($at_ObservacionLicencia;0)
ARRAY TEXT:C222($at_fechaLicenciaDesde;0)
ARRAY TEXT:C222($at_fechaLicenciaHasta;0)
ARRAY TEXT:C222($at_fechaLicenciaDesdevis;0)
ARRAY TEXT:C222($at_fechaLicenciaHastavis;0)
ARRAY LONGINT:C221($al_RecNumAlumnoLicencia;0)
ARRAY LONGINT:C221($al_recNumLicencia;0)
ARRAY TEXT:C222($at_tipoLicencia;0)
ARRAY TEXT:C222($at_motivoLicencia;0)
For ($i;1;Size of array:C274($aRNAlumnos))
	GOTO RECORD:C242([Alumnos:2];$aRNAlumnos{$i})
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Fecha_registro:8>=vdSTR_Periodos_InicioEjercicio)
	
	While (Not:C34(End selection:C36([Alumnos_Licencias:73])))
		APPEND TO ARRAY:C911($al_RecNumAlumnoLicencia;Record number:C243([Alumnos:2]))
		APPEND TO ARRAY:C911($at_ObservacionLicencia;[Alumnos_Licencias:73]Observaciones:5)
		APPEND TO ARRAY:C911($al_recNumLicencia;Record number:C243([Alumnos_Licencias:73]))
		APPEND TO ARRAY:C911($at_fechaLicenciaDesde;STWA2_MakeDate4JS ([Alumnos_Licencias:73]Desde:2))
		APPEND TO ARRAY:C911($at_fechaLicenciaHasta;STWA2_MakeDate4JS ([Alumnos_Licencias:73]Hasta:3))
		APPEND TO ARRAY:C911($at_fechaLicenciaDesdevis;String:C10([Alumnos_Licencias:73]Desde:2))
		APPEND TO ARRAY:C911($at_fechaLicenciaHastavis;String:C10([Alumnos_Licencias:73]Hasta:3))
		APPEND TO ARRAY:C911($at_tipoLicencia;[Alumnos_Licencias:73]Tipo_licencia:4)
		APPEND TO ARRAY:C911($at_motivoLicencia;[Alumnos_Licencias:73]Motivo_especial:13)
		NEXT RECORD:C51([Alumnos_Licencias:73])
	End while 
	
End for 

C_OBJECT:C1216($ob_licencia)
$ob_licencia:=OB_Create 
OB_SET ($ob_licencia;->$al_RecNumAlumnoLicencia;"recnumalumno")
OB_SET ($ob_licencia;->$at_ObservacionLicencia;"observacion")
OB_SET ($ob_licencia;->$al_recNumLicencia;"recnumlicencia")
OB_SET ($ob_licencia;->$at_fechaLicenciaDesde;"desde")
OB_SET ($ob_licencia;->$at_fechaLicenciaHasta;"hasta")
OB_SET ($ob_licencia;->$at_fechaLicenciaDesdevis;"desdevis")
OB_SET ($ob_licencia;->$at_fechaLicenciaHastavis;"hastavis")
OB_SET ($ob_licencia;->$at_tipoLicencia;"tipo")
OB_SET ($ob_licencia;->$at_motivoLicencia;"motivo")
OB_SET ($ob_raiz;->$ob_licencia;"datoslicencias")

QUERY:C277([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]activo:5=True:C214)
ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
SELECTION TO ARRAY:C260([xxSTR_JustificacionAtrasos:227];$al_RecNumJustificacion;[xxSTR_JustificacionAtrasos:227]Motivo:2;$at_motivoJustificacion)

C_OBJECT:C1216($ob_justificacionAtrasos)
$ob_justificacionAtrasos:=OB_Create 
OB_SET ($ob_justificacionAtrasos;->$al_RecNumJustificacion;"RecNumJustificacion")
OB_SET ($ob_justificacionAtrasos;->$at_motivoJustificacion;"MotivoJustificacion")
OB_SET ($ob_raiz;->$ob_justificacionAtrasos;"justificacionAtrasos")


$json:=OB_Object2Json ($ob_raiz)
$0:=$json