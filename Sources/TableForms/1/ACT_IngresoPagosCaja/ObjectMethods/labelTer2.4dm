If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
		vbACT_ModOrderAvisos:=False:C215
		modcargos:=False:C215
		
		If (vlACT_IdentificadorTer#1)
			vt_MsgApdo:=""
			READ WRITE:C146([ACT_Terceros:138])
			QUERY:C277([ACT_Terceros:138];aPtrsTerceros{vlACT_IdentificadorTer}->=Self:C308->)
			If (Records in selection:C76([ACT_Terceros:138])>1)
				SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;aChoicesTercero;[ACT_Terceros:138];aRecNumTercero)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->aChoicesTercero
				<>aChoicePtrs{2}:=->aRecNumTercero
				TBL_ShowChoiceList (1;"Seleccione al Tercero")
				If (ok=1)
					GOTO RECORD:C242([ACT_Terceros:138];aRecNumTercero{choiceIdx})
					RNTercero:=Record number:C243([ACT_Terceros:138])
					ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
				Else 
					$vb_setAreas:=False:C215
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
				End if 
			Else 
				If (Records in selection:C76([ACT_Terceros:138])=0)
					CD_Dlog (0;__ ("No se encuentran terceros que cumplan con ese criterio."))
					$vb_setAreas:=False:C215
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
				Else 
					RNTercero:=Record number:C243([ACT_Terceros:138])
					ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
				End if 
			End if 
		Else 
			READ WRITE:C146([ACT_Terceros:138])
			ARRAY TEXT:C222(aIdentif;0)
			ARRAY TEXT:C222(achoice1;0)
			ARRAY TEXT:C222(achoice2;0)
			ARRAY TEXT:C222(achoice3;0)
			ARRAY TEXT:C222(achoice4;0)
			ARRAY TEXT:C222(achoice5;0)
			ARRAY LONGINT:C221(arecnum1;0)
			ARRAY LONGINT:C221(arecnum2;0)
			ARRAY LONGINT:C221(arecnum3;0)
			ARRAY LONGINT:C221(arecnum4;0)
			ARRAY LONGINT:C221(arecnum5;0)
			ARRAY TEXT:C222(aChoicesTercero;0)
			ARRAY LONGINT:C221(aRecNumTercero;0)
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]RUT:4=Self:C308->)
			SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;achoice1;[ACT_Terceros:138];arecnum1)
			AT_Insert (0;Size of array:C274(achoice1);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice1)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesTerceros{3}
			End for 
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Identificador_Nacional2:20=Self:C308->)
			SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;achoice2;[ACT_Terceros:138];arecnum2)
			AT_Insert (0;Size of array:C274(achoice2);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice2)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesTerceros{4}
			End for 
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Identificador_Nacional3:21=Self:C308->)
			SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;achoice3;[ACT_Terceros:138];arecnum3)
			AT_Insert (0;Size of array:C274(achoice3);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice3)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesTerceros{5}
			End for 
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Pasaporte:25=Self:C308->)
			SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;achoice4;[ACT_Terceros:138];arecnum4)
			AT_Insert (0;Size of array:C274(achoice4);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice4)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesTerceros{7}
			End for 
			QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Codigo_Interno:29=Self:C308->)
			SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;achoice5;[ACT_Terceros:138];arecnum5)
			AT_Insert (0;Size of array:C274(achoice5);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice5)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesTerceros{8}
			End for 
			For ($i;1;5)
				$arr1:=Get pointer:C304("achoice"+String:C10($i))
				$arr2:=Get pointer:C304("arecnum"+String:C10($i))
				AT_Insert (0;Size of array:C274($arr1->);->aChoicesTercero;->aRecNumTercero)
				For ($j;1;Size of array:C274($arr1->))
					aChoicesTercero{Size of array:C274(aChoicesTercero)-Size of array:C274($arr1->)+$j}:=$arr1->{$j}
					aRecNumTercero{Size of array:C274(aRecNumTercero)-Size of array:C274($arr2->)+$j}:=$arr2->{$j}
				End for 
			End for 
			If (Size of array:C274(aRecNumTercero)>1)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=->aChoicesTercero
				<>aChoicePtrs{2}:=->aIdentif
				<>aChoicePtrs{3}:=->aRecNumTercero
				TBL_ShowChoiceList (1;"Seleccione al Tercero")
				If (ok=1)
					vt_MsgApdo:="Encontrado en "+aIdentif{choiceIdx}
					GOTO RECORD:C242([ACT_Terceros:138];aRecNumTercero{choiceIdx})
					RNTercero:=Record number:C243([ACT_Terceros:138])
					ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
				Else 
					$vb_setAreas:=False:C215
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
				End if 
			Else 
				If (Size of array:C274(aRecNumTercero)=0)
					CD_Dlog (0;__ ("No se encuentran terceros que cumplan con ese criterio en ningún identificador nacional."))
					$vb_setAreas:=False:C215
					ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
				Else 
					vt_MsgApdo:="Encontrado en "+aIdentif{1}
					GOTO RECORD:C242([ACT_Terceros:138];aRecNumTercero{1})
					RNTercero:=Record number:C243([ACT_Terceros:138])
					ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
					  //20130131 RCH
					OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
				End if 
			End if 
			AT_Initialize (->achoice1;->achoice2;->achoice3;->achoice4;->achoice5;->arecnum1;->arecnum2;->arecnum3;->arecnum4;->arecnum5;->aChoicesTercero;->aRecNumTercero)
		End if 
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
		$page:=FORM Get current page:C276
		$vb_bool:=False:C215
		ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
		
	Else 
		$vb_setAreas:=True:C214
		ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
	End if 
End if 
