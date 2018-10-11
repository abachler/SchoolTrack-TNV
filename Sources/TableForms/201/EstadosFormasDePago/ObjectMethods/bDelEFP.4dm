$line:=AL_GetLine (xALP_EstadosFDP)
If ($line>0)
	  //If (Num(ACTcfg_OpcionesEstadosPagos ("VerificaUtilizacionEstado";->alACT_estadosID{$line}))=0)
	$vl_num:=Num:C11(ACTcfg_OpcionesPagares ("VerificaUtilizacionEstado";->alACT_estadosID{$line}))
	If ($vl_num=0)
		If (alACT_estadosID{$line}>0)
			
			$vb_continuar:=True:C214
			If (vbACT_mostrarEstadoXDef)
				$vl_idXDef:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneIDEstadoPagoXDef";->vlACT_idFormaDePago))
				If ($vl_idXDef=alACT_estadosID{$line})
					$vb_continuar:=False:C215
				End if 
			End if 
			If ($vb_continuar)
				AL_UpdateArrays (xALP_EstadosFDP;0)
				ACTcfg_OpcionesEstadosPagos ("EliminaFormaDePagoConf";->alACT_estadosID{$line})
				AL_UpdateArrays (xALP_EstadosFDP;-2)
				ACTcfg_OpcionesEstadosPagos ("ColorFormasDePagoXDefecto")
				IT_SetButtonState (False:C215;->bDelEFP)
				
				ACTcfg_OpcionesEstadosPagos ("EstadoXDefecto")
			Else 
				CD_Dlog (0;__ ("Los estados por defecto no pueden ser eliminados."))
			End if 
		Else 
			CD_Dlog (0;__ ("Los estados por defecto no pueden ser eliminados."))
		End if 
	Else 
		CD_Dlog (0;__ ("El estado seleccionado es utilizado actualmente. El estado no puede ser eliminado."))
	End if 
End if 