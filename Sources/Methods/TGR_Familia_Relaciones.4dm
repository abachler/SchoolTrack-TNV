//%attributes = {}
  // Método: TGR_Familia_Relaciones
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:24:35
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If (([Familia_RelacionesFamiliares:77]Tipo_Relación:4>0) & ([Familia_RelacionesFamiliares:77]Tipo_Relación:4<=Size of array:C274(<>aParentesco)))
					  //ticket 153409 JVP 20151216
					If ([Familia_RelacionesFamiliares:77]Tipo_Relación:4#11)
						[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{[Familia_RelacionesFamiliares:77]Tipo_Relación:4}
					End if 
					
					
				End if 
				SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Familia_RelacionesFamiliares:77]ID_Persona:3;SNT_Accion_Actualizar)
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If (([Familia_RelacionesFamiliares:77]Tipo_Relación:4>0) & ([Familia_RelacionesFamiliares:77]Tipo_Relación:4<=Size of array:C274(<>aParentesco)))
					  //ticket 153409 JVP 20151216
					If ([Familia_RelacionesFamiliares:77]Tipo_Relación:4#11)
						[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{[Familia_RelacionesFamiliares:77]Tipo_Relación:4}
					End if 
				End if 
				If (KRL_FieldChanges (->[Familia_RelacionesFamiliares:77]Tipo_Relación:4;->[Familia_RelacionesFamiliares:77]Apoderado:5))
					SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Familia_RelacionesFamiliares:77]ID_Persona:3;SNT_Accion_Actualizar)
				End if 
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				SN3_ManejaReferencias ("actualizar";SN3_RelacionesFamiliares;[Familia_RelacionesFamiliares:77]ID_Persona:3;SNT_Accion_Actualizar)
		End case 
		
		If (Trigger event:C369#On Deleting Record Event:K3:3)
			If (Not:C34(<>vb_NoSincroHaciaCondor_77))
				Sync_RegistraModificacion (->[Familia_RelacionesFamiliares:77]Auto_UUID:7)
			End if 
			<>vb_NoSincroHaciaCondor_77:=False:C215
		Else 
			Sync_RegistraModificacion (->[Familia_RelacionesFamiliares:77]Auto_UUID:7)
		End if 
		
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Familia_RelacionesFamiliares:77])
	End if 
End if 



