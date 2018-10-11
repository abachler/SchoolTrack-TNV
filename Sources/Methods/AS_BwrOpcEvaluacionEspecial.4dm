//%attributes = {}
  //AS_BwrOpcEvaluacionEspecial
  //Mono Ticket 172577 Evaluacion Especial

If (Size of array:C274(alBWR_recordNumber)>0)
	C_LONGINT:C283($resp)
	$resp:=CD_Dlog (0;__ ("¿Desea aplicar o quitar la opción de uso de Evaluaciones Especiales en las asignaturas listadas en el explorador?");"";__ ("Cancelar");__ ("Quitar");__ ("Aplicar"))
	If ($resp>1)
		AS_ObjOpcEvaluacionEspecial (->alBWR_recordNumber;($resp=3);True:C214)
	End if 
	
Else 
	CD_Dlog (0;__ ("Debe haber asignaturas listadas en el explorador"))
End if 