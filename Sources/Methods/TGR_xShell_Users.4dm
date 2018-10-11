//%attributes = {}
  // Método: TGR_xShell_Users
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:47:35
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
				[xShell_Users:47]PasswordVersion:10:=3
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		If (Trigger event:C369#On Deleting Record Event:K3:3)
			If (Not:C34(<>vb_NoSincroHaciaCondor_47))
				READ ONLY:C145([Profesores:4])
				$uuidPersona:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[xShell_Users:47]NoEmployee:7;->[Profesores:4]Auto_UUID:41)
				Sync_RegistraModificacion (->[xShell_Users:47]Auto_UUID:24;$uuidPersona)
			End if 
			<>vb_NoSincroHaciaCondor_47:=False:C215
		End if 
	End if 
End if 
