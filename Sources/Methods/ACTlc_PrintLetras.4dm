//%attributes = {}
  //ACTlc_PrintLetras

C_LONGINT:C283($table)
$Documentos:=$1  //set con los documentos a imprimir
$ID_Doc:=$2  //documento para la impresion

$PrintDocs:=True:C214
If (Not:C34(SYS_IsWindows ))
	$currPrinter:=Get current printer:C788
End if 
$index:=Find in array:C230(alACT_IDDT;$ID_Doc)
If ($index#-1)
	$WhereModelo:=Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})
	$WherePrinter:=Find in array:C230(atACT_Impresoras;atACT_Impresora{$index})
	If ($WherePrinter#-1)
		$Printer:=atACT_Impresoras{$WherePrinter}
	Else 
		If (Not:C34(SYS_IsWindows ))
			$Printer:=Get current printer:C788
		Else 
			$Printer:="la impresora por defecto"
		End if 
	End if 
	If ($WhereModelo#-1)
		$ModID:=alACT_ModelosDocID{$WhereModelo}
		$DocName:=atACT_NombreDoc{$index}
	Else 
		$PrintDocs:=False:C215
		CD_Dlog (0;__ ("No se encuentra el modelo de impresión de documentos tributarios. Revise la configuración e intente imprimir otra vez."))
	End if 
Else 
	$PrintDocs:=False:C215
End if 

If (Records in set:C195($Documentos)>0)
	If ($PrintDocs)
		C_TEXT:C284($Proxima)
		$Proxima:=atACTlc_Folio{1}
		
		$r:=CD_Dlog (0;__ ("Por favor haga clic en el botón Lista cuando la impresora esté lista para imprimir ")+$DocName+__ (".\r\rEl próximo documento a imprimir es el Nº ")+$Proxima+__ ("\r\rEl documento será impreso en ")+$Printer+__ (".");__ ("");__ ("Lista");__ ("Terminar sin imprimir"))
		If ($r=1)
			READ ONLY:C145([ACT_Documentos_de_Pago:176])
			USE SET:C118($Documentos)
			
			  //20120223 RCH No se estaba ordenando adecuadamente...
			  //ORDER BY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]NoSerie;>)
			ACTlc_OrdenaPorFolio 
			
			$Table:=Table:C252(->[ACT_Boletas:181])*-1
			QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
			QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=$ModID)
			
			$reportRecNum:=Record number:C243([xShell_Reports:54])
			
			READ ONLY:C145(*)
			GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
			$reportName:=[xShell_Reports:54]FormName:17
			$specialConfig:=[xShell_Reports:54]SpecialParameter:18
			$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
			$tablePointer:=Table:C252($tableNumber)
			yBWR_currentTable:=$tablePointer
			xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
			$RegXPagina:=[xShell_Reports:54]RegistrosXPagina:44
			If ($RegXPagina=0)
				$RegXPagina:=1
			End if 
			
			COPY NAMED SELECTION:C331([ACT_Documentos_de_Pago:176];"?Editions")
			If ((Not:C34(SYS_IsWindows )) & ($Printer#""))
				SET CURRENT PRINTER:C787($Printer)
			End if 
			If (Records in selection:C76([ACT_Documentos_de_Pago:176])>0)
				SRACTlc_InitiPrintingVariables 
				OK:=SR Page Setup (xSR_ReportBlob)
				If (OK=1)
					READ WRITE:C146([xShell_Reports:54])
					LOAD RECORD:C52([xShell_Reports:54])
					[xShell_Reports:54]xReportData_:29:=xSR_ReportBlob
					SAVE RECORD:C53([xShell_Reports:54])
					KRL_ReloadAsReadOnly (->[xShell_Reports:54])
				End if 
				<>stopExec:=False:C215
				If ((OK=1) & (Not:C34(<>stopExec)))
					ARRAY LONGINT:C221($aRecNumsLetras;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Pago:176];$aRecNumsLetras;"")
					$seleccionados:=Size of array:C274($aRecNumsLetras)
					$Loops:=Int:C8($seleccionados/$RegXPagina)
					$BloquesProcesados:=0
					$LinearIndex:=0
					CD_Msg ("";6)
					For ($i;1;$Loops)
						If (Not:C34(<>stopExec))
							sMess:="Imprimiendo documentos tributarios.\r\rCuantos de "+String:C10($seleccionados)+".\r\rNúmeros Total."
							$numDoc:=""
							For ($j;1;$RegXPagina)
								GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$aRecNumsLetras{$LinearIndex+$j})
								$numDoc:=$numDoc+", "+[ACT_Documentos_de_Pago:176]NoSerie:12
								SRACTlc_CargaDatos ($j)
							End for 
							$numDoc:=Substring:C12($numDoc;3)
							sMess:=Replace string:C233(sMess;"Cuantos";String:C10($LinearIndex+$RegXPagina))
							sMess:=Replace string:C233(sMess;"Total";$numDoc)
							DISPLAY RECORD:C105([xShell_Dialogs:114])
							GET AUTOMATIC RELATIONS:C899($one;$many)
							$err:=SR Print Report (xSR_ReportBlob;4;65535)
							SET AUTOMATIC RELATIONS:C310($one;$many)
							For ($j;1;$RegXPagina)
								SRACTlc_InitiPrintingVariables (3;$j)
							End for 
							$BloquesProcesados:=$BloquesProcesados+1
							$LinearIndex:=$LinearIndex+$RegXPagina
						End if 
						GOTO RECORD:C242([xShell_Reports:54];$reportRecNum)
						xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
					End for 
					$faltan:=$seleccionados-($BloquesProcesados*$RegXPagina)
					If ((Not:C34(<>stopExec)) & ($faltan>0))
						$arrayIndex:=Size of array:C274($aRecNumsLetras)-$faltan
						sMess:="Imprimiendo documentos tributarios.\r\rCuantos de "+String:C10($seleccionados)+".\r\rNúmero(s) Total."
						$numDoc:=""
						For ($i;1;$faltan)
							GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$aRecNumsLetras{$arrayIndex+$i})
							$numDoc:=$numDoc+", "+[ACT_Documentos_de_Pago:176]NoSerie:12
							SRACTlc_CargaDatos ($i)
						End for 
						$numDoc:=Substring:C12($numDoc;3)
						sMess:=Replace string:C233(sMess;"Cuantos";String:C10($faltan))
						sMess:=Replace string:C233(sMess;"Total";$numDoc)
						DISPLAY RECORD:C105([xShell_Dialogs:114])
						GET AUTOMATIC RELATIONS:C899($one;$many)
						$err:=SR Print Report (xSR_ReportBlob;4;65535)
						SET AUTOMATIC RELATIONS:C310($one;$many)
						For ($i;1;$faltan)
							SRACTlc_InitiPrintingVariables (3;$i)
						End for 
					End if 
					CLOSE WINDOW:C154
				End if 
			End if 
			If (Not:C34(SYS_IsWindows ))
				SET CURRENT PRINTER:C787($currPrinter)
			End if 
		End if 
	Else 
		$0:=False:C215
	End if 
End if 