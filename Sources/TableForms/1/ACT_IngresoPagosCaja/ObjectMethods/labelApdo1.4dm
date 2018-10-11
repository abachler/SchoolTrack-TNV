C_TEXT:C284(vsACT_OldNombApellido)
C_LONGINT:C283(vlACT_OldID)
IT_clairvoyanceOnFields2 (Self:C308;->[Personas:7]Apellidos_y_nombres:30;False:C215)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNombApellido:=Self:C308->
		vlACT_OldID:=[Personas:7]No:1
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Self:C308->#"") & (Self:C308->#vsACT_OldNombApellido))
			ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
			vbACT_ModOrderAvisos:=False:C215
			modcargos:=False:C215
			QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=Self:C308->)
			Case of 
				: (Records in selection:C76([Personas:7])=1)
					For ($i;1;Size of array:C274(aPtrsApdos))
						If (Not:C34(Is nil pointer:C315(aPtrsApdos{$i})))
							If (aPtrsApdos{$i}->#"")
								vsACT_RUTApoderado:=aPtrsApdos{$i}->
								vt_MsgApdo:="Encontrado en "+at_IDNacional_NamesApdos{$i}
								$i:=Size of array:C274(aPtrsApdos)+1
							End if 
						End if 
					End for 
					ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
					RNApdo:=Record number:C243([Personas:7])
					ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
					ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
					$page:=FORM Get current page:C276
					$vb_bool:=False:C215
					ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
					
				: (Records in selection:C76([Personas:7])>1)
					CD_Dlog (0;__ ("Existe más de un apoderado con ese nombre. Use un identificador nacional para realizar la búsqueda."))
					$vb_setAreas:=True:C214
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
					GOTO OBJECT:C206(vsACT_RUTApoderado)
				: (Records in selection:C76([Personas:7])=0)
					CD_Dlog (0;__ ("No existe un apoderado con ese nombre."))
					$vb_setAreas:=True:C214
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
			End case 
		Else 
			Self:C308->:=vsACT_OldNombApellido
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->vlACT_OldID)  //20130715 RCH
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)
