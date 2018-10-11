//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 17-05-18, 14:58:56
  // ----------------------------------------------------
  // Método: SR_PrintReports
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($l_error;$l_recNumInf;$l_session)
C_POINTER:C301($y_NombreDoc;$y_RecNumReporte;$y_rutaDocumento;$y_sesionImpresion)
C_TEXT:C284($t_accion;$t_informeXML;$t_NombreDoc)
C_TEXT:C284($t_impresora)

$t_accion:=$1

Case of 
	: ($t_accion="openSession")
		$y_rutaDocumento:=$2
		$y_NombreDoc:=$3
		$y_sesionImpresion:=$4  //20180518 RCH
		
	: ($t_accion="CloseSession")
		$y_sesionImpresion:=$2
		
	Else 
		$y_RecNumReporte:=$2
		$y_rutaDocumento:=$3
		$y_sesionImpresion:=$4
		
End case 

Case of 
	: ($t_accion="openSession")
		$l_error:=SR_OpenSession ($l_session;SRP_Print_DestinationPDF | SRP_Print_NoProgress;$y_rutaDocumento->;$t_informeXML;$y_NombreDoc->;"")
		$y_sesionImpresion->:=$l_session
		
	: ($t_accion="print")
		
		UTIL_ImpresoraPDF (->$t_impresora)
		
		GOTO RECORD:C242([xShell_Reports:54];$y_RecNumReporte->)
		$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML;[xShell_Reports:54]ReportName:26;"SRdh_ExecuteScript")
		
		If (SR_ValidaScripts )
			QR_PreProcesamiento (vyQR_TablePointer;$y_RecNumReporte->)
			If (Not:C34([xShell_Reports:54]NoRequiereSeleccion:40))
				If ([xShell_Reports:54]isOneRecordReport:11)
					If (([xShell_Reports:54]ExecuteBeforeEachDocument:31) & ([xShell_Reports:54]ExecuteBeforePrinting:4#""))
						SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
						EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					Else 
						If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
							SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
							EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
							SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						End if 
					End if 
				Else 
					If ([xShell_Reports:54]ExecuteBeforePrinting:4#"")
						SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
						EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					End if 
				End if 
			End if 
		End if 
		If (OK=1)
			$l_error:=SR_Print ($t_informeXML;0;SRP_Print_NoProgress;$y_rutaDocumento->;$y_sesionImpresion->;$t_impresora)
		End if 
		
	: ($t_accion="CloseSession")
		$l_error:=SR_CloseSession ($y_sesionImpresion->)
End case 
$0:=$l_error



