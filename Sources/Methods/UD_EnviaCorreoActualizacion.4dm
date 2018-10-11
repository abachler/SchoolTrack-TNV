//%attributes = {}
  // UD_EnviaCorreoActualizacion()
  // Por: Alberto Bachler K.: 08-07-14, 10:48:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_versionBD_Build;$l_versionBD_Principal;$l_versionBD_Revision;$l_versionEstructura_Build;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_TEXT:C284($t_asunto;$t_contraseña;$t_copia;$t_copiaOculta;$t_Cuerpo;$t_destinatario;$t_Error;$t_Host;$t_login;$t_responderA)
C_TEXT:C284($t_versionBaseDeDatos;$t_versionEstructura)
C_POINTER:C301($y_nil)

ARRAY TEXT:C222($at_adjuntos;0)


If (Is compiled mode:C492)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
	$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionEstructura_Build)
	
	$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
	$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionBD_Revision)
	$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
	
	If (($l_versionEstructura_Principal=$l_versionBD_Principal) | ($l_versionEstructura_Revision=$l_versionBD_Revision))
		$t_asunto:="Actualización exitosa a SchoolTrack ^2 en "+<>gCustom
		$t_Cuerpo:=__ ("La base de datos en referencia fue exitosamente actualizada a la versión ^2: ")
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("Nombre del computador: ")+Current machine:C483
		$t_Cuerpo:=$t_Cuerpo+"\r"+__ ("Nombre del usuario activo: ")+Current system user:C484
		$t_Cuerpo:=$t_Cuerpo+"\r"+__ ("Ruta de la base de datos: \r")+Data file:C490
		$t_asunto:=Replace string:C233($t_asunto;"^2";$t_versionEstructura)
		$t_Cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionBaseDeDatos)
		$t_Cuerpo:=Replace string:C233($t_Cuerpo;"^2";$t_versionEstructura)
		$t_destinatario:="soporte@colegium.com"
		$t_copia:="qa@colegium.com"
		$t_copiaCC:="abachler@colegium.com"
		$t_error:=Mail_EnviaNotificacion ($t_asunto;$t_Cuerpo;$t_destinatario;$t_copia;$t_copiaCC;$y_nil;__ ("Enviando informe de actualización a Colegium..."))
		If ($t_error="")
			Notificacion_Mostrar ("Envio de informe a Colegium";"El informe de actualización de la base de datos fue enviado a Colegium.")
		End if 
	End if 
End if 