C_TEXT:C284(vsACT_OldNombApellido)
C_LONGINT:C283(vlACT_OldID)
IT_clairvoyanceOnFields2 (Self:C308;->[Personas:7]Apellidos_y_nombres:30;False:C215)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNombApellido:=Self:C308->
		vlACT_OldID:=[Personas:7]No:1
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Self:C308->#"") & (Self:C308->#vsACT_OldNombApellido))
			FORM GOTO PAGE:C247(1)
			rLetras:=0
			rCheques:=1
			AL_UpdateArrays (xALP_DocumentarLC;0)
			AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
			AT_Initialize (->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
			AL_UpdateArrays (xALP_DocumentarLC;-2)
			  //RNApdo:=-1
			  //RNCta:=-1
			  //RNTercero:=-1
			ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
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
					AL_UpdateArrays (xALP_Documentar;0)
					ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
					RNApdo:=Record number:C243([Personas:7])
					ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				: (Records in selection:C76([Personas:7])>1)
					CD_Dlog (0;__ ("Existe más de un apoderado con ese nombre. Use un identificador nacional para realizar la búsqueda."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
					GOTO OBJECT:C206(vsACT_RUTApoderado)
				: (Records in selection:C76([Personas:7])=0)
					CD_Dlog (0;__ ("No existe un apoderado con ese nombre."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
			End case 
			For ($i;1;Size of array:C274(abACT_ASelectedAvisos))  //para seleccionar a pagar todos los avisos
				abACT_ASelectedAvisos{$i}:=True:C214
				GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
			End for 
			  //20110923 RCH Se agrega linea para marcar todos los cargos...
			ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar")
			ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
		Else 
			Self:C308->:=vsACT_OldNombApellido
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->vlACT_OldID)  //20130715 RCH
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)