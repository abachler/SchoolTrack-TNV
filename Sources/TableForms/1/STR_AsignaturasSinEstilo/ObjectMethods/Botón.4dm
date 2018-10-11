C_LONGINT:C283($i;$l_resp)
ARRAY LONGINT:C221($al_filas;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
C_BLOB:C604($x_recNumArray)
C_LONGINT:C283($progress)

al_numEstilo{0}:=0
AT_SearchArray (->al_numEstilo;"#";->$al_filas)
If ((Size of array:C274($al_filas)>0) & (Size of array:C274(al_numAsignatura)>0))
	$l_resp:=CD_Dlog (0;"Se han asignado "+String:C10(Size of array:C274($al_filas))+" Asignaturas con un estilo de evaluación existente. Estas asignaturas serán re-calculadas con el nuevo estilo de evaluación"+"\r"+"¿Desea continuar?";"";"Aceptar";"Cancelar")
	If ($l_resp=1)
		
		READ WRITE:C146([Asignaturas:18])
		$progress:=IT_Progress (1;0;0;"Asignando Estilos de Evaluación...")
		For ($i;1;Size of array:C274($al_filas))
			$progress:=IT_Progress (0;$progress;$i/Size of array:C274($al_filas);"Asignando Estilos de Evaluación")
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=al_numAsignatura{$al_filas{$i}})
			APPEND TO ARRAY:C911($al_RecNumAsignaturas;Record number:C243([Asignaturas:18]))
			[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=al_numEstilo{$al_filas{$i}}
			SAVE RECORD:C53([Asignaturas:18])
			LOG_RegisterEvt ("Se asigno el estilo de evaluación "+String:C10(at_nomEstilo{$al_filas{$i}})+",a la asignatura  "+[Asignaturas:18]Asignatura:3+" con id :"+String:C10([Asignaturas:18]Numero:1)+" del curso  "+String:C10([Asignaturas:18]Curso:5)+".")
		End for 
		$progress:=IT_Progress (-1;$progress;$i/Size of array:C274($al_filas);"")
		
		KRL_UnloadReadOnly (->[Asignaturas:18])
		BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturas)
		$P:=New process:C317("EV2dbu_Recalculos";256000;"Calculo de promedios";$x_recNumArray)
		ACCEPT:C269
	End if 
Else 
	If (Size of array:C274(al_numAsignatura)>0)
		CD_Dlog (0;"Debe Asignar al menos un estilo de evaluación a una asignatura.")
	Else 
		CD_Dlog (0;"No existen asignaturas sin estilo de evaluación.")
	End if 
End if 