//%attributes = {}
  // QR_ImprimeInformeSRP()
  //
  //
  // creado por: Alberto Bachler Klein: 24-03-16, 17:26:54
  // -----------------------------------------------------------
C_LONGINT:C283($0;$1)  //MONO 18-07-2018 Ticket 210195
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_POINTER:C301($5)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_DestinoSNT)
C_LONGINT:C283($err;$i;$i_idxRegistro;$iSR_WinRef;$l_delimitadorRegistros;$l_error;$l_idSesion;$l_numeroTabla;$l_opcionesAjustesImpresion;$l_options)
C_LONGINT:C283($l_recNumInforme)
C_POINTER:C301($y_rutasDocumentos_at;$y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreArchivo;$t_impresora;$t_informeXML;$t_rutaCarpetaDestino;$t_rutaDocumento;$t_printer)
C_BOOLEAN:C305($b_abrirDirectorio)
C_LONGINT:C283($l_registros)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY PICTURE:C279($ap_Imagenes;0)
ARRAY TEXT:C222($at_modelos;0)
ARRAY TEXT:C222($at_printerNames;0)
ARRAY TEXT:C222($at_printerModels;0)
ARRAY TEXT:C222($at_rutaDocumentos;0)

If (False:C215)
	C_LONGINT:C283(QR_ImprimeInformeSRP ;$1)
	C_TEXT:C284(QR_ImprimeInformeSRP ;$2)
	C_TEXT:C284(QR_ImprimeInformeSRP ;$3)
	C_TEXT:C284(QR_ImprimeInformeSRP ;$4)
	C_POINTER:C301(QR_ImprimeInformeSRP ;$5)
	C_BOOLEAN:C305(QR_ImprimeInformeSRP ;$6)
End if 

C_TEXT:C284(vt_rutaCarpetaPDF;vsBWR_CurrentModule)
C_LONGINT:C283(vPeriodo)

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
	: (Count parameters:C259=5)
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreArchivo:=$4
		$y_rutasDocumentos_at:=$5
	: (Count parameters:C259=6)
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreArchivo:=$4
		$y_rutasDocumentos_at:=$5
		$b_DestinoSNT:=$6
	: (Count parameters:C259=7)  //20170225 RCH Por defecto no se muestra directorio en donde se genera el archivo. Si se necesitara mostrar, se debe pasar un true en $7
		$t_destinoImpresion:=$2
		$t_rutaCarpetaDestino:=$3
		$t_expresionNombreArchivo:=$4
		$y_rutasDocumentos_at:=$5
		$b_DestinoSNT:=$6
		$b_abrirDirectorio:=$7
End case 

$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

QR_InitGenericObjects 
dhSR_InitVariables 

READ ONLY:C145(*)
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")  // MOD Ticket 20180622 N° 210263 PA 
C_BOOLEAN:C305(b_ejecutarprop)


If (SR_ValidaScripts )
	$l_opcionesAjustesImpresion:=SRP_Print_AskJobSetup+(SRP_Print_AskPageSetup*Num:C11(Shift down:C543))
	
	  // MOD Ticket N° 209532 PA 20180616
	  //PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF)
	PREF_PreferenciasUsuario_GET (UserPrefs_PDFpath;->vt_rutaCarpetaPDF;0)
	
	
	USE NAMED SELECTION:C332("◊Editions")
	
	$l_numeroTabla:=Choose:C955([xShell_Reports:54]RelatedTable:14=0;[xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)
	$y_tabla:=Table:C252($l_numeroTabla)
	yBWR_currentTable:=$y_tabla
	xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
	vsBWR_CurrentModule:=[xShell_Reports:54]Modulo:41
	
	b_ejecutarprop:=True:C214
	
	SRP_ValidaAjustesImpresion ($l_recNumInforme)
	QR_PreProcesamiento ($y_tabla;$l_recNumInforme;->$al_recNums)
	
	If (OK=1)
		$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")  // MOD Ticket 20180622 N° 210263 PA 
		
		$l_registros:=Size of array:C274($al_recNums)
		
		If ($b_DestinoSNT)  //MONO TICKET 205388
			Case of 
				: (vyQR_TablePointer=->[Alumnos:2])
					$t_dts:=DTS_MakeFromDateTime 
					$t_expresionNombreArchivo:="\"inf_"+$t_dts+".\"+String([Alumnos]Número)"
			End case 
			
		End if 
		
		For ($i_idxRegistro;1;$l_registros)  //MONO 205131
			
			If ([xShell_Reports:54]isOneRecordReport:11)
				GOTO RECORD:C242($y_Tabla->;$al_recNums{$i_idxRegistro})
				$t_rutaDocumento:=Choose:C955($t_rutaCarpetaDestino#"";$t_rutaCarpetaDestino;vt_rutaCarpetaPDF)+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion;$b_DestinoSNT)  //+"."+$t_destinoImpresion
			Else 
				$t_rutaDocumento:=Choose:C955($t_rutaCarpetaDestino#"";$t_rutaCarpetaDestino;vt_rutaCarpetaPDF)+[xShell_Reports:54]ReportName:26+" - "+DTS_MakeFromDateTime +"."+$t_destinoImpresion
			End if 
			
			If (([xShell_Reports:54]ExecuteBeforeEachDocument:31) & ([xShell_Reports:54]ExecuteBeforePrinting:4#""))
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
			
			C_LONGINT:C283($l_session)
			Case of 
				: ($t_destinoImpresion="printer")
					  //MONO 215772: SRP_Print_NoDefaultPrinter Para imprimir en la impresora que viene en el XML informe, si está no existe en el equipo que estamos imprimiendo SR imprime en la impresora por defecto
					$l_error:=SR_Print ($t_informeXML;0;SRP_Print_NoDefaultPrinter;$t_rutaDocumento;0;$t_impresora)
					
				: ($t_destinoImpresion="preview")
					If (SYS_IsWindows )
						PRINTERS LIST:C789($at_printerNames;$at_printerModels)
						CREATE FOLDER:C475(Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview"+Folder separator:K24:12;*)
						Case of 
							: (Find in array:C230($at_printerNames;"@Microsoft Print to PDF@")>0)
								$t_printer:=$at_printerNames{Find in array:C230($at_printerNames;"@Microsoft Print to PDF@")}
							: (Find in array:C230($at_printerNames;"PDFCreator")>0)
								$t_printer:=$at_printerNames{Find in array:C230($at_printerNames;"@PDFCreator@")}
							: (Find in array:C230($at_printerNames;"Win2Pdf")>0)
								$t_printer:=$at_printerNames{Find in array:C230($at_printerNames;"@Win2Pdf@")}
							: (Find in array:C230($at_printerNames;"Microsoft XPS Document Writer")>0)
								$t_printer:=$at_printerNames{Find in array:C230($at_printerNames;"@Microsoft XPS Document Writer@")}
						End case 
						
						$t_doc:=Temporary folder:C486+"4D"+Folder separator:K24:12+"PrintPreview"+Folder separator:K24:12+Generate UUID:C1066+".pdf"
						$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPreview | SRP_Print_NoProgress | SRP_Print_WinPDFPreview;$t_doc;0;$t_printer)
						
						
					Else 
						$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPreview | SRP_Print_NoProgress;"";0;"")
					End if 
					
				: ($t_destinoImpresion="pdf")
					If ($i_idxRegistro=1)
						$b_impresionPDF_OK:=UTIL_ImpresoraPDF (->$t_impresora)
					End if 
					
					If ($b_impresionPDF_OK)
						If ($i_idxRegistro=1)
							  // Modificado por: Saúl Ponce (02-03-2017) Ticket 175452, si la carpeta no existe se crea. Si no se crea, el botón ubicar, al finalizar el proceso no encuentra la ruta.
							If (Not:C34(Test path name:C476(vt_rutaCarpetaPDF)=Is a folder:K24:2))
								CREATE FOLDER:C475(vt_rutaCarpetaPDF;*)
							End if 
						End if 
						
						$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPDF;$t_rutaDocumento;0;$t_impresora)
						
						If ((Not:C34(Is nil pointer:C315($y_rutasDocumentos_at))) & ($l_error=0))
							APPEND TO ARRAY:C911($at_rutaDocumentos;$t_rutaDocumento)
						End if 
					Else 
						$i_idxRegistro:=$l_registros+1
					End if 
					
					
				: ($t_destinoImpresion="xml")
					If ($i_idxRegistro=1)
						CREATE FOLDER:C475(SYS_GetParentNme ($t_rutaDocumento);*)  //20180228 RCH En pruebas no se creaba si no existía la carpeta que contiene el archivo
					End if 
					$err:=SR_ExportBLOB ([xShell_Reports:54]xReportData_:29;SRP_Export_XML+SRP_Export_Body;Tab:K15:37;$t_rutaDocumento;Carriage return:K15:38)
					If ((Not:C34(Is nil pointer:C315($y_rutasDocumentos_at))) & ($l_error=0))
						APPEND TO ARRAY:C911($at_rutaDocumentos;$t_rutaDocumento)
					End if 
					
				: ($t_destinoImpresion="file")
					$l_options:=SRP_Export_Text+SRP_Export_Body+SRP_Export_Headers+SRP_Export_Breaks+SRP_Export_Total+SRP_Export_StaticText
					$l_error:=SR_Export ($t_informeXML;$l_options;Tab:K15:37;$t_rutaDocumento;Carriage return:K15:38)
					If ((Not:C34(Is nil pointer:C315($y_rutasDocumentos_at))) & ($l_error=0))
						APPEND TO ARRAY:C911($at_rutaDocumentos;$t_rutaDocumento)
					End if 
					
				: ($t_destinoImpresion="html")
					$t_rutaDocumento:=$t_rutaCarpetaDestino+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion;$b_DestinoSNT)
					$l_error:=SR_Export ($t_informeXML;SRP_Export_HTML+SRP_Export_Headers;SRP_Export_Breaks+SRP_Export_Total+SRP_Export_StaticText+SRP_Export_Watermark)
					If ((Not:C34(Is nil pointer:C315($y_rutasDocumentos_at))) & ($l_error=0))
						APPEND TO ARRAY:C911($at_rutaDocumentos;$t_rutaDocumento)
					End if 
					
				: ($t_destinoImpresion="pict")
					If ($i_idxRegistro=1)
						AT_Initialize (->$ap_Imagenes)
						$l_error:=SR_PrintIntoPICT ($t_informeXML;-1;0;$ap_imagenes;SRP_PrintPict_PNG;$t_impresora)
					End if 
					
					For ($i;1;Size of array:C274($ap_imagenes))
						$t_rutaDocumento:=$t_rutaCarpetaDestino+__ ("pagina")+String:C10($i;"0000")+".png"
						WRITE PICTURE FILE:C680($t_rutaDocumento;$ap_imagenes{$i})
					End for 
				: ($t_destinoImpresion="txt")  //AOQ 20171103 Ticket 191617 Se genera caso para funcion "Enviar a archivo de texto", con mas de un registro en selección.
					If ($i_idxRegistro=1)
						CREATE FOLDER:C475(SYS_GetParentNme ($t_rutaDocumento);*)  //20180228 RCH En pruebas no se creaba si no existía la carpeta que contiene el archivo
					End if 
					$err:=SR_Export ($t_informeXML;SRP_Export_Text+SRP_Export_Body+SRP_Export_Breaks+SRP_Export_Total+SRP_Export_Headers;Tab:K15:37;$t_rutaDocumento;Carriage return:K15:38)
					If ((Not:C34(Is nil pointer:C315($y_rutasDocumentos_at))) & ($l_error=0))
						APPEND TO ARRAY:C911($at_rutaDocumentos;$t_rutaDocumento)
					End if 
					
			End case 
			
		End for 
		
	End if 
Else 
	CLEAR NAMED SELECTION:C333("◊Editions")  //20170315 RCH Si no se entra, la selección no se usa y no se limpiaba.
End if 

If (Not:C34(Is nil pointer:C315($y_rutasDocumentos_at)))
	COPY ARRAY:C226($at_rutaDocumentos;$y_rutasDocumentos_at->)
End if 

If (($t_destinoImpresion#"printer") & ($t_destinoImpresion#"preview") & (Size of array:C274($at_rutaDocumentos)>0) & (Not:C34(KRL_IsWebProcess )) & (Not:C34(Application type:C494=4D Server:K5:6)) & $b_abrirDirectorio)
	  // $b_abrirDirectorio:=True
Else 
	C_TEXT:C284($vt_name)
	C_LONGINT:C283($vl_state;$vl_time)
	PROCESS PROPERTIES:C336(Current process:C322;$vt_name;$vl_state;$vl_time)
	If ($vt_name="Impresion de:@")
		If ($t_destinoImpresion="pdf")
			$b_abrirDirectorio:=True:C214
		End if 
	End if 
End if 

If ($b_abrirDirectorio)
	OK:=ModernUI_Notificacion (__ ("Impresión de documentos en archivos");__ ("La impresión de documentos concluyó exitosamente\r\r¿Desea abrir la carpeta donde fueron almacenados?");__ ("Abrir carpeta");__ ("No"))
	If (OK=1)
		  //MONO TICKET 197245
		$t_openFolderPDF:=Choose:C955($t_rutaCarpetaDestino#"";$t_rutaCarpetaDestino;vt_rutaCarpetaPDF)
		SHOW ON DISK:C922($t_openFolderPDF;*)
	End if 
End if 

If ($l_idSesion#0)
	SR_CloseSession ($l_idSesion)
End if 

$0:=$l_registros  //MONO 18-07-2018 Ticket 210195