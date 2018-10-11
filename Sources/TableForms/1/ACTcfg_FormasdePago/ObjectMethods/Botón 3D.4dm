C_TEXT:C284($t_textoPop)
C_LONGINT:C283($l_seleccionUsuario;$line)


  //20130822 RCH Solo las formas de pago que no son por defecto se pueden reemplazar. esto es debido a que algunas fd x defecto necesitan campos especiales.
$line:=AL_GetLine (xALP_FormasdePago)

If ($line>0)
	If (alACT_FormasdePagoID{$line}<0)
		$t_textoPop:=$t_textoPop+"(Reemplazar Forma de Pago"
	Else 
		$t_textoPop:=$t_textoPop+"Reemplazar Forma de Pago"
	End if 
	$l_seleccionUsuario:=Pop up menu:C542($t_textoPop)
	
	Case of 
		: ($l_seleccionUsuario=1)
			ACTcfg_OpcionesFormasDePago ("ReemplazaFormaDePago";->alACT_FormasdePagoID{$line})
			
	End case 
End if 

  //C_TEXT($t_textoPop)
  //C_LONGINT($l_seleccionUsuario;$line)
  //
  //$line:=AL_GetLine (xALP_FormasdePago)
  //$t_textoPop:=$t_textoPop+"Agregar Forma de Pago;(-;"
  //
  //If (alACT_FormasdePagoID{$line}<0)
  //$t_textoPop:=$t_textoPop+"("
  //End if 
  //$t_textoPop:=$t_textoPop+"Eliminar Forma de Pago;(-;"
  //
  //$t_textoPop:=$t_textoPop+"Reemplazar Forma de Pago"
  //
  //$l_seleccionUsuario:=Pop up menu($t_textoPop)
  //
  //Case of 
  //: ($l_seleccionUsuario=1)
  //AL_ExitCell (xALP_FormasdePago)
  //DISABLE BUTTON(bDelFP)
  //AL_UpdateArrays (xALP_FormasdePago;0)
  //  //AT_Insert (0;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
  //ACTcfg_OpcionesFormasDePago ("InsertaNuevaFormaDePagoConf")
  //AL_UpdateArrays (xALP_FormasdePago;-2)
  //ACTcfg_OpcionesFormasDePago ("ColorFormasDePagoXDefecto")
  //GOTO OBJECT(xALP_FormasdePago)
  //AL_GotoCell (xALP_FormasdePago;1;Size of array(atACT_FormasdePago))
  //
  //: ($l_seleccionUsuario=3)
  //  //$line:=AL_GetLine (xALP_FormasdePago)
  //If ($line>0)
  //If (alACT_FormasdePagoID{$line}>0)
  //If (Num(ACTcfg_OpcionesFormasDePago ("VerificaUtilizacionDePago";->alACT_FormasdePagoID{$line}))=0)
  //AL_UpdateArrays (xALP_FormasdePago;0)
  //  //AT_Delete ($line;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
  //$l_resp:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar la forma de pago ")+ST_Qte (atACT_FormasdePagoNew{$line})+"?";"";__ ("Si");__ ("No"))
  //If ($l_resp=1)
  //ACTcfg_OpcionesFormasDePago ("EliminaFormaDePagoConf";->alACT_FormasdePagoID{$line})
  //End if 
  //AL_UpdateArrays (xALP_FormasdePago;-2)
  //ACTcfg_OpcionesFormasDePago ("ColorFormasDePagoXDefecto")
  //IT_SetButtonState (False;->bDelFP)
  //Else 
  //CD_Dlog (0;__ (__ ("La forma de pago ")+ST_Qte (atACT_FormasdePagoNew{$line})+__ (" está siendo utilizada actualmente. Antes de intentar eliminarla, utilice la opción Reemplazar Forma de Pago.")+<>cr+<>cr+__ ("La forma de pago no puede ser eliminada.")))
  //End if 
  //
  //Else 
  //CD_Dlog (0;__ ("Las formas de pago por defecto, no pueden ser eliminadas."))
  //End if 
  //
  //End if 
  //
  //: ($l_seleccionUsuario=5)
  //ACTcfg_OpcionesFormasDePago ("ReemplazaFormaDePago";->alACT_FormasdePagoID{$line})
  //
  //End case 