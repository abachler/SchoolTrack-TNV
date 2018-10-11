//%attributes = {}
  // TGR_xxSTR_Link_AlumnosMedicos()
  // Por: Alberto Bachler K.: 02-04-14, 09:50:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			  // con este código evitamos asignar un dts durante la conversión del sistema de registro de médicos que se hace en UD_v2010402_Medicos
			If ([xxSTR_Link_AlumnosMedicos:237]DTS_modificacion:5="")
				[xxSTR_Link_AlumnosMedicos:237]DTS_modificacion:5:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[xxSTR_Link_AlumnosMedicos:237]DTS_modificacion:5:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	
	
End if 




