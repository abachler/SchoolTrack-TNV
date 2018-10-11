//%attributes = {}
  // RIN_DescargaActualizacion()
  // Por: Alberto Bachler K.: 15-08-14, 15:11:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_guardar;$b_muestraErrores;$b_TSModificacionValido)
C_LONGINT:C283($l_error;$l_errorRetorno;$l_opcion;$l_recNum)
C_TEXT:C284($t_consultaAsociada_B64;$t_dtsCreacion;$t_dtsModificacion;$t_error;$t_errorWS;$t_json;$t_mailUsuario;$t_Modelo_B64;$t_modeloEtiqueta;$t_nombreUsuario;$t_refJson)
C_TEXT:C284($t_refNodoData;$t_refNodoError;$t_refNodoInfo;$t_uuid;$t_uuidActualizacion;$t_uuidColegio;$t_uuidInforme)
C_OBJECT:C1216($ob;$ob_data;$ob_error;$ob_info)


If (False:C215)
	C_TEXT:C284(RIN_DescargaActualizacion ;$1)
	C_BOOLEAN:C305(RIN_DescargaActualizacion ;$2)
End if 


$b_muestraErrores:=True:C214
$t_uuidActualizacion:=$1

If (Count parameters:C259=2)
	$b_muestraErrores:=$2
End if 

$t_uuidColegio:=<>gUUID
$t_nombreUsuario:=<>tUSR_CurrentUser
$t_mailUsuario:=<>tUSR_CurrentUserEmail


WEB SERVICE SET PARAMETER:C777("uuid";$t_uuidActualizacion)
WEB SERVICE SET PARAMETER:C777("uuidColegio";$t_uuidColegio)
WEB SERVICE SET PARAMETER:C777("nombreUsuario";$t_nombreUsuario)
WEB SERVICE SET PARAMETER:C777("mailUsuario";$t_mailUsuario)

$t_errorWS:=WS_CallIntranetWebService ("RINws_DescargaActualizacion";True:C214)
If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
	
	$ob:=OB_Create 
	$ob_info:=OB_Create 
	$ob_data:=OB_Create 
	$ob_error:=OB_Create 
	
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	
	OB_GET ($ob;->$ob_error;"error")
	OB_GET ($ob;->$ob_data;"data")
	OB_GET ($ob;->$ob_info;"info")
	
	OB_GET ($ob_error;->$t_error;"textoError")
	OB_GET ($ob_error;->$l_error;"codigoError")
	
	
	
	
	Case of 
		: ($l_error=0)
			
		: ($l_error=-3)
			If ($b_muestraErrores)
				ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");$t_error)
			End if 
			
		: ($l_error=-2)
			If ($b_muestraErrores)
				ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");$t_error)
			End if 
			
		: ($l_error=-1)
			If ($b_muestraErrores)
				ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");$t_error)
			End if 
			
		: ($l_error=-4)
			If ($b_muestraErrores)
				$l_opcion:=ModernUI_Notificacion (__ ("Descarga de informe desde el repositorio");__ ("Advertencia: El informe seleccionado es obsoleto.\r");__ ("Cancelar");__ ("Aceptar"))
				If ($l_opcion=1)
					$l_error:=0
				End if 
			Else 
				$l_error:=0
			End if 
	End case 
	
	If ($l_error=0)
		
		
		OB_GET ($ob_info;->$t_uuidInforme;"uuid")  //olvidé esta linea, por eso en la actualización se duplicaban los informes.
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_Reports:54]UUID:47;->$t_uuidInforme;True:C214)
		If ($l_recNum=No current record:K29:2)
			CREATE RECORD:C68([xShell_Reports:54])
			[xShell_Reports:54]UUID:47:=$t_uuidInforme
		End if 
		
		  // info
		OB_GET ($ob_info;->[xShell_Reports:54]ReportName:26;"nombre")
		OB_GET ($ob_info;->[xShell_Reports:54]Modulo:41;"modulo")
		OB_GET ($ob_info;->[xShell_Reports:54]UUID_institucion:33;"uuidColegio")
		OB_GET ($ob_info;->[xShell_Reports:54]CountryCode:1;"codigoPais")
		OB_GET ($ob_info;->[xShell_Reports:54]LangageCode:10;"codigoLenguaje")
		OB_GET ($ob_info;->[xShell_Reports:54]ReportType:2;"tipoInforme")
		OB_GET ($ob_info;->[xShell_Reports:54]Descripción:16;"descripcion")
		OB_GET ($ob_info;->[xShell_Reports:54]Creacion_Usuario:34;"creadoPor")
		OB_GET ($ob_info;->[xShell_Reports:54]Modificacion_Usuario:39;"modificadoPor")
		OB_GET ($ob_info;->[xShell_Reports:54]DTS_creacion:20;"dtsCreacion")
		OB_GET ($ob_info;->[xShell_Reports:54]DTS_UltimaModificacion:46;"dtsModificacion")
		OB_GET ($ob_info;->[xShell_Reports:54]DTS_Repositorio:45;"dtsRepositorio")
		OB_GET ($ob_info;->[xShell_Reports:54]timestampISO_repositorio:37;"timestampRepositorio")
		OB_GET ($ob_info;->[xShell_Reports:54]timestampISO_creacion:36;"timestampCreacion")
		OB_GET ($ob_info;->[xShell_Reports:54]Tags:43;"tags")
		OB_GET ($ob_info;->[xShell_Reports:54]IsStandard:38;"esEstandar")
		OB_GET ($ob_info;->[xShell_Reports:54]Public:8;"esPublico")
		OB_GET ($ob_info;->[xShell_Reports:54]version_minimo:23;"versionMinima")
		OB_GET ($ob_info;->[xShell_Reports:54]version_maximo:24;"versionMaxima")
		[xShell_Reports:54]timestampISO_modificacion:35:=[xShell_Reports:54]timestampISO_repositorio:37
		
		  // propiedades
		OB_GET ($ob_data;->$t_Modelo_B64;"modelo")  // blob  (texto base64)
		OB_GET ($ob_data;->$t_consultaAsociada_B64;"consultaAsociada")  // blob  (texto base64)
		OB_GET ($ob_data;->$t_modeloEtiqueta;"modeloEtiqueta")  // blob  (texto base64)
		OB_GET ($ob_data;->[xShell_Reports:54]ExecuteBeforePrinting:4;"scriptAntesImpresion")
		OB_GET ($ob_data;->[xShell_Reports:54]ExecuteAfterPrinting:30;"scriptDespuesImpresion")
		OB_GET ($ob_data;->[xShell_Reports:54]ExecuteBeforeEachDocument:31;"ejecutarAntesCadaRegistro")
		OB_GET ($ob_data;->[xShell_Reports:54]ExecuteAfterEachRecord:32;"ejecutarDespuesCadaRegistro")
		OB_GET ($ob_data;->[xShell_Reports:54]isOneRecordReport:11;"unaTareaPorRegistro")
		OB_GET ($ob_data;->[xShell_Reports:54]NoRequiereSeleccion:40;"noRequiereSeleccion")
		OB_GET ($ob_data;->[xShell_Reports:54]MainTable:3;"tablaPrincipal")
		OB_GET ($ob_data;->[xShell_Reports:54]SR_MainTable:42;"tablaSuperReport")
		OB_GET ($ob_data;->[xShell_Reports:54]RelatedTable:14;"tablaRelacionada")
		OB_GET ($ob_data;->[xShell_Reports:54]SourceField:13;"campoOrigenRelacion")
		OB_GET ($ob_data;->[xShell_Reports:54]RelatedField:15;"campoDestinoRelacion")
		OB_GET ($ob_data;->[xShell_Reports:54]FormName:17;"nombreFormulario")
		OB_GET ($ob_data;->[xShell_Reports:54]SpecialParameter:18;"parametroEspecial")
		
		[xShell_Reports:54]EnRepositorio:48:=True:C214
		If (Util_isValidUUID ([xShell_Reports:54]UUID_institucion:33))  //si el UUID de institucion no es correcot se le asigna el del colegio// ABCTKT201635//20180320
			  //esto para que s epeuda visualizar el informe en  el explorador ya que hay una validación el método QR_FilterTemplates que lo quita de selección.
			[xShell_Reports:54]UUID_institucion:33:=<>gUUID
		End if 
		BASE64 DECODE:C896($t_consultaAsociada_B64;[xShell_Reports:54]AssociatedQuery:21)
		BASE64 DECODE:C896($t_Modelo_B64;[xShell_Reports:54]xReportData_:29)
		SAVE RECORD:C53([xShell_Reports:54])
		
		KRL_ReloadAsReadOnly (->[xShell_Reports:54])
		$l_errorRetorno:=0
	End if 
	
	
Else 
	ModernUI_Notificacion (__ ("Conexión con repositorio de informes");__ ("No fue posible establecer la conexión con el repositorio de informes a causa de un error:")+"\r\r"+$t_errorWS)
End if 