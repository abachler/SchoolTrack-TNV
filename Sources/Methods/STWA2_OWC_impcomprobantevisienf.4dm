//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:03:07
  // ----------------------------------------------------
  // Método: STWA2_OWC_impcomprobantevisienf
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
  // 22-06-17 Patricio Aliaga: Modificacion Ticket N° 183332
  // Se cambia la forma en la que se imprime el PDF para su visuzalicion en STWA
  // se cambia la variable del archivo que se debe eliminar posterior al uso de la impresion.


C_TEXT:C284($1;$0;$uuid;$t_impresora;$t_informeXML)
$t_impresora:=""
$t_informeXML:=""
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$idvisita:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
$modelo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"modelo"))
If (KRL_FindAndLoadRecordByIndex (->[xShell_Reports:54]ID:7;->$modelo;False:C215)>-1)
	$b_impresionPDF_OK:=UTIL_ImpresoraPDF (->$t_impresora)
	If (Not:C34($b_impresionPDF_OK))
		WEB SEND TEXT:C677("La impresora Win2PDF no está disponible en el servidor o monousuario. Por favor contacte al administrador del sistema.")
	Else 
		KRL_GotoRecord (->[Alumnos_EventosEnfermeria:14];$idvisita;False:C215)
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;False:C215)
		  //$x_blob:=[xShell_Reports]xReportData_
		$t_rutaDocumentoPDF_temp:=Temporary folder:C486+"enf_"+String:C10($idvisita)+".pdf"
		
		$tableNumber:=Abs:C99([xShell_Reports:54]MainTable:3)
		$tablePointer:=Table:C252($tableNumber)
		yBWR_currentTable:=$tablePointer
		COPY NAMED SELECTION:C331([Alumnos:2];"◊Editions")
		GET AUTOMATIC RELATIONS:C899($one;$many)
		  //$l_error:=SR SetDestination (SR PrintDestination File;$t_rutaDocumentoPDF_temp)
		  //$l_error:=SR Print Report ($x_blob;SRP_Print_DestinationPDF+SRP_Print_WinPDFNoFonts;SR All Sections)
		$l_error:=SR_ConvertReportToXML ([xShell_Reports:54]xReportData_:29;$t_informeXML)
		$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPDF;$t_rutaDocumentoPDF_temp;0;$t_impresora)
		
		SET AUTOMATIC RELATIONS:C310($one;$many)
		If (SYS_TestPathName ($t_rutaDocumentoPDF_temp)=Is a document:K24:1)
			C_BLOB:C604($docBlob;0)
			DOCUMENT TO BLOB:C525($t_rutaDocumentoPDF_temp;$docBlob)
			ARRAY TEXT:C222($hNames;2)
			ARRAY TEXT:C222($hValues;2)
			$hNames{1}:="Content-Type"
			$hNames{2}:="Content-Disposition"
			$hValues{1}:="application/pdf"
			$hValues{2}:="inline"
			WEB SET HTTP HEADER:C660($hNames;$hValues)
			WEB SEND RAW DATA:C815($docBlob;*)
			  //DELETE DOCUMENT($fileName)
			DELETE DOCUMENT:C159($t_rutaDocumentoPDF_temp)
			
		Else 
			WEB SEND TEXT:C677("No se encontró el reporte en PDF. Por favor contacte al administrador del sistema.")
		End if 
	End if 
Else 
	WEB SEND TEXT:C677("No se encontró el modelo de impresión. Por favor contacte al administrador del sistema.")
End if 
