$line:=AL_GetLine (xALP_FormasdePago)
If ($line>0)
	If (alACT_FormasdePagoID{$line}>0)
		If (Num:C11(ACTcfg_OpcionesFormasDePago ("VerificaUtilizacionDePago";->alACT_FormasdePagoID{$line}))=0)
			AL_UpdateArrays (xALP_FormasdePago;0)
			  //AT_Delete ($line;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
			ACTcfg_OpcionesFormasDePago ("EliminaFormaDePagoConf";->alACT_FormasdePagoID{$line})
			AL_UpdateArrays (xALP_FormasdePago;-2)
			ACTcfg_OpcionesFormasDePago ("ColorFormasDePagoXDefecto")
			IT_SetButtonState (False:C215;->bDelFP)
		Else 
			CD_Dlog (0;__ ("La forma de pago es utilizada actualmente. La forma de pago no puede ser eliminada."))
			
			ACTcfg_OpcionesFormasDePago ("ReemplazaFormaDePago";->alACT_FormasdePagoID{$line})
			
		End if 
		
	Else 
		CD_Dlog (0;__ ("Las formas de pago por defecto, no pueden ser eliminadas."))
	End if 
	
End if 