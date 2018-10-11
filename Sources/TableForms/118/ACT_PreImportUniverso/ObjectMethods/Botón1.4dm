If (Size of array:C274(at_rutPACValidado)>0)
	C_LONGINT:C283($resp;$noExApoCtas)
	$resp:=CD_Dlog (0;__ ("Si continúa, a todos aquellos apoderados que ya no cuentan con PAC, según el archivo universo importado, se les sobreescribirá el modo de pago a ")+ST_Qte (atACT_Modo_de_Pago{1})+__ (".\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
	If ($resp=2)
		READ WRITE:C146([Personas:7])
		  //20121005 RCH Se asignan IDS
		  //QUERY([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{2})
		QUERY:C277([Personas:7];[Personas:7]ACT_Modo_de_pago:39=-10)
		$noExApoCtas:=Records in selection:C76([Personas:7])
		  //0xDev_AvoidTriggerExecution (True)
		$vl_id:=-2
		$vt_forma:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->$vl_id)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Modo_de_pago:39:=$vt_forma)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_id_modo_de_pago:94:=$vl_id)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_modo_de_pago_new:95:=$vt_forma)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignado modo de pago ")+atACT_Modo_de_Pago{2}+__ (" a apoderados"))
		For ($i;1;Size of array:C274(at_rutPACValidado))
			QUERY:C277([Personas:7];[Personas:7]RUT:6=at_rutPACValidado{$i})
			$vl_id:=-2
			$vt_forma:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->$vl_id)
			[Personas:7]ACT_id_modo_de_pago:94:=$vl_id
			APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Modo_de_pago:39:=$vt_forma)
			APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_id_modo_de_pago:94:=$vl_id)
			APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_modo_de_pago_new:95:=$vt_forma)
			SAVE RECORD:C53([Personas:7])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_rutPACValidado);__ ("Asignado modo de pago ")+atACT_Modo_de_Pago{2}+__ (" a apoderados"))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		  //0xDev_AvoidTriggerExecution (False)
		KRL_UnloadReadOnly (->[Personas:7])
		LOG_RegisterEvt ("Carga de archivo Universo. Número de apoderados con modo PAC antes de la import"+"ación: "+String:C10($noExApoCtas)+", número de apoderados con modo PAC después de la importación "+String:C10(numAprobados))
	End if 
Else 
	CD_Dlog (0;__ ("No hay registros aprobados. No es posible continuar con la importación."))
End if 
ACCEPT:C269