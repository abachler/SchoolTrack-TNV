//%attributes = {}
  //QRY_LoadLibrary

If (False:C215)
	  //Method: ss_LoadStandardQueries
	  //Written by  Administrateur on 16/03/99
	  //Module: 
	  //Purpose: 
	  //Syntax:  ss_LoadStandardQueries()
	  //Parameters:
	  //Copyright 1999 Transeo Chile
	<>ST_v532:=False:C215
End if 


  //DECLARATIONS
C_DATE:C307($date)
C_TIME:C306($time)

  //INITIALIZATION
$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Queries.txt"

  //MAIN CODE
SET CHANNEL:C77(10;$file)
If (ok=1)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando la consultas pre-definidas…"))
	READ WRITE:C146([xShell_Queries:53])
	QUERY:C277([xShell_Queries:53];[xShell_Queries:53]No:1<0)
	DELETE SELECTION:C66([xShell_Queries:53])
	RECEIVE VARIABLE:C81(nbRecords)
	For ($k;1;nbrecords)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords;__ ("Actualizando la lista de consultas pre-definidas…"))
		CREATE RECORD:C68([xShell_Queries:53])
		RECEIVE RECORD:C79([xShell_Queries:53])
		SAVE RECORD:C53([xShell_Queries:53])
	End for 
	SET CHANNEL:C77(11)
	READ ONLY:C145([xShell_Queries:53])
	SQ_RestauraSecuencias (->[xShell_Queries:53]No:1)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
Else 
	$r:=CD_Dlog (1;__ ("El archivo que contiene las consultas predefinidas no pudo ser cargado."))
End if 

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 