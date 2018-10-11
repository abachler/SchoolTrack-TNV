//%attributes = {}
  //Metodo: BM_CalculaPromediosAlumnos
  //Por abachler
  //Creada el:
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // Record number del registro [xShell_BatchRequests]
  // ----------------------------------------------------
  // MODIFICACIONES
  //29/02/2008, 17:42:00
  //test de la existencia del registrio que se va a procesar
  //si el registro no existe se elimina la tarea Batch


  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($batchRecNum;$1;$id;$status)
C_TEXT:C284($error)
C_BOOLEAN:C305($0;$succes)

$batchRecNum:=$1


  //CUERPO
MESSAGES OFF:C175
$succes:=True:C214
KRL_GotoRecord (->[xShell_BatchRequests:48];$batchRecNum;True:C214)
If (OK=1)
	vb_AsignaSituacionFinal:=False:C215
	$id:=Num:C11([xShell_BatchRequests:48]Msg:2)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$id;True:C214)
	If ($recNum>=0)  //si el registro existe
		$succes:=AL_CalculaPromediosGenerales ($id)
		If ($succes)
			$succes:=AL_CalculaSituacionFinal ($id)
		End if 
	Else   //el registro de alumno no existe, se elimina la tarea programada
		$success:=True:C214
	End if 
Else 
	$success:=True:C214
End if 
$0:=$succes
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[Cursos:3])
KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])