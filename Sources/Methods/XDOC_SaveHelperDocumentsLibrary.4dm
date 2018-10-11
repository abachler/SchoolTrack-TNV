//%attributes = {}
  //XDOC_SaveHelperDocumentsLibrary

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : SS_SaveCmdFile
	  //Autor: Alberto Bachler
	  //Creada el 20/8/96 a 4:24 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

C_TEXT:C284($file)
C_LONGINT:C283($nbRecords)

C_LONGINT:C283($nbRecords)
If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373(Current method name:C684;Pila_256K;"Guardando documentos externos")
Else 
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"HelperDocuments.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		READ ONLY:C145([xShell_Documents:91])
		QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RefType:10;=;"HLPR";*)
		QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=-1;*)
		QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedID:2=-1)
		FIRST RECORD:C50([xShell_Documents:91])
		While (Not:C34(End selection:C36([xShell_Documents:91])))
			SEND RECORD:C78([xShell_Documents:91])
			NEXT RECORD:C51([xShell_Documents:91])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 
