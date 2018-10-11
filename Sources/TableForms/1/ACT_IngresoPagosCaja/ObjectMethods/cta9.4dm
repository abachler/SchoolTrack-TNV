C_TEXT:C284(vsACT_OldNombApellidoCta)
C_LONGINT:C283(vlACT_OldID)
IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]apellidos_y_nombres:40;False:C215)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vsACT_OldNombApellidoCta:=Self:C308->
		vlACT_OldID:=[ACT_CuentasCorrientes:175]ID:1
	: (Form event:C388=On Losing Focus:K2:8)
		If ((Self:C308->#"") & (Self:C308->#vsACT_OldNombApellidoCta))
			
			  //AL_UpdateArrays (ALP_AvisosXPagar;0)
			  //AL_UpdateArrays (ALP_ItemsXPagar;0)
			  //AL_UpdateArrays (ALP_AlumnosXPagar;0)
			  //AL_UpdateArrays (ALP_AvisosAgrupadosXPagar;0)
			ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
			
			  //RNApdo:=-1
			  //RNCta:=-1
			  //RNTercero:=-1
			ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
			vbACT_ModOrderAvisos:=False:C215
			modcargos:=False:C215
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
					  //CANCEL TRANSACTION
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
				: (Records in selection:C76([Personas:7])>1)
					CD_Dlog (0;__ ("Existe más de una cuenta con ese nombre. Use un identificador nacional para realizar la búsqueda."))
					  //IT_SetEnterable (False;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					  //ACTpgs_ClearDlogVars 
					  //ACTpgs_DeclareArraysInterfaz 
					  //CANCEL TRANSACTION
					$vb_setAreas:=False:C215
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
					GOTO OBJECT:C206(vsACT_RUTCta)
				: (Records in selection:C76([Alumnos:2])=0)
					CD_Dlog (0;__ ("No existe una cuenta con ese nombre."))
					  //IT_SetEnterable (False;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					  //ACTpgs_ClearDlogVars 
					  //ACTpgs_DeclareArraysInterfaz 
					  //CANCEL TRANSACTION
					$vb_setAreas:=False:C215
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
			End case 
			
			  //AL_UpdateArrays (ALP_AvisosXPagar;-2)
			  //AL_UpdateArrays (ALP_ItemsXPagar;-2)
			  //AL_UpdateArrays (ALP_AlumnosXPagar;-2)
			  //AL_UpdateArrays (ALP_AvisosAgrupadosXPagar-2)
			ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
			$page:=FORM Get current page:C276
			$vb_bool:=False:C215
			ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
			
		Else 
			Self:C308->:=vsACT_OldNombApellidoCta
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->vlACT_OldID)  //20130715 RCH
		End if 
End case 
BRING TO FRONT:C326(Current process:C322)
