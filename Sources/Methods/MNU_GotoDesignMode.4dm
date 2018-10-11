//%attributes = {}
  // MÉTODO: MNU_GotoDesignMode
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 16:24:34
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MNU_GotoDesignMode()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_4DExplorerIsOpen)
C_LONGINT:C283($l_userModeWindowRef;$i)
C_TEXT:C284($t_explorerWindowTitle;$t_userModeWindowTitle;$t_windowTitle)
ARRAY LONGINT:C221($al_WinRefs;0)

  // CODIGO PRINCIPAL
WINDOW LIST:C442($al_WinRefs)
$b_4DExplorerIsOpen:=False:C215
$t_explorerWindowTitle:=SYS_Path2FileName (Structure file:C489)+__ (" - Explorador")
$t_userModeWindowTitle:=SYS_Path2FileName (Structure file:C489)+" - "
$l_userModeWindowRef:=0

For ($i;1;Size of array:C274($al_WinRefs))
	$t_windowTitle:=Get window title:C450($al_WinRefs{$i})
	If ($t_explorerWindowTitle=$t_windowTitle)
		WDW_SetFrontmost ($al_WinRefs{$i})
		$i:=Size of array:C274($al_WinRefs)
		$b_4DExplorerIsOpen:=True:C214
	Else 
		If (Position:C15($t_userModeWindowTitle;$t_windowTitle)=1)
			$l_userModeWindowRef:=$al_WinRefs{$i}
		End if 
	End if 
End for 

If (Not:C34($b_4DExplorerIsOpen))
	If ($l_userModeWindowRef#0)
		WDW_SetFrontmost ($l_userModeWindowRef)
	Else 
		If (SYS_IsMacintosh )
			POST KEY:C465(Character code:C91("E");Command key mask:K16:1+Shift key mask:K16:3+Option key mask:K16:7)
		Else 
			POST KEY:C465(Character code:C91("E");Control key mask:K16:9+Shift key mask:K16:3+Option key mask:K16:7)
		End if 
		
	End if 
End if 

