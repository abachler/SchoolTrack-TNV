//%attributes = {}
  // TGR_SyncDiccionario()
  // Por: Alberto Bachler K.: 08-04-15, 16:46:14
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[sync_diccionario:285]pKey:13:=String:C10([sync_diccionario:285]st_tabla:8)+"."+String:C10([sync_diccionario:285]st_campo:9)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[sync_diccionario:285]pKey:13:=String:C10([sync_diccionario:285]st_tabla:8)+"."+String:C10([sync_diccionario:285]st_campo:9)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
End if 