//%attributes = {}
C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_TEXT:C284($json)

$url:=$1
$http:=$2

$ipAddressClient:=$3
$ipAddressServer:=$4
$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

If (($url="servicios@") | ($url="/servicios@"))
	If ($url[[1]]="/")
		$action:=ST_GetWord ($url;3;"/")
	Else 
		$action:=ST_GetWord ($url;2;"/")
	End if 
	LOG_RegisterEvt ("Llamado servicio REST "+$action+".")
	
	ARRAY TEXT:C222($aParameterNames;0)
	ARRAY TEXT:C222($aParameterValues;0)
	$b_done:=WEB_GetVariables ($url;->$aParameterNames;->$aParameterValues)
	
	If ($b_done)
		Case of 
			: ($action="guardaatraso")
				$json:=SERwa_guardaatraso (->$aParameterNames;->$aParameterValues)
				
			: ($action="eliminaatraso")
				$json:=SERwa_eliminaatraso (->$aParameterNames;->$aParameterValues)
				
			: ($action="modificaatraso")
				  //$json:=SERwa_modificaatraso (->$aParameterNames;->$aParameterValues)
				
			: ($action="filtrosasistencia")
				$json:=SERwa_filtrosasistencia (->$aParameterNames;->$aParameterValues)
				
			: ($action="cargaasistencia")
				$json:=SERwa_cargaAsistencia (->$aParameterNames;->$aParameterValues)
				
			: ($action="eliminaasistencia")
				$json:=SERwa_eliminainasistencia (->$aParameterNames;->$aParameterValues)
				
			: ($action="modificaasistencia")
				$json:=SERwa_modificainasistencia (->$aParameterNames;->$aParameterValues)
				
			: ($action="guardaasistencia")
				$json:=SERwa_guardaasistencia (->$aParameterNames;->$aParameterValues)
				
			: ($action="sesionimpartida")
				$json:=SERwa_impartida (->$aParameterNames;->$aParameterValues)
				
			: ($action="asistenciaregistrada")
				$json:=SERwa_asistenciaregistrada (->$aParameterNames;->$aParameterValues)
				
			: ($action="filtroshorarios")
				  //$json:=SERwa_filtroshorarios (->$aParameterNames;->$aParameterValues)
				
			: ($action="resumenbloquehorario")
				$json:=SERwa_resumenbloque (->$aParameterNames;->$aParameterValues)
				
			: ($action="gethorario")
				$json:=SERwa_getHorario (->$aParameterNames;->$aParameterValues)
				
			: ($action="gethorarioprofesor")
				$json:=SERwa_gethorarioprofesor (->$aParameterNames;->$aParameterValues)
				
			: ($action="gethorarioalumno")
				$json:=SERwa_gethorarioalumno (->$aParameterNames;->$aParameterValues)
				
			: ($action="gethorariocurso")
				$json:=SERwa_gethorariocurso (->$aParameterNames;->$aParameterValues)
				
			: ($action="reorganizacioncursos")
				$json:=SERwa_ReorganizacionCursos (->$aParameterNames;->$aParameterValues)
				
			: ($action="alumnoscurso")
				$json:=SERwa_alumnosxcurso (->$aParameterNames;->$aParameterValues)
				
			: ($action="reorganizacioncursosconfirms")
				$json:=SERwa_reorganizacionCursosConfs (->$aParameterNames;->$aParameterValues)
				
			: ($action="doreorganizacioncursos")
				$json:=SERwa_doReorganizacionCursos (->$aParameterNames;->$aParameterValues)
				
			: ($action="cambiostatusalumno")
				$json:=SERwa_CambioStatusAL (->$aParameterNames;->$aParameterValues)
				
			: ($action="cambiostatusconfirms")
				$json:=SERwa_cambiostatusConfs (->$aParameterNames;->$aParameterValues)
				
			: ($action="docambiostatus")
				$json:=SERwa_doCambioStatus (->$aParameterNames;->$aParameterValues)
				
			: ($action="alumnosasignaturas")
				$json:=SERwa_AlumnosEnAsignatura (->$aParameterNames;->$aParameterValues)
				
			: ($action="asignaturasprofesores")
				$json:=SERwa_AsignaturasProfesor (->$aParameterNames;->$aParameterValues)
				
			: ($action="obtieneeventoscalendario")
				$json:=SERwa_CalendarioObtieneEventos (->$aParameterNames;->$aParameterValues)
				
			: ($action="creaeditaeventocalendario")
				$json:=SERwa_CalendarioCreaEditaEvento (->$aParameterNames;->$aParameterValues)
				
			: ($action="eliminaeventocalendario")
				$json:=SERwa_CalendarioEliminaEvento (->$aParameterNames;->$aParameterValues)
				
			: ($action="infost")
				$json:=SERwa_InfoSchoolTrack (->$aParameterNames;->$aParameterValues)
				
			: ($action="script")
				If (Size of array:C274($aParameterNames)>0)
					$json:=SERwa_EjecutaScript (->$aParameterNames;->$aParameterValues)
				Else 
					$json:=SERwa_GeneraRespuesta ("-14";"Parámetro no encontrado.")
				End if 
				
			Else 
				$json:=SERwa_GeneraRespuesta ("-13";"Servicio inexistente.")
		End case 
	Else 
		$json:=SERwa_GeneraRespuesta ("-12";"Error al obtener los parámetros para el servicio.")
	End if 
	
	C_BLOB:C604($blob)
	TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
	ARRAY TEXT:C222($hNames;0)
	ARRAY TEXT:C222($hValues;0)
	APPEND TO ARRAY:C911($hNames;"Content-Type")
	APPEND TO ARRAY:C911($hValues;"application/json;charset=utf-8")
	APPEND TO ARRAY:C911($hNames;"Accept")
	APPEND TO ARRAY:C911($hValues;"application/json")
	WEB SET HTTP HEADER:C660($hNames;$hValues)
	WEB SEND RAW DATA:C815($blob;*)
End if 