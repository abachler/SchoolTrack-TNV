//%attributes = {"executedOnServer":true}
  // CFG_SaveDevelopperConfig()
  // Por: Alberto Bachler: 09/03/13, 18:12:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_abortar)
C_LONGINT:C283($l_ignorar;$l_numeroDeRegistros;$l_opcion;$l_IdProcesoEnServidor)
C_TEXT:C284($t_nombreArchivo)

If (False:C215)
	C_TEXT:C284(CFG_SaveDevelopperConfig ;$1)
End if 

If (Count parameters:C259=1)
	$t_nombreArchivo:=$1
Else 
	$t_nombreArchivo:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"app.cfg"
End if 

If (Application type:C494#4D Server:K5:6)
	$l_opcion:=CD_Dlog (0;__ ("¿Deseas guardar los cambios efectuados en la configuración estandar?");__ ("");__ ("No");__ ("Si"))
Else 
	$l_opcion:=2
End if 

If ($l_opcion=2)
	If ((Application type:C494=4D Remote mode:K5:5) & ($t_nombreArchivo#""))
		USR_BuildAccesTables 
		$l_IdProcesoEnServidor:=Execute on server:C373("CFG_SaveDevelopperConfig";Pila_256K;"Guardando configuracion por defecto")
	Else 
		START TRANSACTION:C239
		XS_SaveExecutableObjects 
		USR_BuildAccesTables 
		XSvs_ActualizaEstructuraVirtual 
		MSG_GeneraArchivo 
		EXE_SaveCommandLibrary 
		TBL_SaveLibrary 
		SET CHANNEL:C77(10;$t_nombreArchivo)
		If (ok=1)
			$b_abortar:=False:C215
			QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="XS_CFG_@";*)
			QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]User:9=0)
			$l_numeroDeRegistros:=Records in selection:C76([xShell_Prefs:46])
			SEND VARIABLE:C80($l_numeroDeRegistros)
			FIRST RECORD:C50([xShell_Prefs:46])
			While (Not:C34(End selection:C36([xShell_Prefs:46])))
				SEND RECORD:C78([xShell_Prefs:46])
				NEXT RECORD:C51([xShell_Prefs:46])
			End while 
			SET CHANNEL:C77(11)
			$l_opcion:=CD_Dlog (0;__ ("La configuración estandar fue reemplazada.\r\rSi quieres volver a su estado anterior haz click en el botón Revertir, Confirmar para conservar los cambios");__ ("");__ ("Confirmar");__ ("Revertir"))
		Else 
			$b_abortar:=True:C214
			$l_ignorar:=CD_Dlog (0;__ ("No fue posible crear el archivo de configuración. \r\rLa configuración estándar actual fue conservada."))
		End if 
		If (($l_opcion=2) | ($b_abortar=True:C214))
			CANCEL TRANSACTION:C241
			$l_ignorar:=CD_Dlog (0;__ ("La configuración estándar actual fue conservada."))
		Else 
			VALIDATE TRANSACTION:C240
		End if 
		$l_ignorar:=CD_Dlog (0;__ ("La configuración estándar fue exitosamente guardada."))
	End if 
Else 
	$l_ignorar:=CD_Dlog (0;__ ("La configuración estándar actual fue conservada."))
End if 