If ((cb_soloCuotasVencidas=1) & (Self:C308->>vrACT_MontoAPagar))
	BEEP:C151
Else 
	If (vrACT_MontoPago>0) | (Shift down:C543)
		C_TEXT:C284(vt_noserieLetra2Print)
		C_LONGINT:C283(vl_indiceConfLetras;$Duplicados)
		C_TEXT:C284($vtACTpgs_TextAjuste)
		vt_noserieLetra2Print:=""
		vl_indiceConfLetras:=0
		$continuar:=True:C214
		  //vForma:=FORM Get current page
		vForma:=vlACT_FormasdePago
		Case of 
			: (vForma=-8)
				C_REAL:C285(vrACT_LImpuesto)
				C_TEXT:C284(vtACT_LIndiceLetras)
				vrACT_LImpuesto:=0
				vtACT_LIndiceLetras:=""
				If ((vdACT_LFechaEmision=!00-00-00!) | (vdACT_LFechaVencimiento=!00-00-00!) | (vtACT_LTitular="") | (vtACT_LRUTTitular="") | (Num:C11(vtACT_LDocumento)=0))
					$continuar:=False:C215
					CD_Dlog (0;__ ("Esta forma de pago debe tener fecha emisión, fecha vencimiento, nombre apoderado,rut apoderado y número de documento. Por favor complete los datos."))
				Else 
					vrACT_LImpuesto:=ACTlc_CalculaImpuesto (vdACT_LFechaEmision;vdACT_LFechaVencimiento;vrACT_MontoPago)
					vtACT_LIndiceLetras:="1;1"  //índice por defecto al ingrsar por caja
					$Duplicados:=ACTdc_BuscaDuplicados (5;vtACT_LDocumento)
					If ($Duplicados>0)
						$continuar:=False:C215
						CD_Dlog (0;__ ("Ya existe un documento tipo ")+vsACT_FormasdePago+__ (" con este número de folio (")+vtACT_LDocumento+__ (")."))
					Else 
						vt_noserieLetra2Print:=vtACT_LDocumento
						vl_indiceConfLetras:=vl_indexLC
						ACTcfg_LoadConfigData (8)
						alACT_Proxima{vl_indexLC}:=Num:C11(vtACT_LDocumento)+1
						ACTcfg_SaveConfig (8)
					End if 
				End if 
			: (vForma=-4)
				If ((vtACT_NoSerie#"") & (vtACT_BancoCuenta#"") & (vtACT_BancoID#"") & (vdACT_FechaDocumento#!00-00-00!))
					$Duplicados:=ACTdc_BuscaDuplicados (2;vtACT_NoSerie;vtACT_BancoCuenta;vtACT_BancoID)
					If ($Duplicados>0)
						$continuar:=False:C215
						CD_Dlog (0;__ ("Ya existe un documento tipo ")+vsACT_FormasdePago+__ (" con estos datos. El pago no puede ser ingresado."))
					End if 
					vtACT_BancoCodigo:=vtACT_BancoID
				Else 
					$continuar:=False:C215
					CD_Dlog (0;__ ("Faltan datos para el documento tipo ")+vsACT_FormasdePago+__ (". Por favor complete los datos."))
				End if 
			: (vForma=-6)
				If (vtACT_TCDocumento="")
					$continuar:=False:C215
					CD_Dlog (0;__ ("Faltan datos para la forma de pago ")+vsACT_FormasdePago+__ (". Por favor complete los datos."))
				End if 
				
			: (vForma=-7)
				If (vtACT_RDocumento="")
					$continuar:=False:C215
					CD_Dlog (0;__ ("Faltan datos para la forma de pago ")+vsACT_FormasdePago+__ (". Por favor complete los datos."))
				End if 
		End case 
		If ($continuar)
			If (vrACTpgs_MontoAjuste#0)
				$vtACTpgs_TextAjuste:=", con un "
				If (vrACTpgs_MontoAjuste>0)
					$vtACTpgs_TextAjuste:=$vtACTpgs_TextAjuste+"cargo"
				Else 
					$vtACTpgs_TextAjuste:=$vtACTpgs_TextAjuste+"descuento"
				End if 
				$vtACTpgs_TextAjuste:=$vtACTpgs_TextAjuste+" por ajuste de "+String:C10(Abs:C99(vrACTpgs_MontoAjuste))
			End if 
			$format:="|Despliegue_ACT_Pagos"
			If (cbMultaXCaja=1)
				If (crPermitirRecargoItem=1) & (vrACT_MontoRecargo>0)
					$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar un pago de ")+String:C10(vrACT_MontoPago;$format)+__ (" para pagar una deuda de ")+String:C10(vrACT_MontoSeleccionado;$format)+__ ("  con una multa de ")+String:C10(vrACT_MontoMulta;$format)+("  y un recargo en la forma de pago de ")+String:C10(vrACT_MontoRecargo;$format)+__ (" usando ")+vsACT_FormasdePago+$vtACTpgs_TextAjuste+__ ("?");__ ("");__ ("Si");__ ("No"))
				Else 
					$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar un pago de ")+String:C10(vrACT_MontoPago;$format)+__ (" para pagar una deuda de ")+String:C10(vrACT_MontoSeleccionado;$format)+__ (" y una multa de ")+String:C10(vrACT_MontoMulta;$format)+__ (" usando ")+vsACT_FormasdePago+$vtACTpgs_TextAjuste+__ ("?");__ ("");__ ("Si");__ ("No"))
				End if 
			Else 
				$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar un pago de ")+String:C10(vrACT_MontoPago;$format)+__ (" usando ")+vsACT_FormasdePago+$vtACTpgs_TextAjuste+__ ("?");__ ("");__ ("Si");__ ("No"))
			End if 
			If ($r=1)
				ACTcfg_OpcionesRecargosCaja ("GeneraMultaXCaja")
				ACTcfgmyt_OpcionesGenerales ("GeneraCargoDcto")
				ACCEPT:C269
			End if 
		End if 
	Else 
		BEEP:C151
	End if 
End if 