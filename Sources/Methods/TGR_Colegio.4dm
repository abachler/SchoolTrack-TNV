//%attributes = {}
  // Método: TGR_Colegio
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:18:11
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		If ([Colegio:31]ID_Colegio:57=0)
			[Colegio:31]ID_Colegio:57:=SQ_SeqNumber (->[Colegio:31]ID_Colegio:57)
		End if 
		
		XS_VinculoTablas_AppInstitucion 
		
		If (([Colegio:31]Moneda:49="") & ([Colegio:31]Pais:21#""))
			[Colegio:31]Moneda:49:=ACT_DivisaPais 
		End if 
		
		  //20160505 RCH. Hay reportes de cambio de la moneda por defecto. Se registra en el log para seguimiento.
		If (KRL_FieldChanges (->[Colegio:31]Moneda:49))
			LOG_RegisterEvt ("Cambio en moneda por defecto. Cambió de "+Old:C35([Colegio:31]Moneda:49)+" a "+[Colegio:31]Moneda:49+".")
		End if 
		
	End if 
End if 



