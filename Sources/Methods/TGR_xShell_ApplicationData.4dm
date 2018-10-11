//%attributes = {}
  // TGR_xShell_ApplicationData()
  // Por: Alberto Bachler K.: 02-10-14, 14:24:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_ImportHistoricos_STX;<>vb_AvoidTriggerExecution)


Case of 
	: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		If (Not:C34(Util_isValidUUID ([xShell_ApplicationData:45]UUID_database:13)))
			[xShell_ApplicationData:45]UUID_database:13:=Generate UUID:C1066
		End if 
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		If (Not:C34(Util_isValidUUID ([xShell_ApplicationData:45]UUID_database:13)))
			[xShell_ApplicationData:45]UUID_database:13:=Generate UUID:C1066
		End if 
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		
End case 


If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		XS_VinculoTablas_AppInstitucion 
	End if 
End if 



