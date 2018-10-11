//%attributes = {}
  //Metodo: BM_ResultadosAsignatura
  //Por abachler
  //Creada el 30/08/2008, 19:23:10
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($batchRecNum;$1;$periodo;$id;$status)
C_TEXT:C284($msg;$error)
C_BOOLEAN:C305($0;$success)

  //CUERPO
$batchRecNum:=$1
MESSAGES OFF:C175
$succes:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	
	$msg:=[xShell_BatchRequests:48]Msg:2
	If ($msg#"")
		$idAsignatura:=Num:C11($msg)
		$recNumAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$idAsignatura;True:C214)
		If (($recNumAsignatura>=0) & (OK=1))
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			EV2_ResultadosAsignatura ($recNumAsignatura)
			$success:=True:C214
		Else 
			If (Records in selection:C76([Asignaturas:18])=0)
				$success:=True:C214  //20131206 RCH si no hay registro de asignatura asociado, se elimina la tarea
			End if 
		End if 
	Else 
		$success:=False:C215
	End if 
	
End if 

$0:=$success