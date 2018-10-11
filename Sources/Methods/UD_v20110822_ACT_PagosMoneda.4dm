//%attributes = {}
  //UD_v20110822_ACT_PagosMoneda
  //RCH Se detecta defecto que hace que el monto del pago en moneda pueda llegar a ser distinto del monto del pago, a pesar de estar en la misma moneda...

C_TEXT:C284($vt_moneda)
C_LONGINT:C283($vl_proc)

READ WRITE:C146([ACT_Pagos:172])

$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
$vl_proc:=IT_UThermometer (1;0;"Verificando montos en moneda en pagos...")

QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Moneda:27=$vt_moneda)
QUERY SELECTION BY FORMULA:C207([ACT_Pagos:172];[ACT_Pagos:172]Monto_Pagado:5#[ACT_Pagos:172]MontoEnMoneda:28)

APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]MontoEnMoneda:28:=[ACT_Pagos:172]Monto_Pagado:5)

KRL_UnloadReadOnly (->[ACT_Pagos:172])

IT_UThermometer (-2;$vl_proc)