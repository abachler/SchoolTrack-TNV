//%attributes = {}
  //ACTmnu_Boletas

If (USR_GetMethodAcces (Current method name:C684))
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;__ ("No es posible realizar la emisión de documentos tributarios en este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intente la emisión más tarde."))
	Else 
		C_TEXT:C284(vtACT_CurrentPrinter)
		C_BLOB:C604(xSR_ReportBlob;xs_ReportBlob)
		vtACT_CurrentPrinter:=""
		SET BLOB SIZE:C606(xSR_ReportBlob;0)
		SET BLOB SIZE:C606(xs_ReportBlob;0)
		
		If (SYS_IsWindows )
			$err:=sys_GetDefPrinter (vtACT_CurrentPrinter)
		End if 
		$sem:=Semaphore:C143("ProcesoACT")
		If ((Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181])) | (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182])))
			$currTable:=yBWR_CurrentTable
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTbol_Impresor";0;4;__ ("Impresión de Documentos Tributarios"))
			DIALOG:C40([xxSTR_Constants:1];"ACTbol_Impresor")
			CLOSE WINDOW:C154
			If (OK=1)
				Case of 
					: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
						ACTbol_MassivePrinting 
					Else 
						ACTlc_MassivePrinting 
				End case 
			End if 
			For ($i;1;Size of array:C274(aACT_Ptrs))
				Bash_Return_Variable (aACT_Ptrs{$i})
			End for 
			ACTcfg_OpcionesReimpBoletas ("InitAllVars")
			ARRAY POINTER:C280(aACT_Ptrs;0)
			cs_utilizaImpSel:=False:C215  //se utiliza paraimprimir en la impresora seleccionada en el form ACTbol_Impresor
			yBWR_CurrentTable:=$currTable
		Else 
			
			ACTbol_CargaDiasVencimiento   //20161007 RCH
			
			$go:=ACTbol_ValidaInicioEmision (1)
			If ($go)
				ARRAY TEXT:C222(atCategorias;0)
				ARRAY TEXT:C222(atDocumentos2Print;0)
				ARRAY LONGINT:C221(alHowMany;0)
				ARRAY LONGINT:C221(aDesdeDT;0)
				ARRAY LONGINT:C221(aHastaDT;0)
				ARRAY BOOLEAN:C223(abDoPrint;0)
				ARRAY PICTURE:C279(apDoPrint;0)
				ARRAY TEXT:C222(aSetsDT;0)
				ARRAY LONGINT:C221(alIDDT;0)
				vbACT_EmisionMasivaBoletas:=True:C214
				$currTable:=yBWR_CurrentTable
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_EmisionBoletas";0;4;__ ("Emisión de Documentos Tributarios"))
				DIALOG:C40([xxSTR_Constants:1];"ACTwiz_EmisionBoletas")
				CLOSE WINDOW:C154
				SET_ClearSets ("Selection1";"Selection2";"Selection3")
				SET_ClearSets ("Selection")
				AT_Initialize (->atCategorias;->atDocumentos2Print;->alHowMany;->aDesdeDT;->aHastaDT;->aSetsDT;->alIDDT)
				READ ONLY:C145([Personas:7])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				READ ONLY:C145([ACT_Transacciones:178])
				READ ONLY:C145([ACT_Boletas:181])
				yBWR_CurrentTable:=$currTable
				vbACT_EmisionMasivaBoletas:=False:C215
			Else 
				  //$msg:="La emisión de documentos tributarios no se puede realizar mientras no esté defini"+"da por completo una categoría de documentos tributarios."+◊cr+"Realice la configuración de categorías en Configuración/Documentos Tributarios."
				  //$msg:=$msg+◊cr+"Realice la configuración de categorías en Configuración/Documentos Tributarios."
				CD_Dlog (0;__ ("La emisión de documentos tributarios no se puede realizar mientras no esté definida por completo una categoría de documentos tributarios.\rRealice la configuración de categorías en Configuración/Documentos Tributarios."))
			End if 
		End if 
		If (vtACT_CurrentPrinter#"")
			If (SYS_IsWindows )
				$err:=sys_SetDefPrinter (vtACT_CurrentPrinter)
			End if 
		End if 
		ACTcfg_OpcionesRazonesSociales ("LoadConfig")
		CLEAR SEMAPHORE:C144("ProcesoACT")
	End if 
End if 