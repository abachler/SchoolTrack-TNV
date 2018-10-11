//%attributes = {}
  // WDW_SetWindowIcon()
  // Por: Alberto Bachler Klein: 31-10-15, 11:04:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_error;$l_refVentana;$l_refVentanaWin32)
C_TEXT:C284($t_plataformaServidor;$t_rutaCarpetaIconos;$t_rutaIcono)

If (False:C215)
	C_LONGINT:C283(WDW_SetWindowIcon ;$1)
End if 

C_LONGINT:C283(<>appIconHandle)

If (SYS_IsWindows )
	If (Count parameters:C259=1)
		$l_refVentana:=$1
	End if 
	
	$t_rutaCarpetaIconos:=Get 4D folder:C485(Current resources folder:K5:16)+"Icons"+Folder separator:K24:12
	Case of 
		: (Application type:C494=4D Remote mode:K5:5)
			$t_rutaIcono:=$t_rutaCarpetaIconos+"remote.ico"
		: ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Volume desktop:K5:2))
			$t_rutaIcono:=$t_rutaCarpetaIconos+"local.ico"
		: (Application type:C494=4D Server:K5:6)
			$t_rutaIcono:=$t_rutaCarpetaIconos+"server.ico"
	End case 
	
	
	If ($l_refVentana#0)
		$l_refVentana:=$1
		$l_refVentanaWin32:=gui_GetWindowFrom4DWin ($1)
	Else 
		$l_refVentanaWin32:=gui_GetWindow ("")
	End if 
	If (<>appIconHandle=0)
		$l_error:=gui_LoadIcon ($t_rutaIcono;<>appIconHandle)
	End if 
	$l_error:=gui_SetIcon ($l_refVentanaWin32;<>appIconHandle)
	
End if 

