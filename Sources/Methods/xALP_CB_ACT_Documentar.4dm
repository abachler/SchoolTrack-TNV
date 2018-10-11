//%attributes = {}
  //xALP_CB_ACT_Documentar

C_BOOLEAN:C305($0)
C_LONGINT:C283($Duplicados)
C_LONGINT:C283($1;$2;$3)

$0:=True:C214
AL_GetCurrCell (xALP_Documentar;vCol;vRow)
If (AL_GetCellMod (xALP_Documentar)=1)
	Case of 
		: (vCol=6)
			$Arruga:=False:C215
			If ((arACT_MontoCheque{vRow}#OldMonto_Cheque) & (arACT_MontoCheque{vRow}>0))
				abACT_Modificados{vRow}:=True:C214
				If (vRow#Size of array:C274(arACT_MontoCheque))
					$Cuotas:=0
					$MontoMod:=0
					For ($p;1;Size of array:C274(arACT_Montocheque))
						If (abACT_Modificados{$p}=False:C215)
							$Cuotas:=$Cuotas+1
						Else 
							$MontoMod:=$MontoMod+arACT_Montocheque{$p}
						End if 
					End for 
					If ($Cuotas>0)
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-$MontoMod)/$Cuotas;<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo
					Else 
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo)/vlACT_Cuotas-1;<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo
						vbACT_DummyFalse:=False:C215
						AT_Populate (->abACT_Modificados;->vbACT_DummyFalse)
					End if 
					For ($i;1;Size of array:C274(arACT_MontoCheque)-1)
						If (abACT_Modificados{$i}=False:C215)
							arACT_MontoCheque{$i}:=$MontoEntero
							$Restante:=$Restante-$MontoEntero
							If (arACT_MontoCheque{$i}<=0)
								$Arruga:=True:C214
							End if 
						Else 
							$Restante:=$Restante-arACT_MontoCheque{$i}
						End if 
					End for 
					If (abACT_Modificados{Size of array:C274(abACT_Modificados)}=True:C214)
						$Restante:=$Restante-arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)}
						arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)-1}:=$MontoEntero+$Restante
						If (arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)-1}<=0)
							$Arruga:=True:C214
						End if 
					Else 
						$Restante:=$Restante-$MontoEntero
						arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)}:=$MontoEntero+$Restante
						If (arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)}<=0)
							$Arruga:=True:C214
						End if 
					End if 
					AL_UpdateArrays (xALP_Documentar;-2)
				Else 
					$Cuotas:=0
					$MontoMod:=0
					For ($p;1;Size of array:C274(arACT_Montocheque))
						If (abACT_Modificados{$p}=False:C215)
							$Cuotas:=$Cuotas+1
						Else 
							$MontoMod:=$MontoMod+arACT_Montocheque{$p}
						End if 
					End for 
					If ($Cuotas>0)
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-$MontoMod)/$Cuotas;<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo-$MontoEntero
						$hasta:=Size of array:C274(arACT_MontoCheque)-2
					Else 
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)})/(vlACT_Cuotas-1);<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo
						vbACT_DummyFalse:=False:C215
						AT_Populate (->abACT_Modificados;->vbACT_DummyFalse)
						abACT_Modificados{Size of array:C274(abACT_Modificados)}:=True:C214
						$hasta:=Size of array:C274(arACT_MontoCheque)-1
					End if 
					For ($i;1;$hasta)
						If (abACT_Modificados{$i}=False:C215)
							arACT_MontoCheque{$i}:=$MontoEntero
							$Restante:=$Restante-$MontoEntero
							If (arACT_MontoCheque{$i}<=0)
								$Arruga:=True:C214
							End if 
						Else 
							$Restante:=$Restante-arACT_MontoCheque{$i}
						End if 
					End for 
					$Restante:=$Restante-arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)}
					arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)-1}:=$MontoEntero+$Restante
					If (arACT_MontoCheque{Size of array:C274(arACT_MontoCheque)-1}<=0)
						$Arruga:=True:C214
					End if 
					AL_UpdateArrays (xALP_Documentar;-2)
				End if 
			Else 
				abACT_Modificados{vRow}:=False:C215
				If (arACT_MontoCheque{vRow}<=0)
					CD_Dlog (0;__ ("No se pueden ingresar valores negativos o cero para un documento. Se mantendrá el valor anterior."))
					arACT_MontoCheque{vRow}:=OldMonto_Cheque
					AL_UpdateArrays (xALP_Documentar;-2)
				End if 
			End if 
			If ($Arruga)
				AL_UpdateArrays (xALP_Documentar;0)
				CD_Dlog (0;__ ("El valor ingresado produciría documentos de valor cero o negativo. Se mantendrá el valor anterior."))
				For ($t;1;Size of array:C274(arACT_MontoCheque))
					arACT_MontoCheque{$t}:=arACT_TempMontos{$t}
					abACT_Modificados{$t}:=abACT_TempModificados{$t}
				End for 
				AL_UpdateArrays (xALP_Documentar;Size of array:C274(arACT_MontoCheque))
			End if 
			
		: (vCol=1)
			$InID:=Find in array:C230(atACT_BankID;atACT_BancoNombre{vRow})
			If ($InID#-1)
				atACT_BancoCodigo{vRow}:=atACT_BankID{$InID}
				atACT_BancoNombre{vRow}:=atACT_BankName{$InID}
			Else 
				$foundBank:=Find in array:C230(atACT_BankName;atACT_BancoNombre{vRow})
				If ($foundBank#-1)
					atACT_BancoCodigo{vRow}:=atACT_BankID{$foundBank}
					atACT_BancoNombre{vRow}:=atACT_BankName{$foundBank}
				Else 
					atACT_BankName{0}:=atACT_BancoNombre{vRow}
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->atACT_BankName;"@";->$DA_Return)
					If (Size of array:C274($DA_Return)>0)
						ARRAY TEXT:C222(atXS_Choices;Size of array:C274($DA_Return))
						ARRAY LONGINT:C221(alXS_ChoicesRef;Size of array:C274($DA_Return))
						For ($y;1;Size of array:C274($DA_Return))
							atXS_Choices{$y}:=atACT_BankName{$DA_Return{$y}}
							alXS_ChoicesRef{$y}:=$y
						End for 
						ARRAY POINTER:C280(<>aChoicePtrs;1)
						<>aChoicePtrs{1}:=->atXS_Choices
						TBL_ShowChoiceList (0;__ ("Selección de Banco");1)
						If (choiceidx#0)
							$selectedBankName:=atXS_Choices{choiceidx}
						Else 
							$selectedBankName:=""
						End if 
						AT_Initialize (->$DA_Return;->atXS_Choices;->alXS_ChoicesRef)
					Else 
						$selectedBankName:=""
					End if 
					If ($selectedBankName#"")
						atACT_BancoNombre{vRow}:=$selectedBankName
						atACT_BancoCodigo{vRow}:=atACT_BankID{Find in array:C230(atACT_BankName;atACT_BancoNombre{vRow})}
					Else 
						atACT_BancoNombre{vRow}:=OldBancoNombre
						atACT_BancoCodigo{vRow}:=OldBancoCodigo
						CD_Dlog (0;__ ("No se encontró un banco. Se mantendrá el valor anterior."))
					End if 
				End if 
			End if 
			$Duplicados:=ACTdc_buscaDuplicados (2;atACT_Serie{vRow};atACT_Cuenta{vRow};atACT_BancoCodigo{vRow})
			If ($Duplicados>0)
				atACT_BancoNombre{vRow}:=OldBancoNombre
				atACT_BancoCodigo{vRow}:=OldBancoCodigo
				CD_Dlog (0;__ ("Para este banco y serie ya existe un cheque con este número de cuenta. Se mantendrá el valor anterior."))
			Else 
				AL_SetRowColor (xALP_Documentar;vRow;"Black";0;"";0)
			End if 
			AL_UpdateArrays (xALP_Documentar;-2)
		: (vCol=4)
			  //SET QUERY DESTINATION(Into variable ;$Duplicados)
			  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]Ch_BancoCodigo=atACT_BancoCodigo{vRow};*)
			  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Ch_Cuenta=atACT_Cuenta{vRow};*)
			  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]NoSerie=atACT_Serie{vRow})
			  //SET QUERY DESTINATION(Into current selection )
			
			$Duplicados:=ACTdc_buscaDuplicados (2;atACT_Serie{vRow};atACT_Cuenta{vRow};atACT_BancoCodigo{vRow})
			
			If ($Duplicados>0)
				CD_Dlog (0;__ ("Para este banco y cuenta ya existe un cheque con este número de serie. Se mantendrá el valor anterior."))
				atACT_Serie{vRow}:=OldNoSerie
				AL_UpdateArrays (xALP_Documentar;-2)
			Else 
				ARRAY LONGINT:C221(Duplis;0)
				atACT_Serie{0}:=atACT_Serie{vRow}
				AT_SearchArray (->atACT_Serie;"=";->Duplis)
				If (Size of array:C274(Duplis)<2)
					AL_SetRowColor (xALP_Documentar;vRow;"Black";0;"White";0)
					AL_UpdateArrays (xALP_Documentar;-2)
				Else 
					CD_Dlog (0;__ ("Este número de serie ya está en la lista de documentos a generar. Se mantendrá el número anterior."))
					atACT_Serie{vRow}:=OldNoSerie
				End if 
				ARRAY LONGINT:C221(Duplis;0)
			End if 
		: (vCol=5)
			$strDate:=String:C10(adACT_Fecha{vRow};7)
			$strDate:=DT_StrDateIsOK ($strDate)
			$date:=Date:C102($strDate)
			If ($date#!00-00-00!)
				adACT_Fecha{vRow}:=$date
			Else 
				adACT_Fecha{vRow}:=OldFecha
			End if 
		: (vCol=2)
			$Duplicados:=ACTdc_buscaDuplicados (2;atACT_Serie{vRow};atACT_Cuenta{vRow};atACT_BancoCodigo{vRow})
			If ($Duplicados>0)
				CD_Dlog (0;__ ("Para este banco y serie ya existe un cheque con este número de cuenta. Se mantendrá el valor anterior."))
				atACT_Cuenta{vRow}:=OldCuenta
			Else 
				AL_SetRowColor (xALP_Documentar;vRow;"Black";0;"";0)
			End if 
			AL_UpdateArrays (xALP_Documentar;-2)
	End case 
End if 
