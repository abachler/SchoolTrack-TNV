Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		ACTic_CargaListas 
		
		If (Records in table:C83([xxACT_ItemsCategorias:98])<=1)
			IT_SetButtonState (False:C215;->bSubir;->bBajar)
		Else 
			_O_ENABLE BUTTON:C192(bBajar)
			_O_DISABLE BUTTON:C193(bSubir)
		End if 
		ACTcfgcar_SetObjects ("SetPrivilegios")
		
		  // Modificado por: Saúl Ponce (08/02/2018) Ticket Nº 198592
		  // Los colegios subvencionados no requieren una categoría para los items sin categoría
		  // Ocasionó problemas en la impresión de boletas, ACTbol_PrintBoletasVR() encontraba 6 categorías.
		If (cb_BoletaSubvencionada=0)
			READ WRITE:C146([xxACT_ItemsCategorias:98])
			QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=0)
			If (Records in selection:C76([xxACT_ItemsCategorias:98])=0)
				CREATE RECORD:C68([xxACT_ItemsCategorias:98])
				[xxACT_ItemsCategorias:98]ID:2:=0
				[xxACT_ItemsCategorias:98]Nombre:1:="Ítems sin categoria"
				[xxACT_ItemsCategorias:98]Posicion:3:=0
				SAVE RECORD:C53([xxACT_ItemsCategorias:98])
			End if 
			KRL_UnloadReadOnly (->[xxACT_ItemsCategorias:98])
		End if 
End case 
