If (Self:C308->=0)
	Self:C308->:=1
	$resp:=CD_Dlog (0;__ ("Para habilitar este pagaré usted deberá seleccionar Avisos de Cobranza dede la siguiente lista.")+"\r\r"+__ ("La suma de los Avisos de Cobranza seleccionados deberá ser igual al monto del pagaré.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
	If ($resp=1)
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		ARRAY LONGINT:C221(alACT_IDAviso;0)
		ARRAY DATE:C224(adACT_FechaEAviso;0)
		ARRAY DATE:C224(adACT_FechaVAviso;0)
		ARRAY REAL:C219(arACT_Monto;0)
		
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Pagares:184]ID_Apdo:17;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Pagares:184]ID_Cta:18;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;adACT_FechaEAviso;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;adACT_FechaVAviso)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_IDAviso;[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;arACT_Monto)
		
		SORT ARRAY:C229(adACT_FechaEAviso;adACT_FechaVAviso;alACT_IDAviso;arACT_Monto;>)
		
		ARRAY POINTER:C280(<>aChoicePtrs;0)
		ARRAY POINTER:C280(<>aChoicePtrs;4)
		<>aChoicePtrs{1}:=->adACT_FechaEAviso
		<>aChoicePtrs{2}:=->adACT_FechaVAviso
		<>aChoicePtrs{3}:=->alACT_IDAviso
		<>aChoicePtrs{4}:=->arACT_Monto
		TBL_ShowChoiceList (0;__ ("Seleccione avisos");0;->vtACT_Estado;True:C214)
		If (ok=1)
			ARRAY LONGINT:C221($al_AvisosSelected;0)
			For ($i;1;Size of array:C274(aLinesSelected))
				APPEND TO ARRAY:C911($al_AvisosSelected;alACT_IDAviso{aLinesSelected{$i}})
			End for 
			$vr_monto:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->$al_AvisosSelected;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			If ($vr_monto=[ACT_Pagares:184]Monto:8)
				ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC1";->[ACT_Pagares:184]ID:12;->$al_AvisosSelected)
				Self:C308->:=0
				[ACT_Pagares:184]Anulado_Por:16:=""
				[ACT_Pagares:184]Fecha_Anulacion:13:=!00-00-00!
				[ACT_Pagares:184]ID_Estado:6:=-103
				$vt_evento:="Habilitación de Pagaré."
				ACTcfg_OpcionesPagares ("Log";->$vt_evento)
				  //SAVE RECORD([ACT_Pagares])
				ACTpagares_fSave 
				FLUSH CACHE:C297
			Else 
				CD_Dlog (0;__ ("El monto de los avisos seleccionados no coincide con el monto del pagaré. El pagaré no puede ser habilitado."))
			End if 
		End if 
	End if 
Else 
	If (([ACT_Pagares:184]Fecha_Protesto:20=!00-00-00!) & ([ACT_Pagares:184]Fecha_Devolucion:14=!00-00-00!))
		$resp:=CD_Dlog (0;__ ("¿Está seguro de anular el pagaré seleccionado?.")+"\r\r"+__ ("Esta acción no se puede deshacer.");"";__ ("Si");__ ("No"))
		If ($resp=1)
			ACTcfg_OpcionesPagares ("AnulaPagare";->[ACT_Pagares:184]ID:12)
		Else 
			Self:C308->:=0
		End if 
	Else 
		BEEP:C151
		Self:C308->:=0
	End if 
End if 
ACTcfg_OpcionesPagares ("SetObjetosPag2")