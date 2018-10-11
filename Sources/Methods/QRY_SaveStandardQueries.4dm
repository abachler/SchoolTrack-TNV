//%attributes = {}
  //QRY_SaveStandardQueries

If (False:C215)
	  //Method: `QRY_SaveStandardQueries
	  //Written by  Administrateur on 16/03/99
	  //Module: 
	  //Purpose: 
	  //Syntax:  `QRY_SaveStandardQueries()
	  //Parameters:
	  //Copyright 1999 Transeo Chile
End if 


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("QRY_SaveStandardQueries";Pila_256K;"Guardando biblioteca de consultas")
Else 
	
	
	
	  //DECLARATIONS
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	C_PICTURE:C286($pict)
	C_LONGINT:C283(nbRecords)
	
	  //INITIALIZATION
	
	
	  //MAIN CODE
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Queries.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		QUERY:C277([xShell_Queries:53];[xShell_Queries:53]No:1<0)
		nbRecords:=Records in selection:C76([xShell_Queries:53])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xShell_Queries:53])
		While (Not:C34(End selection:C36([xShell_Queries:53])))
			SEND RECORD:C78([xShell_Queries:53])
			NEXT RECORD:C51([xShell_Queries:53])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 

