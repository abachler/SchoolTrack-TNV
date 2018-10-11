//%attributes = {}
  //ACTbw_RecalculaCtasCtes

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando Cuentas Corrientes..."))
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	ALL RECORDS:C47([ACT_CuentasCorrientes:175])
	ARRAY LONGINT:C221($aIDCC;0)
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$aIDCC)
	For ($y;1;Size of array:C274($aIDCC))
		ACTcc_CalculaMontos ($aIDCC{$y})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274($aIDCC))
	End for 
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 