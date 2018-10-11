//%attributes = {}
  // RIN_InfoExplorador()
  // Por: Alberto Bachler K.: 12-08-14, 16:57:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_conEjemplo;$b_editable;$b_esEstandar)
C_LONGINT:C283($l_color;$l_error;$l_estilo;$l_icono;$l_opcion;$l_posicionEnLista;$l_versionEstructura_Principal;$l_versionEstructura_Revision;$reportRecNum)
C_POINTER:C301($y_dtsRepositorio)
C_TEXT:C284($CurrentReportName;$t_autorModificacion;$t_creador;$t_Description;$t_dtsModificacion;$t_error;$t_errorWS;$t_json;$t_nodoError;$t_refjSon)
C_TEXT:C284($t_refNodoError;$t_refNodoInfo;$t_uuid;$t_version;$t_versionEstructura;$t_timestampModificacion)


If (False:C215)
	C_TEXT:C284(RIN_InfoExplorador ;$1)
End if 


$t_uuid:=$1
$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")

WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
WEB SERVICE SET PARAMETER:C777("version";$t_version)
WEB SERVICE SET PARAMETER:C777("uuidColegio";<>GUUID)

$y_dtsRepositorio:=OBJECT Get pointer:C1124(Object named:K67:5;"ReportData_dtsRepositorio")


$t_errorWS:=WS_CallIntranetWebService ("RINws_InfoExplorador";True:C214)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
	
	C_OBJECT:C1216($ob;$ob_error;$ob_info)
	
	$ob:=OB_Create 
	$ob_error:=OB_Create 
	$ob_info:=OB_Create 
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob;->$ob_error;"error")
	OB_GET ($ob;->$ob_info;"info")
	OB_GET ($ob_error;->$l_error;"codigoError")
	OB_GET ($ob_error;->$t_error;"textoError")
	
	Case of 
		: ($l_error=-1)  // referencia (recNum) inválido
			ModernUI_Notificacion (__ ("Información del informe");__ ("Error: La institución no está registrada en Colegium.\rPor favor póngase en contacto con el departamento de soporte de Colegium."))
			
		: ($l_error=-2)  // no fue posible acceder al informe
			
		: ($l_error=-3)  // informe removido
			
		: ($l_error=-4)  // version incompatible
			OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";__ ("Este informe fue removido del repositorio."))
			OBJECT SET COLOR:C271(*;"reportData_estadoRepositorio";-Red:K11:4)
			
		Else 
			OB_GET ($ob_info;->$b_conEjemplo;"conEjemplo")
			OB_GET ($ob_info;->$t_Description;"descripcion")
			OB_GET ($ob_info;->$b_esEstandar;"esEstandar")
			OB_GET ($ob_info;->$t_dtsModificacion;"dtsModificacion")
			OB_GET ($ob_info;->$t_timestampModificacion;"timestampISO")
			OB_GET ($ob_info;->$t_autorModificacion;"autorModificacion")
			OB_GET ($ob_info;->$t_creador;"creador")
	End case 
	
	
	If (($l_error>-4) & ($l_error<-1))
		GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_Informes);$reportRecNum;$CurrentReportName)
		GET LIST ITEM PROPERTIES:C631(hl_informes;$reportRecNum;$b_editable;$l_estilo;$l_icono;$l_color)
		If (((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | ([xShell_Reports:54]Propietary:9<0) | (USR_IsGroupMember_by_GrpID (-15001))))
			$l_opcion:=ModernUI_Notificacion (__ ("Información del informe");__ ("Error: El informe no existe en el repositorio de informes o está obsoleto.\rPuede conservarlo o eliminarlo de su librería de informes.\rSi lo elimina puede buscar en el repositorio un informe que lo sustituya.\r¿Que desea hacer?");__ ("Conservar en mi librería");__ ("Eliminar"))
			If ($l_opcion=2)
				$l_posicionEnLista:=Selected list items:C379(hl_Informes)
				GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_Informes);$reportRecNum;$CurrentReportName)
				DELETE FROM LIST:C624(hl_Informes;$reportRecNum)
				KRL_DeleteRecord (->[xShell_Reports:54])
				Case of 
					: ($l_posicionEnLista<=Count list items:C380(hl_Informes))
						SELECT LIST ITEMS BY POSITION:C381(hl_Informes;$l_posicionEnLista)
					: (($l_posicionEnLista>Count list items:C380(hl_Informes)) & (Count list items:C380(hl_Informes)>0))
						SELECT LIST ITEMS BY POSITION:C381(hl_Informes;$l_posicionEnLista-1)
					Else 
				End case 
				QR_LoadSelectedReport 
			Else 
				KRL_ReloadInReadWriteMode (->[xShell_Reports:54])
				[xShell_Reports:54]EnRepositorio:48:=False:C215
				[xShell_Reports:54]IsStandard:38:=False:C215
				[xShell_Reports:54]DTS_Repositorio:45:=""
				SAVE RECORD:C53([xShell_Reports:54])
				KRL_ReloadAsReadOnly (->[xShell_Reports:54])
				OBJECT SET ENABLED:C1123(*;"ReportData_ejemplo";$b_conEjemplo)
				OBJECT SET ENABLED:C1123(*;"ReportData_actualizar";False:C215)
				SET LIST ITEM PROPERTIES:C386(hl_Informes;$reportRecNum;False:C215;Plain:K14:1;$l_icono;$l_color)
			End if 
		Else 
			$l_opcion:=ModernUI_Notificacion (__ ("Información del informe");__ ("Error: El informe no existe en el repositorio de informes o está obsoleto.\rEl informe se mantendrá en la librería como un informe no estándar."))
			KRL_ReloadInReadWriteMode (->[xShell_Reports:54])
			[xShell_Reports:54]EnRepositorio:48:=False:C215
			[xShell_Reports:54]IsStandard:38:=False:C215
			[xShell_Reports:54]DTS_Repositorio:45:=""
			SAVE RECORD:C53([xShell_Reports:54])
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
			OBJECT SET ENABLED:C1123(*;"ReportData_ejemplo";$b_conEjemplo)
			OBJECT SET ENABLED:C1123(*;"ReportData_actualizar";False:C215)
			SET LIST ITEM PROPERTIES:C386(hl_Informes;$reportRecNum;False:C215;Plain:K14:1;0)
		End if 
		
	Else 
		IT_SetButtonState ($t_timestampModificacion>[xShell_Reports:54]timestampISO_modificacion:35;->bUpdate)
		Case of 
			: ($l_error=-4)
				OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";__ ("Este informe está obsoleto.\rUtilice de preferencia otro informe."))
				OBJECT SET COLOR:C271(*;"reportData_estadoRepositorio";-Red:K11:4)
				
			: ($t_timestampModificacion>[xShell_Reports:54]timestampISO_repositorio:37)
				OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";__ ("Hay una nueva versión de este informe")+" ("+DT_FechaISO_a_FechaHora ($t_timestampModificacion)+")")
				OBJECT SET COLOR:C271(*;"reportData_estadoRepositorio";-Dark green:K11:10)
				
			Else 
				OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";__ ("El informe corresponde a la última versión almacenada en el repositorio"))
				OBJECT SET COLOR:C271(*;"reportData_estadoRepositorio";-Dark blue:K11:6)
				
		End case 
	End if 
Else 
	ModernUI_Notificacion (__ ("Conexión con repositorio de informes");__ ("No fue posible establecer la conexión con el repositorio de informes a causa de un error:")+"\r\r"+$t_errorWS)
	OBJECT SET TITLE:C194(*;"reportData_estadoRepositorio";__ ("Servidor no disponible: la búsqueda de nuevas versiones fue deshabilitada temporalmente."))
	OBJECT SET COLOR:C271(*;"reportData_estadoRepositorio";-Red:K11:4)
	bc_lookforUpdatedReport:=0
End if 
OBJECT SET ENABLED:C1123(*;"ReportData_actualizar";$t_timestampModificacion>[xShell_Reports:54]timestampISO_modificacion:35)
OBJECT SET ENABLED:C1123(*;"ReportData_ejemplo";$b_conEjemplo)

$y_dtsRepositorio->:=$t_timestampModificacion

