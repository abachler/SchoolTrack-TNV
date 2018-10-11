//%attributes = {}
  //BBLdbu_EliminaReservasVencidas

PERIODOS_Init 
$date:=DT_GetWorkingDayDate (Current date:C33(*);-2)
QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]Until:4<$date)
KRL_DeleteSelection (->[BBL_Reservas:115])
