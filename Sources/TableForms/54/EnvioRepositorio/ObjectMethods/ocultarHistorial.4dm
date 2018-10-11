  // [xShell_Reports].EnvioRepositorio.esconderHistorial()
  // Por: Alberto Bachler K.: 13-08-14, 13:32:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$l_izquierdaO;$l_arribaO;$l_derechaO;$l_abajoO)
GET WINDOW RECT:C443($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV)
SET WINDOW RECT:C444($l_izquierdaV;$l_arribaV;$l_izquierdaV+$l_derechaO-5;$l_abajoV)

OBJECT SET VISIBLE:C603(*;OBJECT Get name:C1087(Object current:K67:2);False:C215)
OBJECT SET VISIBLE:C603(*;"mostrarHistorial";True:C214)

