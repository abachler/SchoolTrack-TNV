//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 12-06-18, 10:48:37
  // ----------------------------------------------------
  // Método: QR_PrintInfSuperReport
  // Descripción
  // Parámetros
  // 20180903 actualización para menejo de sesión de impresión en destination print y pdf
  // ----------------------------------------------------

C_LONGINT:C283($1;$l_recNumInforme)
C_TEXT:C284($2;$t_destinoImpresion;$3;$t_rutaArchivoImpresion;$t_nombreArchivo)
C_BOOLEAN:C305($4;$b_printSettings;$6;$b_closeSession)
C_TEXT:C284($t_informeXML;$t_impresora)
C_LONGINT:C283($l_error;$i;$iSR_WinRef;$l_numeroTabla;$l_opcionesAjustesImpresion;$l_options;$l_session;$5)
C_BLOB:C604($x_blob)
C_POINTER:C301($y_tabla)
C_OBJECT:C1216($0;$o_resp)

ARRAY PICTURE:C279($ap_imagenes;0)

$l_recNumInforme:=$1
$t_destinoImpresion:=$2
$t_rutaArchivoImpresion:=$3
$b_printSettings:=$4
$l_session:=$5
$b_closeSession:=$6

$t_nombreArchivo:=SYS_Path2FileName ($t_rutaArchivoImpresion)
$t_destinoImpresion:=Choose:C955($t_destinoImpresion="";"printer";$t_destinoImpresion)

READ ONLY:C145([xShell_Reports:54])
GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")

  //$l_opcionesAjustesImpresion:=SRP_Print_AskJobSetup+(SRP_Print_AskPageSetup*Num(Shift down))
$l_numeroTabla:=Choose:C955([xShell_Reports:54]RelatedTable:14=0;[xShell_Reports:54]MainTable:3;[xShell_Reports:54]RelatedTable:14)
$y_tabla:=Table:C252($l_numeroTabla)

Case of 
	: ($t_destinoImpresion="printer")
		  //If ($b_printSettings)
		  //$l_opcionesAjustesImpresion:=$l_opcionesAjustesImpresion+SRP_Print_DestinationPrinter
		  //End if 
		If ($l_session=0)
			$l_error:=SR_OpenSession ($l_session;SRP_Print_DestinationPrinter+SRP_Print_NoProgress;"";$t_informeXML;"";"")
		End if 
		$l_error:=SR_Print ($t_informeXML;0;SRP_Print_NoProgress;"";$l_session)
		If ($b_closeSession)
			$l_error:=SR_CloseSession ($l_session)
		End if 
		
		  //$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPrinter;$t_rutaArchivoImpresion;0;$t_impresora)
		
	: ($t_destinoImpresion="preview")
		SR_SetTextProperty (0;0;SRP_Area_WinPreviewName;$t_rutaArchivoImpresion)
		$iSR_WinRef:=SR Preview ([xShell_Reports:54]xReportData_:29;10;60;790;Screen height:C188-20;8;"Vista preliminar de "+[xShell_Reports:54]ReportName:26;1)
		SR_SetTextProperty (0;0;SRP_Area_WinPreviewName;"")
		
	: ($t_destinoImpresion="pdf")
		If ($l_session=0)
			$l_error:=SR_OpenSession ($l_session;SRP_Print_DestinationPDF+SRP_Print_NoProgress;$t_rutaArchivoImpresion;$t_informeXML;$t_nombreArchivo;"")
		End if 
		$l_error:=SR_Print ($t_informeXML;0;SRP_Print_NoProgress;"";$l_session)
		If ($b_closeSession)
			$l_error:=SR_CloseSession ($l_session)
		End if 
		  //$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPDF;$t_rutaArchivoImpresion;0;$t_impresora)
		
	: ($t_destinoImpresion="xml")
		$l_error:=SR_ExportBLOB ([xShell_Reports:54]xReportData_:29;SRP_Export_XML+SRP_Export_Body;Tab:K15:37;$t_rutaArchivoImpresion;Carriage return:K15:38)
		
	: ($t_destinoImpresion="file")
		$l_options:=SRP_Export_Text+SRP_Export_Body+SRP_Export_Headers+SRP_Export_Breaks+SRP_Export_Total+SRP_Export_StaticText
		$l_error:=SR_Export ($t_informeXML;$l_options;Tab:K15:37;$t_rutaArchivoImpresion;Carriage return:K15:38)
		
	: ($t_destinoImpresion="html")
		$l_error:=SR_Export ($t_informeXML;SRP_Export_HTML+SRP_Export_Headers;SRP_Export_Breaks+SRP_Export_Total+SRP_Export_StaticText+SRP_Export_Watermark)
		
	: ($t_destinoImpresion="pict")
		$l_error:=SR_PrintIntoPICT ($t_informeXML;-1;0;$ap_imagenes;SRP_PrintPict_PNG;$t_impresora)
		For ($i;1;Size of array:C274($ap_imagenes))
			WRITE PICTURE FILE:C680($t_rutaArchivoImpresion;$ap_imagenes{$i})
		End for 
	: ($t_destinoImpresion="txt")
		$l_error:=SR_Export ($t_informeXML;SRP_Export_Text+SRP_Export_Body+SRP_Export_Breaks+SRP_Export_Total+SRP_Export_Headers;Tab:K15:37;$t_rutaArchivoImpresion;Carriage return:K15:38)
		
End case 

OB SET:C1220($o_resp;"error";$l_error)
OB SET:C1220($o_resp;"printSessionID";$l_session)

$0:=$o_resp
