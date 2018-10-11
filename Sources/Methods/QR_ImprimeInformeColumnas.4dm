//%attributes = {}
  // QR_ImprimeInformeColumnas()
  //
  //
  // creado por: Alberto Bachler Klein: 23-03-16, 19:14:16
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)


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

C_TEXT:C284(vt_rutaCarpetaPDF;vsBWR_CurrentModule)
C_LONGINT:C283(vPeriodo)

QR_InitGenericObjects 

$l_recNumInforme:=$1
Case of 
	: (Count parameters:C259=2)
		$t_destinoImpresion:=$2
	: (Count parameters:C259=3)
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
	: (Count parameters:C259=4)
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreArchivo:=$4
	: (Count parameters:C259=6)  //MONO 205131 - llamado desde QR_ImprimeGrupo
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreArchivo:=$4
		  //estos parámetros no son utlizados en este método pero son pasados por QR_ImprimeGrupo
		  //creo que originalmente los informes en columnas no son publicables en SN3
		$y_informes_at:=$5
		$b_destinoSNT:=$6
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
yBWR_currentTable:=$y_tabla
vsBWR_CurrentModule:=[xShell_Reports:54]Modulo:41

GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)


USE NAMED SELECTION:C332("◊Editions")
If (Records in selection:C76([xShell_Reports:54])#0)
	dhQR_PrePrintInstructions 
	ok:=1
	If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252(yBWR_currentTable)))
		$y_tabla:=Table:C252([xShell_Reports:54]RelatedTable:14)
		If ([xShell_Reports:54]SourceField:13#0)
			vyQR_StartField:=Field:C253([xShell_Reports:54]MainTable:3;[xShell_Reports:54]SourceField:13)
		End if 
		If ([xShell_Reports:54]RelatedField:15#0)
			vyQR_EndField:=Field:C253([xShell_Reports:54]RelatedTable:14;[xShell_Reports:54]RelatedField:15)
		End if 
	Else 
		$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
	End if 
	OK:=QR_SetUnivers ([xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)
	If (OK=1)
		If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
	End if 
	
	
	
	If (OK=1)
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
			
			If ($t_rutaCarpetaDestino="")
				PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
			Else 
				vt_rutaCarpetaPDF:=$t_rutaCarpetaDestino
			End if 
			vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
			
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
								SET PRINT OPTION:C733(Destination option:K47:7;3;vt_nombreDoc)
								SET PRINT OPTION:C733(Mac spool file format option:K47:11;0)
								SET PRINT OPTION:C733(Spooler document name option:K47:10;vt_nombreDoc)
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
										SET PRINT OPTION:C733(Destination option:K47:7;2;vt_nombreDoc)
										
									: ($t_impresoraPDF=PDFCreator Printer name:K47:13)
										SET PRINT OPTION:C733(Destination option:K47:7;3;vt_nombreDoc)
										
									: ($t_impresoraPDF="Win2Pdf")
										SET PRINT OPTION:C733(Destination option:K47:7;3;vt_nombreDoc)
								End case 
								SET CURRENT PRINTER:C787($t_impresoraPDF)
								QR RUN:C746($l_refArea)
								SET CURRENT PRINTER:C787($t_impresoraActual)
						End case 
					End if 
					
			End case 
			QR DELETE OFFSCREEN AREA:C754($l_refArea)
		End if 
		
	End if 
	MESSAGES OFF:C175
	  //CLEAR NAMED SELECTION("<>Editions")//20170315 RCH La selección se crea con CUT
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	USE CHARACTER SET:C205(*;0)
Else 
	
End if 
MESSAGES OFF:C175



