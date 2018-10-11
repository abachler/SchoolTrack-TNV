//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 11-06-18, 12:55:57
  // ----------------------------------------------------
  // Método: QR_PrintInfColumna
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($1)
C_TEXT:C284($2;$3)

C_LONGINT:C283($l_recNumInforme;$l_refArea)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_impresoraActual;$t_impresoraPDF;$t_rutaCarpetaPdfs;$t_rutaDocumento;$t_rutaFiltro)

ARRAY TEXT:C222($at_impresoras;0)

If (False:C215)
	C_LONGINT:C283(QR_ImprimeInformeColumnas ;$1)
	C_TEXT:C284(QR_ImprimeInformeColumnas ;$2)
	C_TEXT:C284(QR_ImprimeInformeColumnas ;$3)
	C_TEXT:C284(QR_ImprimeInformeColumnas ;$4)
End if 

$l_recNumInforme:=$1
$t_destinoImpresion:=$2
$t_rutaArchivoImpresion:=$3

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

READ ONLY:C145([xShell_Reports:54])
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)

MESSAGES ON:C181
If (SYS_IsWindows )
	USE CHARACTER SET:C205("Windows-1252";0)
End if 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
MESSAGES ON:C181

If (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0)
	$l_refArea:=QR New offscreen area:C735
	QR BLOB TO REPORT:C771($l_refArea;[xShell_Reports:54]xReportData_:29)
	QR SET REPORT TABLE:C757($l_refArea;Choose:C955([xShell_Reports:54]RelatedTable:14=0;[xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14))  //20161014 ASM Ticket 169372
	
	Case of 
		: ($t_destinoImpresion="preview")
			QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;"*")
			SET PRINT PREVIEW:C364(True:C214)
			QR RUN:C746($l_refArea)
			
		: ($t_destinoImpresion="printer")
			QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;$t_rutaDocumento)
			QR RUN:C746($l_refArea)
			
		: ($t_destinoImpresion="html")
			QR SET DESTINATION:C745($l_refArea;qr HTML file:K14903:5)
			QR RUN:C746($l_refArea)
			
		: ($t_destinoImpresion="txt")
			QR SET DESTINATION:C745($l_refArea;qr text file:K14903:2)
			QR RUN:C746($l_refArea)
			
		: ($t_destinoImpresion="4dview")
			QR SET DESTINATION:C745($l_refArea;qr 4D View area:K14903:3)
			QR RUN:C746($l_refArea)
			
		: ($t_destinoImpresion="pdf")
			$b_impresionPDF_OK:=UTIL_ImpresoraPDF (->$t_impresoraPDF)
			If ($b_impresionPDF_OK)
				Case of 
					: (SYS_IsMacintosh )
						SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaArchivoImpresion)
						SET PRINT OPTION:C733(Mac spool file format option:K47:11;0)
						SET PRINT OPTION:C733(Spooler document name option:K47:10;$t_rutaArchivoImpresion)
						SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
						SET CURRENT PRINTER:C787(Generic PDF driver:K47:15)  //MONO 205131
						QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;"*")  //MONO 205131
						QR RUN:C746($l_refArea)
						SET CURRENT PRINTER:C787("")
						
					: (SYS_IsWindows )
						$t_impresoraActual:=Get current printer:C788
						PRINTERS LIST:C789($at_impresoras)
						Case of 
							: ($t_impresoraPDF="Microsoft Print to PDF")
								SET PRINT OPTION:C733(Destination option:K47:7;2;$t_rutaArchivoImpresion)
								
							: ($t_impresoraPDF=PDFCreator Printer name:K47:13)
								SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaArchivoImpresion)
								
							: ($t_impresoraPDF="Win2Pdf")
								SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaArchivoImpresion)
						End case 
						SET CURRENT PRINTER:C787($t_impresoraPDF)
						QR RUN:C746($l_refArea)
						SET CURRENT PRINTER:C787($t_impresoraActual)
				End case 
			End if 
			
	End case 
	QR DELETE OFFSCREEN AREA:C754($l_refArea)
End if 

MESSAGES OFF:C175
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
USE CHARACTER SET:C205(*;0)