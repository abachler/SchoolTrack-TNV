
C_LONGINT:C283($line)

$line:=AL_GetLine (xALP_FormasdePago)

  //$line:=AL_GetLine (xALP_FormasdePago)
If ($line>0)
	If (alACT_FormasdePagoID{$line}>0)
		If (Num:C11(ACTcfg_OpcionesFormasDePago ("VerificaUtilizacionDePago";->alACT_FormasdePagoID{$line}))=0)
			AL_UpdateArrays (xALP_FormasdePago;0)
			  //AT_Delete ($line;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
			$l_resp:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar la forma de pago ")+ST_Qte (atACT_FormasdePagoNew{$line})+"?";"";__ ("Si");__ ("No"))
			If ($l_resp=1)
				ACTcfg_OpcionesFormasDePago ("EliminaFormaDePagoConf";->alACT_FormasdePagoID{$line})
			End if 
			AL_UpdateArrays (xALP_FormasdePago;-2)
			ACTcfg_OpcionesFormasDePago ("ColorFormasDePagoXDefecto")
			IT_SetButtonState (False:C215;->bDelFP)
		Else 
			CD_Dlog (0;__ (__ ("La forma de pago ")+ST_Qte (atACT_FormasdePagoNew{$line})+__ (" está siendo utilizada actualmente. Antes de intentar eliminarla, utilice la opción Reemplazar Forma de Pago.")+"\r\r"+__ ("La forma de pago no puede ser eliminada.")))
		End if 
		
	Else 
		CD_Dlog (0;__ ("Las formas de pago por defecto, no pueden ser eliminadas."))
	End if 
	
End if 