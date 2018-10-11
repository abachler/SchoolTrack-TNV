//%attributes = {}
  //TGR_ACT_DctosIndividuales


  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		C_TEXT:C284($t_llave)
		  //$t_llave:=ST_Concatenate (".";->[ACT_DctosIndividuales_Cuentas]Inactivo;->[ACT_DctosIndividuales_Cuentas]Periodo;->[ACT_DctosIndividuales_Cuentas]Porcentaje;->[ACT_DctosIndividuales_Cuentas]ID_CuentaCorriente)
		$t_llave:=ST_Concatenate (".";->[ACT_DctosIndividuales_Cuentas:228]Inactivo:10;->[ACT_DctosIndividuales_Cuentas:228]Periodo:9;->[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5;->[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6)  //20160805 RCH
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[ACT_DctosIndividuales_Cuentas:228]DTS_Creacion:3:=DTS_MakeFromDateTime 
				[ACT_DctosIndividuales_Cuentas:228]DTS_Modificacion:4:=DTS_MakeFromDateTime 
				[ACT_DctosIndividuales_Cuentas:228]Llave:11:=$t_llave
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[ACT_DctosIndividuales_Cuentas:228]DTS_Modificacion:4:=DTS_MakeFromDateTime 
				[ACT_DctosIndividuales_Cuentas:228]Llave:11:=$t_llave
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
End if 