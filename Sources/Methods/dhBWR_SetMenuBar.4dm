//%attributes = {}
  //dhBWR_SetMenuBar

If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )))
	DISABLE MENU ITEM:C150(1;8)
End if 


Case of 
	: (vsBWR_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				MNU_SetMenuItemState (False:C215;1;1)
				MNU_SetDeleteItemState (True:C214;False:C215)
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Candidatos:49]))
				
		End case 
	: (vsBWR_CurrentModule="AccountTrack")
		MNU_SetMenuItemState (False:C215;1;1)
		  // 20110311 RCH Al ejecutarse esta linea se deshabilita el boton eliminar al entrar a la ficha de una cuenta y salir (el menu esta deshabilitado a pesar de que el registro estaba seleccionado....
		  //MNU_SetDeleteItemState (True;(Table(yBWR_CurrentTable)=Table(->[ACT_Terceros])))
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				MNU_SetDeleteItemState (True:C214;False:C215)
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
				MNU_SetMenuItemState (True:C214;1;1)
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Familia:78]))
				MNU_SetDeleteItemState (True:C214;False:C215)
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
				MNU_EnableDisableToolsMenuItem (9)
				MNU_SetDeleteItemState 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				Case of 
					: (Size of array:C274(abrSelect)=1)
						If (vb_RecordInInputForm=False:C215)
							If (alBWR_recordNumber{abrSelect{1}}>=0)
								$readw:=Read only state:C362([ACT_Documentos_en_Cartera:182])
								GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];alBWR_recordNumber{abrSelect{1}})
								Case of 
									: ([ACT_Documentos_en_Cartera:182]Estado:9="@Reemplazado@")
										MNU_EnableDisableToolsMenuItem (-17)  //Prorrogar
										MNU_EnableDisableToolsMenuItem (-18)  //Depositar
										MNU_EnableDisableToolsMenuItem (19)  //Cambiar ubicación
										MNU_EnableDisableToolsMenuItem (20)  //Recalcular
										MNU_EnableDisableToolsMenuItem (-21)  //Reemplazar
										  //: ([ACT_Documentos_en_Cartera]Estado="Protestado@")
									: (([ACT_Documentos_en_Cartera:182]id_estado:21=-2) | ([ACT_Documentos_en_Cartera:182]id_estado:21=-7))
										MNU_EnableDisableToolsMenuItem (-17)  //Prorrogar
										MNU_EnableDisableToolsMenuItem (-18)  //Depositar
										MNU_EnableDisableToolsMenuItem (19)  //Cambiar ubicación
										MNU_EnableDisableToolsMenuItem (20)  //Recalcular
										MNU_EnableDisableToolsMenuItem (21)  //Reemplazar
									Else 
										MNU_EnableDisableToolsMenuItem (17)  //Prorrogar
										MNU_EnableDisableToolsMenuItem (18)  //Depositar
										MNU_EnableDisableToolsMenuItem (19)  //Cambiar ubicación
										MNU_EnableDisableToolsMenuItem (20)  //Recalcular
										MNU_EnableDisableToolsMenuItem (21)  //Reemplazar
								End case 
								If ($readw)
									KRL_ReloadAsReadOnly (->[ACT_Documentos_en_Cartera:182])
								Else 
									KRL_ReloadInReadWriteMode (->[ACT_Documentos_en_Cartera:182])
								End if 
							End if 
						End if 
					: (Size of array:C274(abrSelect)>0)
						MNU_EnableDisableToolsMenuItem (17)  //Prorrogar
						MNU_EnableDisableToolsMenuItem (18)  //Depositar
						MNU_EnableDisableToolsMenuItem (19)  //Cambiar ubicación
						MNU_EnableDisableToolsMenuItem (20)  //Recalcular
						MNU_EnableDisableToolsMenuItem (21)  //Reemplazar
				End case 
				MNU_SetDeleteItemState 
				SET MENU ITEM:C348(4;9;__ ("Imprimir Documentos Tributarios..."))  //rch
				If (Size of array:C274(abrSelect)>0)
					MNU_EnableDisableToolsMenuItem (9)  //rch
				Else 
					MNU_EnableDisableToolsMenuItem (-9)  //rch
				End if 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				If (Size of array:C274(abrSelect)>0)
					MNU_EnableDisableToolsMenuItem (23)  //Protestar
				Else 
					MNU_EnableDisableToolsMenuItem (-23)  //Protestar
				End if 
				MNU_SetDeleteItemState 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				SET MENU ITEM:C348(4;6;__ ("Imprimir Avisos de Cobranza..."))
				If (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)
					MNU_EnableDisableToolsMenuItem (6)
				Else 
					MNU_EnableDisableToolsMenuItem (-6)
				End if 
				MNU_SetDeleteItemState 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				MNU_SetDeleteItemState (True:C214;False:C215)
				SET MENU ITEM:C348(4;9;__ ("Imprimir Documentos Tributarios..."))
				If (Size of array:C274(abrSelect)>0)
					MNU_EnableDisableToolsMenuItem (8)
					MNU_EnableDisableToolsMenuItem (9)
				Else 
					MNU_EnableDisableToolsMenuItem (-8)
					MNU_EnableDisableToolsMenuItem (-9)
				End if 
		End case 
End case 