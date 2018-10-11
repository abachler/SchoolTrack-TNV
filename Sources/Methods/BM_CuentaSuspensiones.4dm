//%attributes = {}
  //BM_CuentaSuspensiones

  //DECLARATIONS
C_LONGINT:C283($batchRecNum;$1;$id;$status)
C_TEXT:C284($error)
C_BOOLEAN:C305($0;$succes)

  //INITIALIZATION
$batchRecNum:=$1

  //MAIN CODE
MESSAGES OFF:C175
$succes:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	
	$id:=Num:C11([xShell_BatchRequests:48]Msg:2)
	$succes:=AL_TotalizaSuspensiones ($id)
	
End if 

$0:=$succes