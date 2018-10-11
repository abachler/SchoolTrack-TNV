//%attributes = {}
  //ACTexe_ModificaNoCuotasCup

If (USR_GetMethodAcces (Current method name:C684))
	$vI_NumCuotasTxt:=CD_Request (__ ("Ingrese número de cuotas:");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("10"))
	$vI_NumCuotas:=Num:C11($vI_NumCuotasTxt)
	If ($vI_NumCuotas>0)
		$therm:=IT_UThermometer (1;0;__ ("Modificando número de cuotas..."))
		READ WRITE:C146([Personas:7])
		  //20121005 RCH
		  //QUERY([Personas];[Personas]ACT_Modo_de_pago="Cuponera")
		QUERY:C277([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=-11)
		  //0xDev_AvoidTriggerExecution (True)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_NoCuotasCup:80:=$vI_NumCuotas)
		  //0xDev_AvoidTriggerExecution (False)
		KRL_UnloadReadOnly (->[Personas:7])
		REDUCE SELECTION:C351([Personas:7];0)
		IT_UThermometer (-2;$therm)
	End if 
End if 