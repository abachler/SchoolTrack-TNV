//%attributes = {}
  //SN3_CleanLog

C_DATE:C307($date)
READ WRITE:C146([xxSN3_Log:160])
  //$date:=Add to date(Current date(*);0;0;-14)
$date:=Add to date:C393(Current date:C33(*);0;0;-90)  //20170215 RCH Se guardan más días
$dts:=DTS_MakeFromDateTime ($date;?00:00:00?)
QUERY:C277([xxSN3_Log:160];[xxSN3_Log:160]dts:4<$dts)
DELETE SELECTION:C66([xxSN3_Log:160])
KRL_UnloadReadOnly (->[xxSN3_Log:160])