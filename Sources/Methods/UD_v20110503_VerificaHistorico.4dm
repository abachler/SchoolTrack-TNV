//%attributes = {}
  //UD_v20110503_VerificaHistorico
  //20110503 RCH Por un defecto que permitia crear registros de sintesis anual historico
  // ... sin registros de alumnos_historico, se crea este metodo para validacion...

C_LONGINT:C283($i;$vl_proc)
ARRAY TEXT:C222(aQR_Text1;0)

READ ONLY:C145([Alumnos_SintesisAnual:210])

$vl_proc:=IT_UThermometer (1;0;__ ("Verificando registros históricos..."))
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4<0)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]LlavePrincipal:5;aQR_Text1)
IT_UThermometer (-2;$vl_proc)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando registros históricos..."))
For ($i;1;Size of array:C274(aQR_Text1))
	STRal_CreaHistorico (aQR_Text1{$i})
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Text1))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)