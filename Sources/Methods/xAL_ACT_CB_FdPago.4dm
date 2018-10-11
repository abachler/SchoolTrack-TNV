//%attributes = {}
  //xAL_ACT_CB_FdPago

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3;$table)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_FormasdePago;$col;$row)
	If (AL_GetCellMod (xALP_FormasdePago)=1)
		$vb_continuar:=True:C214
		Case of 
			: ($col=1)
				  //$dupli:=Find in array(atACT_FormasdePagoNew;atACT_FormasdePagoNew{$row})
				$dupli:=Count in array:C907(atACT_FormasdePagoNew;atACT_FormasdePagoNew{$row})
				If ($dupli>1)
					$vb_continuar:=False:C215
					CD_Dlog (0;__ ("Esta forma de pago ya existe."))
					atACT_FormasdePagoNew{$row}:=atACT_FormasdePagoNew{0}
				End if 
				If ($vb_continuar)
					KRL_FindAndLoadRecordByIndex (->[ACT_Formas_de_Pago:287]id:1;->alACT_FormasdePagoID{$row};True:C214)
					If (ok=1)
						[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9:=atACT_FormasdePagoNew{$row}
						[ACT_Formas_de_Pago:287]forma_de_pago_old:2:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
					End if 
					ACTpgs_SaveFormasDePago 
				End if 
				
			: ($col=2)
				  //$dupli:=Find in array(atACT_FdPCodes;atACT_FdPCodes{$row})
				$dupli:=Count in array:C907(atACT_FdPCodes;atACT_FdPCodes{$row})
				  //If (($dupli#$row) & ($dupli#-1))
				If ($dupli>1)
					$vb_continuar:=False:C215
					CD_Dlog (0;__ ("Ese código ya existe. Por favor use otro."))
					atACT_FdPCodes{$row}:=atACT_FdPCodes{0}
				End if 
				
				If ($vb_continuar)
					KRL_FindAndLoadRecordByIndex (->[ACT_Formas_de_Pago:287]id:1;->alACT_FormasdePagoID{$row};True:C214)
					If (ok=1)
						[ACT_Formas_de_Pago:287]codigo_ingreso:3:=atACT_FdPCodes{$row}
					End if 
					ACTpgs_SaveFormasDePago 
				End if 
				
			: ($col=3)
				KRL_FindAndLoadRecordByIndex (->[ACT_Formas_de_Pago:287]id:1;->alACT_FormasdePagoID{$row};True:C214)
				If (ok=1)
					[ACT_Formas_de_Pago:287]codigo_interno:8:=atACT_FdPCodInterno{$row}
				End if 
				ACTpgs_SaveFormasDePago 
				
		End case 
	End if 
End if 