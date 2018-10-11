//%attributes = {}
  // MÉTODO: BWR_BringWindowToFront
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 20/02/12, 16:49:47
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // se ejecuta cuando el usuario selecciona una ventana en el menú Ventanas
  // Pasa al primer plano la ventana seleccionada por el usuario en menú ventana
  //
  // PARÁMETROS
  // BWR_BringWindowToFront()
  // ----------------------------------------------------
C_LONGINT:C283($l_windowProcess;$l_windowRef)
C_TEXT:C284($t_menuItemParameter;$t_WindowTitle)


  // CODIGO PRINCIPAL
$t_menuItemParameter:=Get selected menu item parameter:C1005
$l_windowRef:=Num:C11(ST_GetWord ($t_menuItemParameter;1;"."))  // obtengo la referencia de la ventana
$l_windowProcess:=Num:C11(ST_GetWord ($t_menuItemParameter;2;"."))  // obtengo el Id del proceso en el que la ventana está abierta
$t_WindowTitle:=Get window title:C450($l_windowRef)  // obtengo el título de la ventana seleccionada (solo para depuración)

  // paso la ventana y el proceso al primer plano
WDW_SetFrontmost ($l_windowRef)
If ($l_windowProcess#Current process:C322)
	SHOW PROCESS:C325($l_windowProcess)
	BRING TO FRONT:C326($l_windowProcess)
End if 
