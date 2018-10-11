If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
		vbACT_ModOrderAvisos:=False:C215
		modcargos:=False:C215
		If (vbACT_PagoXApdo)
			If (vlACT_IdentificadorApdo#1)
				vt_MsgApdo:=""
				READ ONLY:C145([Personas:7])
				Case of 
					: (Table:C252(aPtrsApdos{vlACT_IdentificadorApdo})=Table:C252(->[Personas:7]))
						QUERY:C277([Personas:7];aPtrsApdos{vlACT_IdentificadorApdo}->=Self:C308->)
					: (Table:C252(aPtrsApdos{vlACT_IdentificadorApdo})=Table:C252(->[Familia:78]))
						REDUCE SELECTION:C351([Personas:7];0)
						READ ONLY:C145([Familia:78])
						READ ONLY:C145([Alumnos:2])
						QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=Self:C308->)
						If (Records in selection:C76([Familia:78])>0)
							QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
							KRL_RelateSelection (->[Personas:7]No:1;->[Alumnos:2]Apoderado_Cuentas_Número:28;"")
						End if 
				End case 
				If (Records in selection:C76([Personas:7])>1)
					SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;aChoicesApdo;[Personas:7];aRecNumApdo)
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;2)
					<>aChoicePtrs{1}:=->aChoicesApdo
					<>aChoicePtrs{2}:=->aRecNumApdo
					TBL_ShowChoiceList (1;"Seleccione al Apoderado")
					If (ok=1)
						GOTO RECORD:C242([Personas:7];aRecNumApdo{choiceIdx})
						  //CANCEL TRANSACTION
						RNApdo:=Record number:C243([Personas:7])
						ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
						  //20130131 RCH
						OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
					Else 
						$vb_setAreas:=False:C215
						ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
					End if 
				Else 
					If (Records in selection:C76([Personas:7])=0)
						CD_Dlog (0;__ ("No se encuentran apoderados que cumplan con ese criterio."))
						$vb_setAreas:=False:C215
						ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
					Else 
						  //CANCEL TRANSACTION
						RNApdo:=Record number:C243([Personas:7])
						ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
						  //20130131 RCH
						OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
					End if 
				End if 
			Else 
				READ ONLY:C145([Personas:7])
				ARRAY TEXT:C222(aIdentif;0)
				
				ARRAY TEXT:C222(achoice1;0)
				ARRAY TEXT:C222(achoice2;0)
				ARRAY TEXT:C222(achoice3;0)
				ARRAY TEXT:C222(achoice4;0)
				ARRAY TEXT:C222(achoice5;0)
				ARRAY TEXT:C222(achoice6;0)
				
				ARRAY LONGINT:C221(arecnum1;0)
				ARRAY LONGINT:C221(arecnum2;0)
				ARRAY LONGINT:C221(arecnum3;0)
				ARRAY LONGINT:C221(arecnum4;0)
				ARRAY LONGINT:C221(arecnum5;0)
				ARRAY LONGINT:C221(arecnum6;0)
				
				ARRAY TEXT:C222(aChoicesApdo;0)
				ARRAY LONGINT:C221(aRecNumApdo;0)
				QUERY:C277([Personas:7];[Personas:7]RUT:6=Self:C308->)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;achoice1;[Personas:7];arecnum1)
				AT_Insert (0;Size of array:C274(achoice1);->aIdentif)
				For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice1)+1;-1)
					aIdentif{$i}:=at_IDNacional_NamesApdos{3}
				End for 
				QUERY:C277([Personas:7];[Personas:7]IDNacional_2:37=Self:C308->)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;achoice2;[Personas:7];arecnum2)
				AT_Insert (0;Size of array:C274(achoice2);->aIdentif)
				For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice2)+1;-1)
					aIdentif{$i}:=at_IDNacional_NamesApdos{4}
				End for 
				QUERY:C277([Personas:7];[Personas:7]IDNacional_3:38=Self:C308->)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;achoice3;[Personas:7];arecnum3)
				AT_Insert (0;Size of array:C274(achoice3);->aIdentif)
				For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice3)+1;-1)
					aIdentif{$i}:=at_IDNacional_NamesApdos{5}
				End for 
				QUERY:C277([Personas:7];[Personas:7]Pasaporte:59=Self:C308->)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;achoice4;[Personas:7];arecnum4)
				AT_Insert (0;Size of array:C274(achoice4);->aIdentif)
				For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice4)+1;-1)
					aIdentif{$i}:=at_IDNacional_NamesApdos{7}
				End for 
				QUERY:C277([Personas:7];[Personas:7]Codigo_interno:22=Self:C308->)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;achoice5;[Personas:7];arecnum5)
				AT_Insert (0;Size of array:C274(achoice5);->aIdentif)
				For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice5)+1;-1)
					aIdentif{$i}:=at_IDNacional_NamesApdos{8}
				End for 
				
				REDUCE SELECTION:C351([Personas:7];0)
				QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=Self:C308->)
				If (Records in selection:C76([Familia:78])>0)
					READ ONLY:C145([Alumnos:2])
					QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
					KRL_RelateSelection (->[Personas:7]No:1;->[Alumnos:2]Apoderado_Cuentas_Número:28;"")
				End if 
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;achoice6;[Personas:7];arecnum6)
				AT_Insert (0;Size of array:C274(achoice6);->aIdentif)
				For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice6)+1;-1)
					aIdentif{$i}:=at_IDNacional_NamesApdos{9}
				End for 
				
				For ($i;1;6)
					$arr1:=Get pointer:C304("achoice"+String:C10($i))
					$arr2:=Get pointer:C304("arecnum"+String:C10($i))
					AT_Insert (0;Size of array:C274($arr1->);->aChoicesApdo;->aRecNumApdo)
					For ($j;1;Size of array:C274($arr1->))
						aChoicesApdo{Size of array:C274(aChoicesApdo)-Size of array:C274($arr1->)+$j}:=$arr1->{$j}
						aRecNumApdo{Size of array:C274(aRecNumApdo)-Size of array:C274($arr2->)+$j}:=$arr2->{$j}
					End for 
				End for 
				If (Size of array:C274(aRecNumApdo)>1)
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;3)
					<>aChoicePtrs{1}:=->aChoicesApdo
					<>aChoicePtrs{2}:=->aIdentif
					<>aChoicePtrs{3}:=->aRecNumApdo
					TBL_ShowChoiceList (1;"Seleccione al Apoderado")
					If (ok=1)
						vt_MsgApdo:="Encontrado en "+aIdentif{choiceIdx}
						GOTO RECORD:C242([Personas:7];aRecNumApdo{choiceIdx})
						  //CANCEL TRANSACTION
						RNApdo:=Record number:C243([Personas:7])
						ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
						  //20130131 RCH
						OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
					Else 
						  //CANCEL TRANSACTION
						$vb_setAreas:=False:C215
						ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
					End if 
				Else 
					If (Size of array:C274(aRecNumApdo)=0)
						CD_Dlog (0;__ ("No se encuentran apoderados que cumplan con ese criterio en ningún identificador nacional."))
						$vb_setAreas:=False:C215
						ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
						  //CANCEL TRANSACTION
					Else 
						vt_MsgApdo:="Encontrado en "+aIdentif{1}
						GOTO RECORD:C242([Personas:7];aRecNumApdo{1})
						RNApdo:=Record number:C243([Personas:7])
						ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
						  //20130131 RCH
						OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
						  //CANCEL TRANSACTION
					End if 
				End if 
				AT_Initialize (->aChoicesApdo;->aRecNumApdo;->achoice1;->achoice2;->achoice3;->achoice4;->achoice5;->achoice6;->arecnum1;->arecnum2;->arecnum3;->arecnum4;->arecnum5;->arecnum6)
			End if 
		Else 
			
		End if 
		
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
		$page:=FORM Get current page:C276
		$vb_bool:=False:C215
		ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
		
	Else 
		$vb_setAreas:=True:C214
		ACTpgs_LimpiaVarsInterfaz ("ClearVars_Arrays";->$vb_setAreas)
		  //CANCEL TRANSACTION
	End if 
End if 
