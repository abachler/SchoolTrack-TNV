//%attributes = {}
  // 4D_RestoreUserModeWindow()
  // Por: Alberto Bachler K.: 04-03-15, 08:48:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_estado;$l_process;$l_tiempo)
C_TEXT:C284($t_nombreProceso;$t_Titulo)

ARRAY LONGINT:C221($al_winRefs;0)

WINDOW LIST:C442($al_winRefs)
For ($i;1;Size of array:C274($al_winRefs))
	$t_Titulo:=Get window title:C450($al_winRefs{$i})
	$l_process:=Window process:C446($al_winRefs{$i})
	PROCESS PROPERTIES:C336($l_process;$t_nombreProceso;$l_estado;$l_tiempo)
	If ($l_process=1)
		SET WINDOW RECT:C444(100;100;1600;800;$al_winRefs{$i})
	End if 
End for 