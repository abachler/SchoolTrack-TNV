C_TEXT:C284(vsACT_OldNombApellidoTer)
C_LONGINT:C283(vlACT_OldID)
IT_clairvoyanceOnFields2 (Self:C308;->[ACT_Terceros:138]Nombre_Completo:9;False:C215)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNombApellidoTer:=Self:C308->
		vlACT_OldID:=[ACT_Terceros:138]Id:1
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Self:C308->#"") & (Self:C308->#vsACT_OldNombApellidoTer))
			FORM GOTO PAGE:C247(1)
			rLetras:=0
			rCheques:=1
			AL_UpdateArrays (xALP_DocumentarLC;0)
			AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
			AT_Initialize (->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
			AL_UpdateArrays (xALP_DocumentarLC;-2)
			ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
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
					AL_UpdateArrays (xALP_Documentar;0)
					  //CANCEL TRANSACTION
					RNTercero:=Record number:C243([ACT_Terceros:138])
					ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				: (Records in selection:C76([ACT_Terceros:138])>1)
					CD_Dlog (0;__ ("Existe más de un tercero con ese nombre. Use un identificador nacional para realizar la búsqueda."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
					GOTO OBJECT:C206(vsACT_RUTTercero)
				: (Records in selection:C76([ACT_Terceros:138])=0)
					CD_Dlog (0;__ ("No existe un tercero con ese nombre."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
			End case 
			ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar")
			ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		Else 
			Self:C308->:=vsACT_OldNombApellidoTer
			KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->vlACT_OldID)  //20130715 RCH
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)