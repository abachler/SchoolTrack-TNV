  // CIM_Principal.Botón6()
  // Por: Alberto Bachler K.: 26-10-14, 17:57:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_clientesDesconectados;$b_noReiniciar)
C_LONGINT:C283($l_accion;$l_proceso;$l_progressId)
C_PICTURE:C286($p_icono)
C_REAL:C285($r_avanceCompactacion)
C_TEXT:C284($t_adicional;$t_etapaCompactacion;$t_mensaje;$t_RutaCompactacion)

ARRAY LONGINT:C221($al_metodosEnCola;0)
ARRAY TEXT:C222($at_Usuarios;0)
C_REAL:C285(<>r_AvanceCompactacion)
C_TEXT:C284(<>t_EtapaCompactacion)


OBJECT SET TITLE:C194(*;"resultadoVerificacion";"")
If (Application type:C494=4D Remote mode:K5:5)
	GET REGISTERED CLIENTS:C650($at_Usuarios;$al_metodosEnCola)
	Case of 
		: (Size of array:C274($at_Usuarios)=1)
			$t_mensaje:=__ ("Una vez finalizada la compactación en el servidor esta aplicación se cerrará y el servidor SchoolTrack será reiniciado.\r^1\r\r")
			$t_mensaje:=$t_mensaje+__ ("¿Desea compactar la base de datos ahora?")
		: (Size of array:C274($at_Usuarios)=2)
			$t_mensaje:=__ ("Hay otro usuario conectado en este momento.\r\r")
			$t_mensaje:=$t_mensaje+__ ("Los usuarios activos de SchoolTrack contarán con 5 minutos para salir de la aplicación antes de ser desconectados para que la compactación pueda ser iniciada en el servidor.\r\r")
			$t_mensaje:=$t_mensaje+__ ("Una vez finalizada la compactación en el servidor esta aplicación se cerrará y el servidor SchoolTrack será reiniciado.^1\r\r")
			$t_mensaje:=$t_mensaje+__ ("¿Desea compactar la base de datos ahora?")
		: (Size of array:C274($at_Usuarios)>2)
			$t_mensaje:=__ ("Hay ^0 otros usuarios conectados en este momento.\r\r")
			$t_mensaje:=$t_mensaje+__ ("Los usuarios activos de SchoolTrack contarán con 5 minutos para salir de la aplicación antes de ser desconectados para que la compactación pueda ser iniciada en el servidor.\r\r")
			$t_mensaje:=$t_mensaje+__ ("Una vez finalizada la compactación en el servidor esta aplicación se cerrará y el servidor SchoolTrack será reiniciado.^1\r\r")
			$t_mensaje:=$t_mensaje+__ ("¿Desea compactar la base de datos ahora?")
	End case 
	$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(Size of array:C274($at_Usuarios)-1))
	If (<>tUSR_CurrentUserEmail#"")
		$t_adicional:=__ ("\rSe enviará un correo a ^0 cuando la compactación haya terminado y la base de datos este nuevamente disponible.")
		$t_adicional:=Replace string:C233($t_adicional;"^0";IT_SetTextStyle_Bold (-><>tUSR_CurrentUserEmail;True:C214))
	End if 
	$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_adicional)
	$l_accion:=ModernUI_Notificacion (__ ("Compactación de la base de datos");$t_mensaje;__ ("Compactar base de datos");__ ("Cancelar"))
Else 
	$l_accion:=ModernUI_Notificacion (__ ("Compactación de la base de datos");__ ("Por favor espere que la compactación finalice antes iniciar ninguna otra operación.\r\r¿Desea compactar la base de datos ahora?");__ ("Continuar");__ ("Cancelar"))
End if 


If ($l_accion=1)
	$b_clientesDesconectados:=True:C214
	If (Application type:C494=4D Remote mode:K5:5)
		$b_clientesDesconectados:=SYS_DisconnectClients (5;True:C214)
	End if 
	
	If ($b_clientesDesconectados)
		$b_noReiniciar:=True:C214
		If (Application type:C494=4D Remote mode:K5:5)
			$l_progressId:=Progress New 
			Progress SET TITLE ($l_progressId;"Compactando base de datos...";-1;"";True:C214)
			GET PICTURE FROM LIBRARY:C565(31993;$p_icono)
			Progress SET ICON ($l_progressId;$p_icono)
			Progress SET PROGRESS ($l_progressId;0)
			$b_noReiniciar:=True:C214
			$l_proceso:=Execute on server:C373("CIM_CompactDataFile";Pila_1024K;"Compactación de base de datos";<>tUSR_CurrentUserEmail;$b_noReiniciar)
			DELAY PROCESS:C323(Current process:C322;60)
			Repeat 
				GET PROCESS VARIABLE:C371($l_proceso;<>r_AvanceCompactacion;$r_avanceCompactacion)
				GET PROCESS VARIABLE:C371($l_proceso;<>t_EtapaCompactacion;$t_etapaCompactacion)
				Progress SET PROGRESS ($l_progressId;$r_avanceCompactacion;$t_etapaCompactacion+"\r"+__ ("El servidor se reiniciará cuando la reconstrucción concluya.");True:C214)
				DELAY PROCESS:C323(Current process:C322;10)
			Until (($r_avanceCompactacion=-1) & (Semaphore:C143("CompactandoBD")))
			Progress QUIT ($l_progressId)
			
			USR_RegisterUserEvent (UE_SIM_CompactDB;0)
			
			$l_proceso:=Execute on server:C373("CIM_ReiniciaAplicacion";Pila_1024K;"Quit")
			If (Application type:C494=4D Remote mode:K5:5)
				<>b_NoEjecutarOnExit:=True:C214
				QUIT 4D:C291
			End if 
			
		Else 
			$t_RutaCompactacion:=CIM_CompactDataFile (<>tUSR_CurrentUserEmail)
			If ($t_RutaCompactacion="")
				$l_accion:=ModernUI_Notificacion (__ ("Compactación de la base de datos");__ ("No fue posible compactar la base de datos a causa de un error.");__ ("OK"))
			End if 
		End if 
		
	Else 
		$l_accion:=ModernUI_Notificacion (__ ("Compactación de la base de datos");__ ("Uno o mas usuarios no pudieron ser desconectados.\r\rLa compactación de la base de datos no puede ejecutarse en este momento.");__ ("OK"))
	End if 
End if 

