$vt_nombreCampo:="No incluir en documentos tributarios"
vtMsg:="Si lo desea puede aplicar el cambio a los cargos ya generados/emitidos o bien sól"+"o para lo"+"s cargos que se generen de ahora en adelante."
vtDesc1:="La opción "+ST_Qte ($vt_nombreCampo)+" es modificada, pero sólo será aplicada a los nuevos "+"cargos que se generen."
vtDesc2:="Se asigna el cambio a los cargos ya generados/emitidos (sólo a los cargos no incl"+"uidos en "+"docu"+"mentos tributarios)."
vtBtn1:="Sólo para los nuevos cargos"
vtBtn2:="Aplicar también a los cargos ya generados/emitidos"
WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
If (ok=1)
	Case of 
		: (r1=1)
			
		: (r2=1)
			C_LONGINT:C283($proc)
			$proc:=IT_UThermometer (1;0;__ ("Aplicando cambio a cargos ya generados/emitidos no incluidos en documentos tributarios..."))
			
			READ ONLY:C145([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
			CREATE SET:C116([ACT_Cargos:173];"ACT_TodosCargos")
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"ACT_EnBoleta")
			
			DIFFERENCE:C122("ACT_TodosCargos";"ACT_EnBoleta";"ACT_TodosCargos")
			
			READ WRITE:C146([ACT_Cargos:173])
			USE SET:C118("ACT_TodosCargos")
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=(Self:C308->=1))
			
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			SET_ClearSets ("ACT_TodosCargos";"ACT_EnBoleta")
			IT_UThermometer (-2;$proc)
			
			  //20150908 RCH Daba error en compilado. Ticket 149544.
			  //LOG_RegisterEvt ("Configuración ítems: Campo "+ST_Qte ($vt_nombreCampo)+" modificado a: "+ST_Boolean2Str (Self->;"Verdadero";"Falso"))
			LOG_RegisterEvt ("Configuración ítems: Campo "+ST_Qte ($vt_nombreCampo)+" modificado a: "+Choose:C955((Self:C308->=1);"Verdadero";"Falso"))
	End case 
End if 