//%attributes = {}
  //xALP_CB_ACT_DocumentarLC

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

$0:=True:C214
AL_GetCurrCell (xALP_DocumentarLC;vCol;vRow)
If (AL_GetCellMod (xALP_DocumentarLC)=1)
	Case of 
		: (vCol=1)
			$Duplicados:=ACTdc_buscaDuplicados (5;String:C10(arACT_LCFolio{vRow}))
			If ($Duplicados>0)
				CD_Dlog (0;__ ("Ya existe una letra con este número de serie. Se mantendrá el valor anterior."))
				arACT_LCFolio{vRow}:=OldFolio
				AL_UpdateArrays (xALP_DocumentarLC;-2)
			Else 
				ARRAY LONGINT:C221(Duplis;0)
				arACT_LCFolio{0}:=arACT_LCFolio{vRow}
				AT_SearchArray (->arACT_LCFolio;"=";->Duplis)
				If (Size of array:C274(Duplis)<2)
					AL_SetRowColor (xALP_DocumentarLC;vRow;"";0;"White";0)
					AL_UpdateArrays (xALP_DocumentarLC;-2)
				Else 
					CD_Dlog (0;__ ("Este número de folio ya está en la lista de documentos a generar. Se mantendrá el número anterior."))
					arACT_LCFolio{vRow}:=OldFolio
				End if 
				ARRAY LONGINT:C221(Duplis;0)
			End if 
			If (arACT_LCFolio{vRow}<vlACT_LCFolio)
				arACT_LCFolio{vRow}:=OldFolio
				BEEP:C151
			End if 
		: (vCol=5)
			$strDate:=String:C10(adACT_LCVencimiento{vRow};7)
			$strDate:=DT_StrDateIsOK ($strDate)
			$date:=Date:C102($strDate)
			If ($date#!00-00-00!)
				adACT_LCVencimiento{vRow}:=$date
			Else 
				adACT_LCVencimiento{vRow}:=OldFVencimiento
			End if 
			
			If (adACT_LCVencimiento{vRow}<adACT_LCEmision{vRow})
				adACT_LCVencimiento{vRow}:=OldFVencimiento
				BEEP:C151
			End if 
			
			Case of 
				: (Size of array:C274(arACT_LCFolio)=1)
				: (Size of array:C274(arACT_LCFolio)=2)
					If (adACT_LCVencimiento{1}>adACT_LCVencimiento{2})
						adACT_LCVencimiento{vRow}:=OldFVencimiento
						BEEP:C151
					End if 
				: (Size of array:C274(arACT_LCFolio)=vRow)
					If (adACT_LCVencimiento{vRow}<adACT_LCVencimiento{vRow-1})
						adACT_LCVencimiento{vRow}:=OldFVencimiento
						BEEP:C151
					End if 
				: (Size of array:C274(arACT_LCFolio)>2)
					If (adACT_LCVencimiento{vRow}>adACT_LCVencimiento{vRow+1})
						adACT_LCVencimiento{vRow}:=OldFVencimiento
						BEEP:C151
					End if 
					If (vRow>1)
						If (adACT_LCVencimiento{vRow}<adACT_LCVencimiento{vRow-1})
							adACT_LCVencimiento{vRow}:=OldFVencimiento
							BEEP:C151
						End if 
					End if 
			End case 
		: (vCol=6)
			
			$Arruga:=False:C215
			If ((arACT_LCMonto{vRow}#OldMonto) & (arACT_LCMonto{vRow}>0))
				abACT_LCModificados{vRow}:=True:C214
				If (vRow#Size of array:C274(arACT_LCMonto))
					$Cuotas:=0
					$MontoMod:=0
					For ($p;1;Size of array:C274(arACT_LCMonto))
						If (abACT_LCModificados{$p}=False:C215)
							$Cuotas:=$Cuotas+1
						Else 
							$MontoMod:=$MontoMod+arACT_LCMonto{$p}
						End if 
					End for 
					If ($Cuotas>0)
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-$MontoMod)/$Cuotas;<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo
					Else 
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo)/vlACT_Cuotas-1;<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo
						vbACT_DummyFalse:=False:C215
						AT_Populate (->abACT_LCModificados;->vbACT_DummyFalse)
					End if 
					
					For ($i;1;Size of array:C274(arACT_LCMonto)-1)
						If (abACT_LCModificados{$i}=False:C215)
							arACT_LCMonto{$i}:=$MontoEntero
							$Restante:=$Restante-$MontoEntero
							If (arACT_LCMonto{$i}<=0)
								$Arruga:=True:C214
							End if 
						Else 
							$Restante:=$Restante-arACT_LCMonto{$i}
						End if 
					End for 
					
					If (abACT_LCModificados{Size of array:C274(abACT_LCModificados)}=True:C214)
						$Restante:=$Restante-arACT_LCMonto{Size of array:C274(arACT_LCMonto)}
						arACT_LCMonto{Size of array:C274(arACT_LCMonto)-1}:=$MontoEntero+$Restante
						If (arACT_LCMonto{Size of array:C274(arACT_LCMonto)-1}<=0)
							$Arruga:=True:C214
						End if 
					Else 
						$Restante:=$Restante-$MontoEntero
						arACT_LCMonto{Size of array:C274(arACT_LCMonto)}:=$MontoEntero+$Restante
						If (arACT_LCMonto{Size of array:C274(arACT_LCMonto)}<=0)
							$Arruga:=True:C214
						End if 
					End if 
					AL_UpdateArrays (xALP_DocumentarLC;-2)
				Else 
					$Cuotas:=0
					$MontoMod:=0
					
					For ($p;1;Size of array:C274(arACT_LCMonto))
						If (abACT_LCModificados{$p}=False:C215)
							$Cuotas:=$Cuotas+1
						Else 
							$MontoMod:=$MontoMod+arACT_LCMonto{$p}
						End if 
					End for 
					If ($Cuotas>0)
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-$MontoMod)/$Cuotas;<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo-$MontoEntero
						$hasta:=Size of array:C274(arACT_LCMonto)-2
					Else 
						$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-arACT_LCMonto{Size of array:C274(arACT_LCMonto)})/(vlACT_Cuotas-1);<>vlACT_Decimales)
						$Restante:=vrACT_MontoAPagarApdo
						vbACT_DummyFalse:=False:C215
						AT_Populate (->abACT_LCModificados;->vbACT_DummyFalse)
						abACT_LCModificados{Size of array:C274(abACT_LCModificados)}:=True:C214
						$hasta:=Size of array:C274(arACT_LCMonto)-1
					End if 
					
					For ($i;1;$hasta)
						If (abACT_LCModificados{$i}=False:C215)
							arACT_LCMonto{$i}:=$MontoEntero
							$Restante:=$Restante-$MontoEntero
							If (arACT_LCMonto{$i}<=0)
								$Arruga:=True:C214
							End if 
						Else 
							$Restante:=$Restante-arACT_LCMonto{$i}
						End if 
					End for 
					$Restante:=$Restante-arACT_LCMonto{Size of array:C274(arACT_LCMonto)}
					arACT_LCMonto{Size of array:C274(arACT_LCMonto)-1}:=$MontoEntero+$Restante
					If (arACT_LCMonto{Size of array:C274(arACT_LCMonto)-1}<=0)
						$Arruga:=True:C214
					End if 
					AL_UpdateArrays (xALP_DocumentarLC;-2)
				End if 
			Else 
				abACT_LCModificados{vRow}:=False:C215
				If (arACT_LCMonto{vRow}<=0)
					CD_Dlog (0;__ ("No se pueden ingresar valores negativos o cero para un documento. Se mantendrá el valor anterior."))
					arACT_LCMonto{vRow}:=OldMonto
					AL_UpdateArrays (xALP_DocumentarLC;-2)
				End if 
			End if 
			If ($Arruga)
				AL_UpdateArrays (xALP_DocumentarLC;0)
				CD_Dlog (0;__ ("El valor ingresado produciría documentos de valor cero o negativo. Se mantendrá el valor anterior."))
				For ($t;1;Size of array:C274(arACT_LCMonto))
					arACT_LCMonto{$t}:=arACT_LCMontosTemp{$t}
					abACT_LCModificados{$t}:=abACT_LCTempModificados{$t}
				End for 
				AL_UpdateArrays (xALP_DocumentarLC;Size of array:C274(arACT_LCMonto))
			End if 
	End case 
	For ($i;1;Size of array:C274(arACT_LCFolio))
		arACT_LCImpuesto{$i}:=ACTlc_CalculaImpuesto (adACT_LCEmision{$i};adACT_LCVencimiento{$i};arACT_LCMonto{$i})
	End for 
End if 