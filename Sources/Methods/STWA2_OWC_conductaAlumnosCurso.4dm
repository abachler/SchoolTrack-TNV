//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:44:37
  // ----------------------------------------------------
  // Método: STWA2_OWC_conductaAlumnosCurso
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
READ ONLY:C145([Alumnos:2])
  //QUERY([Alumnos];[Alumnos]Curso=$curso)
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
	
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
	APPEND TO ARRAY:C911($ab_condicional;[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
	
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

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$curso;"alumnosCurso")
OB_SET ($ob_raiz;->$aRNAlumnos;"alumnosRN")
OB_SET ($ob_raiz;->$aNombres;"alumnosNombres")
OB_SET ($ob_raiz;->$aStatuses;"alumnosStatuses")
OB_SET ($ob_raiz;->$aNoListaLONG;"alumnosnoLista")
OB_SET ($ob_raiz;->$ab_condicional;"cond")

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

$json:=OB_Object2Json ($ob_raiz)

$0:=$json
