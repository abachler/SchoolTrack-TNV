//%attributes = {}
  //ACTexe_CopiaDatosApdos

If (USR_GetMethodAcces (Current method name:C684))
	$r:=CD_Dlog (0;__ ("Este comando sobre escribirá la información de Nombres para Tarjetas de Crédito y Cuentas Corrientes para todos los apoderados de cuenta.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
		FIRST RECORD:C50([Personas:7])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando información de nombres para Tarjetas y Cuentas..."))
		While (Not:C34(End selection:C36([Personas:7])))
			[Personas:7]ACT_Apellido_Materno_TC:72:=[Personas:7]Apellido_materno:4
			[Personas:7]ACT_Apellido_Paterno_TC:71:=[Personas:7]Apellido_paterno:3
			[Personas:7]ACT_Nombres_TC:73:=[Personas:7]Nombres:2
			[Personas:7]ACT_Titular_TC:55:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
			[Personas:7]ACT_RUTTitular_TC:56:=[Personas:7]RUT:6
			[Personas:7]ACT_Apellido_Materno_Cta:75:=[Personas:7]Apellido_materno:4
			[Personas:7]ACT_Apellido_Paterno_Cta:74:=[Personas:7]Apellido_paterno:3
			[Personas:7]ACT_Nombres_Cta:76:=[Personas:7]Nombres:2
			[Personas:7]ACT_Titular_Cta:49:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
			[Personas:7]ACT_RUTTitutal_Cta:50:=[Personas:7]RUT:6
			  //0xDev_AvoidTriggerExecution (True)
			SAVE RECORD:C53([Personas:7])
			  //0xDev_AvoidTriggerExecution (False)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Personas:7])/Records in selection:C76([Personas:7]);__ ("Copiando información de nombres para Tarjetas y Cuentas..."))
			NEXT RECORD:C51([Personas:7])
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		LOG_RegisterEvt ("Sobreescritura de datos de tarjetas y cuentas con datos del apoderado.")
	End if 
	$r:=CD_Dlog (0;__ ("¿Desea eliminar la información de tarjeta de crédito y cuenta corriente para todos los apoderados que no son apoderados de cuenta?\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=False:C215)
		  //0xDev_AvoidTriggerExecution (True)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Apellido_Materno_TC:72:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Apellido_Paterno_TC:71:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Nombres_TC:73:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Titular_TC:55:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_RUTTitular_TC:56:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Tipo_TC:52:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Numero_TC:54:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_MesVenc_TC:57:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_AñoVenc_TC:58:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Banco_TC:53:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_CodMandatoPAT:63:="")
		
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Apellido_Materno_Cta:75:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Apellido_Paterno_Cta:74:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Nombres_Cta:76:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Titular_Cta:49:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_RUTTitutal_Cta:50:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Banco_Cta:47:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Numero_Cta:51:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_CodMandatoPAC:62:="")
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_ID_Banco_Cta:48:="")
		  //0xDev_AvoidTriggerExecution (False)
		LOG_RegisterEvt ("Limpieza de datos de tarjetas y cuentas a apoderados que no son apoderados de cue"+"nta.")
	End if 
	KRL_UnloadReadOnly (->[Personas:7])
End if 