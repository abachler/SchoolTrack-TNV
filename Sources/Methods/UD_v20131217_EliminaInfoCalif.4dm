//%attributes = {}
  //UD_v20131217_EliminaInfoCalif

C_LONGINT:C283($l_proc)
C_DATE:C307($d_fecha)
READ WRITE:C146([xxSTR_InfoCalificaciones:142])
READ ONLY:C145([xxSTR_Constants:1])

MESSAGES OFF:C175
ALL RECORDS:C47([xxSTR_Constants:1])
FIRST RECORD:C50([xxSTR_Constants:1])

$d_fecha:=DT_GetDateFromDayMonthYear (1;1;[xxSTR_Constants:1]Año:8)
$l_proc:=IT_UThermometer (1;0;"Eliminando registros de info calificaciones histórico...")

QUERY:C277([xxSTR_InfoCalificaciones:142];[xxSTR_InfoCalificaciones:142]Registro_Fecha:3<$d_fecha)
DELETE SELECTION:C66([xxSTR_InfoCalificaciones:142])
FLUSH CACHE:C297
KRL_UnloadReadOnly (->[xxSTR_InfoCalificaciones:142])

IT_UThermometer (-2;$l_proc)