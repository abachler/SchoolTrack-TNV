//%attributes = {}
  // QR_ImprimeEtiquetas()
  //
  //
  // creado por: Alberto Bachler Klein: 23-03-16, 19:07:32
  // -----------------------------------------------------------
C_BOOLEAN:C305($printPreview)
C_LONGINT:C283($l_recNumInforme;$l_refArea)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreArchivo;$t_impresoraActual;$t_impresoraPDF;$t_rutaCarpetaDestino;$t_rutaDocumento;vt_nombreDoc)

ARRAY TEXT:C222($at_impresoras;0)

C_TEXT:C284(vt_rutaCarpetaPDF)
C_LONGINT:C283(vPeriodo)
C_TEXT:C284($vt_etiqueta)


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
		  //originalmente los informes en etiquetas no son publicables en SN3
		$y_informes_at:=$5
		$b_destinoSNT:=$6
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


SET MENU BAR:C67("XS_Edicion")

READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
yBWR_currentTable:=$y_tabla

dhQR_PrePrintInstructions 

If ($t_destinoImpresion="preview")
	SET PRINT PREVIEW:C364($printPreview)
End if 

GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
If (Records in selection:C76([xShell_Reports:54])#0)
	C_TEXT:C284(vsBWR_CurrentModule)
	  // asigno nuevamente el modulo, al mandar a imprimir se pierde el valor debido a que es un nuevo proceso
	  //20161003 JVP
	vsBWR_CurrentModule:=[xShell_Reports:54]Modulo:41
	
	If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#(Table:C252(yBWR_currentTable))))
		$y_tabla:=Table:C252([xShell_Reports:54]RelatedTable:14)
	End if 
	vyQR_TablePointer:=$y_tabla
	
	USE NAMED SELECTION:C332("◊Editions")
	OK:=QR_SetUnivers ([xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)
	
	If (ok=1)
		If ($t_rutaCarpetaDestino="")
			PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
		Else 
			vt_rutaCarpetaPDF:=$t_rutaCarpetaDestino
		End if 
		vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
	End if 
	
	USE CHARACTER SET:C205("MacRoman";0)
	$h_refDocumento:=Create document:C266([xShell_Reports:54]ReportName:26;"4DET")
	SEND PACKET:C103($h_refDocumento;[xShell_Reports:54]Texto:5)
	CLOSE DOCUMENT:C267($h_refDocumento)
	$vt_etiqueta:=document  // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
	READ ONLY:C145($y_tabla->)
	If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
		EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
	End if 
	
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	If (Macintosh option down:C545 | Windows Alt down:C563)
		ORDER BY:C49($y_tabla->)
	End if 
	  //JVP 20170227 creo el area de impresión
	$l_refArea:=QR New offscreen area:C735
	
	$t_rutaDocumento:=vt_nombreDoc  // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
	PDF_VerificaCreacionDocumento ($vt_etiqueta)  // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
	
	Case of 
			
			
			
		: ($t_destinoImpresion="preview")
			QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;"*")
			SET PRINT PREVIEW:C364(True:C214)
			  //PRINT LABEL($y_tabla->;$t_rutaDocumento) // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
			PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
			
		: ($t_destinoImpresion="printer")
			QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1;$t_rutaDocumento)
			  //PRINT LABEL($y_tabla->;$t_rutaDocumento) // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
			PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
			
		: ($t_destinoImpresion="pdf")
			Case of 
				: (SYS_IsMacintosh )
					QR SET DESTINATION:C745($l_refArea;qr printer:K14903:1)
					SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaDocumento)
					SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
					OPEN PRINTING JOB:C995
					  //PRINT LABEL($y_tabla->;$t_rutaDocumento) // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
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
					  //PRINT LABEL($y_tabla->) // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
					PRINT LABEL:C39($y_tabla->;$vt_etiqueta)
					SET CURRENT PRINTER:C787($t_impresoraActual)
					
			End case 
	End case 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	  //JVP 20170227 elimino el area de impresión
	QR DELETE OFFSCREEN AREA:C754($l_refArea)
	
	  //DELETE DOCUMENT(document)
	USE CHARACTER SET:C205(*;0)
	
	DELETE DOCUMENT:C159($vt_etiqueta)  // Modificado por: Saúl Ponce (13-03-2017) Ticket Nº 176724
End if 

