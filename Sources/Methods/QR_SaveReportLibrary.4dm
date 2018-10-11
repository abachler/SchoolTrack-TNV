//%attributes = {}
  //QR_SaveReportLibrary

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 26/07/03, 19:59:47
  // -------------------------------------------------------------------------------
  // Metodo: QR_SaveReportLibrary
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================



  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_TEXT:C284($file)
_O_C_STRING:C293(15;fileHeader)
C_LONGINT:C283(nbRecords)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------


  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("QR_SaveReportLibrary";Pila_256K;"Guardando biblioteca de informes")
Else 
	
	RIN_DescargaLibreria 
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Informes.txt"
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		READ WRITE:C146([xShell_Reports:54])
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]IsStandard:38=True:C214)
		nbRecords:=Records in selection:C76([xShell_Reports:54])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xShell_Reports:54])
		While (Not:C34(End selection:C36([xShell_Reports:54])))
			[xShell_Reports:54]Public:8:=True:C214
			SAVE RECORD:C53([xShell_Reports:54])
			SEND RECORD:C78([xShell_Reports:54])
			NEXT RECORD:C51([xShell_Reports:54])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 


  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------





