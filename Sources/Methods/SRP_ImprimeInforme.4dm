//%attributes = {}
  //  // SRP_ImprimeInforme()
  //  // Por: Alberto Bachler K.: 24-08-15, 11:05:59
  //  //  ---------------------------------------------
  //  //
  //  //
  //  //  ---------------------------------------------
  //C_POINTER($1)
  //C_LONGINT($2)
  //C_TEXT($3)
  //C_TEXT($4)
  //C_TEXT($5)

  //C_LONGINT($i_idxRegistro;$l_delimitadorRegistros;$l_error;$l_numeroTabla;$l_recNumInforme)
  //C_POINTER($y_tabla)
  //C_TEXT($t_destinoImpresion;$t_expresionNombreArchivo;$t_impresora;$t_informeXML;$t_rutaCarpetaDestino;$t_rutaDocumento)
  //C_BLOB($x_blob)

  //ARRAY LONGINT($al_recNums;0)
  //ARRAY PICTURE($ap_Imagenes;0)



  //If (False)
  //C_POINTER(SRP_ImprimeInforme ;$1)
  //C_LONGINT(SRP_ImprimeInforme ;$2)
  //C_TEXT(SRP_ImprimeInforme ;$3)
  //C_TEXT(SRP_ImprimeInforme ;$4)
  //C_TEXT(SRP_ImprimeInforme ;$5)
  //End if 

  //$y_tabla:=$1
  //$l_recNumInforme:=$2

  //Case of 
  //: (Count parameters=3)
  //$t_destinoImpresion:=$3
  //: (Count parameters=4)
  //$t_destinoImpresion:=$3
  //$t_rutaCarpetaDestino:=$4
  //: (Count parameters=5)
  //$t_destinoImpresion:=$3
  //$t_rutaCarpetaDestino:=$4
  //$t_expresionNombreArchivo:=$5
  //End case 

  //If ($t_destinoImpresion="pdf")
  //$t_impresora:=SRP_ImpresoraPDF 
  //End if 



  //READ ONLY(*)
  //GOTO RECORD([xShell_Reports];$l_recNumInforme)

  //If (SR_ValidaScripts )
  //If ($t_rutaCarpetaDestino#"")
  //$t_rutaCarpetaDestino:=$t_rutaCarpetaDestino+[xShell_Reports]ReportName+Folder separator
  //SYS_CreateFolder ($t_rutaCarpetaDestino)
  //End if 

  //USE NAMED SELECTION("◊Editions")
  //$l_numeroTabla:=Abs([xShell_Reports]MainTable)
  //$y_tabla:=Table($l_numeroTabla)
  //yBWR_currentTable:=$y_tabla
  //xSR_ReportBlob:=[xShell_Reports]xQR_ReportData

  //SRP_ValidaAjustesImpresion ($l_recNumInforme)
  //QR_PreProcesamiento ($y_tabla;$l_recNumInforme)

  //If (Not([xShell_Reports]NoRequiereSeleccion))
  //If ([xShell_Reports]isOneRecordReport)
  //SELECTION TO ARRAY($y_Tabla->;$al_recNums)
  //GOTO RECORD($y_Tabla->;$al_recNums{1})
  //If (([xShell_Reports]ExecuteBeforeEachDocument) & ([xShell_Reports]ExecuteBeforePrinting))
  //SET AUTOMATIC RELATIONS(True;False)
  //SR_ExecuteScript ([xShell_Reports]ExecuteBeforePrinting)
  //SET AUTOMATIC RELATIONS(False;False)
  //End if 
  //End if 
  //End if 

  //If (([xShell_Reports]isOneRecordReport) & ($t_expresionNombreArchivo#"") & ($t_rutaCarpetaDestino#""))
  //$t_rutaDocumento:=$t_rutaCarpetaDestino+SRP_EvaluaNombreArchivo ($t_expresionNombreArchivo)+".pdf"
  //Else 
  //$t_rutaDocumento:=$t_rutaCarpetaDestino+Replace string(String(Current date;ISO date GMT;Current time);Folder separator;"-")+"."+$t_destinoImpresion
  //End if 

  //$l_error:=SR_ConvertReportToXML ([xShell_Reports]xQR_ReportData;$t_informeXML;[xShell_Reports]ReportName;"SR_ExecuteScript")
  //Case of 
  //: ($t_destinoImpresion="printer")
  //$l_error:=SR_Print ($t_informeXML;-1;SRP_Print_DestinationPrinter+SRP_Print_SimplePageSetup;"";0;"")

  //: ($t_destinoImpresion="preview")
  //$l_error:=SR_Print ($t_informeXML;-1;SRP_Print_DestinationPreview;"";0;"")

  //: ($t_destinoImpresion="pdf")
  //$l_error:=SR_Print ($t_informeXML;-1;SRP_Print_DestinationPDF+SRP_Print_WinPDFNoFonts+SRP_Print_AskPageSetup;$t_rutaDocumento;0;$t_impresora)

  //: ($t_destinoImpresion="txt")
  //$err:=SR Print Disk (xSR_ReportBlob;$t_rutaDocumento;SR PrintToDisk Static Text;SR All Sections;9;13;SR Generic Option Set On)

  //: ($t_destinoImpresion="html")
  //$err:=SR Print HTML (xSR_ReportBlob;$t_rutaDocumento;SR PrintToDisk Static Text;SR All Sections;SR Generic Option Set On)

  //: ($t_destinoImpresion="pict")
  //AT_Initialize (->$ap_Imagenes)
  //$l_error:=SR_PrintIntoPICT ($t_informeXML;-1;SRP_Print_SimplePageSetup;$ap_imagenes;SRP_PrintPict_PNG;$t_impresora)
  //For ($i;1;Size of array($ap_imagenes))
  //$t_rutaDocumento:=Replace string($t_rutaDocumento;"pict";"")+"_"+String($i)+".png"
  //WRITE PICTURE FILE($t_rutaDocumento;$ap_imagenes{$i})
  //End for 
  //End case 

  //For ($i_idxRegistro;2;Size of array($al_recNums))
  //GOTO RECORD($y_Tabla->;$al_recNums{$i_idxRegistro})
  //If (([xShell_Reports]ExecuteBeforeEachDocument) & ([xShell_Reports]ExecuteBeforePrinting))
  //SET AUTOMATIC RELATIONS(True;False)
  //SR_ExecuteScript ([xShell_Reports]ExecuteBeforePrinting)
  //SET AUTOMATIC RELATIONS(False;False)
  //End if 

  //Case of 
  //: ($t_destinoImpresion="printer")
  //$l_error:=SR_Print ($t_informeXML;-1;SRP_Print_DestinationPrinter;"";0;$t_impresora)

  //: ($t_destinoImpresion="preview")
  //$l_error:=SR_Print ($t_informeXML;-1;SRP_Print_DestinationPreview;"";0;$t_impresora)

  //: ($t_destinoImpresion="pdf")
  //$l_error:=SR_Print ($t_informeXML;-1;SRP_Print_ValidatePageSetup+SRP_Print_DestinationPDF+SRP_Print_WinPDFNoFonts;$t_rutaDocumento;0;$t_impresora)

  //: ($t_destinoImpresion="file")
  //$l_error:=SR_Export ($t_informeXML;-1;SRP_Export_PlainText+SRP_Export_Headers;SRP_Export_Breaks+SRP_Export_Total+SRP_Export_StaticText;$t_rutaDocumento;0;$t_impresora)

  //: ($t_destinoImpresion="html")
  //$t_rutaDocumento:=$t_rutaCarpetaDestino+SRP_EvaluaNombreArchivo ($t_expresionNombreArchivo)
  //$l_error:=SR_Export ($t_informeXML;SRP_Export_HTML+SRP_Export_Headers;SRP_Export_Breaks+SRP_Export_Total+SRP_Export_StaticText+SRP_Export_Watermark)

  //: ($t_destinoImpresion="pict")
  //$l_error:=SR_PrintIntoPICT ($t_informeXML;-1;SRP_Print_SimplePageSetup;$ap_imagenes;0;$t_impresora)
  //End case 

  //End for 
  //End if 