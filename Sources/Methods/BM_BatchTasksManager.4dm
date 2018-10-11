//%attributes = {}
  // BM_BatchTasksManager()
  // Por: Alberto Bachler K.: 13-12-13, 10:58:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_estadoProceso;$l_IdProceso)

$l_IdProceso:=Process number:C372(__ ("Tareas Programadas"))
$l_estadoProceso:=Process state:C330($l_IdProceso)


Case of 
		
	: (($l_IdProceso=0) | ($l_estadoProceso<0))
		  // el proceso no existe o fue abortado
		  // el proceso se inicia a si mismo
		$l_IdProceso:=New process:C317(Current method name:C684;Pila_128K;__ ("Tareas Programadas"))
		
		
	: ($l_estadoProceso>0)
		  // el proceso está en ejecución pero escondido y/o pausado
		RESUME PROCESS:C320($l_IdProceso)
		SHOW PROCESS:C325($l_IdProceso)
		BRING TO FRONT:C326($l_IdProceso)
		
	Else 
		  //el proceso fue iniciado, mostramos la ventana
		  // al iniciar la aplicación la ventana es ocultada inmediatamente
		HIDE PROCESS:C324(Current process:C322)
		WDW_OpenFormWindow (->[xShell_BatchRequests:48];"TareasProgramadas";6;Plain form window:K39:10;__ ("Tareas Programadas"))
		DIALOG:C40([xShell_BatchRequests:48];"TareasProgramadas")
		CLOSE WINDOW:C154
		
End case 


