C_TEXT:C284(vsACT_OldNomApellidoTer)
C_LONGINT:C283(vlACT_OldID)
IT_clairvoyanceOnFields2 (Self:C308;->[ACT_Terceros:138]Nombre_Completo:9;False:C215)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNomApellidoTer:=Self:C308->
		vlACT_OldID:=[ACT_Terceros:138]Id:1
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Self:C308->#"") & (Self:C308->#vsACT_OldNomApellidoTer))
			ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
			vbACT_ModOrderAvisos:=False:C215
			modcargos:=False:C215
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Nombre_Completo:9=Self:C308->)
			Case of 
				: (Records in selection:C76([ACT_Terceros:138])=1)
					For ($i;1;Size of array:C274(aPtrsTerceros))
						If (Not:C34(Is nil pointer:C315(aPtrsTerceros{$i})))
							If (aPtrsTerceros{$i}->#"")
								vsACT_RUTTercero:=aPtrsTerceros{$i}->
								vt_MsgApdo:="Encontrado en "+at_IDNacional_NamesTerceros{$i}
								$i:=Size of array:C274(aPtrsTerceros)+1
							End if 
						End if 
					End for 
					ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
					RNTercero:=Record number:C243([ACT_Terceros:138])
					ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
					ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
					$page:=FORM Get current page:C276
					$vb_bool:=False:C215
					ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
					
				: (Records in selection:C76([ACT_Terceros:138])>1)
					CD_Dlog (0;__ ("Existe más de un tercero con ese nombre. Use un identificador nacional para realizar la búsqueda."))
					$vb_setAreas:=True:C214
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
					GOTO OBJECT:C206(vsACT_RUTTercero)
				: (Records in selection:C76([ACT_Terceros:138])=0)
					CD_Dlog (0;__ ("No existe un tercero con ese nombre."))
					$vb_setAreas:=True:C214
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
			End case 
		Else 
			Self:C308->:=vsACT_OldNomApellidoTer
			KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vlACT_OldID)  //20130715 RCH
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)
