//%attributes = {}
  //WIZ_ACT_ImportBancarios

If (USR_GetMethodAcces (Current method name:C684))
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible realizar la importación este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intente la importación más tarde."))
	Else 
		If (Test semaphore:C652("ImportBancarios"))
			CD_Dlog (0;__ ("En este momento hay un proceso de importación en curso. Intente realizar la importación más tarde."))
		Else 
			If (Semaphore:C143("ACT_ImportBancarios"))
				CD_Dlog (0;__ ("En estos momentos hay un proceso de importación en curso. Intente realizar la importación más tarde."))
			Else 
				
				C_BOOLEAN:C305(<>bACTimport_inDialog;<>bACTimport_enProceso;<>bACTimport_importando;<>bACTimport_botonCancelar)
				ARRAY LONGINT:C221($alACT_RecNumPagosInforme;0)
				C_REAL:C285($cb_emitirDT;$cb_listarPagos)
				C_LONGINT:C283($procid;$l_proc)
				
				$procid:=New process:C317("ACTwiz_ImportBancarios";Pila_256K;"Importación de archivos bancarios";vpXS_IconModule;vsBWR_CurrentModule)
				
				DELAY PROCESS:C323(Current process:C322;60)
				While (<>bACTimport_inDialog)
					DELAY PROCESS:C323(Current process:C322;60)
					IDLE:C311
				End while 
				GET PROCESS VARIABLE:C371($procid;cb_emitirDT;$cb_emitirDT)
				GET PROCESS VARIABLE:C371($procid;cb_listarPagos;$cb_listarPagos)
				If (($cb_emitirDT=1) | ($cb_listarPagos=1))
					$l_proc:=IT_UThermometer (1;0;"Esperando que concluya la importación de pagos...";4)
					
					While (<>bACTimport_importando)
						DELAY PROCESS:C323(Current process:C322;60)
						IDLE:C311
					End while 
					
					  // Modificado por: Saúl Ponce (11-04-2017)-Ticket 178916, el array de proceso debía ser interproceso
					  //GET PROCESS VARIABLE($procid;<>alACT_RecNumPagosInforme;$alACT_RecNumPagosInforme)
					GET PROCESS VARIABLE:C371($procid;alACT_RecNumPagosInforme;$alACT_RecNumPagosInforme)  //20170801 ASM Ticket 186378 descomento la línea porque no se estaban cargando los datos.
					GET PROCESS VARIABLE:C371($procid;cb_emitirDT;$cb_emitirDT)
					GET PROCESS VARIABLE:C371($procid;cb_listarPagos;$cb_listarPagos)
					<>bACTimport_enProceso:=False:C215
					
					IT_UThermometer (-2;$l_proc)
					If (Not:C34(<>bACTimport_botonCancelar))
						If (Size of array:C274($alACT_RecNumPagosInforme)>0)
							C_BOOLEAN:C305($vb_go)
							C_POINTER:C301($newTable)
							C_LONGINT:C283($tab)
							
							  // Modificado por: Saúl Ponce (06-04-2018) Ticket Nº 198580, permitir listar los pagos importados sin conf de boletas establecida
							If ($cb_listarPagos=1)
								
								If (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_Pagos:172]))
									$newTable:=->[ACT_Pagos:172]
									AL_RemoveArrays (xALP_Browser;1;30)
									yBWR_currentTable:=$newTable
									CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
									SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;Table:C252($newTable))
									$tab:=Selected list items:C379(vlXS_BrowserTab)
									GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
									BWR_PanelSettings 
									BWR_SelectTableData 
									XS_SetInterface 
									ALP_SetInterface (xALP_Browser)
									_O_REDRAW LIST:C382(vlXS_BrowserTab)
								End if 
								
								READ ONLY:C145([ACT_Pagos:172])
								CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];$alACT_RecNumPagosInforme;"")
								CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
								BWR_SelectTableData 
							End if 
							
							  // Modificado por: Saúl Ponce (06-04-2018) Ticket Nº 198580, iniciar el asistente de documentos tributarios
							If ($cb_emitirDT=1)
								
								$vb_go:=ACTbol_ValidaInicioEmision (2)  // validar que todo esté configurado para emitir boletas
								If ($vb_go)
									ACTmnu_Boletas 
									
									If ($cb_listarPagos=0)  //si no listan los pagos, se listaran las boletas
										
										If (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_Boletas:181]))
											$newTable:=->[ACT_Boletas:181]
											AL_RemoveArrays (xALP_Browser;1;30)
											yBWR_currentTable:=$newTable
											CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
											SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;Table:C252($newTable))
											$tab:=Selected list items:C379(vlXS_BrowserTab)
											GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
											BWR_PanelSettings 
											BWR_SelectTableData 
											XS_SetInterface 
											ALP_SetInterface (xALP_Browser)
											_O_REDRAW LIST:C382(vlXS_BrowserTab)
										End if 
										
										READ ONLY:C145([ACT_Pagos:172])
										READ ONLY:C145([ACT_Transacciones:178])
										READ ONLY:C145([ACT_Boletas:181])
										
										CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];$alACT_RecNumPagosInforme;"")
										KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
										KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
										CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
										BWR_SelectTableData 
										
									End if 
									
								End if 
								
							End if 
							
						Else 
							CD_Dlog (0;"No fueron importados pagos. La Emisión de Documentos Tributarios no puede ser iniciada.")
						End if 
					End if 
				Else 
					<>bACTimport_enProceso:=False:C215
				End if 
				
				CLEAR SEMAPHORE:C144("ACT_ImportBancarios")
			End if 
		End if 
	End if 
End if 