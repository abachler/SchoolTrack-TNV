Case of 
	: (Form event:C388=On Load:K2:1)
		If (vb_selectionMonth2Pay)
			GET WINDOW RECT:C443($left;$top;$right;$bottom)
			SET WINDOW RECT:C444($left;$top;$left+337;$top+486)
			FORM GOTO PAGE:C247(2)
		Else 
			FORM GOTO PAGE:C247(1)
		End if 
		XS_SetInterface 
		
		For ($m;1;Size of array:C274(al_idItems))
			AT_Insert (0;1;->ab_Item2Import;->ap_item2Import)
			ab_Item2Import{$m}:=True:C214
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_item2Import{$m})
		End for 
		AT_Inc (0)
		Case of 
			: (vb_selectionItems2Pay)
				$Error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"ap_item2Import";"";40;"1")
		End case 
		$Error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"at_glosasItems";__ ("Glosas items");250;"")
		$Error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"al_idItems";"";80;"")
		$Error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"ab_Item2Import";"";80;"")
		$Error:=ALP_DefaultColSettings (ALP_CargosXPagar;AT_Inc ;"alACT_idsRSOrg";"";80;"")
		
		  //general options
		ALP_SetDefaultAppareance (ALP_CargosXPagar;9;1;6;2;8)
		AL_SetColOpts (ALP_CargosXPagar;1;1;1;3;0)
		AL_SetRowOpts (ALP_CargosXPagar;0;1;0;0;1;0)
		AL_SetCellOpts (ALP_CargosXPagar;0;1;1)
		AL_SetMainCalls (ALP_CargosXPagar;"";"")
		AL_SetScroll (ALP_CargosXPagar;0;-3)
		AL_SetEntryOpts (ALP_CargosXPagar;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (ALP_CargosXPagar;0;30;0)
		AL_SetLine (ALP_CargosXPagar;0)
		
		_O_DISABLE BUTTON:C193(bSubir)
		_O_DISABLE BUTTON:C193(bBajar)
		OBJECT SET VISIBLE:C603(*;"order@";vb_selectionOrder2PayItems)
		
		If (Not:C34(vb_selectionMonth2Pay))
			$Error:=ALP_DefaultColSettings (ALP_CargosXPagarO;1;"at_glosasItems2";__ ("Glosas items");300;"1")
			$Error:=ALP_DefaultColSettings (ALP_CargosXPagarO;2;"al_mesCargosT";__ ("Mes");50;"###0")
			$Error:=ALP_DefaultColSettings (ALP_CargosXPagarO;3;"al_refItemsT";"";80;"")
			$Error:=ALP_DefaultColSettings (ALP_CargosXPagarO;4;"alACT_idsRST";"";80;"")
			
			  //general options
			ALP_SetDefaultAppareance (ALP_CargosXPagarO;9;1;6;2;8)
			AL_SetColOpts (ALP_CargosXPagarO;1;1;1;2;0)
			AL_SetRowOpts (ALP_CargosXPagarO;0;1;0;0;1;0)
			AL_SetCellOpts (ALP_CargosXPagarO;0;1;1)
			AL_SetMainCalls (ALP_CargosXPagarO;"";"")
			AL_SetScroll (ALP_CargosXPagarO;0;-3)
			AL_SetEntryOpts (ALP_CargosXPagarO;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
			AL_SetDrgOpts (ALP_CargosXPagarO;0;30;0)
			AL_SetLine (ALP_CargosXPagarO;0)
			
			_O_DISABLE BUTTON:C193(bSubir2)
			_O_DISABLE BUTTON:C193(bBajar2)
			consideraMesSC:=True:C214
			
			AL_UpdateArrays (ALP_CargosXPagar;-0)
			AL_UpdateArrays (ALP_CargosXPagarO;-0)
			ACTcfg_OpcionesImportCargos ("OrdenaCargos")
			AL_UpdateArrays (ALP_CargosXPagar;-2)
			AL_UpdateArrays (ALP_CargosXPagarO;-2)
		End if 
		
		ACTcfg_OpcionesRazonesSociales ("SetObjetosInformes")
		cs_todasRazones:=1
		ACTcfg_OpcionesRazonesSociales ("SetObjetosInformesClick")
		
		ACTcfg_OpcionesImportCargos ("DeclaraArreglosCopia")
		
		ACTcfg_OpcionesImportCargos ("CopiaArreglosCopia")
		
	: (Form event:C388=On Clicked:K2:4)
		ACTcfg_OpcionesRazonesSociales ("SetObjetosInformesClick")
		
End case 
