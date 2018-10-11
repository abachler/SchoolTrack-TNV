//%attributes = {}
  //UD_v20150422_CleanCTlog 
C_LONGINT:C283($proc;$recs;$i)

$proc:=IT_UThermometer (1;0;__ ("Buscando registro de actividades de Commtrack..."))
MESSAGES OFF:C175
READ ONLY:C145([xxSNT_LOG:93])

QUERY:C277([xxSNT_LOG:93];[xxSNT_LOG:93]Modulo:8=CommTrack;*)
QUERY:C277([xxSNT_LOG:93]; & ;[xxSNT_LOG:93]Event:3="No hay datos a transferir.")
CREATE SET:C116([xxSNT_LOG:93];"log")
$recs:=Records in set:C195("log")
REDUCE SELECTION:C351([xxSNT_LOG:93];0)
IT_UThermometer (-2;$proc)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Limpiando registro de actividades de Commtrack...")

For ($i;1;$recs)
	READ WRITE:C146([xxSNT_LOG:93])
	USE SET:C118("log")
	REDUCE SELECTION:C351([xxSNT_LOG:93];10000)
	DELETE SELECTION:C66([xxSNT_LOG:93])
	KRL_UnloadReadOnly (->[xxSNT_LOG:93])
	$i:=$i+9999
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$recs)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

CLEAR SET:C117("log")
