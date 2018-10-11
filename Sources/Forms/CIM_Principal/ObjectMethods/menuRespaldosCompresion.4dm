  // XS_CIM.BKP_respaldosCompresion()
  // Por: Alberto Bachler K.: 23-09-14, 09:33:21
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_menuCompresion:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_modoCompresion:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_modoCompresion")
Case of 
	: ($y_menuCompresion->=1)
		$y_modoCompresion->:="None"
	: ($y_menuCompresion->=2)
		$y_modoCompresion->:="Fast"
	: ($y_menuCompresion->=3)
		$y_modoCompresion->:="Compact"
End case 

