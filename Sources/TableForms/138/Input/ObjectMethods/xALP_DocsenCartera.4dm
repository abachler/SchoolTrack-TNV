  //If (False)
  //Case of 
  //
  //: (alProEvt=1)
  //$line:=AL_GetLine (xALP_DocsenCartera)
  //If ($line=0)
  //ACTpp_HabDesHabAcciones (False)
  //Else 
  //If (aACT_ApdosDCarEstado{$line}="Protestado@")
  //ACTpp_HabDesHabAcciones (False)
  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID=aACT_ApdosDCarID{$line})
  //If ([ACT_Documentos_en_Cartera]Reemplazado)
  //DISABLE BUTTON(bReemplazar)
  //Else 
  //ENABLE BUTTON(bReemplazar)
  //End if 
  //Else 
  //ACTpp_HabDesHabAcciones (True)
  //End if 
  //End if 
  //: (alProEvt=2)
  //$line:=AL_GetLine (xALP_DocsenCartera)
  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID=aACT_ApdosDCarID{$line})
  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]ID=[ACT_Documentos_en_Cartera]ID_DocdePago)
  //QUERY([ACT_Pagos];[ACT_Pagos]ID_DocumentodePago=[ACT_Documentos_de_Pago]ID)
  //If (aACT_ApdosDCarEstado{$line}="Protestado@")
  //ACTpp_HabDesHabAcciones (False)
  //QUERY([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID=aACT_ApdosDCarID{$line})
  //If ([ACT_Documentos_en_Cartera]Reemplazado)
  //DISABLE BUTTON(bReemplazar)
  //Else 
  //ENABLE BUTTON(bReemplazar)
  //End if 
  //Else 
  //ACTpp_HabDesHabAcciones (True)
  //DISABLE BUTTON(bReemplazar)
  //End if 
  //WDW_OpenFormWindow (->[ACT_Documentos_de_Pago];"ACTDisplayDocPago";0;4;"Detalle Documento de Pago")
  //DIALOG([ACT_Documentos_de_Pago];"ACTDisplayDocPago")
  //CLOSE WINDOW
  //UNLOAD RECORD([ACT_Documentos_de_Pago])
  //UNLOAD RECORD([ACT_Documentos_en_Cartera])
  //UNLOAD RECORD([ACT_Pagos])
  //End case 
  //End if 

Case of 
		
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_DocsenCartera)
		If ($line=0)
			ACTpp_HabDesHabAcciones (False:C215)
		Else 
			$vl_id:=aACT_ApdosDCarID{$line}
			$vl_idEstado:=KRL_GetNumericFieldData (->[ACT_Documentos_en_Cartera:182]ID:1;->$vl_id;->[ACT_Documentos_en_Cartera:182]id_estado:21)
			If (($vl_idEstado=-2) | (KRL_GetBooleanFieldData (->[ACT_Documentos_en_Cartera:182]ID:1;->$vl_id;->[ACT_Documentos_en_Cartera:182]Reemplazado:14)=True:C214))
				ACTpp_HabDesHabAcciones (False:C215)
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
				If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
					_O_DISABLE BUTTON:C193(bReemplazar)
				Else 
					_O_ENABLE BUTTON:C192(bReemplazar)
				End if 
			Else 
				ACTpp_HabDesHabAcciones (True:C214)
			End if 
		End if 
	: (alProEvt=2)
		$line:=AL_GetLine (xALP_DocsenCartera)
		  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
		$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
		$yBWR_currentTable:=yBWR_currentTable
		$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
		$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
		
		  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
		yBWR_currentTable:=->[ACT_Documentos_en_Cartera:182]
		vyBWR_CustomArrayPointer:=->aACT_ApdosDCarID
		aACT_ApdosDCarID:=$line
		vyBWR_CustonFieldRefPointer:=->[ACT_Documentos_en_Cartera:182]ID:1
		vlBWR_BrowsingMethod:=BWR Array Browsing
		
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=aACT_ApdosDCarID{$line})
		
		If ([ACT_Documentos_en_Cartera:182]id_estado:21=-2)
			ACTpp_HabDesHabAcciones (False:C215)
			If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
				_O_DISABLE BUTTON:C193(bReemplazar)
			Else 
				_O_ENABLE BUTTON:C192(bReemplazar)
			End if 
		Else 
			ACTpp_HabDesHabAcciones (True:C214)
		End if 
		
		WDW_OpenFormWindow (->[ACT_Documentos_de_Pago:176];"Input";0;4;__ ("Detalle del Documento en Cartera"))
		DIALOG:C40([ACT_Documentos_de_Pago:176];"Input")
		CLOSE WINDOW:C154
		UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
		UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
		UNLOAD RECORD:C212([ACT_Pagos:172])
		
		  //reestablecemos el metodo de navegación previo
		vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
		yBWR_currentTable:=$yBWR_currentTable
		vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
		vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
		BWR_SetInputFormButtons 
End case 

