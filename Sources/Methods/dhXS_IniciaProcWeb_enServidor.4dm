//%attributes = {}
  // dhXS_IniciaProcWeb_enServidor()
  // Por: Alberto Bachler K.: 19-02-14, 11:53:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_estadoProceso;$l_idProceso;$l_numeroProceso)

C_LONGINT:C283(<>lSNT_CtrlProcessID)

  // interacción con SchoolNet
SN3_LoadGeneralSettings 
If ((LICENCIA_esModuloAutorizado (1;SchoolNet)) | (LICENCIA_esModuloAutorizado (1;SchoolCenter)))
	If (<>inSN3)
		If ((SN3_SendFrom_Server=1) & ((SN3_EnvioActivado=1) | (LICENCIA_esModuloAutorizado (1;SchoolCenter))))
			$l_estadoProceso:=Process state:C330(<>lSNT_CtrlProcessID)
			If ($l_estadoProceso<0)
				<>lSNT_CtrlProcessID:=New process:C317("SN3_CommController";Pila_256K;"Conexión SchoolNet";*)
			End if 
		End if 
	End if 
End if 

If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
	$l_numeroProceso:=Process number:C372("STWA 2 Session Manager")
	If (Process state:C330($l_numeroProceso)<0)
		$l_idProceso:=New process:C317("STWA2_Session_Init";128000;"STWA 2 Session Manager";*)
	End if 
End if 

If (LICENCIA_esModuloAutorizado (1;SchoolNet))
	$l_numeroProceso:=Process number:C372("Demonio de Actualización de Datos desde SN3")
	If (Process state:C330($l_numeroProceso)<0)
		$l_idProceso:=New process:C317("SN3_ActuaDatos_AutomaticTask";Pila_256K;"Demonio de Actualización de Datos desde SN3";*)
	End if 
End if 


If (LICENCIA_esModuloAutorizado (1;CommTrack))
	$l_numeroProceso:=Process number:C372("Envío de datos Commtrack")
	If (Process state:C330($l_numeroProceso)<0)
		$l_idProceso:=New process:C317("CMT_CommController";Pila_256K;"Envío de datos Commtrack";*)
	End if 
End if 

