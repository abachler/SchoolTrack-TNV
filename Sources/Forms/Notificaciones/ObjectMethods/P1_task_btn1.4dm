C_LONGINT:C283($l_ExecutionResult;$l_moduleProcess;$l_userChoice)
C_TEXT:C284($t_popupItems)


$t_popupItems:=""
$b_mostrarEnExplorador:=((([NTC_Notificaciones:190]Explorador_modulo:13#"") & ([NTC_Notificaciones:190]Explorador_pestaña:14#0)) & ((BLOB size:C605([NTC_Notificaciones:190]Explorador_registros:15)#0) | ([NTC_Notificaciones:190]Explorador_ejecutarAntes:20#"")))
If ($b_mostrarEnExplorador)
	$t_popupItems:=$t_popupItems+__ ("Mostrar en el explorador;")
Else 
	$t_popupItems:=$t_popupItems+__ ("(Mostrar en el explorador;")
End if 

$b_ejecutarMetodo:=([NTC_Notificaciones:190]Ejecucion_nombreMetodo:17#"")
If ($b_ejecutarMetodo)
	If ([NTC_Notificaciones:190]Ejecucion_TextoItem:26="")
		$t_popupItems:=$t_popupItems+__ ("Repetir análisis;")
	Else 
		$t_popupItems:=$t_popupItems+[NTC_Notificaciones:190]Ejecucion_TextoItem:26+";"
	End if 
End if 

If ($t_popupItems[[Length:C16($t_popupItems)]]=";")
	$t_popupItems:=Substring:C12($t_popupItems;1;Length:C16($t_popupItems))
End if 

$l_userChoice:=Pop up menu:C542($t_popupItems)


$l_uuid:=vt_UUIDmensaje
Case of 
	: ($l_userChoice=1)
		$l_moduleProcess:=Process number:C372("Explorador "+[NTC_Notificaciones:190]Explorador_modulo:13)
		PROCESS PROPERTIES:C336($l_moduleProcess;$procName;$procState;$time)
		If ($l_moduleProcess>0)
			IP_SendMessage ($l_moduleProcess;"NTC_MuestraDatosEnExplorador";vt_UUIDmensaje)
			BRING TO FRONT:C326($l_moduleProcess)
		End if 
		
	: ($l_userChoice=2)
		$l_executionProcessID:=New process:C317("NTC_EjecutaCodigo";128000;"NTC_EjecucionCodigo";$l_uuid;Current process:C322)
		
End case 