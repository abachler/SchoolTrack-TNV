//%attributes = {"executedOnServer":true}
  // CFG_LoadDevelopperConfig()
  // Por: Alberto Bachler: 09/03/13, 18:09:08
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Count parameters:C259=1)
	$t_nombreArchivo:=$1
Else 
	$t_nombreArchivo:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"app.cfg"
End if 

If ($t_nombreArchivo="")
	$h_refArchivo:=Open document:C264("";"TEXT";3)
	$t_nombreArchivo:=document
End if 

If ((Application type:C494=4D Remote mode:K5:5) & ($t_nombreArchivo#""))
	$l_IdProcesoEnServer:=Execute on server:C373("CFG_LoadDevelopperConfig";Pila_256K;"Actualizando configuracion...")
	$l_IdProcesoAvance:=IT_UThermometer (1;0;__ ("Leyendo configuración..."))
	While (Test semaphore:C652("Restoring app config"))
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	IT_UThermometer (-2;$l_IdProcesoAvance)
Else 
	While (Semaphore:C143("Restoring app config"))
		IDLE:C311
		DELAY PROCESS:C323(Current process:C322;15)
	End while 
	SET CHANNEL:C77(10;$t_nombreArchivo)
	If (ok=1)
		$l_IdProcesoAvance:=IT_UThermometer (1;0;__ ("Actualizando configuración por defecto…"))
		READ WRITE:C146([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="XS_CFG_@";*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]User:9=0)
		DELETE SELECTION:C66([xShell_Prefs:46])
		RECEIVE VARIABLE:C81($l_numeroDeRegistros)
		For ($k;1;$l_numeroDeRegistros)
			RECEIVE RECORD:C79([xShell_Prefs:46])
			SAVE RECORD:C53([xShell_Prefs:46])
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([xShell_Prefs:46])
		IT_UThermometer (-2;$l_IdProcesoAvance)
		XSvs_CargaArchivos 
		XS_LoadExecutableObjects 
		MSG_ActualizaDesdeIntranet 
		EXE_LoadCommandLibrary 
		RObj_LoadLibrary 
		TBL_LoadListLibrary 
		CLEAR SEMAPHORE:C144("Restoring app config")
	Else 
		$l_ignorar:=CD_Dlog (1;__ ("El archivo que contiene la configuración no pudo ser cargado."))
	End if 
End if 


If (FORM Get current page:C276>1)
	FORM GOTO PAGE:C247(1)
	XS_Settings ("Initialize")
End if 

PREF_Set (0;"VirtualStructureDefined";"1")