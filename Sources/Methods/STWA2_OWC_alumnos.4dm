//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:43:43
  // ----------------------------------------------------
  // Método: STWA2_OWC_alumnos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_BOOLEAN:C305($b_enfermeria)
C_OBJECT:C1216($ob_raiz)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$term:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"term")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$b_enfermeria:=Choose:C955(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"enfermeria")="true";True:C214;False:C215)
READ ONLY:C145([Alumnos:2])

If (USR_LimitedSearch ($userID))
	dhSTWA2_SpecialSearch ("SchoolTrack";->[Alumnos:2];$profID)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=($term+"@"))
Else 
	QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=($term+"@"))
End if 

If ($b_enfermeria)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
	QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Status:50="En Trámite";*)
	QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Status:50="Oyente")
Else 
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
	QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Status:50="En Trámite")
End if 
ARRAY TEXT:C222($aNombres;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($aCursos;0)
ARRAY BOOLEAN:C223($ad_condicional;0)

  //20140708 Ticket 130920
ARRAY LONGINT:C221($aNivelNo;0)
ARRAY LONGINT:C221($aRegistroAsistencia;0)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$aNombres;[Alumnos:2]curso:20;$aCursos;[Alumnos:2]nivel_numero:29;$aNivelNo;[Alumnos:2]Status:50;$at_status)

For ($i;1;Size of array:C274($aNombres))
	$aNombres{$i}:=$aNombres{$i}+" ("+$aCursos{$i}+")"
	APPEND TO ARRAY:C911($aRegistroAsistencia;KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$aNivelNo{$i};->[xxSTR_Niveles:6]AttendanceMode:3))
	APPEND TO ARRAY:C911($ad_condicional;[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
End for 

LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums)
SORT ARRAY:C229($aNombres;$aRecNums;$aRegistroAsistencia;$aCursos)

  //busco las licencias de los alumnos seleccionados
C_OBJECT:C1216($ob_licencias)
ARRAY OBJECT:C1221($aob_LicenciasArray;0)

For ($i;1;Size of array:C274($aRecNums))
	ARRAY TEXT:C222($at_LicenciaDesde;0)
	ARRAY TEXT:C222($at_LicenciaHasta;0)
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Año:9=<>gyear)
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_licenciaDesde;[Alumnos_Licencias:73]Hasta:3;$ad_licenciaHasta;*)
	SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Tipo_licencia:4;$at_licenciaTipo;[Alumnos_Licencias:73]Observaciones:5;$at_licenciaObs;*)
	SELECTION TO ARRAY:C260
	
	  //para dar formato a la fecha
	For ($x;1;Size of array:C274($ad_licenciaDesde))
		APPEND TO ARRAY:C911($at_LicenciaDesde;String:C10($ad_licenciaDesde{$x};System date short:K1:1))
		APPEND TO ARRAY:C911($at_LicenciaHasta;String:C10($ad_licenciaHasta{$x};System date short:K1:1))
	End for 
	
	$ob_licencias:=OB_Create 
	OB_SET ($ob_licencias;->$at_LicenciaDesde;"desde")
	OB_SET ($ob_licencias;->$at_LicenciaHasta;"hasta")
	OB_SET ($ob_licencias;->$at_licenciaTipo;"tipo")
	OB_SET ($ob_licencias;->$at_licenciaObs;"obs")
	APPEND TO ARRAY:C911($aob_LicenciasArray;$ob_licencias)
End for 

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$aNombres;"values")
OB_SET ($ob_raiz;->$aCursos;"cursos")
OB_SET ($ob_raiz;->$aRecNums;"recnums")
OB_SET ($ob_raiz;->$aRegistroAsistencia;"registroinas")
OB_SET ($ob_raiz;->$at_status;"status")
OB_SET ($ob_raiz;->$ad_condicional;"codicional")
OB_SET ($ob_raiz;->$aob_LicenciasArray;"licencias")
$json:=OB_Object2Json ($ob_raiz)

$0:=$json
