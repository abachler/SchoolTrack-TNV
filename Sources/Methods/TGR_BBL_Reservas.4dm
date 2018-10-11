//%attributes = {}
  // TGR_BBL_Reservas()
  // Por: Alberto Bachler K.: 20-05-15, 12:41:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		
	: (Trigger event:C369=On Saving Existing Record Event:K3:2)
		
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		READ WRITE:C146([BBL_Items:61])
		RELATE ONE:C42([BBL_Reservas:115]ID_Item:2)
		[BBL_Items:61]Copias_reservadas:44:=[BBL_Items:61]Copias_reservadas:44-1
		SAVE RECORD:C53([BBL_Items:61])
		KRL_UnloadReadOnly (->[BBL_Items:61])
End case 
