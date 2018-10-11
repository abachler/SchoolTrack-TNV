//%attributes = {}
  // QR_ImprimeFormularioSeleccion()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 11:29:43
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($5)

C_BOOLEAN:C305($b_tareaImpresionIniciada)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_nombreDocumento;$t_nombreFormulario;$t_rutaPDF)
ARRAY LONGINT:C221($al_recNums;0)  //MONO 060618 Ticket 208709

If (False:C215)
	C_POINTER:C301(QR_ImprimeFormularioSeleccion ;$1)
	C_TEXT:C284(QR_ImprimeFormularioSeleccion ;$2)
	C_TEXT:C284(QR_ImprimeFormularioSeleccion ;$3)
	C_TEXT:C284(QR_ImprimeFormularioSeleccion ;$4)
	C_BOOLEAN:C305(QR_ImprimeFormularioSeleccion ;$5)
End if 

$y_tabla:=$1
$t_nombreFormulario:=$2
Case of 
	: (Count parameters:C259=3)
		$t_destinoImpresion:=$3
	: (Count parameters:C259=4)
		$t_destinoImpresion:=$3
		$t_nombreDocumento:=$4
	: (Count parameters:C259=5)
		$t_destinoImpresion:=$3
		$t_nombreDocumento:=$4
		$b_enUnaTarea:=$5
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


FORM SET OUTPUT:C54($y_tabla->;$t_nombreFormulario)


Case of 
	: ($t_destinoImpresion="pdf")
		If (Test path name:C476(vt_rutaCarpetaPDF)#Is a folder:K24:2)
			vt_rutaCarpetaPDF:=Select folder:C670(__ ("Seleccione la carpeta donde desea guardar los documentos pdf…"))
		End if 
		If ($b_enUnaTarea)
			EXECUTE FORMULA:C63("vt_nombreDoc:="+$t_nombreDocumento)
			vt_nombreDoc:=Choose:C955(vt_nombreDoc#"@.pdf";vt_nombreDoc+".pdf";vt_nombreDoc)
			$t_rutaPDF:=vt_rutaCarpetaPDF+vt_nombreDoc
			SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaPdf)
			SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
			OPEN PRINTING JOB:C995
		End if 
		LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
		<>stopExec:=False:C215
		For ($i_registros;1;Size of array:C274($al_recNums))
			KRL_GotoRecord ($y_tabla;$al_recNums{$i_registros};False:C215)
			QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_nombreDocumento;$b_enUnaTarea)
			If (<>stopExec)
				$i_registros:=Size of array:C274($al_recNums)+1
			End if 
		End for 
		If ($b_enUnaTarea)
			PAGE BREAK:C6
			CLOSE PRINTING JOB:C996
		End if 
		
	: ($t_destinoImpresion="printer")
		PRINT SELECTION:C60($y_tabla->;>)
		
	: ($t_destinoImpresion="preview")
		SET PRINT PREVIEW:C364(True:C214)
		PRINT SELECTION:C60($y_tabla->;>)
		SET PRINT PREVIEW:C364(False:C215)
	Else 
		PRINT SELECTION:C60($y_tabla->;>)
End case 