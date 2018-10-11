//%attributes = {}
  //MSN_DisplayMsgonClient

Sender:=$1
vMsgText:=$2
AnswerTo:=$3
BRING TO FRONT:C326(Current process:C322)
BEEP:C151
$winRef:=WDW_OpenFormWindow (->[xShell_Dialogs:114];"MSN_DisplayMsnOnClient";1;4;__ ("Servicio de Mensajería Interna"))
WDW_SetFrontmost ($winRef)
DIALOG:C40([xShell_Dialogs:114];"MSN_DisplayMsnOnClient")
CLOSE WINDOW:C154