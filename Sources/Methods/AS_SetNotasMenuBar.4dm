//%attributes = {}
  //AS_SetNotasMenuBar

C_LONGINT:C283($bestWidth;$bestHeight)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)


OBJECT GET COORDINATES:C663(*;"bkgMenu";$refLeft;$refTop;$refRight;$refBottom)
$topPosition:=$refTop+5
$leftStart:=$refLeft+13
OBJECT GET BEST SIZE:C717(*;"TextoMenu1";$bestWidth;$bestheight)
$obRight:=$leftStart+$bestWidth
$obBottom:=$topPosition+$bestheight
IT_SetNamedObjectRect ("TextoMenu1";$leftStart;$topPosition;$obRight;$obBottom)
$obLeft:=$obRight
$obTop:=$obBottom-2
$obRight:=$obLeft+5
IT_SetNamedObjectRect ("ArrowMenu1";$obLeft;$obTop;$obRight;$obTop+4)
$obRight:=$obRight+2
$obBottom:=$topPosition+18
IT_SetNamedObjectRect ("bMenu1";$leftStart;$topPosition;$obRight;$obBottom)
OBJECT GET COORDINATES:C663(*;"bMenu1";$refLeft;$refTop;$refRight;$refBottom)

$leftStart:=$obRight+15
OBJECT GET BEST SIZE:C717(*;"TextoMenu2";$bestWidth;$bestheight)
$obRight:=$leftStart+$bestWidth
$obBottom:=$topPosition+$bestheight
IT_SetNamedObjectRect ("TextoMenu2";$leftStart;$topPosition;$obRight;$obBottom)
$obLeft:=$obRight
$obTop:=$obBottom-2
$obRight:=$obLeft+5
IT_SetNamedObjectRect ("ArrowMenu2";$obLeft;$obTop;$obRight;$obTop+4)
$obRight:=$obRight+2
IT_SetNamedObjectRect ("bMenu2";$leftStart;$topPosition;$obRight;$topPosition+18)

$leftStart:=$obRight+15
OBJECT GET BEST SIZE:C717(*;"TextoMenu3";$bestWidth;$bestheight)
$obRight:=$leftStart+$bestWidth
$obBottom:=$topPosition+$bestheight
IT_SetNamedObjectRect ("TextoMenu3";$leftStart;$topPosition;$obRight;$obBottom)
$obLeft:=$obRight
$obTop:=$obBottom-2
$obRight:=$obLeft+5
IT_SetNamedObjectRect ("ArrowMenu3";$obLeft;$obTop;$obRight;$obTop+4)
$obRight:=$obRight+2
IT_SetNamedObjectRect ("bMenu3";$leftStart;$topPosition;$obRight;$topPosition+18)


$leftStart:=$obRight+15
OBJECT GET BEST SIZE:C717(*;"TextoMenu4";$bestWidth;$bestheight)
$obRight:=$leftStart+$bestWidth
$obBottom:=$topPosition+$bestheight
IT_SetNamedObjectRect ("TextoMenu4";$leftStart;$topPosition;$obRight;$obBottom)
$obLeft:=$obRight
$obTop:=$obBottom-2
$obRight:=$obLeft+5
IT_SetNamedObjectRect ("ArrowMenu4";$obLeft;$obTop;$obRight;$obTop+4)
$obRight:=$obRight+2
IT_SetNamedObjectRect ("bMenu4";$leftStart;$topPosition;$obRight;$topPosition+18)

$leftStart:=$obRight+80
OBJECT GET BEST SIZE:C717(*;"TextoPeriodo";$bestWidth;$bestheight)
$obRight:=$leftStart+$bestWidth
$obBottom:=$topPosition+$bestheight
IT_SetNamedObjectRect ("TextoPeriodo";$leftStart;$topPosition;$obRight;$obBottom)
  //OBJECT GET BEST SIZE(vt_periodo;$bestWidth;$bestheight)
OBJECT GET BEST SIZE:C717(sPeriodo;$bestWidth;$bestheight)
$obLeft:=$obRight+6
$obTop:=$topPosition
$obRight:=$obLeft+$bestWidth
$obBottom:=$obTop+$bestheight
IT_SetNamedObjectRect ("varPeriodo";$obLeft;$obTop;$obRight;$obBottom)
$obLeft:=$obRight+1
$obTop:=$obBottom-2
$obRight:=$obLeft+5
IT_SetNamedObjectRect ("ArrowPeriodo";$obLeft;$obTop;$obRight;$obTop+4)
$obRight:=$obRight+2
IT_SetNamedObjectRect ("PopupPeriodos";$leftStart;$topPosition;$obRight;$topPosition+18)