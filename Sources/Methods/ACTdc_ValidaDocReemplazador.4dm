//%attributes = {}
  //ACTdc_ValidaDocReemplazador

C_BOOLEAN:C305($0;$Reemplazar)
C_LONGINT:C283($vl_recNum)
$vl_recNum:=Record number:C243([ACT_Documentos_de_Pago:176])

Case of 
	: (vlACT_ReempPor=1)
		If ((vACT_BancoNombre="") | (vACT_Serie="") | (vACT_FechaDoc=!00-00-00!))
			CD_Dlog (0;__ ("Faltan datos del cheque."))
		Else 
			If (vACT_FechaDoc-Current date:C33(*)<=-60)
				$r:=CD_Dlog (0;__ ("La fecha ingresada generará un cheque vencido. ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
				If ($r=1)
					$Reemplazar:=True:C214
				Else 
					GOTO OBJECT:C206(vtACT_FechaDoc)
				End if 
			Else 
				$Reemplazar:=True:C214
			End if 
		End if 
		
	: (vlACT_ReempPor=2)
		If ((vrACT_MontoAPagarApdo>0) & (Size of array:C274(atACT_BancoNombre)>0))
			If (ACTcm_IsMonthOpenFromDate (vdACT_FechaPago))
				$Reemplazar:=ACTpgs_ValidaDocumentos (False:C215)
			Else 
				CD_Dlog (0;__ ("Los pagos no pueden ser registrados con esta fecha ya que corresponde a un mes cerrado."))
			End if 
		Else 
			CD_Dlog (0;__ ("Antes de ingresar el pago usted debe generar los documentos con la opción Generar Documentos."))
		End if 
		
	: (vlACT_ReempPor=(vl_indiceFormasDePago+1))
		If ((vACT_BancoNombre="") | (vACT_Serie="") | (vACT_FechaDoc=!00-00-00!))
			CD_Dlog (0;__ ("Faltan datos del cheque."))
		Else 
			C_LONGINT:C283($duplicados)
			$duplicados:=ACTdc_buscaDuplicados (2;vACT_Serie;vACT_Cuenta;vACT_BancoCodigo)
			
			If ($duplicados>0)
				CD_Dlog (0;__ ("Para este banco y esta cuenta ya existe un cheque con este número de serie."))
				GOTO OBJECT:C206(vACT_Serie)
			Else 
				If (vACT_FechaDoc-Current date:C33(*)<=-60)
					CD_Dlog (0;__ ("La fecha ingresada generaría un cheque vencido."))
					GOTO OBJECT:C206(vtACT_FechaDoc)
				Else 
					$Reemplazar:=True:C214
				End if 
			End if 
		End if 
		
	: (vlACT_ReempPor=(vl_indiceFormasDePago+4))
		C_REAL:C285(vrACT_LImpuesto)
		C_TEXT:C284(vtACT_LIndiceLetras)
		vrACT_LImpuesto:=0
		vtACT_LIndiceLetras:=""
		If ((vdACT_LFechaEmision=!00-00-00!) | (vdACT_LFechaVencimiento=!00-00-00!) | (vtACT_LTitular="") | (vtACT_LRUTTitular="") | (Num:C11(vtACT_LDocumento)=0))
			CD_Dlog (0;__ ("Complete todos los datos antes de ingresar el pago."))
		Else 
			vrACT_LImpuesto:=ACTlc_CalculaImpuesto (vdACT_LFechaEmision;vdACT_LFechaVencimiento;vrACT_MontoPago)
			vtACT_LIndiceLetras:="1;1"  //índice por defecto al ingrsar por caja
			$Duplicados:=ACTdc_buscaDuplicados (5;vtACT_LDocumento)
			If ($Duplicados>0)
				CD_Dlog (0;__ ("Ya existe un documento tipo ")+vsACT_FormasdePago+__ (" con este número de folio (")+vtACT_LDocumento+__ (")."))
			Else 
				ACTcfg_LoadConfigData (8)
				alACT_Proxima{vl_indexLC}:=Num:C11(vtACT_LDocumento)+1
				ACTcfg_SaveConfig (8)
				$Reemplazar:=True:C214
			End if 
		End if 
		
	Else 
		$Reemplazar:=True:C214
		
End case 
KRL_GotoRecord (->[ACT_Documentos_de_Pago:176];$vl_recNum)

$0:=$Reemplazar