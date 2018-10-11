//%attributes = {}
  // TGR_BBL_ItemsMarcFields()
  // Por: Alberto Bachler: 17/09/13, 13:45:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)


  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[BBL_ItemMarcFields:205]CompoundIndex:4:=String:C10([BBL_ItemMarcFields:205]ID_Item:1)+"."+String:C10([BBL_ItemMarcFields:205]FieldRef:2)+"_"+[BBL_ItemMarcFields:205]SubFieldRef:3
				[BBL_ItemMarcFields:205]LLaveItem:10:=String:C10([BBL_ItemMarcFields:205]TableNum:7)+"."+String:C10([BBL_ItemMarcFields:205]FieldNum:8)+"."+String:C10([BBL_ItemMarcFields:205]ID_Item:1)+"."+[BBL_ItemMarcFields:205]SubFieldRef:3
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				[BBL_ItemMarcFields:205]CompoundIndex:4:=String:C10([BBL_ItemMarcFields:205]ID_Item:1)+"."+String:C10([BBL_ItemMarcFields:205]FieldRef:2)+"_"+[BBL_ItemMarcFields:205]SubFieldRef:3
				[BBL_ItemMarcFields:205]LLaveItem:10:=String:C10([BBL_ItemMarcFields:205]TableNum:7)+"."+String:C10([BBL_ItemMarcFields:205]FieldNum:8)+"."+String:C10([BBL_ItemMarcFields:205]ID_Item:1)+"."+[BBL_ItemMarcFields:205]SubFieldRef:3
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
	End if 
End if 



