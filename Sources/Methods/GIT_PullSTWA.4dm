//%attributes = {}
  //GIT_PullSTWA

C_TEXT:C284($t_command;$in;$out;$t_error)
C_POINTER:C301($1)
C_BOOLEAN:C305($0)

If (SYS_IsWindows )
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	  //$t_command:="C:\\Program Files\\Git\\bin\\git.exe -C "+ST_Qte (<>syT_StructurePath+"Carpeta Web\\stwa")+" pull"
	
	$t_command:="C:\\Program Files\\Git\\bin\\git.exe -C "+ST_Qte (Get 4D folder:C485(HTML Root folder:K5:20)+"\\stwa")+" pull"
	LAUNCH EXTERNAL PROCESS:C811($t_command;$in;$out;$t_error)  //La variable $t_error no siempre devuelve algo cuando hay error.
	
	$1->:=$t_error+$out
	If ((Position:C15("fatal:";$t_error)>0) | (Position:C15("error:";$t_error)>0))
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=False:C215
End if 
