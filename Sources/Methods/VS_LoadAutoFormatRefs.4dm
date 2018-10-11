//%attributes = {}
  //VS_LoadAutoFormatRefs



If (False:C215)
	  //Method: vs_LoadAutoFormatRefs
	  //Written by  Alberto Bachler on 27/3/98
	  //Module: Virtual Structure
	  //Purpose: Load field reference to autoformatable configured fields
	  //Syntax:  INIT_AutoFormatables()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
End if 


  //DECLARATIONS
ARRAY INTEGER:C220(<>aL_AutoFormatFile;0)
ARRAY INTEGER:C220(<>aL_AutoFormatfield;0)
ARRAY REAL:C219(<>aR_AutoFormatOpts;0)

  //INITIALIZATION


  //MAIN CODE
MESSAGES OFF:C175
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]FormatoNombres:15>0)
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroTabla:1;<>aL_AutoFormatFile;[xShell_Fields:52]NumeroCampo:2;<>aL_AutoFormatfield;[xShell_Fields:52]FormatoNombres:15;<>aR_AutoFormatOpts)

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 