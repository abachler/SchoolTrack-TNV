//%attributes = {}
  //SYS_READVERSION


C_BOOLEAN:C305($0;$vb_continuar)
C_LONGINT:C283($l_versionEstructura_Principal;$l_versionEstructura_Revision;$l_versionEstructura_Build)
C_LONGINT:C283($l_versionBD_Principal;$l_versionBD_Revision;$l_versionBD_Build)
C_TEXT:C284($t_versionEstructura)


  // lectura de la version de la estructura (se leen variables interproceso con los detalles de la version
$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_versionEstructura:=SYS_LeeVersionEstructura ("build";->$l_versionEstructura_Build)

$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionBD_Principal)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionBD_Revision)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)


$stop:=False:C215
$vb_continuar:=True:C214

Case of 
	: ($l_versionBD_Principal=0)
		cdT_HelpTxt:=""
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		vsBWR_CurrentModule:="SchoolTrack"
		If (Picture size:C356(vpXS_IconModule)=0)
			GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		End if 
		$t_mensaje:="No existe información sobre la versión de los datos.\rLa aplicación no puede ser utilizada\r\rPor favor pongase inmediatamente en contacto con Soporte Técnico de Colegium."
		  //WDW_OpenDialogInDrawer (->[xShell_Dialogs];"cd_ALERT")
		ALERT:C41($t_mensaje)
		LOG_RegisterEvt ($t_mensaje)
		TRACE:C157
		QUIT 4D:C291
		$vb_continuar:=False:C215
		
	: ($l_versionBD_Principal<10)
		cdT_HelpTxt:=""
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		vsBWR_CurrentModule:="SchoolTrack"
		If (Picture size:C356(vpXS_IconModule)=0)
			GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		End if 
		$t_mensaje:="Esta versión de la base de datos no puede ser convertida a la versión 10.3.\rLa aplicación no puede ser utilizada.\r\rPor favor pongase inmediatamente en contacto con Soporte Técnico de Colegium."
		  //WDW_OpenDialogInDrawer (->[xShell_Dialogs];"cd_ALERT")
		ALERT:C41($t_mensaje)
		LOG_RegisterEvt ($t_mensaje)
		TRACE:C157
		QUIT 4D:C291
		$vb_continuar:=False:C215
		
	: (($l_versionBD_Principal=10) & ($l_versionBD_Revision<2))  //Las bases de datos deben ser abiertas con 10.2 antes de abrir con STX 10.3
		$t_mensaje:="Esta base de datos debe ser actualizada con la versión 10.2 antes de abrirla con la versón 10.3.\r\rLa base de datos puede haber resultado dañada después de abrirla con SchoolTrack 10.3. Por favor abra un respaldo de su base de datos con la versión"+" 10"+" y luego actualice a 10.3."
		cdT_HelpTxt:=""
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		  //WDW_OpenDialogInDrawer (->[xShell_Dialogs];"cd_ALERT")
		ALERT:C41($t_mensaje)
		LOG_RegisterEvt ($t_mensaje)
		TRACE:C157
		QUIT 4D:C291
		$vb_continuar:=False:C215
		
		  //20110305 RCH Se testeaba la version de la estuctura y no de los datos...
		  //: (($l_versionEstructura_Principal=10) & ($l_versionBD_Revision<4) & ($l_versionBD_Build<697))  //Las bases de datos deben ser abiertas con 10.4r697 antes de  convertir a v11
	: (($l_versionBD_Principal=10) & ($l_versionBD_Revision<4) & ($l_versionBD_Build<697))  //Las bases de datos deben ser abiertas con 10.4r697 antes de  convertir a v11
		  // se necesita 634 por los numeros de tc en ACT
		  // se necesita 638 por los archivos bancarios en ACT
		  // se necesita 644 por los archivos bancarios en ACT
		  // se necesita 697 por las contraseñas de usuario
		$t_mensaje:="Esta base de datos debe ser actualizada con la versión 10.4.697 antes de abrirla con SchoolTrack v11.\r\rLa base de datos puede haber resultado dañada después de abrirla con SchoolTrack v11.\r Por favor abra un respaldo de su base de datos con la vers"+" 10.4r697 y luego actualice a SchoolTrack v11"
		cdT_HelpTxt:=""
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		  //WDW_OpenDialogInDrawer (->[xShell_Dialogs];"cd_ALERT")
		ALERT:C41($t_mensaje)
		LOG_RegisterEvt ($t_mensaje)
		TRACE:C157
		QUIT 4D:C291
		$vb_continuar:=False:C215
		
	: (($l_versionBD_Principal=10) & ($l_versionBD_Revision=4))  //Las bases de datos deben ser abiertas con 11.0 antes de  convertir a v11.1
		$t_mensaje:="Esta base de datos debe ser actualizada con la versión 11.0 antes de abrirla con SchoolTrack v11.1.\r\rLa base de datos puede haber resultado dañada después de abrirla con SchoolTrack v11.\r Por favor abra un respaldo de su base de datos con la versi"+"ó"+"0 (build 11194) y luego actualice a SchoolTrack v11.1"
		cdT_HelpTxt:=""
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		  //WDW_OpenDialogInDrawer (->[xShell_Dialogs];"cd_ALERT")
		ALERT:C41($t_mensaje)
		LOG_RegisterEvt ($t_mensaje)
		TRACE:C157
		QUIT 4D:C291
		$vb_continuar:=False:C215
		
		  // 20111102 RCH se pasa a 11197 por un metodo de actualizacion requerido...
		  // 20111102 RCH se pasa a 11202 por un metodo de actualizacion requerido...
	: (($l_versionBD_Principal=11) & ($l_versionBD_Revision=0) & ($l_versionBD_Build<11999))  //Las bases de datos deben ser abiertas con 11.0 antes de  convertir a v11.1
		$t_mensaje:="Esta base de datos debe ser preparada con la versión 11.0r11265 antes de abrirla con SchoolTrack v11.1.\r\rLa base de datos puede haber resultado dañada después de abrirla con SchoolTrack v11.1\r Por favor abra un respaldo de su base de datos con la v"+"ión 11.0r11265 y prepare la base de datos para actualizarla a SchoolTrack v11.1"
		cdT_HelpTxt:=""
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		  //WDW_OpenDialogInDrawer (->[xShell_Dialogs];"cd_ALERT")
		ALERT:C41($t_mensaje)
		LOG_RegisterEvt ($t_mensaje)
		TRACE:C157
		QUIT 4D:C291
		$vb_continuar:=False:C215
		
		
	: ($l_versionBD_Principal>$l_versionEstructura_Principal)
		$stop:=True:C214
	: (($l_versionEstructura_Principal=$l_versionBD_Principal) & ($l_versionBD_Revision>$l_versionEstructura_Revision))
		$stop:=True:C214
	: ($t_versionBaseDeDatos>$t_versionEstructura)
		If (Is compiled mode:C492)
			$stop:=True:C214
		Else 
			ALERT:C41("Esta base de datos ya fue abierta con una versión ulterior a la actual.\r\r¡¡¡Cuidado con las operaciones de actualización!!!\r\rEn compilado la aplicación se cerrará para no ejecutar la actualización.")
			TRACE:C157
		End if 
		
	Else 
		
		
End case 


If ($stop)
	$t_mensaje:="Esta base de datos ya fue abierta con la versión "+String:C10($l_versionBD_Principal)+"."+String:C10($l_versionBD_Revision)+"."+String:C10($l_versionBD_Build)+".\r\rNo es posible abrir la base de datos con una versión anterior."
	If (Application type:C494#4D Server:K5:6)
		CD_Dlog (0;$t_mensaje)
		QUIT 4D:C291
		$vb_continuar:=False:C215
	Else 
		If (Application type:C494=4D Server:K5:6)
			cdT_HelpTxt:=""
			cdS_btn1:="OK"
			
			cdS_btn2:=""
			cdS_btn3:=""
			ALERT:C41($t_mensaje)
			QUIT 4D:C291
			$vb_continuar:=False:C215
		End if 
	End if 
Else 
	If ($vb_continuar)
		If (Application type:C494#4D Remote mode:K5:5)
			Case of 
				: ($l_versionBD_Principal=0)
					HIDE PROCESS:C324(<>Splash)
					HLPR_InitNewDatabase 
					SHOW PROCESS:C325(<>Splash)
					
				: ($t_versionBaseDeDatos<$t_versionEstructura)
					MESSAGES OFF:C175
					If (Not:C34(Semaphore:C143("Actualización")))
						TRACE:C157
						UD_Handler 
						SHOW PROCESS:C325(<>Splash)
						CLEAR SEMAPHORE:C144("Actualización")
					End if 
					MESSAGES ON:C181
			End case 
		End if 
	End if 
End if 
$0:=$vb_continuar