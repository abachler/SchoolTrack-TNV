C_TEXT:C284(vsACT_OldNombApellidoCta)
C_LONGINT:C283(vlACT_OldID)
IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]apellidos_y_nombres:40;False:C215)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNombApellidoCta:=Self:C308->
		vlACT_OldID:=[ACT_CuentasCorrientes:175]ID:1
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Self:C308->#"") & (Self:C308->#vsACT_OldNombApellidoCta))
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
			QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=Self:C308->)
			Case of 
				: (Records in selection:C76([Alumnos:2])=1)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					For ($i;1;Size of array:C274(aPtrsCtas))
						If (Not:C34(Is nil pointer:C315(aPtrsCtas{$i})))
							If (aPtrsCtas{$i}->#"")
								vsACT_RUTCta:=aPtrsCtas{$i}->
								vt_MsgCta:="Encontrado en "+at_IDNacional_NamesCtas{$i}
								$i:=Size of array:C274(aPtrsCtas)+1
							End if 
						End if 
					End for 
					ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
					AL_UpdateArrays (xALP_Documentar;0)
					  //CANCEL TRANSACTION
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				: (Records in selection:C76([Personas:7])>1)
					CD_Dlog (0;__ ("Existe más de una cuenta con ese nombre. Use un identificador nacional para realizar la búsqueda."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
					GOTO OBJECT:C206(vsACT_RUTCta)
				: (Records in selection:C76([Alumnos:2])=0)
					CD_Dlog (0;__ ("No existe una cuenta con ese nombre."))
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
			Self:C308->:=vsACT_OldNombApellidoCta
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->vlACT_OldID)  //20130715 RCH
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)
