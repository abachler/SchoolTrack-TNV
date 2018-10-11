C_LONGINT:C283($idUther)
C_BOOLEAN:C305($b_ultimoDia)
Case of 
	: (rCheques=1)
		If ((vtACT_BancoNombre="") | (vtACT_NoSerie="") | (vtACT_FechaDocumento="") | (vrACT_MontoAPagarApdo<=0))
			$GenerarDocs:=False:C215
			_O_DISABLE BUTTON:C193(bIngresarPago)
			IT_SetButtonState (False:C215;->bIngresarPago;->bImprimirLista)
		Else 
			$GenerarDocs:=True:C214
			IT_SetButtonState (True:C214;->bIngresarPago;->bImprimirLista)
		End if 
		AL_UpdateArrays (xALP_Documentar;0)
		modCargos:=False:C215
		If ($GenerarDocs)
			chequesGenerados:=True:C214
			AT_Initialize (->atACT_BancoNombre;->atACT_BancoCodigo;->atACT_Cuenta;->atACT_Titular;->atACT_RUTTitular;->atACT_Serie;->atACT_Fecha;->adACT_Fecha;->arACT_MontoCheque;->asACT_RUTTitular;->abACT_Modificados;->atACT_ObsDoc)
			ARRAY TEXT:C222(atACT_BancoNombre;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_BancoCodigo;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_Cuenta;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_Titular;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_RUTTitular;vlACT_Cuotas)
			_O_ARRAY STRING:C218(80;asACT_RUTTitular;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_Serie;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_Fecha;vlACT_Cuotas)
			ARRAY DATE:C224(adACT_Fecha;vlACT_Cuotas)
			ARRAY REAL:C219(arACT_MontoCheque;vlACT_Cuotas)
			ARRAY BOOLEAN:C223(abACT_Modificados;vlACT_Cuotas)
			ARRAY TEXT:C222(atACT_ObsDoc;vlACT_Cuotas)
			
			vbACT_DummyFalse:=False:C215
			AT_Populate (->abACT_Modificados;->vbACT_DummyFalse)
			
			atACT_BancoNombre{1}:=vtACT_BancoNombre
			atACT_BancoCodigo{1}:=vtACT_BancoID
			atACT_Cuenta{1}:=vtACT_BancoCuenta
			atACT_Titular{1}:=vtACT_BancoTitular
			atACT_RUTTitular{1}:=vtACT_BancoRUTTitular
			asACT_RUTTitular{1}:=vtACT_BancoRUTTitular
			atACT_Serie{1}:=vtACT_NoSerie
			atACT_Fecha{1}:=vtACT_FechaDocumento
			adACT_Fecha{1}:=vdACT_FechaDocumento
			
			If (vlACT_Cuotas>=2)
				If (vrACT_MontoPrimero=0)
					$MontoEntero:=Round:C94(vrACT_MontoAPagarApdo/vlACT_Cuotas;<>vlACT_Decimales)
					$Restante:=vrACT_MontoAPagarApdo-$MontoEntero
					arACT_MontoCheque{1}:=$MontoEntero
				Else 
					$MontoEntero:=Round:C94((vrACT_MontoAPagarApdo-vrACT_MontoPrimero)/(vlACT_Cuotas-1);0)
					$Restante:=vrACT_MontoAPagarApdo-vrACT_MontoPrimero
					arACT_MontoCheque{1}:=vrACT_MontoPrimero
					abACT_Modificados{1}:=True:C214
				End if 
				
				For ($i;2;vlACT_Cuotas-1)
					$Fecha:=Add to date:C393(vdACT_FechaDocumento;0;$i-1;0)
					atACT_BancoNombre{$i}:=vtACT_BancoNombre
					atACT_BancoCodigo{$i}:=vtACT_BancoID
					atACT_Cuenta{$i}:=vtACT_BancoCuenta
					atACT_Titular{$i}:=vtACT_BancoTitular
					atACT_RUTTitular{$i}:=vtACT_BancoRUTTitular
					asACT_RUTTitular{$i}:=vtACT_BancoRUTTitular
					atACT_Serie{$i}:=String:C10(Num:C11(vtACT_NoSerie)+$i-1)
					atACT_Fecha{$i}:=String:C10($Fecha;7)
					adACT_Fecha{$i}:=$Fecha
					arACT_MontoCheque{$i}:=$MontoEntero
					$Restante:=$Restante-$MontoEntero
				End for 
				
				$Fecha:=Add to date:C393(vdACT_FechaDocumento;0;vlACT_Cuotas-1;0)
				atACT_BancoNombre{vlACT_Cuotas}:=vtACT_BancoNombre
				atACT_BancoCodigo{vlACT_Cuotas}:=vtACT_BancoID
				atACT_Cuenta{vlACT_Cuotas}:=vtACT_BancoCuenta
				atACT_Titular{vlACT_Cuotas}:=vtACT_BancoTitular
				atACT_RUTTitular{vlACT_Cuotas}:=vtACT_BancoRUTTitular
				asACT_RUTTitular{vlACT_Cuotas}:=vtACT_BancoRUTTitular
				atACT_Serie{vlACT_Cuotas}:=String:C10(Num:C11(vtACT_NoSerie)+vlACT_Cuotas-1)
				atACT_Fecha{vlACT_Cuotas}:=String:C10($Fecha;1)
				adACT_Fecha{vlACT_Cuotas}:=$Fecha
				$Restante:=$Restante-$MontoEntero
				arACT_MontoCheque{vlACT_Cuotas}:=$MontoEntero+$Restante
				AL_UpdateArrays (xALP_Documentar;-2)
			Else 
				vrACT_MontoPrimero:=0
				arACT_MontoCheque{1}:=vrACT_MontoAPagarApdo
				AL_UpdateArrays (xALP_Documentar;-2)
			End if 
			
			$idUther:=IT_UThermometer (1;0;__ ("Buscando posibles documentos duplicados..."))
			ARRAY LONGINT:C221($Duplis;0)
			For ($k;1;vlACT_Cuotas)
				$Duplicados:=ACTdc_BuscaDuplicados (2;atACT_Serie{$k};atACT_Cuenta{$k};atACT_BancoCodigo{$k})
				If ($Duplicados>0)
					APPEND TO ARRAY:C911($Duplis;$k)
				End if 
			End for 
			If (Size of array:C274($Duplis)>0)
				CD_Dlog (0;__ ("Los cheques indicados en rojo presentan números de serie que ya existen para este banco y cuenta."))
				For ($i;1;Size of array:C274($Duplis))
					AL_SetRowColor (xALP_Documentar;$Duplis{$i};"Red";0;"";0)
				End for 
				AL_UpdateArrays (xALP_Documentar;-2)
			End if 
			IT_UThermometer (-2;$idUther)
			ARRAY LONGINT:C221($aFechaIncorrecta;0)
			For ($k;1;vlACT_Cuotas)
				If (adACT_Fecha{$k}-Current date:C33(*)<=-60)
					INSERT IN ARRAY:C227($aFechaIncorrecta;Size of array:C274($aFechaIncorrecta)+1;1)
					$aFechaIncorrecta{Size of array:C274($aFechaIncorrecta)}:=$k
				End if 
			End for 
			If (Size of array:C274($aFechaIncorrecta)>0)
				CD_Dlog (0;__ ("Los cheques indicados en azul presentan fechas que generarían cheques vencidos."))
				For ($i;1;Size of array:C274($aFechaIncorrecta))
					AL_SetRowColor (xALP_Documentar;$aFechaIncorrecta{$i};"Blue";0;"";0)
				End for 
				AL_UpdateArrays (xALP_Documentar;-2)
			End if 
		Else 
			If (vrACT_MontoAPagarApdo>0)
				CD_Dlog (0;__ ("Faltan datos del primer documento."))
			Else 
				CD_Dlog (0;__ ("No se pueden generar documentos ya que el monto a documentar es 0."))
			End if 
		End if 
	: (rLetras=1)
		$continuar:=True:C214
		If ((vlACT_LCFolio<=0) | (vdACT_LCFechaEDocumento=!00-00-00!) | (vdACT_LCFechaVDocumento=!00-00-00!) | (vrACT_MontoAPagarApdo<=0) | ((vrACT_LCMontoPrimero<=0) & (cs_CuotasIguales=0)))
			$continuar:=False:C215
			_O_DISABLE BUTTON:C193(bIngresarPago)
			IT_SetButtonState (False:C215;->bIngresarPago;->bImprimirLista)
		Else 
			$continuar:=True:C214
			IT_SetButtonState (True:C214;->bIngresarPago;->bImprimirLista)
		End if 
		If ($continuar)
			AL_UpdateArrays (xALP_DocumentarLC;0)
			AT_Initialize (->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
			AT_Initialize (->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
			ARRAY REAL:C219(ar_LCCuotas;0)
			If (vlACT_Cuotas=1)
				$montoADoc:=vrACT_MontoAPagarApdo
				INSERT IN ARRAY:C227(ar_LCCuotas;Size of array:C274(ar_LCCuotas)+1;1)
				ar_LCCuotas{Size of array:C274(ar_LCCuotas)}:=$montoADoc
			Else 
				INSERT IN ARRAY:C227(ar_LCCuotas;Size of array:C274(ar_LCCuotas)+1;1)
				If (cs_CuotasIguales=1)
					$montoCuotas:=Trunc:C95(vrACT_MontoAPagarApdo/vlACT_Cuotas;<>vlACT_Decimales)
					ar_LCCuotas{Size of array:C274(ar_LCCuotas)}:=$montoCuotas
				Else 
					ar_LCCuotas{Size of array:C274(ar_LCCuotas)}:=vrACT_LCMontoPrimero
					$montoADoc:=vrACT_MontoAPagarApdo-vrACT_LCMontoPrimero
					$montoCuotas:=Trunc:C95(($montoADoc/(vlACT_Cuotas-1));<>vlACT_Decimales)
				End if 
				For ($i;2;vlACT_Cuotas)
					INSERT IN ARRAY:C227(ar_LCCuotas;Size of array:C274(ar_LCCuotas)+1;1)
					ar_LCCuotas{Size of array:C274(ar_LCCuotas)}:=$montoCuotas
				End for 
				$sumaCuotas:=AT_GetSumArray (->ar_LCCuotas)
				$dif:=Round:C94(vrACT_MontoAPagarApdo-$sumaCuotas;<>vlACT_Decimales)
				If ($dif>0)
					If (<>vlACT_Decimales=0)
						$vr_minimo:=1
					Else 
						$vt_minimo:=ST_RigthChars (("0"*<>vlACT_Decimales)+"1";<>vlACT_Decimales)
						$vr_minimo:=Num:C11("0"+<>tXS_RS_DecimalSeparator+$vt_minimo)
					End if 
					For ($i;Size of array:C274(ar_LCCuotas);1;-1)
						If ($dif>0)
							ar_LCCuotas{$i}:=ar_LCCuotas{$i}+$vr_minimo
							$dif:=$dif-$vr_minimo
						End if 
					End for 
				End if 
			End if 
			
			AT_Insert (0;Size of array:C274(ar_LCCuotas);->arACT_LCFolio;->atACT_LCRut;->atACT_LCAceptante;->adACT_LCEmision;->adACT_LCVencimiento)
			AT_Insert (0;Size of array:C274(ar_LCCuotas);->arACT_LCMonto;->arACT_LCImpuesto;->abACT_LCModificados;->atACT_BancoCodigo;->atACT_ObsDoc)
			arACT_LCFolio{0}:=vlACT_LCFolio-1
			$fEmsion:=vdACT_LCFechaEDocumento
			AT_Populate (->atACT_LCRut;->vsACT_RUTApoderado)
			AT_Populate (->atACT_LCAceptante;->vsACT_NomApellido)
			AT_Populate (->adACT_LCEmision;->vdACT_LCFechaEDocumento)
			adACT_LCVencimiento{0}:=vdACT_LCFechaVDocumento
			$diaGeneracion:=Day of:C23(vdACT_LCFechaVDocumento)
			$year:=Year of:C25(vdACT_LCFechaVDocumento)
			For ($i;1;vlACT_Cuotas)
				arACT_LCFolio{$i}:=arACT_LCFolio{$i-1}+1
				If ($i=1)
					adACT_LCVencimiento{$i}:=vdACT_LCFechaVDocumento
					$date:=vdACT_LCFechaVDocumento
					$diaGeneracion:=Day of:C23(adACT_LCVencimiento{$i})
					$year:=Year of:C25(adACT_LCVencimiento{$i})
					
					  //20150825 RCH Problema cuando, por ejemplo, el primer documento tenía fecha 31-08-15
					$b_ultimoDia:=($diaGeneracion=DT_GetLastDay2 (vdACT_LCFechaVDocumento))
				Else 
					$month:=Month of:C24(adACT_LCVencimiento{$i-1})+1
					$year:=Year of:C25(adACT_LCVencimiento{$i-1})
					If ($month>12)
						$month:=1
						$year:=$year+1
					End if 
					If ($b_ultimoDia)  //20150825 RCH Problema cuando, por ejemplo, el primer documento tenía fecha 31-08-15
						$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year))
					Else 
						  //$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($diaGeneracion;$month;$year))
						If ($diaGeneracion>DT_GetLastDay ($month;$year))
							$date:=ACTut_fFechaValida (Add to date:C393($date;0;1;0))
						Else 
							$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($diaGeneracion;$month;$year))
						End if 
					End if 
					adACT_LCVencimiento{$i}:=$date
				End if 
				arACT_LCMonto{$i}:=ar_LCCuotas{$i}
				arACT_LCImpuesto{$i}:=ACTlc_CalculaImpuesto ($fEmsion;$date;arACT_LCMonto{$i})
				abACT_LCModificados{Size of array:C274(abACT_LCModificados)}:=True:C214
			End for 
			
			AL_UpdateArrays (xALP_DocumentarLC;-2)
			ARRAY LONGINT:C221($al_Duplis;0)
			For ($k;1;vlACT_Cuotas)
				$Duplicados:=ACTdc_BuscaDuplicados (5;String:C10(arACT_LCFolio{$k}))
				If ($Duplicados>0)
					APPEND TO ARRAY:C911($al_Duplis;$k)
				End if 
			End for 
			If (Size of array:C274($al_Duplis)>0)
				For ($i;1;Size of array:C274($al_Duplis))
					AL_SetRowColor (xALP_DocumentarLC;$al_Duplis{$i};"Red";0;"";0)
				End for 
				CD_Dlog (0;__ ("Los documentos indicados en rojo presentan números de serie que ya existen."))
			End if 
			AL_UpdateArrays (xALP_DocumentarLC;-1)
			
			ACTcfg_LoadConfigData (8)
			alACT_Proxima{vl_indexLC}:=arACT_LCFolio{Size of array:C274(arACT_LCFolio)}+1
			ACTcfg_SaveConfig (8)
			cambioLC:=False:C215
		Else 
			CD_Dlog (0;__ ("Faltan datos de la primera letra"))
		End if 
End case 
  //End if 