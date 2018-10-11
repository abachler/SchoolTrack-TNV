  // AdministracionServidor.webTimeoutInactivesRuler()
  // Por: Alberto Bachler K.: 07-09-15, 16:47:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($y_timeoutCS_L;$y_timeoutCS_T;$y_timeoutRuler_L)

$y_timeoutCS_T:=OBJECT Get pointer:C1124(Object named:K67:5;"csTimeout")
$y_timeoutRuler_L:=OBJECT Get pointer:C1124(Object named:K67:5;"csTimeoutRuler")

Case of 
	: ($y_timeoutRuler_L->=6)
		$y_timeoutCS_T->:="0"
		
	: ($y_timeoutRuler_L-><=1)
		$y_timeoutCS_T->:="1"
		
	: ($y_timeoutRuler_L->=2)
		$y_timeoutCS_T->:="5"
		
	: ($y_timeoutRuler_L->=3)
		$y_timeoutCS_T->:="15"
		
	: ($y_timeoutRuler_L->=4)
		$y_timeoutCS_T->:="30"
		
	: ($y_timeoutRuler_L->=5)
		$y_timeoutCS_T->:="60"
End case 

OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)
