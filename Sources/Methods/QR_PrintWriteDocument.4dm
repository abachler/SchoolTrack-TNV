//%attributes = {}
  // QR_PrintWriteDocument()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 17:17:10
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_PICTURE:C286($5)
C_TEXT:C284($6)

C_BLOB:C604($x_blob;$x_printSettings)
C_BOOLEAN:C305($b_previsualizar)
C_LONGINT:C283($i;$l_columna;$l_continuar;$l_desde;$l_destinoInforme;$l_fila;$l_hasta;$l_pagina;$l_posicion;$l_recNum)
C_LONGINT:C283($l_refArea4DWR;$l_refAreaOffscreen;$l_tabla)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_rutaCarpeta;$t_extension;$t_nombreDocumento;$t_nombreInforme;$t_Texto;$t_tipoDocumento)

ARRAY LONGINT:C221($al_recnums;0)



If (False:C215)
	C_LONGINT:C283(QR_PrintWriteDocument ;$1)
	C_BOOLEAN:C305(QR_PrintWriteDocument ;$2)
	C_LONGINT:C283(QR_PrintWriteDocument ;$3)
	C_TEXT:C284(QR_PrintWriteDocument ;$4)
	C_PICTURE:C286(QR_PrintWriteDocument ;$5)
	C_TEXT:C284(QR_PrintWriteDocument ;$6)
End if 

QR_InitGenericObjects 

$l_recNum:=$1
Case of 
	: (Count parameters:C259=6)
		vpXS_IconModule:=$5
		vsBWR_CurrentModule:=$6
		$t_tipoDocumento:=$4
		$l_destinoInforme:=$3
		$b_previsualizar:=$2
	: (Count parameters:C259=4)
		$t_tipoDocumento:=$4
		$l_destinoInforme:=$3
		$b_previsualizar:=$2
	: (Count parameters:C259=3)
		$l_destinoInforme:=$3
		$b_previsualizar:=$2
	: (Count parameters:C259=2)
		$b_previsualizar:=$2
	Else 
		$b_previsualizar:=False:C215
End case 

If ($l_destinoInforme=0)
	$l_destinoInforme:=qr printer:K14903:1
End if 

If ($t_tipoDocumento#"")
	Case of 
		: ($t_tipoDocumento="ASCM")
			$t_extension:=".txt"
		: ($t_tipoDocumento="ASCW")
			$t_extension:=".txt"
		: ($t_tipoDocumento="ASCU")
			$t_extension:=".txt"
		: ($t_tipoDocumento="HTM3")
			$t_extension:=".html"
		: ($t_tipoDocumento="HTML")
			$t_extension:=".html"
		: ($t_tipoDocumento="DOC8")
			$t_extension:=".doc"
		: ($t_tipoDocumento="RTF ")
			$t_extension:=".rtf"
	End case 
End if 

SET MENU BAR:C67("XS_Edicion")

READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$l_recNum)
$t_nombreInforme:=[xShell_Reports:54]FormName:17
$l_tabla:=Abs:C99([xShell_Reports:54]MainTable:3)
$y_tabla:=Table:C252($l_tabla)
yBWR_currentTable:=$y_tabla






USE NAMED SELECTION:C332("◊Editions")
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
	$y_tabla:=Table:C252(Abs:C99([xShell_Reports:54]MainTable:3))
End if 
OK:=QR_SetUnivers (Abs:C99([xShell_Reports:54]MainTable:3);[xShell_Reports:54]RelatedTable:14)
$l_continuar:=ok
If ($l_continuar=1)
	If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
		$l_continuar:=ok
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	End if 
End if 
If ($l_continuar=1)
	MESSAGES ON:C181
	If ([xShell_Reports:54]isOneRecordReport:11)
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		
		If (Not:C34([xShell_Reports:54]NoRequiereSeleccion:40))
			SELECTION TO ARRAY:C260($y_tabla->;$al_recnums)
			If (Size of array:C274($al_recnums)>0)
				GOTO RECORD:C242($y_tabla->;$al_recnums{1})
				vlSR_CurrentRecorNumber:=$al_recnums{1}
			End if 
		Else 
			WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
			WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd print preview:K12007:18)
		End if 
		MESSAGES ON:C181
		If ($b_previsualizar)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274($al_recnums))
				GOTO RECORD:C242($y_tabla->;$al_recnums{$i})
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				If ($i>1)
					If (([xShell_Reports:54]ExecuteBeforePrinting:4#"") & ([xShell_Reports:54]ExecuteBeforeEachDocument:31))
						EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
					End if 
				End if 
				SET PRINT PREVIEW:C364(True:C214)
				WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
				WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd print preview:K12007:18)
				If (Macintosh option down:C545 | Windows Alt down:C563)
				Else 
					$i:=Size of array:C274($al_recnums)
				End if 
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		Else 
			ARRAY TEXT:C222(at_GeneratedHTMLFileNames;0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			Case of 
				: ($l_destinoInforme=qr printer:K14903:1)
					WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
					  //WR PRINT ($l_refArea4DWR;0;1)
					  //WR PRINT MERGE ($l_refArea4DWR;Table($y_tabla);1)
					  //OK:=1
					
					  //PS 03-01-2012: se modifica la forma de imprimir documentos write ya que del segundo registro en adelante siempre mandaba a imprimir a la impresora por defecto
					PRINT SETTINGS:C106
					$x_printSettings:=WR Print settings to BLOB:P12000:93 ($l_refArea4DWR)
					WR PRINT:P12000:4 ($l_refArea4DWR;0;1)
					
				: ($l_destinoInforme=qr text file:K14903:2)
					$t_rutaCarpeta:=SYS_SelectFolder ("Seleccione la carpeta para guardar los documentos")
					$t_nombreDocumento:=$t_rutaCarpeta+Replace string:C233([xShell_Reports:54]ReportName:26;" ";"")+"1"+$t_extension
					WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
					WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;$t_nombreDocumento;$t_tipoDocumento)
				: ($l_destinoInforme=qr HTML file:K14903:5)
					$t_rutaCarpeta:=SYS_SelectFolder ("Seleccione la carpeta para guardar los documentos")
					$t_nombreDocumento:=$t_rutaCarpeta+Replace string:C233([xShell_Reports:54]ReportName:26;" ";"")+"1"+$t_extension
					WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
					WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;$t_nombreDocumento;$t_tipoDocumento)
			End case 
			
			If (Ok=1)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				For ($i;2;Size of array:C274($al_recnums))
					GOTO RECORD:C242($y_tabla->;$al_recnums{$i})
					vlSR_CurrentRecorNumber:=$al_recnums{$i}
					If (([xShell_Reports:54]ExecuteBeforePrinting:4#"") & ([xShell_Reports:54]ExecuteBeforeEachDocument:31))
						EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
					End if 
					If ($b_previsualizar)
						WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
						WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd print preview:K12007:18)
					Else 
						SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
						Case of 
							: ($l_destinoInforme=qr printer:K14903:1)
								WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
								WR PRINT:P12000:4 ($l_refArea4DWR;0;1)
							: ($l_destinoInforme=qr text file:K14903:2)
								$t_nombreDocumento:=$t_rutaCarpeta+Replace string:C233([xShell_Reports:54]ReportName:26;" ";"")+String:C10($i)+$t_extension
								WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
								WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;$t_nombreDocumento;$t_tipoDocumento)
							: ($l_destinoInforme=qr HTML file:K14903:5)
								$t_nombreDocumento:=$t_rutaCarpeta+Replace string:C233([xShell_Reports:54]ReportName:26;" ";"")+String:C10($i)+$t_extension
								WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
								WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;$t_nombreDocumento;$t_tipoDocumento)
								AT_Insert (0;1;->at_GeneratedHTMLFileNames)
								at_GeneratedHTMLFileNames{Size of array:C274(at_GeneratedHTMLFileNames)}:=$t_nombreDocumento
						End case 
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					End if 
				End for 
			End if 
		End if 
		MESSAGES OFF:C175
		WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
	Else 
		
		If ($b_previsualizar)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			$l_refArea4DWR:=WR New offscreen area:P12000:47 
			WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
			WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
			WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd print preview:K12007:18)
			WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		Else 
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			Case of 
				: ($l_destinoInforme=qr printer:K14903:1)
					$l_refArea4DWR:=WR New offscreen area:P12000:47 
					WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
					WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);1)
					WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
					
				: (($l_destinoInforme=qr text file:K14903:2) | ($l_destinoInforme=qr HTML file:K14903:5))
					SELECTION TO ARRAY:C260($y_tabla->;$al_recnums)
					If (Size of array:C274($al_recnums)>0)
						GOTO RECORD:C242($y_tabla->;$al_recnums{1})
						vlSR_CurrentRecorNumber:=$al_recnums{1}
					End if 
					
					$h_refDocumento:=Create document:C266("";$t_extension)
					CLOSE DOCUMENT:C267($h_refDocumento)
					If (Position:C15($t_extension;document)#(Length:C16(document)-4))
						$t_nombreDocumento:=document+$t_extension
					Else 
						$t_nombreDocumento:=document
					End if 
					DELETE DOCUMENT:C159(document)
					
					  //$l_refArea4DWR:=WR New offscreen area
					
					$l_refAreaOffscreen:=WR New offscreen area:P12000:47 
					WR BLOB TO AREA:P12000:142 ($l_refAreaOffscreen;[xShell_Reports:54]xReportData_:29)
					WR EXECUTE COMMAND:P12000:113 ($l_refAreaOffscreen;wr cmd compute references:K12007:172)
					WR EXECUTE COMMAND:P12000:113 ($l_refAreaOffscreen;wr cmd freeze references:K12007:173)
					WR EXECUTE COMMAND:P12000:113 ($l_refAreaOffscreen;wr cmd select all:K12007:7)
					
					$x_blob:=WR Get styled text:P12000:127 ($l_refAreaOffscreen)
					$t_Texto:=WR Get text:P12000:20 ($l_refAreaOffscreen;1;32000)
					$l_pagina:=WR Count:P12000:143 ($l_refArea4DWR;wr nb pages:K12009:12)
					WR SET CURSOR POSITION:P12000:106 ($l_refArea4DWR;$l_pagina;1;1;1)
					WR INSERT STYLED TEXT:P12000:128 ($l_refArea4DWR;$x_blob)
					WR GET CURSOR POSITION:P12000:134 ($l_refArea4DWR;$l_pagina;$l_columna;$l_fila;$l_posicion)
					WR GET SELECTION:P12000:2 ($l_refArea4DWR;$l_desde;$l_hasta)
					WR DELETE OFFSCREEN AREA:P12000:38 ($l_refAreaOffscreen)
					
					For ($i;2;Size of array:C274($al_recnums))
						GOTO RECORD:C242($y_tabla->;$al_recnums{$i})
						vlSR_CurrentRecorNumber:=$al_recnums{$i}
						SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
						If (([xShell_Reports:54]ExecuteBeforePrinting:4#"") & ([xShell_Reports:54]ExecuteBeforeEachDocument:31))
							EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
						End if 
						
						$l_refAreaOffscreen:=WR New offscreen area:P12000:47 
						WR BLOB TO AREA:P12000:142 ($l_refAreaOffscreen;[xShell_Reports:54]xReportData_:29)
						WR EXECUTE COMMAND:P12000:113 ($l_refAreaOffscreen;wr cmd compute references:K12007:172)
						WR EXECUTE COMMAND:P12000:113 ($l_refAreaOffscreen;wr cmd freeze references:K12007:173)
						WR EXECUTE COMMAND:P12000:113 ($l_refAreaOffscreen;wr cmd select all:K12007:7)
						$x_blob:=WR Get styled text:P12000:127 ($l_refAreaOffscreen)
						WR DELETE OFFSCREEN AREA:P12000:38 ($l_refAreaOffscreen)
						
						WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd insert page break:K12007:52)
						WR INSERT STYLED TEXT:P12000:128 ($l_refArea4DWR;$x_blob)
						WR GET CURSOR POSITION:P12000:134 ($l_refArea4DWR;$l_pagina;$l_columna;$l_fila;$l_posicion)
						WR GET SELECTION:P12000:2 ($l_refArea4DWR;$l_desde;$l_hasta)
						
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					End for 
					WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;$t_nombreDocumento;$t_tipoDocumento)
					WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
			End case 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		End if 
	End if 
End if 

CLEAR NAMED SELECTION:C333("◊Editions")




