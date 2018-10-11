C_LONGINT:C283($l_refItem)
$line:=AL_GetLine (xALP_PlanillaIntereses)
If ($line#0)
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el cargo seleccionado?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		$l_refItem:=alACT_CRefs{$line}
		alACT_RecNumsCargosTemp{0}:=alACT_IntRecNum{$line}
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->alACT_RecNumsCargosTemp;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)=1)
			$refId:=$DA_Return{1}
		Else 
			BEEP:C151
			$refId:=$DA_Return{Size of array:C274($DA_Return)}
		End if 
		$ok:=0
		If (alACT_IntRecNum{$line}>0)
			$ok:=ACTcar_Delete (alACT_IntRecNum{$line})
			If ($ok>=1)
				modCargos:=False:C215
				modInt:=False:C215
			End if 
		End if 
		If ($ok=0)
			modCargos:=True:C214
			modInt:=True:C214
			AT_Insert (1;1;->alACT_AvisosModInt)
			alACT_AvisosModInt{1}:=alACT_IntAvisoID{$line}
			AL_UpdateArrays (xALP_PlanillaIntereses;0)
			AT_Delete ($line;1;->alACT_IntAvisoID;->adACT_IntFecha;->adACT_IntFechaV;->atACT_IntGlosa;->arACT_IntMonto;->arACT_IntSaldo;->alACT_IntCargoID;->alACT_IntRecNum)
			xALSet_ACT_PlanillaIntereses 
			AL_UpdateArrays (xALP_PlanillaIntereses;-2)
			AL_SetLine (xALP_PlanillaIntereses;0)
			_O_DISABLE BUTTON:C193(bDelCargos)
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
				AT_Delete ($refId;1;->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
			End if 
		End if 
	End if 
End if 