//%attributes = {}
  // ACTac_ImprimePDF()
  //
  //
  // modificado por: Alberto Bachler Klein: 26-12-16, 17:45:13
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BLOB:C604($x_blob;$x_documento)
C_BOOLEAN:C305($b_continuar;$b_impresionPDF_OK;$b_Relacion_Muchos_a_Uno;$b_Relacion_Uno_a_muchos)
C_LONGINT:C283($l_error;$l_IdAvisoCobranza;$l_modeloAviso;$l_recNumAviso;$l_recNumInforme)
C_TEXT:C284($t_error;$t_impresora;$t_impresoraPDF;$t_informeXML;$t_nombreDocumento;$t_RutaAvisoPDF;$t_RutaAvisoSNT;$t_rutaCarpetaArchivos;$t_RutaCarpetaAvisosPDF;$t_RutaCarpetaAvisosSNT)
C_TEXT:C284($t_rutaDocumentoPDF_temp;$t_separador)


If (False:C215)
	C_BOOLEAN:C305(ACTac_ImprimePDF ;$0)
	C_LONGINT:C283(ACTac_ImprimePDF ;$1)
End if 

$l_IdAvisoCobranza:=$1
$l_modeloAviso:=Num:C11(PREF_fGet (0;"ACT_AvisoSeleccionado2PDF";"0"))
$l_recNumInforme:=Find in field:C653([xShell_Reports:54]ID:7;$l_modeloAviso)
$l_recNumAviso:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$l_IdAvisoCobranza)



If ($l_modeloAviso#0)
	$b_impresionPDF_OK:=UTIL_ImpresoraPDF 
	$b_continuar:=$b_impresionPDF_OK & ($l_recNumInforme>No current record:K29:2) & ($l_recNumAviso>No current record:K29:2)
	
	
	
	If ($b_continuar)
		  // determino las rutas
		$t_separador:=SYS_FolderDelimiterOnServer 
		$t_nombreDocumento:="AC_"+String:C10($l_IdAvisoCobranza)+".pdf"
		$t_rutaDocumentoPDF_temp:=Temporary folder:C486+$t_nombreDocumento
		$t_RutaCarpetaAvisosPDF:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"AvisosPDF"  // obtengo la ruta de la carpeta Archivos (en el servidor o en el monousuario)
		$t_RutaCarpetaAvisosSNT:=SYS_CarpetaAplicacion (CLG_Intercambios_SNT)+"AvisosPDF4SN"  // creo la carpeta en toda, sin importar si la licencia SNT esta activada, no perdemos nada
		SYS_CreaCarpetaServidor ($t_RutaCarpetaAvisosPDF)  // si la aplicación es monousuario o intepretada la carpeta se crea localmente
		SYS_CreaCarpetaServidor ($t_RutaCarpetaAvisosSNT)  // si la aplicación es monousuario o intepretada la carpeta se crea localmente
		$t_RutaAvisoPDF:=$t_RutaCarpetaAvisosPDF+$t_separador+$t_nombreDocumento
		$t_RutaAvisoSNT:=$t_RutaCarpetaAvisosSNT+$t_separador+$t_nombreDocumento
		
		
		  // cargo el aviso de cobranza a imprimir
		KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$l_recNumAviso;False:C215)
		  // inicializo la impresion
		QR_InitGenericObjects 
		SRACTac_InitPrintingVariables 
		vlSR_RegXPagina:=1
		vb_HideColsCtas:=False:C215
		vb_HideColAfecto:=False:C215
		SRACTac_CargaCargos (1)
		SRACTac_HideNonUsedObjects 
		GET AUTOMATIC RELATIONS:C899($b_Relacion_Muchos_a_Uno;$b_Relacion_Uno_a_muchos)
		
		  // cargo el informe
		KRL_GotoRecord (->[xShell_Reports:54];$l_recNumInforme;False:C215)
		$x_blob:=[xShell_Reports:54]xReportData_:29
		$l_error:=SR SetDestination (SR PrintDestination File;$t_rutaDocumentoPDF_temp)
		
		$l_error:=SR Print Report ($x_blob;SRP_Print_DestinationPDF;SR All Sections)
		
		If (False:C215)
			  // por alguna razon que no he descubierto los comandos de la API de SRP3 no funcionan bien en este caso (el resultado es un PDF vacío)
			  //$l_error:=SR_ConvertReportToXML ($x_blob;$t_informeXML;[xShell_Reports]ReportName;"SR_ExecuteScript")
			  //$l_error:=SR_Print ($t_informeXML;0;SRP_Print_DestinationPDF+SRP_Print_WinPDFNoFonts;$t_rutaDocumentoPDF_temp;0;$t_impresora)
		End if 
		
		SET AUTOMATIC RELATIONS:C310($b_Relacion_Muchos_a_Uno;$b_Relacion_Uno_a_muchos)
		SRACTac_EndAviso (1)
		
		  // almaceno el documento PDF en la carpeta AvisosPDF y en la carpeta AvisosPDFSN, ambas en la carpeta Archivos en la ruta del archivo de datos
		$t_error:=KRL_CopyFileToServer ($t_rutaDocumentoPDF_temp;$t_RutaAvisoPDF;True:C214)
		If ((LICENCIA_esModuloAutorizado (1;SchoolNet)) & ($t_error=""))
			$t_error:=KRL_CopyFileToServer ($t_rutaDocumentoPDF_temp;$t_RutaAvisoSNT;True:C214)
		End if 
		
		  // elimino el documento PDF de la carpeta temporal
		SYS_DeleteFile ($t_rutaDocumentoPDF_temp)
	End if 
	
	
Else 
	  //NOTIFICAR!!!
	$0:=True:C214
End if 