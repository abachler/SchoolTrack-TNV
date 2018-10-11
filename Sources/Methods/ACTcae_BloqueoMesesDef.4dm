//%attributes = {}
  //ACTcae_BloqueoMesesDef

READ WRITE:C146([xxACT_CierresMensuales:108])
$iterations:=(12*(vl_Año-2000))+vl_Mes
$currentIteration:=0
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Bloqueando meses en forma definitiva..."))
For ($i;2000;vl_Año-1)
	For ($j;1;12)
		$currentIteration:=$currentIteration+1
		QUERY:C277([xxACT_CierresMensuales:108];[xxACT_CierresMensuales:108]Mes:1=$j;*)
		QUERY:C277([xxACT_CierresMensuales:108]; & ;[xxACT_CierresMensuales:108]Año:2=$i)
		If (Records in selection:C76([xxACT_CierresMensuales:108])=1)
			[xxACT_CierresMensuales:108]BloqueoDefinitivo:3:=True:C214
			SAVE RECORD:C53([xxACT_CierresMensuales:108])
		Else 
			CREATE RECORD:C68([xxACT_CierresMensuales:108])
			[xxACT_CierresMensuales:108]Mes:1:=$j
			[xxACT_CierresMensuales:108]Año:2:=$i
			[xxACT_CierresMensuales:108]BloqueoDefinitivo:3:=True:C214
			SAVE RECORD:C53([xxACT_CierresMensuales:108])
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Bloqueando meses en forma definitiva..."))
	End for 
End for 
For ($i;1;vl_Mes)
	$currentIteration:=$currentIteration+1
	QUERY:C277([xxACT_CierresMensuales:108];[xxACT_CierresMensuales:108]Mes:1=$i;*)
	QUERY:C277([xxACT_CierresMensuales:108]; & ;[xxACT_CierresMensuales:108]Año:2=vl_Año)
	If (Records in selection:C76([xxACT_CierresMensuales:108])=1)
		[xxACT_CierresMensuales:108]BloqueoDefinitivo:3:=True:C214
		SAVE RECORD:C53([xxACT_CierresMensuales:108])
	Else 
		CREATE RECORD:C68([xxACT_CierresMensuales:108])
		[xxACT_CierresMensuales:108]Mes:1:=$i
		[xxACT_CierresMensuales:108]Año:2:=vl_Año
		[xxACT_CierresMensuales:108]BloqueoDefinitivo:3:=True:C214
		SAVE RECORD:C53([xxACT_CierresMensuales:108])
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Bloqueando meses en forma definitiva..."))
End for 
KRL_UnloadReadOnly (->[xxACT_CierresMensuales:108])
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)