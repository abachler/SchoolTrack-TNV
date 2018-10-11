//%attributes = {}
  // BM_JustificaInasistencias()
  // Por: Alberto Bachler K.: 06-04-14, 08:46:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_tareaEjecutada)
C_LONGINT:C283($l_idTarea;$l_recNumTarea)

If (False:C215)
	C_BOOLEAN:C305(BM_JustificaInasistencias ;$0)
	C_LONGINT:C283(BM_JustificaInasistencias ;$1)
End if 

$l_recNumTarea:=$1

MESSAGES OFF:C175
$b_tareaEjecutada:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$l_recNumTarea;True:C214)
If (OK=1)
	
	$l_idTarea:=Num:C11([xShell_BatchRequests:48]Msg:2)
	$b_tareaEjecutada:=AL_JustificaInasistencias ($l_idTarea)
	
End if 
$0:=$b_tareaEjecutada