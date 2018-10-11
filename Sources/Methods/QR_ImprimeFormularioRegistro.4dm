//%attributes = {}
  // QR_ImprimeFormularioRegistro()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 11:29:50
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($5)

C_BOOLEAN:C305($b_tareaImpresionIniciada)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreArchivo;$t_impresoraActual;$t_impresoraPDF;$t_expresionNombreDocumento;$t_nombreFormulario;$t_rutaCarpetaDestino;$t_rutaPDF)

ARRAY TEXT:C222($at_impresoras;0)



If (False:C215)
	C_POINTER:C301(QR_ImprimeFormularioRegistro ;$1)
	C_TEXT:C284(QR_ImprimeFormularioRegistro ;$2)
	C_TEXT:C284(QR_ImprimeFormularioRegistro ;$3)
	C_TEXT:C284(QR_ImprimeFormularioRegistro ;$4)
	C_BOOLEAN:C305(QR_ImprimeFormularioRegistro ;$5)
End if 

$y_tabla:=$1
$t_nombreFormulario:=$2
Case of 
	: (Count parameters:C259=3)
		$t_destinoImpresion:=$3
	: (Count parameters:C259=4)
		$t_destinoImpresion:=$3
		$t_expresionNombreDocumento:=$4
	: (Count parameters:C259=5)
		$t_destinoImpresion:=$3
		$t_expresionNombreDocumento:=$4
		$b_tareaImpresionIniciada:=$5
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


FORM SET OUTPUT:C54($y_tabla->;$t_nombreFormulario)


Case of 
	: ($t_destinoImpresion="pdf")
		If (Not:C34($b_tareaImpresionIniciada))
			$t_expresionNombreDocumento:=Replace string:C233($t_expresionNombreDocumento;",";".")
			If ($t_rutaCarpetaDestino="")
				PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
			Else 
				vt_rutaCarpetaPDF:=$t_rutaCarpetaDestino
			End if 
			vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
			
			Case of 
				: (SYS_IsMacintosh )
					SET PRINT OPTION:C733(Destination option:K47:7;3;vt_nombreDoc)
					SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
					OPEN PRINTING JOB:C995
					PRINT RECORD:C71($y_tabla->;>)
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
					PRINT RECORD:C71($y_tabla->;>)
					SET CURRENT PRINTER:C787($t_impresoraActual)
					
			End case 
			
		Else 
			PRINT RECORD:C71($y_tabla->;>)
		End if 
		
	: ($t_destinoImpresion="printer")
		PRINT RECORD:C71($y_tabla->;>)
		
	: ($t_destinoImpresion="preview")
		SET PRINT PREVIEW:C364(True:C214)
		PRINT RECORD:C71($y_tabla->;>)
		SET PRINT PREVIEW:C364(False:C215)
	Else 
		  //PRINT RECORD($y_tabla->;>)
End case 