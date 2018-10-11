//%attributes = {}
  // QR_ImprimeDocumento4DWrite()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 17:17:10
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_BLOB:C604($x_blob;$x_printSettings)
C_BOOLEAN:C305($b_previsualizar)
C_LONGINT:C283($i;$l_columna;$l_continuar;$l_desde;$l_destinoInforme;$l_fila;$l_hasta;$l_pagina;$l_posicion;$l_recNumInforme)
C_LONGINT:C283($l_recNumInformeInforme;$l_refArea4DWR;$l_refAreaOffscreen;$l_tabla)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_tabla)
C_TEXT:C284($fileType;$t_destinoImpresion;$t_expresionNombreArchivo;$t_extension;$t_impresora;$t_nombreDocumento;$t_nombreInforme;$t_rutaCarpeta;$t_rutaCarpetaDestino;$t_Texto;$t_tipoDocumento)

ARRAY LONGINT:C221($al_recnums;0)

If (False:C215)
	C_LONGINT:C283(QR_ImprimeDocumento4DWrite ;$1)
	C_TEXT:C284(QR_ImprimeDocumento4DWrite ;$2)
	C_TEXT:C284(QR_ImprimeDocumento4DWrite ;$3)
	C_TEXT:C284(QR_ImprimeDocumento4DWrite ;$4)
End if 

C_TEXT:C284(vt_rutaCarpetaPDF)
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
		  //creo que originalmente los informes en 4dWrite no son publicables en SN3
		$y_informes_at:=$5
		$b_destinoSNT:=$6
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)


SET MENU BAR:C67("XS_Edicion")

READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$t_nombreInforme:=[xShell_Reports:54]FormName:17
$l_tabla:=Abs:C99([xShell_Reports:54]MainTable:3)
$y_tabla:=Table:C252($l_tabla)
yBWR_currentTable:=$y_tabla
C_TEXT:C284(vsBWR_CurrentModule)
  // asigno nuevamente el modulo, al mandar a imprimir se pierde el valor debido a que es un nuevo proceso
  //20161003 JVP
vsBWR_CurrentModule:=[xShell_Reports:54]Modulo:41

USE NAMED SELECTION:C332("◊Editions")
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recnums)
dhQR_PrePrintInstructions 
OK:=QR_SetUnivers (Abs:C99([xShell_Reports:54]MainTable:3);[xShell_Reports:54]RelatedTable:14)
If (ok=1)
	If ($t_rutaCarpetaDestino="")
		PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
	Else 
		vt_rutaCarpetaPDF:=$t_rutaCarpetaDestino
	End if 
	vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
End if 


  //If ([xShell_Reports]ExecuteBeforePrinting#"")
  //SET AUTOMATIC RELATIONS(True;False)
  //EXE_Execute ([xShell_Reports]ExecuteBeforePrinting)
  //SET AUTOMATIC RELATIONS(False;False)
  //End if 


  //$l_refArea4DWR:=WR New offscreen area 
  //WR BLOB TO AREA ($l_refArea4DWR;[xShell_Reports]xReportData_)
  //WR EXECUTE COMMAND ($l_refArea4DWR;wr cmd page setup)
  //$x_printSettings:=WR Print settings to BLOB ($l_refArea4DWR)
  //WR BLOB TO PRINT SETTINGS ($l_refArea4DWR;$x_printSettings;wr layout and print settings)
C_TEXT:C284($t_error)  //ABC////20180608//TICKET 209069 //Variable para obtener parametro devuelto por exe_execute así cancelar impresión (se modificaron todos los Case).
$t_error:=""
Case of 
	: ($t_destinoImpresion="printer")
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242($y_tabla->;$al_recNums{$i})
			If (([xShell_Reports:54]ExecuteAfterEachRecord:32) | ($i=1))  //ABC //TKT//214337//20180813
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				$t_error:=EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			If ($t_error="")
				$l_refArea4DWR:=WR New offscreen area:P12000:47 
				WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
				If (BLOB size:C605($x_printSettings)=0)
					WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);wr with print settings dialog:K12011:39)
					$x_printSettings:=WR Print settings to BLOB:P12000:93 ($l_refArea4DWR)
				Else 
					WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);wr no print settings dialog:K12011:38)
				End if 
				WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
			Else 
				$i:=Size of array:C274($al_recNums)
			End if 
		End for 
		
	: ($t_destinoImpresion="preview")
		  // Modificado por: Alexis Bustamante (24-04-2017)
		  //ticket 180214 
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242($y_tabla->;$al_recNums{$i})
			If (([xShell_Reports:54]ExecuteAfterEachRecord:32) | ($i=1))  //ABC //TKT//214337//20180813
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				$t_error:=EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			If ($t_error="")
				$l_refArea4DWR:=WR New offscreen area:P12000:47 
				WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
				  //WR EXECUTE COMMAND ($l_refArea4DWR;wr destination option)//abc//204082
				WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd print preview:K12007:18)
				WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
			Else 
				$i:=Size of array:C274($al_recNums)
			End if 
			  //si no se cancelo la ejecución.
		End for 
		
	: ($t_destinoImpresion="pdf")
		
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242($y_tabla->;$al_recNums{$i})
			vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
			If (([xShell_Reports:54]ExecuteAfterEachRecord:32) | ($i=1))  //ABC //TKT//214337//20180813
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				$t_error:=EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			If ($t_error="")
				$l_refArea4DWR:=WR New offscreen area:P12000:47 
				WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
				
				If (SYS_IsMacintosh )
					WR SET PRINT OPTION:P12000:173 ($l_refArea4DWR;wr destination option:K12010:9;3;0;vt_nombreDoc)
					$b_impresoraOK:=True:C214
				Else 
					WR SET PRINT OPTION:P12000:173 ($l_refArea4DWR;wr destination option:K12010:9;wr send to file:K12011:84;0;vt_nombreDoc)
					$_defaultPrinter:=Get current printer:C788
					$b_impresoraOK:=UTIL_ImpresoraPDF (->$t_impresora)
					SET CURRENT PRINTER:C787($t_impresora)
				End if 
				
				If ($b_impresoraOK)
					WR PRINT MERGE:P12000:5 ($l_refArea4DWR;Table:C252($y_tabla);wr no print settings dialog:K12011:38)
					$b_abrirDirectorio:=True:C214
					If (SYS_IsWindows )
						SET CURRENT PRINTER:C787($_defaultPrinter)
					End if 
				Else 
					OK:=ModernUI_Notificacion (__ ("Impresión de documentos en archivos pdf");__ ("No hay controlador de impresora para generar documentos PDF"))
					$i:=Size of array:C274($al_recNums)
				End if 
				WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
				
				
				
			Else 
				$i:=Size of array:C274($al_recNums)
			End if 
		End for 
		
		If ($b_abrirDirectorio)
			OK:=ModernUI_Notificacion (__ ("Impresión de documentos en archivos");__ ("La impresión de documentos concluyó exitosamente\r\r¿Desea abrir la carpeta donde fueron almacenados?");__ ("Abrir carpeta");__ ("No"))
			If (OK=1)
				  //MONO TICKET 197245
				$t_openFolderPDF:=Choose:C955($t_rutaCarpetaDestino#"";$t_rutaCarpetaDestino;vt_rutaCarpetaPDF)
				SHOW ON DISK:C922($t_openFolderPDF;*)
			End if 
		End if 
		
		
	: ($t_destinoImpresion="html")
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242($y_tabla->;$al_recNums{$i})
			vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
			If (([xShell_Reports:54]ExecuteAfterEachRecord:32) | ($i=1))  //ABC //TKT//214337//20180813
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				$t_error:=EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			If ($t_error="")
				$l_refArea4DWR:=WR New offscreen area:P12000:47 
				WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
				WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
				WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;vt_nombreDoc;wr HTML 4 document:K12013:9)
				WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
			Else 
				$i:=Size of array:C274($al_recNums)
			End if 
		End for 
	: ($t_destinoImpresion="txt")
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242($y_tabla->;$al_recNums{$i})
			vt_nombreDoc:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
			vt_nombreDoc:=Replace string:C233(vt_nombreDoc;".txt";".rtf")
			If (([xShell_Reports:54]ExecuteAfterEachRecord:32) | ($i=1))  //ABC //TKT//214337//20180813
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			$l_refArea4DWR:=WR New offscreen area:P12000:47 
			WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
			WR EXECUTE COMMAND:P12000:113 ($l_refArea4DWR;wr cmd compute references:K12007:172)
			WR SAVE DOCUMENT:P12000:50 ($l_refArea4DWR;vt_nombreDoc;wr RTF document:K12013:3)
			WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
		End for 
		
	Else 
		$l_refArea4DWR:=WR New offscreen area:P12000:47 
		WR BLOB TO AREA:P12000:142 ($l_refArea4DWR;[xShell_Reports:54]xReportData_:29)
		WR PRINT MERGE:P12000:5 ($l_refArea4DWR;[xShell_Reports:54]MainTable:3;wr no print settings dialog:K12011:38)
		WR DELETE OFFSCREEN AREA:P12000:38 ($l_refArea4DWR)
End case 
  //WR DELETE OFFSCREEN AREA ($l_refArea4DWR)








