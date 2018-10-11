Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(at_ACTNombreCampo;0)
		ARRAY BOOLEAN:C223(ab_EnPAT;0)
		ARRAY BOOLEAN:C223(ab_EnPAC;0)
		ARRAY BOOLEAN:C223(ab_EnCUPONERA;0)
		ARRAY BOOLEAN:C223(ab_EnCONTABILIDAD;0)
		ARRAY TEXT:C222(at_ACTNombreCampoAL;0)
		ARRAY BOOLEAN:C223(ab_EnPATAL;0)
		ARRAY BOOLEAN:C223(ab_EnPACAL;0)
		ARRAY BOOLEAN:C223(ab_EnCUPONERAAL;0)
		ARRAY BOOLEAN:C223(ab_EnCONTABILIDADAL;0)
		ARRAY INTEGER:C220(ai_ACTTipoExportacion;0)
		C_LONGINT:C283($Error)
		ALP_DefaultColSettings (xALP_CFG_TranfBancaria;1;"at_ACTNombreCampoAL";__ ("Nombre del Campo");200;"";1;2;0)
		ALP_DefaultColSettings (xALP_CFG_TranfBancaria;2;"ab_EnPATAL";__ ("En PAT:");60;__ ("SI;NO");2;2;0)
		ALP_DefaultColSettings (xALP_CFG_TranfBancaria;3;"ab_EnPACAL";__ ("En PAC:");60;__ ("SI;NO");2;2;0)
		ALP_DefaultColSettings (xALP_CFG_TranfBancaria;4;"ab_EnCUPONERAAL";__ ("En Cuponera:");90;"SI;NO";2;2;0)
		ALP_DefaultColSettings (xALP_CFG_TranfBancaria;5;"ab_EnCONTABILIDADAL";__ ("En Contabilidad:");90;"SI;NO";2;2;0)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_CFG_TranfBancaria;9;1;6;1;8)
		
		AL_SetColOpts (xALP_CFG_TranfBancaria;1;1;1;0;0)
		AL_SetRowOpts (xALP_CFG_TranfBancaria;0;0;0;0;1;0)
		AL_SetCellOpts (xALP_CFG_TranfBancaria;0;1;1)
		AL_SetMiscOpts (xALP_CFG_TranfBancaria;0;0;"\\";0;1)
		AL_SetCallbacks (xALP_CFG_TranfBancaria;"";"")
		AL_SetMainCalls (xALP_CFG_TranfBancaria;"";"")
		AL_SetScroll (xALP_CFG_TranfBancaria;0;0)
		AL_SetEntryOpts (xALP_CFG_TranfBancaria;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_CFG_TranfBancaria;0;30;0)
		AL_SetSortOpts (xALP_CFG_TranfBancaria;0;0;0)
		  //dragging options
		AL_SetDrgSrc (xALP_CFG_TranfBancaria;1;"";"";"")
		AL_SetDrgSrc (xALP_CFG_TranfBancaria;2;"";"";"")
		AL_SetDrgSrc (xALP_CFG_TranfBancaria;3;"";"";"")
		AL_SetDrgDst (xALP_CFG_TranfBancaria;1;"";"";"")
		AL_SetDrgDst (xALP_CFG_TranfBancaria;1;"";"";"")
		AL_SetDrgDst (xALP_CFG_TranfBancaria;1;"";"";"")
		AL_UpdateArrays (xALP_CFG_TranfBancaria;0)
		
		
		
		
		  //Personas
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		ARRAY LONGINT:C221(al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[Personas:7]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[Personas:7]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[PE]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		  //Avisos de Cobranza
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[ACT_Avisos_de_Cobranza:124]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[AC]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		  //Familia
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[Familia:78]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[Familia:78]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[FA]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		  //cargos
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[ACT_Cargos:173]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[ACT_Cargos:173]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[CA]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		  //pagos
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[ACT_Pagos:172]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[ACT_Pagos:172]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[PA]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		  //boletas
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[ACT_Boletas:181]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[ACT_Boletas:181]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[BO]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		  //Documentos de pago
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[ACT_Documentos_de_Pago:176]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[ACT_Documentos_de_Pago:176]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[DP]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		  //Cuentas corrientes
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[ACT_CuentasCorrientes:175]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[ACT_CuentasCorrientes:175]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[CC]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		  //Alumnos
		ARRAY TEXT:C222($aFieldName;0)
		ARRAY INTEGER:C220($aFieldNo;0)
		ARRAY LONGINT:C221($al_idCampos;0)
		READ ONLY:C145([xShell_Fields:52])
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[Alumnos:2]))
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNo;[xShell_Fields:52]Alias:4;$aFieldName;[xShell_Fields:52]ID:24;$al_idCampos)
		SORT ARRAY:C229($aFieldName;$aFieldNo;>)
		For ($i;1;Size of array:C274($aFieldNo))
			$s:=Size of array:C274(at_ACTNombreCampo)+1
			AT_Insert ($s;1;->at_ACTNombreCampo;->al_idCampos)
			$y_campo:=Field:C253(Table:C252(->[Alumnos:2]);$aFieldNo{$i})
			at_ACTNombreCampo{$s}:="[AL]"+XSvs_nombreCampoLocal_puntero ($y_campo)
			al_idCampos{$s}:=$al_idCampos{$i}
		End for 
		
		
		
		
		
		
		
		
		AT_Insert (1;Size of array:C274(at_ACTNombreCampo);->ab_EnPAT;->ab_EnPAC;->ab_EnCUPONERA;->ab_EnCONTABILIDAD)  //redimensiona los arreglos
		READ ONLY:C145([xxACT_TransferenciaBancaria:131])
		For ($j;1;Size of array:C274(at_ACTNombreCampo))  //Para leer lo almacenado
			  //20130401 RCH
			  //$el:=Find in field([xxACT_TransferenciaBancaria]id_xShellFields;al_idCampos{$j})
			  //If ($el#-1)
			  //GOTO RECORD([xxACT_TransferenciaBancaria];$el)
			KRL_FindAndLoadRecordByIndex (->[xShell_Fields:52]ID:24;->al_idCampos{$j})
			QUERY:C277([xxACT_TransferenciaBancaria:131];[xxACT_TransferenciaBancaria:131]Tabla_Número:2=[xShell_Fields:52]NumeroTabla:1;*)
			QUERY:C277([xxACT_TransferenciaBancaria:131]; & ;[xxACT_TransferenciaBancaria:131]Campo_Número:3=[xShell_Fields:52]NumeroCampo:2)
			
			If (Records in selection:C76([xxACT_TransferenciaBancaria:131])=1)
				ab_EnPAT{$j}:=[xxACT_TransferenciaBancaria:131]EnPAT:4
				ab_EnPAC{$j}:=[xxACT_TransferenciaBancaria:131]EnPAC:5
				ab_EnCUPONERA{$j}:=[xxACT_TransferenciaBancaria:131]EnCuponera:6
				ab_EnCONTABILIDAD{$j}:=[xxACT_TransferenciaBancaria:131]EnContabilidad:7
			End if 
		End for 
		
		co_Personas:=1  //selecciono Personas
		ARRAY LONGINT:C221(al_PosicionAL;0)
		at_ACTNombreCampo{0}:="[PE]"
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->at_ACTNombreCampo;"@";->$DA_Return)
		For ($i;1;Size of array:C274($DA_Return))
			AT_Insert (0;1;->at_ACTNombreCampoAL;->ab_EnPATAL;->ab_EnPACAL;->ab_EnCUPONERAAL;->ab_EnCONTABILIDADAL;->al_PosicionAL)
			at_ACTNombreCampoAL{Size of array:C274(at_ACTNombreCampoAL)}:=Substring:C12(at_ACTNombreCampo{$DA_Return{$i}};5)
			ab_EnPATAL{Size of array:C274(ab_EnPATAL)}:=ab_EnPAT{$DA_Return{$i}}
			ab_EnPACAL{Size of array:C274(ab_EnPACAL)}:=ab_EnPAC{$DA_Return{$i}}
			ab_EnCUPONERAAL{Size of array:C274(ab_EnCUPONERAAL)}:=ab_EnCUPONERA{$DA_Return{$i}}
			ab_EnCONTABILIDADAL{Size of array:C274(ab_EnCONTABILIDADAL)}:=ab_EnCONTABILIDAD{$DA_Return{$i}}
			al_PosicionAL{Size of array:C274(al_PosicionAL)}:=$DA_Return{$i}
		End for 
		
		SORT ARRAY:C229(at_ACTNombreCampoAL;ab_EnPATAL;ab_EnPACAL;ab_EnCUPONERAAL;ab_EnCONTABILIDADAL;al_PosicionAL;>)
		AL_UpdateArrays (xALP_CFG_TranfBancaria;-2)
End case 
