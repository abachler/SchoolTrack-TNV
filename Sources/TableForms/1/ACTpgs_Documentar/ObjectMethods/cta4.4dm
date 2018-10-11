If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		FORM GOTO PAGE:C247(1)
		rLetras:=0
		rCheques:=1
		AL_UpdateArrays (xALP_DocumentarLC;0)
		AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
		AT_Initialize (->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
		AL_UpdateArrays (xALP_DocumentarLC;-2)
		  //RNApdo:=-1
		  //RNCta:=-1
		  //RNTercero:=-1
		ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
		If (vlACT_IdentificadorCta#1)
			vt_MsgCta:=""
			READ WRITE:C146([Personas:7])
			$table:=Table:C252(Table:C252(aPtrsCtas{vlACT_IdentificadorCta}))
			QUERY:C277($table->;aPtrsCtas{vlACT_IdentificadorCta}->=Self:C308->)
			If (Records in selection:C76($table->)>1)
				If (Table:C252($table)=Table:C252(->[ACT_CuentasCorrientes:175]))
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
				End if 
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aChoicesCta;[Alumnos:2]numero:1;aIDCta)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;2)
				<>aChoicePtrs{1}:=->aChoicesCta
				<>aChoicePtrs{2}:=->aIDCta
				TBL_ShowChoiceList (1;"Seleccione la Cuenta")
				If (ok=1)
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=aIDCta{choiceIdx})
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=aIDCta{choiceIdx})
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
					AL_UpdateArrays (xALP_Documentar;0)
					  //CANCEL TRANSACTION
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				Else 
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
				End if 
			Else 
				If (Records in selection:C76([Personas:7])=0)
					CD_Dlog (0;__ ("No se encuentran apoderados que cumplan con ese criterio."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
				Else 
					If (Table:C252($table)#Table:C252(->[ACT_CuentasCorrientes:175]))
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
					End if 
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
					AL_UpdateArrays (xALP_Documentar;0)
					  //CANCEL TRANSACTION
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				End if 
			End if 
		Else 
			READ WRITE:C146([Personas:7])
			ARRAY TEXT:C222(aIdentif;0)
			ARRAY TEXT:C222(achoice1;0)
			ARRAY TEXT:C222(achoice2;0)
			ARRAY TEXT:C222(achoice3;0)
			ARRAY TEXT:C222(achoice4;0)
			ARRAY TEXT:C222(achoice5;0)
			ARRAY LONGINT:C221(aIDCta1;0)
			ARRAY LONGINT:C221(aIDCta2;0)
			ARRAY LONGINT:C221(aIDCta3;0)
			ARRAY LONGINT:C221(aIDCta4;0)
			ARRAY LONGINT:C221(aIDCta5;0)
			ARRAY TEXT:C222(aChoicesCta;0)
			ARRAY LONGINT:C221(aIDsCtas;0)
			QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=Self:C308->)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;achoice1;[Alumnos:2]numero:1;aIDCta1)
			AT_Insert (0;Size of array:C274(achoice1);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice1)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesCtas{3}
			End for 
			QUERY:C277([Alumnos:2];[Alumnos:2]IDNacional_2:71=Self:C308->)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;achoice2;[Alumnos:2]numero:1;aIDCta2)
			AT_Insert (0;Size of array:C274(achoice2);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice2)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesCtas{4}
			End for 
			QUERY:C277([Alumnos:2];[Alumnos:2]IDNacional_3:70=Self:C308->)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;achoice3;[Alumnos:2]numero:1;aIDCta3)
			AT_Insert (0;Size of array:C274(achoice3);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice3)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesCtas{5}
			End for 
			QUERY:C277([Alumnos:2];[Alumnos:2]NoPasaporte:87=Self:C308->)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;achoice4;[Alumnos:2]numero:1;aIDCta4)
			AT_Insert (0;Size of array:C274(achoice4);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice4)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesCtas{7}
			End for 
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Codigo:19=Self:C308->)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;achoice5;[Alumnos:2]numero:1;aIDCta5)
			AT_Insert (0;Size of array:C274(achoice5);->aIdentif)
			For ($i;Size of array:C274(aIdentif);Size of array:C274(aIdentif)-Size of array:C274(achoice5)+1;-1)
				aIdentif{$i}:=at_IDNacional_NamesCtas{8}
			End for 
			For ($i;1;5)
				$arr1:=Get pointer:C304("achoice"+String:C10($i))
				$arr2:=Get pointer:C304("aIDCta"+String:C10($i))
				AT_Insert (0;Size of array:C274($arr1->);->aChoicesCta;->aIDsCtas)
				For ($j;1;Size of array:C274($arr1->))
					aChoicesCta{Size of array:C274(aChoicesCta)-Size of array:C274($arr1->)+$j}:=$arr1->{$j}
					aIDsCtas{Size of array:C274(aIDsCtas)-Size of array:C274($arr2->)+$j}:=$arr2->{$j}
				End for 
			End for 
			If (Size of array:C274(aIDsCtas)>1)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=->aChoicesCta
				<>aChoicePtrs{2}:=->aIdentif
				<>aChoicePtrs{3}:=->aIDsCtas
				TBL_ShowChoiceList (1;"Seleccione la Cuenta")
				If (ok=1)
					vt_MsgCta:="Encontrado en "+aIdentif{choiceIdx}
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=aIDsCtas{choiceIdx})
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=aIDsCtas{choiceIdx})
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
					AL_UpdateArrays (xALP_Documentar;0)
					  //CANCEL TRANSACTION
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				Else 
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
				End if 
			Else 
				If (Size of array:C274(aIDsCtas)=0)
					CD_Dlog (0;__ ("No se encuentran cuentas que cumplan con ese criterio en ningún identificador nacional."))
					IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
					ACTpgs_ClearDlogVars 
					  //CANCEL TRANSACTION
				Else 
					vt_MsgCta:="Encontrado en "+aIdentif{1}
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=aIDsCtas{1})
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=aIDsCtas{1})
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
					AL_UpdateArrays (xALP_Documentar;0)
					  //CANCEL TRANSACTION
					RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
					ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
					ACTpgs_DocumentarInit 
					AL_UpdateArrays (xALP_Documentar;-2)
				End if 
			End if 
			AT_Initialize (->achoice1;->achoice2;->achoice3;->achoice4;->achoice5;->aIDCta1;->aIDCta2;->aIDCta3;->aIDCta4;->aIDCta5;->aChoicesCta;->aIDsCtas)
		End if 
		For ($i;1;Size of array:C274(abACT_ASelectedAvisos))  //para seleccionar a pagar todos los avisos
			abACT_ASelectedAvisos{$i}:=True:C214
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ASelectedAvisos{$i})
		End for 
		  //20110923 RCH Se agrega linea para marcar todos los cargos...
		ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar")
		ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
	Else 
		IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
		ACTpgs_ClearDlogVars 
		  //CANCEL TRANSACTION
	End if 
End if 
BRING TO FRONT:C326(Current process:C322)