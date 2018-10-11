$mesAbierto:=ACTcm_IsMonthOpenFromDate (vdACT_FechaPago)
If (Not:C34($mesAbierto))
	CD_Dlog (0;__ ("El pago no puede ser registrado con esta fecha ya que corresponde a un mes cerrado."))
Else 
	
	$vb_go:=ACTpgs_OpcionesVR ("ValidaSoloEmitir")
	If ($vb_go)
		$resp:=CD_Dlog (0;__ ("Se generarán cargos no pagados para ")+vsACT_NomApellido+__ (".\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		If ($resp=1)
			ACTpgs_OpcionesVR ("GeneraAvisos")
			ACTpgs_OpcionesVR ("LimpiaCampos")
			If (Process number:C372("Explorador AccountTrack")>0)
				<>vb_Refresh:=True:C214
			End if 
		End if 
	End if 
End if 