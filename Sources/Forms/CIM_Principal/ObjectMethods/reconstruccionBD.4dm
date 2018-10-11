  // CIM_Principal.reconstruccionBD()
  // Por: Alberto Bachler K.: 18-04-15, 14:33:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_clientesDesconectados)
C_LONGINT:C283($l_proceso;$l_progressId;$l_respuesta)
C_REAL:C285($r_avanceProceso)


  //If (Not(KRL_HayRegistrosBloqueados ))
$l_respuesta:=ModernUI_Notificacion (__ ("Reconstrucción de base de datos");__ ("¿Desea respaldar la base de datos antes de la reconstrucción?");__ ("Respaldar");__ ("No");__ ("Cancelar"))
If ($l_respuesta=3)
	
Else 
	
	If ($l_respuesta=1)
		BACKUP:C887
	End if 
	
	OBJECT SET TITLE:C194(*;"resultadoVerificacion";"")
	
	$b_clientesDesconectados:=True:C214
	If (Application type:C494=4D Server:K5:6)
		$b_clientesDesconectados:=SYS_DisconnectClients (5;True:C214)
	End if 
	If ($b_clientesDesconectados)
		
		  // termino los procesos en tarea de fondo
		dhXS_StopApplicationProcess 
		  // cierro todos los exploradores abiertos
		BWR_CierraExploradores 
		
		If (Not:C34(KRL_HayRegistrosBloqueados ))
			$l_progressId:=Progress New 
			Progress SET TITLE ($l_progressId;__ ("Reconstruyendo base de datos...");0;"";True:C214)
			Progress SET MESSAGE ($l_progressId;__ ("El servidor se reiniciará cuando la reconstrucción concluya."))
			$l_proceso:=Execute on server:C373("CIM_ReconstruyeBD";Pila_512K;"Reconstruccion Base de datos";"";<>tUSR_CurrentUserEmail)
			DELAY PROCESS:C323(Current process:C322;60)
			$r_avanceProceso:=0
			While (Test semaphore:C652("ReconstruyendoBD")=True:C214)
				$r_avanceProceso:=$r_avanceProceso+0.01
				If ($r_avanceProceso=1)
					$r_avanceProceso:=0.1
				End if 
				Progress SET PROGRESS ($l_progressId;$r_avanceProceso;__ ("El servidor se reiniciará cuando la reconstrucción concluya.");True:C214)
				DELAY PROCESS:C323(Current process:C322;10)
			End while 
			Progress QUIT ($l_progressId)
			USR_RegisterUserEvent (UE_SIM_ExportDB;0)
			$l_proceso:=Execute on server:C373("CIM_ReiniciaAplicacion";Pila_256K;"Quit")
			If (Application type:C494=4D Remote mode:K5:5)
				<>b_NoEjecutarOnExit:=True:C214
				QUIT 4D:C291
			End if 
		Else 
			$l_respuesta:=ModernUI_Notificacion (__ ("Reconstrucción de base de datos");__ ("Hay registros en uso en otros procesos.\r\rNo es posible reconstruir la base de datos en este momento."))
		End if 
	Else 
		$l_respuesta:=ModernUI_Notificacion (__ ("Reconstrucción de base de datos");__ ("No fue posible desconectar a todos los demás usuarios conectados en este momento.")+"\r\r"+__ ("No es posible reconstruir la base de datos en este momento."))
	End if 
End if 


