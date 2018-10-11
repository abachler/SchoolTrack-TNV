//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 22-08-18, 12:36:21
  // ----------------------------------------------------
  // Método: UD_v20180822_FixPF_AsigEvaPtos
  // Descripción
  // Este fix recalcula los promedios de las calificaciones de las asignaturas con estilos de evaluacion con modo de evaluación de puntos
  // debido a que hubo un defecto en el método EV2_Calculos_Final con respecto a esta forma de evaluación al calcular el real promedio final
  // para mas detalles ticket 214665

ARRAY LONGINT:C221($al_estilosID;0)
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
C_BLOB:C604($x_recNumArray)
C_LONGINT:C283($i)

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([xxSTR_EstilosEvaluacion:44])

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
SELECTION TO ARRAY:C260([xxSTR_EstilosEvaluacion:44]ID:1;$al_estilosID)

For ($i;Size of array:C274($al_estilosID);1;-1)
	
	EVS_ReadStyleData ($al_estilosID{$i})
	If (iEvaluationMode#Puntos)
		AT_Delete ($i;1;->$al_estilosID)
	End if 
	
End for 

QUERY WITH ARRAY:C644([Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_estilosID)
If (Records in selection:C76([Asignaturas:18])>0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignaturas)
	BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturas)
	EV2dbu_Recalculos ($x_recNumArray;False:C215)
End if 
