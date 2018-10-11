//%attributes = {}
  //CMT_LoadSTLog

C_DATE:C307($date)
$date:=Add to date:C393(Current date:C33(*);0;-2;0)

READ ONLY:C145([xxSNT_LOG:93])
QUERY:C277([xxSNT_LOG:93];[xxSNT_LOG:93]_date:1>=$date;*)
QUERY:C277([xxSNT_LOG:93]; & ;[xxSNT_LOG:93]Modulo:8=CommTrack)
ORDER BY:C49([xxSNT_LOG:93]_date:1;<;[xxSNT_LOG:93]_Time:2;<)
SELECTION TO ARRAY:C260([xxSNT_LOG:93]_date:1;adCMT_Log_FechaST;[xxSNT_LOG:93]Event:3;atCMT_Log_EventoST;[xxSNT_LOG:93]_Time:2;alCMT_Log_HoraST)
vbCMT_LoadedSTLog:=True:C214