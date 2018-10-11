If (Self:C308->>Current date:C33(*))
	CD_Dlog (0;__ ("No puede ingresar una fecha superior a la fecha de hoy."))
	Self:C308->:=vdACT_FechaPagoIni
Else 
	$mesAbierto:=ACTcm_IsMonthOpenFromDate (Self:C308->)
	If (Not:C34($mesAbierto))
		CD_Dlog (0;__ ("Los pagos no podrán ser registrados con esta fecha ya que corresponde a un mes cerrado."))
	Else 
		If (Self:C308->#vdACT_FechaPagoIni)
			  //CANCEL TRANSACTION
			AL_UpdateArrays (xALP_Documentar;0)
			AL_UpdateArrays (xALP_DocumentarLC;0)
			ACTpgs_LimpiaVarsInterfaz ("RecargaDatos3")
			
			  //20120831 RCH No se cargaba correctamente el monto deuda cuando se cambiaba la fecha...
			ACTcfg_OpcionesRecargosCaja ("ValidacionesFormDocumentar")
			
			AL_UpdateArrays (xALP_Documentar;-2)
			AL_UpdateArrays (xALP_DocumentarLC;-2)
		End if 
		vdACT_FechaPagoIni:=Self:C308->
	End if 
End if 