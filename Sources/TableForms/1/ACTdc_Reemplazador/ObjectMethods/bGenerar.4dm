C_LONGINT:C283($idUther)

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
				$Duplicados:=ACTdc_buscaDuplicados (2;atACT_Serie{$k};atACT_Cuenta{$k};atACT_BancoCodigo{$k})
				If ($Duplicados>0)
					APPEND TO ARRAY:C911($Duplis;$k)
				End if 
			End for 
			IT_UThermometer (-2;$idUther)
			If (Size of array:C274($Duplis)>0)
				CD_Dlog (0;__ ("Los cheques indicados en rojo presentan números de serie que ya existen para este banco y cuenta."))
				For ($i;1;Size of array:C274($Duplis))
					AL_SetRowColor (xALP_Documentar;$Duplis{$i};"Red";0;"";0)
				End for 
				AL_UpdateArrays (xALP_Documentar;-2)
			End if 
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
End case 
  //End if 