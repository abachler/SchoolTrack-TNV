  // AdministracionServidor.webTimeoutInactivesRuler()
  // Por: Alberto Bachler K.: 07-09-15, 16:47:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($y_timeoutCS_L;$y_timeoutCS_T;$y_webTimeOutInactivesRuler)

$y_webTimeOutInactives:=OBJECT Get pointer:C1124(Object named:K67:5;"webTimeoutInactives")
$y_webTimeOutInactivesRuler:=OBJECT Get pointer:C1124(Object named:K67:5;"webTimeoutInactivesRuler")

Case of 
	: ($y_webTimeOutInactivesRuler->=0)
		$y_webTimeOutInactives->:=0
		
	: ($y_webTimeOutInactivesRuler->=7)
		$y_webTimeOutInactives->:=-1
		
	: ($y_webTimeOutInactivesRuler->=1)
		$y_webTimeOutInactives->:=5
		
	: ($y_webTimeOutInactivesRuler->=2)
		$y_webTimeOutInactives->:=15
		
	: ($y_webTimeOutInactivesRuler->=3)
		$y_webTimeOutInactives->:=30
		
	: ($y_webTimeOutInactivesRuler->=4)
		$y_webTimeOutInactives->:=60
		
	: ($y_webTimeOutInactivesRuler->=5)
		$y_webTimeOutInactives->:=480
		
	: ($y_webTimeOutInactivesRuler->=6)
		$y_webTimeOutInactives->:=1440
End case 

OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)