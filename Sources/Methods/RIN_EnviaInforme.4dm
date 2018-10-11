//%attributes = {}
  // RIN_EnviaInforme()
  // Por: Alberto Bachler K.: 01-08-14, 09:53:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3;$4)
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BLOB:C604($x_Blob;$x_busquedaAsociada;$x_dataInforme;$x_ejemplo)
C_LONGINT:C283($l_actualizarUltimaVersion;$l_buildFuerzaActualizacion;$l_listaVacia;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_POINTER:C301($y_JsonComparacion)
C_TEXT:C284($t_busquedaAsociada;$t_codigoLenguaje;$t_codigoPais;$t_comentario;$t_consultaAsociada_B64;$t_dataInformeB64;$t_desdeVersion;$t_dtsModificacion;$t_ejemploBase64;$t_errorWS)
C_TEXT:C284($t_hastaVersion;$t_json;$t_palabrasClaves;$t_refJson;$t_refNodoActualizacion;$t_refNodoData;$t_refNodoError;$t_refNodoInfo;$t_rutaEjemplo;$t_uuidColegio)
C_TEXT:C284($t_uuidInforme;$t_versionEstructura;$t_versionSRP;$t_timestampRepositorio)


If (False:C215)
	C_TEXT:C284(RIN_EnviaInforme ;$0)
	C_TEXT:C284(RIN_EnviaInforme ;$1)
	C_TEXT:C284(RIN_EnviaInforme ;$2)
	C_LONGINT:C283(RIN_EnviaInforme ;$3)
	C_LONGINT:C283(RIN_EnviaInforme ;$4)
End if 



Case of 
	: (Count parameters:C259=4)
		$l_actualizarUltimaVersion:=$4
		$l_buildFuerzaActualizacion:=$3
		$t_rutaEjemplo:=$2
		$t_comentario:=$1
	: (Count parameters:C259=3)
		$l_buildFuerzaActualizacion:=$3
		$t_rutaEjemplo:=$2
		$t_comentario:=$1
	: (Count parameters:C259=2)
		$t_rutaEjemplo:=$2
		$t_comentario:=$1
	: (Count parameters:C259=1)
		$t_comentario:=$1
End case 

Case of 
	: (($t_codigoLenguaje="") & ([xShell_Reports:54]LangageCode:10#""))
		$t_codigoLenguaje:=[xShell_Reports:54]LangageCode:10
	: (($t_codigoLenguaje="") & ([xShell_Reports:54]LangageCode:10=""))
		$t_codigoLenguaje:=<>vtXS_langage
	: ($t_codigoLenguaje="")
		$t_codigoLenguaje:=[xShell_Reports:54]LangageCode:10
End case 

If (($t_codigoPais="") & ([xShell_Reports:54]CountryCode:1#""))
	$t_codigoPais:=[xShell_Reports:54]CountryCode:1
End if 

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_versionEstructura:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")


  // almacenamiento del modelo de etiqueta del informe en el blob que contiene los datos del modelo
If ([xShell_Reports:54]ReportType:2="4DET")
	If ([xShell_Reports:54]Texto:5#"")
		TEXT TO BLOB:C554([xShell_Reports:54]Texto:5;$x_dataInforme;UTF8 text without length:K22:17)
		[xShell_Reports:54]xReportData_:29:=$x_dataInforme
	End if 
End if 

  // codificación de blobs en Base 64
If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
	If ([xShell_Reports:54]ReportType:2="gSR2")
		$l_error:=SR_NewReportBLOB ($l_areaRef;[xShell_Reports:54]xReportData_:29)
		$t_versionSRP:=SR_GetTextProperty ($l_areaRef;1;SRP_Report_Version)
		SR_DeleteReport ($l_areaRef)
	End if 
	
	$x_dataInforme:=[xShell_Reports:54]xReportData_:29
	BASE64 ENCODE:C895($x_dataInforme)
	$t_dataInformeB64:=BLOB to text:C555($x_dataInforme;UTF8 text without length:K22:17)
End if 

If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
	$x_busquedaAsociada:=[xShell_Reports:54]AssociatedQuery:21
	BASE64 ENCODE:C895($x_busquedaAsociada)
	$t_busquedaAsociada:=BLOB to text:C555($x_busquedaAsociada;UTF8 text without length:K22:17)
End if 

If (Test path name:C476($t_rutaEjemplo)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($t_rutaEjemplo;$x_ejemplo)
	COMPRESS BLOB:C534($x_ejemplo;GZIP best compression mode:K22:18)
	BASE64 ENCODE:C895($x_ejemplo;$t_ejemploBase64)
Else 
	$y_JsonComparacion:=OBJECT Get pointer:C1124(Object named:K67:5;"jsonComparacion")
	
	If (Not:C34(Is nil pointer:C315($y_JsonComparacion)))
		C_OBJECT:C1216($ob;$ob_NodoInfo;$ob_NodoError)
		
		
		$ob:=JSON Parse:C1218($y_JsonComparacion->)
		OB_GET ($ob;->$ob_NodoInfo;"info")
		OB_GET ($ob;->$ob_NodoError;"error")
		OB_GET ($ob_NodoError;->$t_ejemploBase64;"ejemploPDF")
		
		CLEAR VARIABLE:C89($ob)
		CLEAR VARIABLE:C89($ob_NodoInfo)
		CLEAR VARIABLE:C89($ob_NodoError)
	End if 
End if 


C_OBJECT:C1216($ob_raiz;$ob_NodoData;$ob_NodoInfo;$ob_nodoActualizacion)
$ob_raiz:=OB_Create 
$ob_NodoData:=OB_Create 
$ob_NodoInfo:=OB_Create 
$ob_nodoActualizacion:=OB_Create 

  //[xShell_Reports]DTS_Repositorio:=DTS_MakeFromDateTime 
  //[xShell_Reports]DTS_UltimaModificacion:=[xShell_Reports]DTS_Repositorio

  //[xShell_Reports]timestampISO_modificacion:=Timestamp
  //[xShell_Reports]timestampISO_repositorio:=[xShell_Reports]timestampISO_modificacion

  // informacion de actualizacion
OB_SET ($ob_nodoActualizacion;-><>tUSR_CurrentUserName;"nombreUsuario")
OB_SET ($ob_nodoActualizacion;->$t_Comentario;"descripcionCambio")

  // informacionGeneral
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]UUID:47;"uuid")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]ReportName:26;"nombre")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]Modulo:41;"modulo")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]UUID_institucion:33;"uuidColegio")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]CountryCode:1;"codigoPais")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]LangageCode:10;"codigoLenguaje")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]ReportType:2;"tipoInforme")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]Descripción:16;"descripcion")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]Creacion_Usuario:34;"creadoPor")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]Modificacion_Usuario:39;"modificadoPor")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]DTS_creacion:20;"dtsCreacion")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]DTS_UltimaModificacion:46;"dtsModificacion")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]DTS_Repositorio:45;"dtsRepositorio")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]timestampISO_creacion:36;"timestampCreacion")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]timestampISO_modificacion:35;"timestampModificacion")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]Tags:43;"tags")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]IsStandard:38;"esEstandar")
If ([xShell_Reports:54]IsStandard:38)  //MONO 203298 - Si es Standar, sube como público al repositorio no importando la configuración local.
	[xShell_Reports:54]Public:8:=True:C214
End if 
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]Public:8;"esPublico")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]version_minimo:23;"versionMinima")
OB_SET ($ob_NodoInfo;->[xShell_Reports:54]version_maximo:24;"versionMaxima")
OB_SET ($ob_NodoInfo;->$l_buildFuerzaActualizacion;"buildFuerzaActualizacion")
OB_SET ($ob_NodoInfo;->$t_versionSRP;"versionSRP")


  // propiedades
OB_SET ($ob_NodoData;->$t_dataInformeB64;"modelo")  // blob convertido a texto base64
OB_SET ($ob_NodoData;->$t_consultaAsociada_B64;"consultaAsociada")  // blob convertido a texto base64
OB_SET ($ob_NodoData;->$t_ejemploBase64;"ejemplo")  // blob convertido a texto base64
OB_SET ($ob_NodoData;->[xShell_Reports:54]ExecuteBeforePrinting:4;"scriptAntesImpresion")
OB_SET ($ob_NodoData;->[xShell_Reports:54]ExecuteAfterPrinting:30;"scriptFinImpresion")
OB_SET ($ob_NodoData;->[xShell_Reports:54]ExecuteBeforeEachDocument:31;"ejecutarAntesCadaRegistro")
OB_SET ($ob_NodoData;->[xShell_Reports:54]ExecuteAfterEachRecord:32;"ejecutarDespuesCadaRegistro")
OB_SET ($ob_NodoData;->[xShell_Reports:54]isOneRecordReport:11;"unaTareaPorRegistro")
OB_SET ($ob_NodoData;->[xShell_Reports:54]NoRequiereSeleccion:40;"noRequiereSeleccion")
OB_SET ($ob_NodoData;->[xShell_Reports:54]MainTable:3;"tablaPrincipal")
OB_SET ($ob_NodoData;->[xShell_Reports:54]SR_MainTable:42;"tablaSuperReport")
OB_SET ($ob_NodoData;->[xShell_Reports:54]RelatedTable:14;"tablaRelacionada")
OB_SET ($ob_NodoData;->[xShell_Reports:54]SourceField:13;"campoOrigenRelacion")
OB_SET ($ob_NodoData;->[xShell_Reports:54]RelatedField:15;"campoDestinoRelacion")
OB_SET ($ob_NodoData;->[xShell_Reports:54]FormName:17;"nombreFormulario")
OB_SET ($ob_NodoData;->[xShell_Reports:54]SpecialParameter:18;"parametroEspecial")

  //agrego NODOS a la Raiz
OB_SET ($ob_raiz;->$ob_NodoData;"data")
OB_SET ($ob_raiz;->$ob_NodoInfo;"info")
OB_SET ($ob_raiz;->$ob_nodoActualizacion;"datosActualizacion")
$t_json:=OB_Object2Json ($ob_raiz)


  // envío del informe mediante una petición soap
WEB SERVICE SET PARAMETER:C777("json";$t_json)
WEB SERVICE SET PARAMETER:C777("actualizarUltimaVersion";$l_actualizarUltimaVersion)
$t_errorWS:=WS_CallIntranetWebService ("RINws_RecibeInforme";True:C214)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_dtsModificacion;"dtsRepositorio")
	WEB SERVICE GET RESULT:C779($t_timestampRepositorio;"timestampRepositorio";*)  //20180514 RCH Ticket 206788
	
	If ($t_dtsModificacion#"")
		[xShell_Reports:54]DTS_Repositorio:45:=$t_dtsModificacion
		[xShell_Reports:54]timestampISO_repositorio:37:=$t_timestampRepositorio
		
		If ([xShell_Reports:54]IsStandard:38)
			$l_listaVacia:=New list:C375
			LIST TO BLOB:C556($l_listaVacia;[xShell_Reports:54]xAuthorizedGroups:27)
			LIST TO BLOB:C556($l_listaVacia;[xShell_Reports:54]xAuthorizedUsers:28)
			CLEAR LIST:C377($l_listaVacia)
		End if 
	Else 
		[xShell_Reports:54]IsStandard:38:=False:C215  //205056 //ABC//si no se develve dts es por que no fue subido por lo que hay que desmarcar estandar.
		[xShell_Reports:54]Public:8:=False:C215
	End if 
	SAVE RECORD:C53([xShell_Reports:54])
End if 

$0:=$t_dtsModificacion



