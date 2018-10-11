//%attributes = {}
  // Modificado por: Adrian Sepulveda (02/10/2015)

C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_TEXT:C284($url;$http;$ipAddressClient;$ipAddressServer;$userName;$password)
C_LONGINT:C283(vl_STWAloginResult)
C_LONGINT:C283($errL)
C_LONGINT:C283($err_print)
C_TEXT:C284($currPrinter)
C_BLOB:C604($blob;$blob2)
C_TEXT:C284($uuid)


$url:=$1
$http:=$2
$ipAddressClient:=$3
$ipAddressServer:=$4

$userName:=$5
$password:=$6

$vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
$vtWEB_HTTPHost:="http://"+$vtWEB_Host

$go:=False:C215
If (<>web_server_usarSSL=1)
	If (WEB Is secured connection:C698)
		$go:=True:C214
	End if 
Else 
	$go:=True:C214
End if 

If ($go)
	If (($url="stwa@") | ($url="/stwa@"))
		If (($url="/stwa/ajax/@") | ($url="stwa/ajax/@"))  //ajax solicitando datos...
			If ($url[[1]]="/")
				$action:=ST_GetWord ($url;4;"/")
			Else 
				$action:=ST_GetWord ($url;3;"/")
			End if 
			ARRAY TEXT:C222($aHeaderNames;0)
			ARRAY TEXT:C222($aHeaderValues;0)
			WEB GET HTTP HEADER:C697($aHeaderNames;$aHeaderValues)
			
			$method:=NV_GetValueFromPairedArrays (->$aHeaderNames;->$aHeaderValues;"X-METHOD")
			ARRAY TEXT:C222($aParameterNames;0)
			ARRAY TEXT:C222($aParameterValues;0)
			Case of 
				: ($method="GET")
					$parameters:=ST_GetWord ($url;2;"?")
					If ($parameters#"")
						$action:=Substring:C12($action;1;Position:C15("?";$action)-1)
						$countParameters:=ST_CountWords ($parameters;0;"&")
						ARRAY TEXT:C222($aParameterNames;$countParameters)
						ARRAY TEXT:C222($aParameterValues;$countParameters)
						For ($i;1;$countParameters)
							$parameterPair:=ST_GetWord ($parameters;$i;"&")
							$aParameterNames{$i}:=ST_GetWord ($parameterPair;1;"=")
							$aParameterValues{$i}:=ST_GetWord ($parameterPair;2;"=")
						End for 
					End if 
				: ($method="POST")
					WEB GET VARIABLES:C683($aParameterNames;$aParameterValues)
			End case 
			$uuid:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"UUID")
			If (STWA2_Session_UpdateLastSeen ($uuid))  //actualizar tiempo de sesion restante...
				Case of 
					: ($action="buildParciales")
						$userID:=STWA2_Session_GetUserSTID ($uuid)
						If (STWA2_OWC_verificaProcesoAutori ($userID;"STWA2_BuildCambioNombreParcial"))
							$json:=STWA2_BuildCambioNombreParcial ($uuid;->$aParameterNames;->$aParameterValues)
						Else 
							C_OBJECT:C1216($ob_raiz)
							OB SET:C1220($ob_raiz;"permiso";False:C215)
							$json:=JSON Stringify:C1217($ob_raiz)
						End if 
						
					: ($action="busquedaPrefUsuario")
						$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
						$l_profID:=STWA2_Session_GetProfID ($uuid)
						STWA2_FiltraAsignPref ($uuid;->$aParameterNames;->$aParameterValues;"guardaPreferencia")
						$json:=STWA2_AJAX_ListaAsignaturas ($uuid;$l_profID)
						
					: ($action="cargaPaginaPrincipal")
						C_OBJECT:C1216($ob_raiz;$ob_sso;$ob_diap;$ob_usuarioReemplazo;$ob_funciones)
						C_BOOLEAN:C305($b_ACTvalida;$b_vDirector;$b_configuracion;$b_acceso)
						
						$userID:=STWA2_Session_GetUserSTID ($uuid)
						$b_vDirector:=STWA2_OWC_verificaProcesoAutori ($userID;"STWA2_OWC_VistaDirector")
						$b_configuracion:=STWA2_OWC_verificaProcesoAutori ($userID;"STWA2_BuildCambioNombreParcial")
						$b_acceso:=STWA2_OWC_verificaProcesoAutori ($userID;"STWA2_OWC_InformesLCD")  //ABC//REQ 137441 //20180305
						
						$ob_raiz:=OB_Create 
						$ob_sso:=OB_JsonToObject (STWA2_OWC_SSO ($uuid;->$aParameterNames;->$aParameterValues;"consultaservicioscondor"))
						$ob_diap:=OB_JsonToObject (STWA2_OWC_Diap ($uuid;->$aParameterNames;->$aParameterValues;"verificapermisodiap"))
						$ob_usuarioReemplazo:=OB_JsonToObject (STWA2_ReemplazaUsuario ("CargaUsuarioReemplazo";$uuid))
						$ob_preferencia:=STWA2_FiltraAsignPref ($uuid;->$aParameterNames;->$aParameterValues;"cargaPreferenciaBusqueda")
						
						  //cargo el identificador de la maquina
						$b_forzarActualizacion:=False:C215
						If ($userID<0)
							$b_forzarActualizacion:=True:C214
						Else 
							$t_uuidMachine:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"uuidMachine")
							$t_versionBD:=SYS_LeeVersionEstructura 
							If ($t_uuidMachine#"")
								$t_versionAntigua:=PREF_fGet (0;$t_uuidMachine)
								If ($t_versionBD#$t_versionAntigua)
									$b_forzarActualizacion:=True:C214
									PREF_Set (0;$t_uuidMachine;$t_versionBD)
								End if 
							End if 
						End if 
						
						$t_dispositivo:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"dispositivo")
						$ob_funciones:=SC_ObtieneUrlDocsFunciones ($t_dispositivo;$uuid)
						
						OB_SET ($ob_raiz;->$ob_sso;"SSO")
						OB_SET ($ob_raiz;->$ob_diap;"DIAP")
						OB_SET ($ob_raiz;->$ob_usuarioReemplazo;"REEMPLAZO")
						OB_SET ($ob_raiz;->$b_vDirector;"vistadirector")
						OB_SET ($ob_raiz;->$ob_preferencia;"preferencia")
						OB_SET ($ob_raiz;->$b_configuracion;"configuracion")
						OB_SET ($ob_raiz;->$b_acceso;"InformesLCD")  //ABC//REQ 137441 //20180305
						OB_SET ($ob_raiz;->$ob_funciones;"funciones")
						OB SET:C1220($ob_raiz;"forzarActualizacion";$b_forzarActualizacion)
						$json:=OB_Object2Json ($ob_raiz)
						
						
					: ($action="eliminaevento")
						$json:=STWA2_OWC_eliminaevento ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="getvisitadata")
						$json:=STWA2_OWC_getvisitadata ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="modtextosficha")
						$json:=STWA2_OWC_modtextosficha ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="guardadatosfichasalud")
						$json:=STWA2_OWC_guardadatosfichasalud ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="eliminadatofichasalud")
						$json:=STWA2_OWC_eliminadatofichasalud ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="agregarvalorlista")
						$json:=STWA2_OWC_agregarvalorlista ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="obtieneURLsGAFE")
						$json:=STWA2_OWC_obtieneURLsGAFE ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="obtieneLlaveEdunet")
						$json:=STWA2_OWC_obtieneLlaveEdunet ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="cargaInasistenciaporHora")
						$json:=STWA2_OWC_cargaInasistenciaporH ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="eliminaLicencia")
						$json:=STWA2_OWC_eliminaLicencia ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="eliminaInasistencia")
						$json:=STWA2_OWC_eliminaInasistencia ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="inasistenciasAlumno")
						$json:=STWA2_OWC_inasistenciasAlumno ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="eliminaSuspension")
						$json:=STWA2_OWC_eliminaSuspension ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="suspensionesAlumno")
						$json:=STWA2_OWC_suspensionesAlumno ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="eliminaCastigo")
						$json:=STWA2_OWC_eliminaCastigo ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="castigosAlumno")
						$json:=STWA2_OWC_castigosAlumno ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="eliminaAnotacion")
						$json:=STWA2_OWC_eliminaAnotacion ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="anotacionesAlumno")
						$json:=STWA2_OWC_anotacionesAlumno ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="profesores")
						$json:=STWA2_OWC_profesores ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="asignaturasprof")
						$json:=STWA2_OWC_asignaturasprof ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="verLicencia")
						$json:=STWA2_OWC_verLicencia ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="alumnos")
						$json:=STWA2_OWC_alumnos ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="conductaAlumnosCurso")
						$json:=STWA2_OWC_conductaAlumnosCurso ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="inasistenciasAlumnos")
						$json:=STWA2_OWC_inasistenciasAlumnos ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="atrasosAlumnos")
						$json:=STWA2_OWC_atrasosAlumnos ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="conductaInit")
						$json:=STWA2_OWC_conductaInit ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="doquicksearch")
						$json:=STWA2_OWC_doquicksearch ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="doquery")
						$json:=STWA2_OWC_doquery ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="getqsvalues")
						$json:=STWA2_OWC_getqsvalues ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="getqueries")
						$json:=STWA2_OWC_getqueries ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="replicarPlanes")
						$json:=STWA2_OWC_replicarPlanes ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="agregarPlan")
						$json:=STWA2_OWC_agregarPlan ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="deletePlan")
						$json:=STWA2_OWC_deletePlan ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="cargaPropiedadesURL")
						$json:=STWA2_OWC_cargaPropiedadesURL ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="cargaPropiedadesAdjunto")
						$json:=STWA2_OWC_cargaPropiedadesAdjun ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="deletefileplan")
						$json:=STWA2_OWC_deletefileplan ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="getcontenidosplan")
						$json:=STWA2_OWC_getcontenidosplan ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="getcontenidossesion")
						$json:=STWA2_OWC_getcontenidossesion ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="objasignatura")
						$json:=STWA2_OWC_objasignatura ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="enfermeria")  //ASM Pendiente
						$json:=STWA2_OWC_enfermeria ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="nuevavisitaenfermeria")
						$json:=STWA2_OWC_nuevavisitaenfermeria ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="datosalumnoenfermeria")
						$json:=STWA2_OWC_datosalumnoenfermeria ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="datosfichamedica")
						$json:=STWA2_OWC_datosfichamedica ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="deactivateSession")
						STWA2_OWC_deactivateSession ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="sessionRenew")
						$json:=STWA2_OWC_sessionRenew ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="changePass")
						$json:=STWA2_OWC_changePass ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="logoff")
						$json:=STWA2_OWC_logoff ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="dashboards")
						$json:=STWA2_OWC_dashboards ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="builder")
						$json:=STWA2_OWC_builder ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="search")
						$json:=STWA2_GeneralSearch 
						
					: ($action="saveDato")
						$json:=STWA2_OWC_saveDato ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="PeriodoCurso")  //MONO 152677
						$json:=STWA2_OWC_PeriodoCurso ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="deletefileguias")  //ASM Agregado para las guias
						$json:=STWA2_OWC_deletefileguias ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="verificalicencia")
						$json:=STWA2_OWC_verificaLicencia ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="verificaModuloCondor")
						$json:=STWA2_OWC_SSO ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="vistadirector")
						$userID:=STWA2_Session_GetUserSTID ($uuid)
						$b_aceso:=STWA2_OWC_verificaProcesoAutori ($userID;"STWA2_OWC_VistaDirector")
						If ($b_aceso)
							$json:=STWA2_OWC_VistaDirector ($uuid;->$aParameterNames;->$aParameterValues)
						Else 
							C_OBJECT:C1216($ob_raiz)
							$ob_raiz:=OB_Create 
							OB_SET_Boolean ($ob_raiz;False:C215;"permiso")
							$json:=OB_Object2Json ($ob_raiz)
						End if 
					: ($action="VerificaUsuariosReemplazo")
						$json:=STWA2_ReemplazaUsuario ("CargaUsuarioReemplazo";$uuid)
						
					: ($action="detalleAtrasos")
						$json:=STWA2_CargaDetalleAtrasos ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="diap")
						$json:=STWA2_OWC_Diap ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="CargaAlumnosAsignaturaMobile")
						$json:=STWA2_MO_CargaAlumnosAsignatura ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="CargaAlumnosHoraMobile")
						$json:=STWA2_MO_CargaAlumnosxHora ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="builderMobile")
						$json:=STWA2_MO_Builder ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="evaluacionEspecial")  //Mono Ticket 172577 Evaluacion Especial
						$json:=STWA2_OWC_EvaluacionEspecial ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="InformesLCD")  //ABC 20180227 / / 
						$json:=STWA2_OWC_InformesLCD ($uuid;->$aParameterNames;->$aParameterValues)
						
					: ($action="propiedadesEvaluacion")
						$json:=STWA2conf_PropEvaluacion ($uuid;->$aParameterNames;->$aParameterValues)
						
						
					Else 
						  //devolver json con error...
						If (Application version:C493>="15@")
							C_OBJECT:C1216($ob_raiz)
							  //$t_refJson:=JSON New 
							JSON_AgregaTexto ($ob_raiz;"unknown action";"Error")
							$json:=OB_Object2Json ($ob_raiz)
							  //$json:=JSON Export to text ($t_refJson;JSON_WITHOUT_WHITE_SPACE)
							  //JSON CLOSE ($t_refJson)
						Else 
							  //$json:=json_newObject 
							  //json_addText (->$json;ST_Qte ("unknown action");ST_Qte ("Error"))
						End if 
				End case 
			Else 
				$json:=STWA2_JSON_SendError (-50000)
			End if 
			TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
			WEB SEND RAW DATA:C815($blob;*)
			
		Else 
			If ($url[[1]]="/")
				$action:=ST_GetWord ($url;3;"/")
			Else 
				$action:=ST_GetWord ($url;2;"/")
			End if 
			ARRAY TEXT:C222($aHeaderNames;0)
			ARRAY TEXT:C222($aHeaderValues;0)
			WEB GET HTTP HEADER:C697($aHeaderNames;$aHeaderValues)
			$method:=NV_GetValueFromPairedArrays (->$aHeaderNames;->$aHeaderValues;"X-METHOD")
			ARRAY TEXT:C222($aParameterNames;0)
			ARRAY TEXT:C222($aParameterValues;0)
			Case of 
				: ($method="GET")
					$parameters:=ST_GetWord ($url;2;"?")
					If ($parameters#"")
						$action:=Substring:C12($action;1;Position:C15("?";$action)-1)
						$countParameters:=ST_CountWords ($parameters;0;"&")
						ARRAY TEXT:C222($aParameterNames;$countParameters)
						ARRAY TEXT:C222($aParameterValues;$countParameters)
						For ($i;1;$countParameters)
							$parameterPair:=ST_GetWord ($parameters;$i;"&")
							$aParameterNames{$i}:=ST_GetWord ($parameterPair;1;"=")
							$aParameterValues{$i}:=ST_GetWord ($parameterPair;2;"=")
						End for 
					End if 
				: ($method="POST")
					WEB GET VARIABLES:C683($aParameterNames;$aParameterValues)
			End case 
			
			Case of 
					
				: ($action="Vista_Previa")
					TRACE:C157
					$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"emulador.html"
					  //WEB SEND FILE($t_rutaEstructura)
					  //WEB SEND HTTP REDIRECT("/stwa/login.shtml")
					DOCUMENT TO BLOB:C525($t_rutaEstructura;$blob)
					  //TEXT TO BLOB("<html><head></head><body>"+String(Current time)+"</body></html>";$blob;UTF8 text without length)
					WEB SEND BLOB:C654($blob;"text/html")
				: ($action="")
					vl_STWAloginResult:=0
					WEB SEND HTTP REDIRECT:C659("/stwa/login.shtml")
					
				: ($action="imprimircomprobantevisitaenf")
					STWA2_OWC_impcomprobantevisienf ($uuid;->$aParameterNames;->$aParameterValues)
					
				: ($action="uploadfile_guias@")  //agregado guias
					$json:=STWA2_OWC_uploadfileguias ($uuid;->$aParameterNames;->$aParameterValues;$action)
					
				: ($action="dowload_guias@")  //agregado guias
					STWA2_OWC_download_guias ($uuid;->$aParameterNames;->$aParameterValues)
					
				: ($action="uploadfile@")
					$json:=STWA2_OWC_uploadfile ($uuid;->$aParameterNames;->$aParameterValues;$action)
					
				: ($action="download")
					STWA2_OWC_download ($uuid;->$aParameterNames;->$aParameterValues)
					
				: ($action="changePass")
					$json:=STWA2_OWC_changePass2 ($uuid;->$aParameterNames;->$aParameterValues)
					
				: ($action="renewpass")
					
					STWA2_OWC_renewpass ($uuid;->$aParameterNames;->$aParameterValues)
				: ($action="login")
					STWA2_OWC_login 
					
				: ($action="forgotPass")
					$json:=STWA2_OWC_forgotPass ($uuid;->$aParameterNames;->$aParameterValues;$vtWEB_HTTPHost)
					
				: ($action="isValidSession")
					$json:=STWA2_OWC_isValidSession ($uuid;->$aParameterNames;->$aParameterValues)
					
				: ($action="users")
					$json:=STWA2_OWC_users 
					
				: ($action="licencia")
					$json:=STWA2_OWC_licencia 
					
				: ($action="webaccess2")
					STWA2_OWC_webaccess2 
					
				: ($action="processUUIDlogin")
					$uuid:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"uuidlog")
					STWA2_OWC_processUUIDlogin ($uuid;->$aParameterNames;->$aParameterValues)
				: ($action="processlogin")
					STWA2_OWC_processlogin_2 ($uuid;->$aParameterNames;->$aParameterValues;$ipAddressClient)
				: ($action="processloginST")
					
					ARRAY TEXT:C222($aHeaderNames;0)
					ARRAY TEXT:C222($aHeaderValues;0)
					ARRAY TEXT:C222($aParameterNames;0)
					ARRAY TEXT:C222($aParameterValues;0)
					
					  //Leo los datos 
					WEB GET HTTP HEADER:C697($aHeaderNames;$aHeaderValues)
					$t_UrlCompleta:=NV_GetValueFromPairedArrays (->$aHeaderNames;->$aHeaderValues;"X-URL")
					$t_url:=ST_GetWord ($t_UrlCompleta;2;"?")
					
					$usuario:=ST_GetWord ($t_url;2;"=")
					$usuario:=Substring:C12($usuario;1;Position:C15("&";$usuario)-1)
					
					$password:=ST_GetWord ($t_url;3;"=")
					$password:=Substring:C12($password;1;Position:C15("&";$password)-1)
					
					QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=$usuario)
					If (Records in selection:C76([xShell_Users:47])=0)
						$hl_SuperUsers:=Load list:C383("XS_Designers")
						HL_ExpandAll ($hl_SuperUsers)
						For ($i_elemento;1;Count list items:C380($hl_SuperUsers))
							GET LIST ITEM:C378($hl_SuperUsers;$i_elemento;$l_idUsuario;$t_NombreUsuario)
							GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_idUsuario;"login";$login)
							If ($login=$usuario)
								GET LIST ITEM PARAMETER:C985($hl_SuperUsers;$l_idUsuario;"contraseña";$passLocal)
								$i_elemento:=Count list items:C380($hl_SuperUsers)+1
							End if 
						End for 
						$storedPassword:=$passLocal
						$t_pass:=$passLocal
					Else 
						$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
						$t_pass:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
					End if 
					
					
					
					TEXT TO BLOB:C554($storedPassword;$blob;UTF8 text without length:K22:17)
					$storedPassword:=SHA512 ($blob;Crypto HEX)
					
					TEXT TO BLOB:C554($usuario;$blob;UTF8 text without length:K22:17)
					$t_user:=SHA512 ($blob;Crypto HEX)
					
					$t_userPass:=$storedPassword+$t_user
					
					TEXT TO BLOB:C554($t_userPass;$blob;UTF8 text without length:K22:17)
					$storedPassword:=SHA512 ($blob;Crypto HEX)
					
					
					If ($storedPassword=$password)
						<>lUSR_CurrentUserID:=0
						APPEND TO ARRAY:C911($aParameterNames;"user")
						APPEND TO ARRAY:C911($aParameterNames;"password")
						APPEND TO ARRAY:C911($aParameterNames;"enter")
						APPEND TO ARRAY:C911($aParameterNames;"culture")
						APPEND TO ARRAY:C911($aParameterNames;"usuario_reemplazo")
						APPEND TO ARRAY:C911($aParameterValues;$usuario)
						APPEND TO ARRAY:C911($aParameterValues;$t_pass)
						APPEND TO ARRAY:C911($aParameterValues;"ingresar")
						APPEND TO ARRAY:C911($aParameterValues;"es")
						APPEND TO ARRAY:C911($aParameterValues;"")
						STWA2_OWC_processlogin_2 ($uuid;->$aParameterNames;->$aParameterValues;$ipAddressClient)
					Else 
						
					End if 
				: ($action="processloginSSO")
					  //verifico el listado de IPs configuradas para relizar la petición
					C_BLOB:C604($blob)
					C_BOOLEAN:C305($b_activo)
					ARRAY TEXT:C222($atSTWA2_nombreCS;0)
					ARRAY TEXT:C222($atSTWA2_IPs;0)
					ARRAY BOOLEAN:C223($abSTWA2_Activo;0)
					$b_activo:=False:C215
					$blob:=PREF_fGetBlob (0;"STWA2_SERVICIO_SSO")
					BLOB_Blob2Vars (->$blob;0;->$atSTWA2_nombreCS;->$atSTWA2_IPs;->$abSTWA2_Activo)
					$l_pos:=Find in array:C230($atSTWA2_IPs;$ipAddressClient)
					If ($l_pos#-1)
						$b_activo:=$abSTWA2_Activo{$l_pos}
					End if 
					If ((<>b_STWA2_ssoActivo) & ($b_activo))  // valido si está´activo el servicio.
						ARRAY TEXT:C222($aHeaderNames;0)
						ARRAY TEXT:C222($aHeaderValues;0)
						ARRAY TEXT:C222($aParameterNames;0)
						ARRAY TEXT:C222($aParameterValues;0)
						C_BLOB:C604($blob)
						
						  //20160216 RCH Se cambia forma de obtener valores - INICIO .Corrige ticket 154983
						  //  //Leo los datos 
						  //WEB GET HTTP HEADER($aHeaderNames;$aHeaderValues)
						  //$t_UrlCompleta:=NV_GetValueFromPairedArrays (->$aHeaderNames;->$aHeaderValues;"X-URL")
						  //
						  //  //leo los datos que vienen en la url
						  //$t_url:=ST_GetWord ($t_UrlCompleta;2;"?")
						  //$usuario:=ST_GetWord ($t_url;2;"=")
						  //$usuario:=Substring($usuario;1;Position("&";$usuario)-1)
						  //
						  //$password:=ST_GetWord ($t_url;3;"=")
						  //$password:=Substring($password;1;Position("&";$password)-1)
						  //
						  //$t_llaveUrl:=ST_GetWord ($t_url;4;"=")
						
						ARRAY TEXT:C222($aParameterNames;0)
						ARRAY TEXT:C222($aParameterValues;0)
						WEB_GetVariables ($url;->$aParameterNames;->$aParameterValues)
						$usuario:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"usuario")
						$password:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"pass")
						$t_llaveUrl:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"llave")
						  //20160216 RCH Se cambia forma de obtener valores - FIN
						
						$llavePrivada:="f6150b819489bfe46e7da82f43e8b637c087d7ff90b7e25754e192fdd0219750"
						$llavePublica:=($llavePrivada+$usuario)
						
						TEXT TO BLOB:C554($llavePublica;$blob;UTF8 text without length:K22:17)
						$t_passLocal:=SHA512 ($blob;Crypto HEX)
						
						If ($t_llaveUrl=$t_passLocal)
							  //busco pass del usuario
							QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=$usuario)
							$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
							$pass:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
							
							  // encripto pass del usuario
							TEXT TO BLOB:C554($storedPassword;$blob;UTF8 text without length:K22:17)
							$storedPassword:=SHA512 ($blob;Crypto HEX)
							
							
							If ($storedPassword=$password)
								  //acá coloco el código para descomprimir la cadena
								APPEND TO ARRAY:C911($aParameterNames;"user")
								APPEND TO ARRAY:C911($aParameterNames;"password")
								APPEND TO ARRAY:C911($aParameterNames;"enter")
								APPEND TO ARRAY:C911($aParameterNames;"culture")
								APPEND TO ARRAY:C911($aParameterNames;"usuario_reemplazo")
								APPEND TO ARRAY:C911($aParameterValues;$usuario)
								APPEND TO ARRAY:C911($aParameterValues;$pass)
								APPEND TO ARRAY:C911($aParameterValues;"ingresar")
								APPEND TO ARRAY:C911($aParameterValues;"es")
								APPEND TO ARRAY:C911($aParameterValues;"")
								STWA2_OWC_processlogin_2 ($uuid;->$aParameterNames;->$aParameterValues;$ipAddressClient)
							Else 
								WEB SEND FILE:C619("stwa/login.shtml")
							End if 
						Else 
							WEB SEND FILE:C619("stwa/login.shtml")
						End if 
					Else 
						WEB SEND FILE:C619("stwa/login.shtml")
					End if 
				: ($action="error")
					WEB SEND FILE:C619("stwa/error.shtml")
				Else 
					WEB SEND HTTP REDIRECT:C659("/stwa/error")
			End case 
		End if 
	Else 
		  //devolver pagina de error
	End if 
Else 
	  //STWA2_OWC_licencia_no_http ($url;$ipAddressServer)
	$referer:=WEB_GetHTTPHeaderField ("Referer")
	$referer:=Substring:C12($referer;8)
	WEB SEND HTTP REDIRECT:C659("https://"+$referer+"stwa")
End if 