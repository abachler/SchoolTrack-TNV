//%attributes = {}
  //Metodo: QR_DeleteReportStandar_Dup

  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones

ARRAY LONGINT:C221($RecNum;0)
C_LONGINT:C283($i)

  // Código principal

READ WRITE:C146([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]IsStandard:38=True:C214)
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=True:C214)
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]MainTable:3>0)
SELECTION TO ARRAY:C260([xShell_Reports:54];$RecNum)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Eliminando informes Duplicados.")

For ($i;1;Size of array:C274($RecNum))
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($RecNum))
	GOTO RECORD:C242([xShell_Reports:54];$RecNum{$i})
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26=[xShell_Reports:54]ReportName:26)
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]IsStandard:38#True:C214)
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48#True:C214)
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]MainTable:3>0)
	DELETE SELECTION:C66([xShell_Reports:54])
	
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

KRL_UnloadReadOnly (->[xShell_Reports:54])