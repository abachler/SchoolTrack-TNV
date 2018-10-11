//%attributes = {}
  //MNU_Soporte

If (USR_IsGroupMember_by_GrpID (-15001))
	$l_processNumber:=Process number:C372("Centro de Información y Mantenimiento")
	$l_processState:=Process state:C330($l_processNumber)
	Case of 
		: ($l_processState<0)
			KRL_UnloadAll 
			$l_IdProcesoServidor:=Execute on server:C373("KRL_UnloadAll";Pila_256K;"LiberandoRegistros")
			$l_IdProcesoSoporte:=New process:C317("MNU_CIM";Pila_512K;"Centro de Información y Mantenimiento")
			
		: ($l_processState#0)
			SHOW PROCESS:C325($l_processNumber)
			BRING TO FRONT:C326($l_processNumber)
	End case 
Else 
	CD_Dlog (0;__ ("Sólo los miembros del grupo Administración pueden utilizar estas funciones."))
End if 
