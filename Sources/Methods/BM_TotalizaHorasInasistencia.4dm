//%attributes = {}
  //BM_TotalizaHorasInasistencia

  //Metodo: BM_TotalizasHorasInasistencia
  //Por abachler
  //Creada el 03/06/2008, 10:04:32
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($batchRecNum;$1;$id;$status)
C_BOOLEAN:C305($0;$succes)
$batchRecNum:=$1


  //CUERPO
MESSAGES OFF:C175
$succes:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	
	$id:=Num:C11([xShell_BatchRequests:48]Msg:2)
	$succes:=AL_TotalizaHorasDeClase ($id)
	
End if 


$0:=$succes