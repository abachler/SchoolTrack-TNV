//%attributes = {}
  //UD_VerificaActualizacion

  //20091009
  //En algunas ocasiones el método UD_Handler no se ejecuta completo y se corta. Esto impide que se ejecute la actualización de los datos completamente. 
  //Este método tiene por objetivo informar al usuario del grupo administración que al parecer hubo un problema de actualización.
  //20110318 RCH Se agrega condicion Is compiled mode para evitar que se ejecute en colegium...
  //20110415 Se agrega filtro de versiones compiladas para que trace no salte en interpretado...

If (Is compiled mode:C492)
	C_TEXT:C284($t_versionEstructura;$t_versionBaseDeDatos)
	C_LONGINT:C283($l_versionPrincipal;$l_revision;$l_Build)
	
	  //20140404 RCH Ahora se guarda el texto beta en la base. Se necesita...
	  //20130523 RCH Se estaba comparando con el texto beta.
	$t_versionEstructura:=SYS_LeeVersionEstructura 
	  //SYS_LeeVersionEstructura ("principal";->$l_versionPrincipal)
	  //SYS_LeeVersionEstructura ("revision";->$l_revision)
	  //SYS_LeeVersionEstructura ("build";->$l_Build)
	  //$t_versionEstructura:=String($l_versionPrincipal)+"."+String($l_revision)+"."+String($l_Build)
	$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 
	If (($t_versionBaseDeDatos#$t_versionEstructura) & (USR_IsGroupMember_by_GrpID (-15001)) & (USR_GetUserID >0))
		TRACE:C157
		C_TEXT:C284($vt_msg)
		$vt_msg:="¡¡¡¡¡   ATENCIÓN   !!!!!\r\rLa versión de los datos ("+String:C10($t_versionBaseDeDatos)+") es distinta a la versión de la aplicacion ("+String:C10($t_versionEstructura)+"). Es altamente probab"+"le que se haya producido un problema durante la última actualización del sistema."+"\r\r"+"Por favor capture esta pantal"+"la y comuníquese con soporte para verificar el problema."+"\r\r"+"Ruta Base de datos actualmente utilizada: "+SYS_GetDataPath +"\r\r"+"NOTA: Este mensaje sólo aparece a los usuarios del grupo administración."
		
		vsBWR_CurrentModule:="SchoolTrack"
		$To:="soporte@colegium.com"
		  //20150326 RCH
		  //$message:="Versión de datos y estructura diferentes.\rEs altamente probab"+"le que se haya producido un problema durante la última actualización del sistema."+<>cr+"Ruta Base de datos actualmente utilizada: "+SYS_GetDataPath 
		$message:="Versión de datos y estructura diferentes.\rEs altamente probab"+"le que se haya producido un problema durante la última actualización del sistema. Versión de la base de datos: "+$t_versionBaseDeDatos+", versión de la aplicación: "+$t_versionEstructura+"."+"\r"+"Ruta Base de datos actualmente utilizada: "+SYS_GetDataPath 
		$resultado:=SOPORTE_EnviaMailIncidente ($To;$message;"D")
		LOG_RegisterEvt ($vt_msg)
		CD_Dlog (0;$vt_msg)
	End if 
	
	  //20101022 verifica correcta ejecucion de tareas de fin de dia
	If ((USR_IsGroupMember_by_GrpID (-15001)) & (USR_GetUserID >0))
		TRACE:C157
		dhBM_VerificaEjecucionTareas 
	End if 
	
	  //20141120 RCH Verifica ejecucion de tareas dte
	If (<>vlXS_CurrentModuleRef=3)
		ACTdte_Alertas (True:C214)
	End if 
	
End if 