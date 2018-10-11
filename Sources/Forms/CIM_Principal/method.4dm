  // XS_CIM()
  // Por: Alberto Bachler K.: 04-09-14, 11:41:52
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(<>arrCurrPath;0)
		
		SET WINDOW TITLE:C213("Centro de Información y Mantenimiento";Frontmost window:C447)
		OBJECT SET FONT STYLE:C166(bPage1;1)
		
		
		C_LONGINT:C283(vlProgress)
		C_TEXT:C284(vtAction)
		vlProgress:=0
		vtAction:=""
		
		
		hl_infoItemsLocal:=New list:C375
		APPEND TO LIST:C376(hl_infoItemsLocal;__ ("Mi Computador");1)
		APPEND TO LIST:C376(hl_infoItemsLocal;__ ("  Red");2)
		APPEND TO LIST:C376(hl_infoItemsLocal;__ ("  Configuración regional");3)
		APPEND TO LIST:C376(hl_infoItemsLocal;__ ("  SchoolTrack");4)
		  //APPEND TO LIST(hl_infoItemsLocal;__ ("  Información detallada");5)
		
		hl_infoItemsServer:=New list:C375
		APPEND TO LIST:C376(hl_infoItemsServer;__ ("Servidor");1)
		APPEND TO LIST:C376(hl_infoItemsServer;__ ("  Red");2)
		APPEND TO LIST:C376(hl_infoItemsServer;__ ("  Configuración regional");3)
		APPEND TO LIST:C376(hl_infoItemsServer;__ ("  SchoolTrack");4)
		APPEND TO LIST:C376(hl_infoItemsServer;__ ("  Usuarios SchoolTrack");5)
		  //APPEND TO LIST(hl_infoItemsServer;__ ("  Información detallada");6)
		
		hlCIM_LocalBrowser_FTP:=New list:C375
		hlCIM_LocalBrowser_Explorer:=New list:C375
		hlCIM_FTPDirectories:=New list:C375
		hlCIM_ServerBrowser:=New list:C375
		
		
		XS_CIM_ObjetMethods ("ConnectionPrefs")
		
		GOTO OBJECT:C206(hl_InfoItemsLocal)
		OBJECT SET FONT:C164(*;"BKP_passwordVolumenRemoto";"%Password")
		
		OBJECT SET FONT STYLE:C166(*;"bPage@";Bold:K14:2)
		OBJECT SET TITLE:C194(*;"bPage1";"Información")
		OBJECT DUPLICATE:C1111(*;"bPage1";"bPage2")
		OBJECT SET TITLE:C194(*;"bPage2";__ ("Sesiones"))
		OBJECT DUPLICATE:C1111(*;"bPage1";"bPage3")
		OBJECT SET TITLE:C194(*;"bPage3";__ ("Respaldos"))
		OBJECT DUPLICATE:C1111(*;"bPage1";"bPage4")
		OBJECT SET TITLE:C194(*;"bPage4";__ ("Mantenimiento"))
		OBJECT DUPLICATE:C1111(*;"bPage1";"bPage5")
		OBJECT SET TITLE:C194(*;"bPage5";__ ("FTP"))
		  //OBJECT DUPLICATE(*;"bPage1";"bPage6")
		  //OBJECT SET TITLE(*;"bPage6";__ ("Soporte"))
		OBJECT DUPLICATE:C1111(*;"bPage1";"bPage7")
		OBJECT SET TITLE:C194(*;"bPage7";__ ("Registro de actividades"))
		OBJECT DUPLICATE:C1111(*;"bPage1";"bPage8")
		OBJECT SET TITLE:C194(*;"bPage8";__ ("Manuales"))
		IT_DistribuyeObjetos_Horizontal ("bPage@";30;1;24;14)
		
		
		OBJECT SET FONT STYLE:C166(*;"bPage@";Plain:K14:1)
		OBJECT SET COLOR:C271(*;"bPage@";-Dark grey:K11:12)
		OBJECT SET FONT STYLE:C166(*;"bPage1";Bold:K14:2)
		OBJECT GET COORDINATES:C663(*;"bPage1";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		IT_SetNamedObjectRect ("fondoBotonesPaginas";$l_izquierda-8;$l_arriba-5;$l_derecha+8;$l_abajo+5)
		$l_colorFondo:=(210 << 16)+(228 << 8)+248
		$l_colorTexto:=(31 << 16)+(102 << 8)+177
		OBJECT SET RGB COLORS:C628(*;"fondoBotonesPaginas";$l_colorFondo;$l_colorFondo)
		OBJECT SET RGB COLORS:C628(*;"bPage1";$l_colorTexto;$l_colorFondo)
		
		
		
		If ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1))
			OBJECT SET VISIBLE:C603(hl_InfoItemsServer;False:C215)
			OBJECT SET VISIBLE:C603(lb_ServerInfo;False:C215)
			OBJECT GET COORDINATES:C663(hl_InfoItemsServer;$l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
			OBJECT GET COORDINATES:C663(hl_InfoItemsLocal;$l_Izquierda;$l_Arriba;$l_derecha;$l_abajoLocal)
			IT_SetObjectRect (->hl_InfoItemsLocal;$l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
			OBJECT GET COORDINATES:C663(lb_Locallnfo;$l_Izquierda;$l_Arriba;$l_derecha;$l_abajoLocal)
			IT_SetObjectRect (->lb_Locallnfo;$l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
		End if 
		
		CIM_CambiaPagina (1)
		
		If (Application type:C494=4D Volume desktop:K5:2)
			OBJECT SET ENABLED:C1123(*;"compactacionBD";False:C215)
			OBJECT SET ENABLED:C1123(*;"reconstruccionBD";False:C215)
			OBJECT SET COLOR:C271(*;"textoCompactacion@";-Light grey:K11:13)
			OBJECT SET COLOR:C271(*;"textoreconstruccion@";-Light grey:K11:13)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		XS_CIM_ObjetMethods ("SaveCurrent")
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		CIM_GuardaConfiguracion 
		HL_ClearList (hl_infoItemsLocal;hl_infoItemsServer;hlCIM_FTPDirectories;hlCIM_ServerBrowser;hlCIM_LocalBrowser_FTP;hlCIM_LocalBrowser_Explorer)
		vtBKP_xmlRef:=""
		$y_refMenuModulos:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuModulos")
		RELEASE MENU:C978($y_refMenuModulos->)
		$y_refMenuUsuarios:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuUsuarios")
		RELEASE MENU:C978($y_refMenuUsuarios->)
		
	: (Form event:C388=On Timer:K2:25)
		If ((webArea_progress>0) & (webArea_progress<100))
			$l_ancho:=IT_Objeto_Ancho ("barraOriginal")
			$r_ratio:=webArea_progress/100
			OBJECT GET COORDINATES:C663(*;"barra";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			$l_derecha:=$l_ancho*$r_ratio
			IT_SetNamedObjectRect ("barra";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		End if 
End case 
