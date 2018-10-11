$vt_Date2Gen:=Substring:C12(String:C10(Current date:C33(*);8);1;10)
MXLEG_ConoVtaXML ($vt_Date2Gen)
$vt_msg:="Cono de ventas "+$vt_Date2Gen+" generado manualmente desde el formulario."
LOG_RegisterEvt ($vt_msg;-1;-1;<>lUSR_CurrentUserID;"Schootrack")
CD_Dlog (0;__ ("Cono ")+$vt_Date2Gen+__ (" generado  y almacenado"))
