C_LONGINT:C283($l_refItem)
$line:=AL_GetLine (ALP_CargosXPagar)
If ($line#0)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el cargo seleccionado?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		$l_refItem:=alACT_CRefs{$line}
		alACT_RecNumsCargosTemp{0}:=alACT_RecNumsCargos{$line}
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->alACT_RecNumsCargosTemp;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)=1)
			$refId:=$DA_Return{1}
		Else 
			BEEP:C151
			$refId:=$DA_Return{Size of array:C274($DA_Return)}
		End if 
		$ok:=0
		If (alACT_RecNumsCargos{$line}>0)
			ARRAY REAL:C219($arACT_MontoPagado;0)  // este arreglo se inicializa y pierde los elementos. Se utiliza este arreglo para recuperar los elementos
			COPY ARRAY:C226(arACT_MontoPagado;$arACT_MontoPagado)
			
			ACTpgs_OpcionesCargosEliminados ("SetBooleanVar")  //20120710 RCH 
			
			  //20140512 RCH Se perdía la cuenta corriente con la que se estaba ingresando. Esto afectaba la carga de info para pagar.
			$l_recNunCtaCte:=Record number:C243([ACT_CuentasCorrientes:175])
			$ok:=ACTcar_Delete (alACT_RecNumsCargos{$line})
			KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$l_recNunCtaCte)
			
			COPY ARRAY:C226($arACT_MontoPagado;arACT_MontoPagado)
		End if 
		If ($ok=0)
			AL_UpdateArrays (ALP_CargosXPagar;0)
			For ($j;1;Size of array:C274(ap_arrays2Pay))
				AT_Delete ($line;1;ap_arrays2Pay{$j})
			End for 
			AL_UpdateArrays (ALP_CargosXPagar;-2)
			modCargos:=True:C214
			If ($refId>0)
				Case of 
					: ($l_refItem=-100)
						If (vb_interesBorrado)
							AT_Insert (0;1;->adACT_fInteresBorrado;->alACT_idInteresBorrado;->arACT_mInteresBorrado)
							adACT_fInteresBorrado{Size of array:C274(adACT_fInteresBorrado)}:=adACT_CfechaInteresTemp{$refId}
							alACT_idInteresBorrado{Size of array:C274(alACT_idInteresBorrado)}:=alACT_CidCargoGenIntTemp{$refId}
							arACT_mInteresBorrado{Size of array:C274(arACT_mInteresBorrado)}:=arACT_CMontoNetoTemp{$refId}
						Else 
							vb_interesBorrado:=True:C214
							ARRAY DATE:C224(adACT_fInteresBorrado;0)
							ARRAY LONGINT:C221(alACT_idInteresBorrado;0)
							ARRAY REAL:C219(arACT_mInteresBorrado;0)
							AT_Insert (0;1;->adACT_fInteresBorrado;->alACT_idInteresBorrado;->arACT_mInteresBorrado)
							adACT_fInteresBorrado{Size of array:C274(adACT_fInteresBorrado)}:=adACT_CfechaInteresTemp{$refId}
							alACT_idInteresBorrado{Size of array:C274(alACT_idInteresBorrado)}:=alACT_CidCargoGenIntTemp{$refId}
							arACT_mInteresBorrado{Size of array:C274(arACT_mInteresBorrado)}:=arACT_CMontoNetoTemp{$refId}
						End if 
						
					: (($l_refItem=-140) | ($l_refItem=-141))  //20170714 RCH
						If (vb_descuentoBorrado)
						Else 
							vb_descuentoBorrado:=True:C214
							ARRAY TEXT:C222(atACT_llaveDctoEliminado;0)
						End if 
						AT_Insert (0;1;->atACT_llaveDctoEliminado)
						atACT_llaveDctoEliminado{Size of array:C274(atACT_llaveDctoEliminado)}:=String:C10(alACT_CRefsTemp{$refId})+";"+String:C10(alACT_CIDCtaCteTemp{$refId})+";"+String:C10(alACT_CIdsAvisosTemp{$refId})
						
				End case 
				AT_Delete ($refId;1;->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp)
				AT_Delete ($refId;1;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->alACT_CidCargoGenIntTemp;->adACT_CfechaInteresTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
			End if 
		End if 
	End if 
End if 
$line:=AL_GetLine (ALP_CargosXPagar)
If (($line=0) | ($line=1))
	_O_DISABLE BUTTON:C193(bSubir)
Else 
	_O_ENABLE BUTTON:C192(bSubir)
End if 
If (($line=0) | ($line=Size of array:C274(adACT_CFechaEmision)))
	_O_DISABLE BUTTON:C193(bBajar)
Else 
	_O_ENABLE BUTTON:C192(bBajar)
End if 
IT_SetButtonState ((Size of array:C274(alACT_RecNumsCargos)>0);->bDelCargos)