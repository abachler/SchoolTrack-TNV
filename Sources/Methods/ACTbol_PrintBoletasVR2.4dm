//%attributes = {}
  //ACTbol_PrintBoletasVR2

C_LONGINT:C283($table)
C_BOOLEAN:C305($Afectas;$1)

$Afectas:=$1  //True para indicar que el set en $2 es de documentos afectos. Siempre false para recibos
$Documentos:=$2  //Set con los documentos a imprimir

$PrintDocs:=True:C214  //Lo pondremos a false si algo impide la impresión (no exixtencia de modelo)
$currPrinter:=Get current printer:C788
$Printer:=$currPrinter
$PrintRecibo:=False:C215
$FailMsg:=""
$ReciboMsg:=""
$MassivePrinting:=False:C215
$0:=True:C214

If (Records in set:C195($Documentos)>0)
	ACTcfg_LoadConfigData (8)
	If (cbImprimirBoletas=1)
		$DocCat:=vlACT_CatVR
		$ExisteCat:=Find in array:C230(alACT_IDsCats;$DocCat)
		If (($DocCat=0) | ($ExisteCat=-1))
			$CatPorDefecto:=Find in array:C230(abACT_PorDefecto;True:C214)
			If ($CatPorDefecto#-1)
				$DocCat:=alACT_IDsCats{$CatPorDefecto}
				$NombreCat:=atACT_Categorías{Find in array:C230(alACT_IDsCats;$DocCat)}
			Else 
				$PrintDocs:=False:C215
				$ReciboMsg:="La Venta Rápida no tiene definida una categoría de documentos tributarios. Tampoc"+"o h"+"ay una categoría definida por defecto."+"\r"
				$ReciboMsg:=$ReciboMsg+"Corrija esta situación en Configuración/Documentos Tributarios."+"\r\r"
				$ReciboMsg:=$ReciboMsg+"Un recibo será impreso como comprobante de pago."
				$PrintRecibo:=True:C214
			End if 
		Else 
			$NombreCat:=atACT_Categorías{$ExisteCat}
		End if 
		If ($PrintDocs)
			alACT_IDCat{0}:=$DocCat
			AT_SearchArray (->alACT_IDCat;"=")
			ARRAY TEXT:C222(atACT_DocsAfectos;0)
			ARRAY LONGINT:C221(alACT_DocsAfectosIDs;0)
			If (Size of array:C274(DA_Return)>0)
				If ($Afectas)
					For ($i;1;Size of array:C274(DA_Return))
						If (abACT_Afecta{DA_Return{$i}})
							AT_Insert (0;1;->atACT_DocsAfectos;->alACT_DocsAfectosIDs)
							atACT_DocsAfectos{Size of array:C274(atACT_DocsAfectos)}:=atACT_NombreDoc{DA_Return{$i}}
							alACT_DocsAfectosIDs{Size of array:C274(alACT_DocsAfectosIDs)}:=alACT_IDDT{DA_Return{$i}}
						End if 
					End for 
				Else 
					For ($i;1;Size of array:C274(DA_Return))
						If (Not:C34(abACT_Afecta{DA_Return{$i}}))
							AT_Insert (0;1;->atACT_DocsAfectos;->alACT_DocsAfectosIDs)
							atACT_DocsAfectos{Size of array:C274(atACT_DocsAfectos)}:=atACT_NombreDoc{DA_Return{$i}}
							alACT_DocsAfectosIDs{Size of array:C274(alACT_DocsAfectosIDs)}:=alACT_IDDT{DA_Return{$i}}
						End if 
					End for 
				End if 
			Else 
				$PrintDocs:=False:C215
				$ReciboMsg:="No existen definiciones de documentos para la categoría "+$NombreCat+". Defina documentos en C"+"onfiguración/Documentos Tributarios."+"\r\r"
				$ReciboMsg:=$ReciboMsg+"Un recibo será impreso como comprobante de pago."
				$PrintRecibo:=True:C214
			End if 
			ACTcfg_LoadPrinters 
			If (Not:C34($PrintRecibo))
				If (Size of array:C274(atACT_DocsAfectos)>1)
					vlACT_DocID:=0
					If ($Afectas)
						vtMsgText:="Las siguientes definiciones afectas están disponibles para la categoría "+$NombreCat+". Por favor seleccione una."
					Else 
						vtMsgText:="Las siguientes definiciones están disponibles para la categoría "+$NombreCat+". Por favor seleccione una."
					End if 
					WDW_OpenFormWindow (->[Personas:7];"ChooseDoc_ACT";-1;-Palette form window:K39:9;__ ("Seleccione..."))
					DIALOG:C40([Personas:7];"ChooseDoc_ACT")
					CLOSE WINDOW:C154
					If (ok=1)
						$DocID:=vlACT_DocID
						$WhereModelo:=Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{Find in array:C230(alACT_IDDT;$DocID)})
						$WherePrinter:=Find in array:C230(atACT_Impresoras;atACT_Impresora{Find in array:C230(alACT_IDDT;$DocID)})
						If ($WhereModelo#-1)
							$ModID:=alACT_ModelosDocID{$WhereModelo}
						Else 
							$PrintDocs:=False:C215
							$ReciboMsg:="El modelo asignado para la impresión de este documento no existe. Por favor selec"+"cione otro en Configuración/Documentos Tributarios."+"\r\r"
							$ReciboMsg:=$ReciboMsg+"Un recibo será impreso como comprobante de pago."
							$PrintRecibo:=True:C214
						End if 
						If ($WherePrinter#-1)
							$Printer:=atACT_Impresoras{$WherePrinter}
						End if 
						$Proxima:=alACT_Proxima{Find in array:C230(alACT_IDDT;$DocID)}
					Else 
						$PrintDocs:=False:C215
						$FailMsg:="Impresión cancelada por el usuario."
					End if 
				Else 
					If (Size of array:C274(atACT_DocsAfectos)=0)
						If ($Afectas)
							$ReciboMsg:="No existen definiciones de documentos afectos a impuestos para la categoría "+$NombreCat+". Cree definiciones desde Configuración/Documentos Tributarios."+"\r\r"
						Else 
							$ReciboMsg:="No existen definiciones de documentos excentos de impuestos para la categoría "+$NombreCat+". Cree definiciones desde Configuración/Documentos Tributarios."+"\r\r"
						End if 
						$ReciboMsg:=$ReciboMsg+"Un recibo será impreso como comprobante de pago."
						$PrintDocs:=False:C215
						$PrintRecibo:=True:C214
					Else 
						$DocID:=alACT_DocsAfectosIDs{1}
						$WhereModelo:=Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{Find in array:C230(alACT_IDDT;$DocID)})
						$WherePrinter:=Find in array:C230(atACT_Impresoras;atACT_Impresora{Find in array:C230(alACT_IDDT;$DocID)})
						If ($WhereModelo#-1)
							$ModID:=alACT_ModelosDocID{$WhereModelo}
						Else 
							$ReciboMsg:="El modelo asignado para la impresión de este documento no existe. Por favor selec"+"cione otro en Configuración/Documentos Tributarios."+"\r\r"
							$ReciboMsg:=$ReciboMsg+"Un recibo será impreso como comprobante de pago."
							$PrintDocs:=False:C215
							$PrintRecibo:=True:C214
						End if 
						If ($WherePrinter#-1)
							$Printer:=atACT_Impresoras{$WherePrinter}
						End if 
						$Proxima:=alACT_Proxima{Find in array:C230(alACT_IDDT;$DocID)}
					End if 
				End if 
			End if 
		End if 
		If ($PrintRecibo)
			$WhereModelo:=Find in array:C230(atACT_ModelosDoc;vtACT_ModRecibo)
			If ($WhereModelo#-1)
				$ModID:=alACT_ModelosDocID{$WhereModelo}
				$NombreCat:=__ ("Recibos")
				$Proxima:=vlACT_NextRecibo
				$WherePrinter:=Find in array:C230(atACT_Impresoras;vtACT_PrinterRecibo)
				If ($WherePrinter#-1)
					$Printer:=vtACT_PrinterRecibo
				End if 
				CD_Dlog (0;$ReciboMsg)
			Else 
				$FailMsg:="El modelo asignado para imprimir recibos no existe. Por favor seleccione otro en "+"Configuración/Documentos Tributarios e imprima desde el explorador."
				$PrintDocs:=False:C215
			End if 
		End if 
	Else 
		$WhereModelo:=Find in array:C230(atACT_ModelosDoc;vtACT_ModRecibo)
		If ($WhereModelo#-1)
			$ModID:=alACT_ModelosDocID{$WhereModelo}
			$NombreCat:=__ ("Recibos")
			$Proxima:=vlACT_NextRecibo
			$WherePrinter:=Find in array:C230(atACT_Impresoras;vtACT_PrinterRecibo)
			If ($WherePrinter#-1)
				$Printer:=vtACT_PrinterRecibo
			End if 
		Else 
			$FailMsg:="El modelo asignado para imprimir recibos no existe. Por favor seleccione otro en "+"Configuración/Documentos Tributarios e imprima desde el explorador."
			$PrintDocs:=False:C215
			$PrintRecibo:=False:C215
		End if 
	End if 
	
	If (($PrintDocs) | ($PrintRecibo))
		If (Not:C34($MassivePrinting))
			  //$msg:="Por favor haga clic en el botón Lista cuando la impresora esté lista para imprim"+"ir "+$NombreCat+"."+◊cr+◊cr
			  //$msg:=$msg+"El próximo documento a imprimir es el Nº "+String($Proxima)+◊cr+◊cr
			  //$msg:=$msg+"El documento será impreso en "+$Printer+"."
			$r:=CD_Dlog (0;__ ("Por favor haga clic en el botón Lista cuando la impresora esté lista para imprimir ")+$NombreCat+__ (".\r\rEl próximo documento a imprimir es el Nº ")+String:C10($Proxima)+__ ("\r\rEl documento será impreso en ")+$Printer+__ (".");"";__ ("Lista"))
		Else 
			$r:=1
		End if 
		If ($r=1)
			READ WRITE:C146([ACT_Boletas:181])
			USE SET:C118($Documentos)
			APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Impresa:10:=True:C214)
			$Proxima:=ACTbol_Numbering ($Proxima;$NombreCat)
			If ((cbImprimirBoletas=1) & (Not:C34($PrintRecibo)))
				alACT_Proxima{Find in array:C230(alACT_IDDT;$DocID)}:=$Proxima
			Else 
				vlACT_NextRecibo:=$Proxima
			End if 
			ACTcfg_SaveConfig (8)
			READ ONLY:C145([ACT_Boletas:181])
			USE SET:C118($Documentos)
			
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
			
			  //COPY NAMED SELECTION([ACT_Boletas];"◊Editions")
			CUT NAMED SELECTION:C334([ACT_Boletas:181];"◊Editions")  //20170315 RCH La selección se crea con CUT
			
			SET CURRENT PRINTER:C787($Printer)
			If (Records in selection:C76([ACT_Boletas:181])>0)
				$Table:=Table:C252(->[ACT_Boletas:181])*-1
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
				QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=$ModID)
				$RecNumSR:=Record number:C243([xShell_Reports:54])
				QR_ImprimeInformeSRP ($RecNumSR)
				
			End if 
			SET CURRENT PRINTER:C787($currPrinter)
			  //CLEAR NAMED SELECTION("◊Editions")
		End if 
	Else 
		If (Not:C34($MassivePrinting))
			CD_Dlog (0;$FailMsg)
		End if 
		$0:=False:C215
	End if 
End if 