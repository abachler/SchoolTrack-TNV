C_LONGINT:C283($l_refItem)
$line:=AL_GetLine (ALP_CargosXPagar)
If ($line#0)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el cargo seleccionado?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
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
			
			ACTpgs_OpcionesCargosEliminados ("SetBooleanVar")  //20120710 RCH
			
			$ok:=ACTcar_Delete (alACT_RecNumsCargos{$line})
		End if 
		If ($ok=0)
			AL_UpdateArrays (ALP_CargosXPagar;0)
			$aviso:=AL_GetLine (ALP_AvisosXPagar)
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
			If (Size of array:C274(adACT_CFechaEmision)>0)
			Else 
				AL_SetLine (ALP_AvisosXPagar;0)
				IT_SetButtonState (False:C215;->bSubir;->bBajar)
			End if 
			ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		End if 
		ACTpgs_LimpiaVarsInterfaz ("Recarga")
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		ACTpgs_LimpiaVarsInterfaz ("RecargaDatos")
		C_LONGINT:C283($page)
		$page:=Selected list items:C379(hlACT_IngresoPagos)
		ACTpgs_LimpiaVarsInterfaz ("SeteaObjetosYSelPage";->$page)
		ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar";->$page)
		ACTpgs_CopiaArreglosCargos 
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
	End if 
End if 
$line:=AL_GetLine (ALP_CargosXPagar)
If (($line=0) | ($line=1))
	_O_DISABLE BUTTON:C193(bSubirC)
Else 
	_O_ENABLE BUTTON:C192(bSubirC)
End if 
If (($line=0) | ($line=Size of array:C274(adACT_CFechaEmision)))
	_O_DISABLE BUTTON:C193(bBajarC)
Else 
	_O_ENABLE BUTTON:C192(bBajarC)
End if 
If (USR_checkRights ("D";->[ACT_Cargos:173]))
	IT_SetButtonState (($line>0);->bDelCargos)
Else 
	_O_DISABLE BUTTON:C193(bDelCargos)
End if 