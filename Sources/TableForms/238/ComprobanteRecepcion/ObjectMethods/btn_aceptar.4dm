C_LONGINT:C283($l_resp)

$l_resp:=CD_Dlog (0;__ ("¿Está seguro de querer generar un comprobante de recepción?");"";__ ("Si");__ ("No"))
If ($l_resp=1)
	
	C_LONGINT:C283($l_proc)
	C_TEXT:C284($t_rutEmisor;$t_rutReceptor)
	C_LONGINT:C283($l_resp)
	C_TEXT:C284($t_tipoAprobacion)
	C_BOOLEAN:C305($b_continuar)
	
	$t_recinto:=""
	
	$t_rutEmisor:=vtACTcr_emisor+vtACTcr_emisorDV
	$t_rutEmisor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutEmisor)
	$t_rutReceptor:=vtACTcr_receptor+vtACTcr_receptorDV
	$t_rutReceptor:=ACTcfg_opcionesDTE ("GetFormatoRUT";->$t_rutReceptor)
	
	$b_continuar:=False:C215
	Case of 
		: (CTRY_CL_VerifRUT (Replace string:C233($t_rutEmisor;"-";"");False:C215)="")
			CD_Dlog (0;"Ingrese rut del emisor.")
			
		: (CTRY_CL_VerifRUT (Replace string:C233($t_rutReceptor;"-";"");False:C215)="")
			CD_Dlog (0;"Ingrese rut del receptor.")
			
		: (vtACTcr_tipoDTE="")
			CD_Dlog (0;"Ingrese tipo de documento.")
			
		: (vtACTcr_folioDoc="")
			CD_Dlog (0;"Ingrese folio de documento.")
			
		: (vtACTcr_montoDoc="")
			CD_Dlog (0;"Ingrese monto de documento.")
			
		: (vtACTcr_recinto="")
			CD_Dlog (0;"Ingrese recinto del documento.")
			
		: (vdACTcr_fechaEmision=!00-00-00!)
			CD_Dlog (0;"Ingrese fecha del documento.")
			
		Else 
			$b_continuar:=True:C214
	End case 
	
	If ($b_continuar)
		
		$l_proc:=IT_UThermometer (1;0;__ ("Enviando comprobante de recepcion de documento..."))
		
		$t_tipoAprobacion:="mercaderiasDTENoRecibido"
		vtACTcr_nombreAprob:=USR_GetUserName (USR_GetUserID )
		
		C_LONGINT:C283($l_folio)
		C_REAL:C285($r_monto;$r_tiopoDTE)
		
		$l_folio:=Num:C11(vtACTcr_folioDoc)
		$r_monto:=Num:C11(vtACTcr_montoDoc)
		$r_tiopoDTE:=Num:C11(vtACTcr_tipoDTE)
		
		vlWS_estado:=WSactdte_EnvioMercaderias ($t_rutEmisor;$t_rutReceptor;$r_tiopoDTE;$l_folio;$t_tipoAprobacion;vtACTcr_nombreAprob;vtACTcr_recinto;$r_monto;vtACTcr_fechaEmision)
		
		IT_UThermometer (-2;$l_proc)
		
		If (vlWS_estado=1)
			ACCEPT:C269
		End if 
		
	End if 
End if 