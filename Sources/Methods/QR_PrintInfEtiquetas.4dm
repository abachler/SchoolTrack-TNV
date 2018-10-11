//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 11-06-18, 18:23:44
  // ----------------------------------------------------
  // Método: QR_PrintInfEtiquetas
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($printPreview)
C_LONGINT:C283($l_recNumInforme;$l_refArea)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreArchivo;$t_impresoraActual;$t_impresoraPDF;$t_rutaCarpetaDestino;$t_rutaDocumento)

ARRAY TEXT:C222($at_impresoras;0)

C_TEXT:C284(vt_rutaCarpetaPDF)
C_LONGINT:C283(vPeriodo)
C_TEXT:C284($vt_etiqueta)

$l_recNumInforme:=$1
$t_destinoImpresion:=$2
$t_rutaCarpetaDestino:=$3

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

SET MENU BAR:C67("XS_Edicion")

READ ONLY:C145([xShell_Reports:54])
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)

$l_refArea:=QR New offscreen area:C735
PDF_VerificaCreacionDocumento ($vt_etiqueta)  // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724

Case of 
	: ($t_destinoImpresion="preview")
		QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;"*")
		SET PRINT PREVIEW:C364(True:C214)
		PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
		
	: ($t_destinoImpresion="printer")
		QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;$t_rutaDocumento)
		PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
		
	: ($t_destinoImpresion="pdf")
		Case of 
			: (SYS_IsMacintosh )
				QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1)
				SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaDocumento)
				SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
				OPEN PRINTING JOB:C995
				PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
				PAGE BREAK:C6
				CLOSE PRINTING JOB:C996
				
			: (SYS_IsWindows )
				$t_impresoraActual:=Get current printer:C788
				PRINTERS LIST:C789($at_impresoras)
				Case of 
					: (Find in array:C230($at_impresoras;"Microsoft Print to PDF")>0)
						$t_impresoraPDF:="Microsoft Print to PDF"
						SET PRINT OPTION:C733(Destination option:K47:7;2;vt_nombreDoc)
						
					: (Find in array:C230($at_impresoras;PDFCreator Printer name:K47:13)>0)
						$t_impresoraPDF:="PDFCreator"
						SET PRINT OPTION:C733(Destination option:K47:7;3;vt_nombreDoc)
						
					: (Find in array:C230($at_impresoras;"Win2Pdf")>0)
						$t_impresoraPDF:="Win2Pdf"
						SET PRINT OPTION:C733(Destination option:K47:7;3;vt_nombreDoc)
				End case 
				SET CURRENT PRINTER:C787($t_impresoraPDF)
				PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
				SET CURRENT PRINTER:C787($t_impresoraActual)
				
		End case 
End case 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
QR DELETE OFFSCREEN AREA:C754($l_refArea)
USE CHARACTER SET:C205(*;0)
