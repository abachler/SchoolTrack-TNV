//%attributes = {}
  // MÉTODO: dhCFG_OnCloseConfig
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 19:14:08
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dhCFG_OnCloseConfig()
  // ----------------------------------------------------
C_BLOB:C604($x_RecNumsBlob)
C_LONGINT:C283($i;$l_IdEstiloEvaluacionModificado;$l_IdProcesoRecalculo)

ARRAY LONGINT:C221($al_recNumAsignaturas;0)




  // CODIGO PRINCIPAL

  //si hay modificaciones en estilos de evaluación se sugiere recalcular promedios
C_BLOB:C604($x_RecNumsBlob)
If (Size of array:C274(alEVS_ModifiedStyles)>0)
	OK:=CD_Dlog (0;__ ("Usted modificó uno mas estilos de evaluación actualmente utilizados.\rLas propieda"+"des modificadas puede tener impacto en los cálculos de resultados.\r\r¿Desea usted "+"calcular los resultados en asignaturas inmediatamente?");"";"Si";"No")
	If (OK=1)
		EVS_initialize 
		If (<>vb_BloquearModifSituacionFinal)
			CD_Dlog (0;"Cualquier acción que afecte la situación académica de los alumnos ha sido bloquea"+"da a contar del "+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
		Else 
			For ($i;1;Size of array:C274(alEVS_ModifiedStyles))
				$l_IdEstiloEvaluacionModificado:=alEVS_ModifiedStyles{$i}
				LOG_RegisterEvt ("Modificación estilo evaluación Nº "+String:C10($l_IdEstiloEvaluacionModificado)+" ("+KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionModificado;->[xxSTR_EstilosEvaluacion:44]Name:2)+"). Recalculo de promedios iniciado")
			End for 
			QUERY WITH ARRAY:C644([Asignaturas:18]Numero_de_EstiloEvaluacion:39;alEVS_ModifiedStyles)
			ARRAY LONGINT:C221($al_recNumAsignaturas;0)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
			BLOB_Variables2Blob (->$x_RecNumsBlob;0;->$al_recNumAsignaturas)
			$l_IdProcesoRecalculo:=New process:C317("EV2dbu_Recalculos";255000;"Calculo de promedios de asignaturas";$x_RecNumsBlob)
			
		End if 
	Else 
		For ($i;1;Size of array:C274(alEVS_ModifiedStyles))
			$l_IdEstiloEvaluacionModificado:=alEVS_ModifiedStyles{$i}
			LOG_RegisterEvt ("Modificación estilo evaluación Nº "+String:C10($l_IdEstiloEvaluacionModificado)+" ("+KRL_GetTextFieldData (->[xxSTR_EstilosEvaluacion:44]ID:1;->$l_IdEstiloEvaluacionModificado;->[xxSTR_EstilosEvaluacion:44]Name:2)+"). Sin recalculo de promedios")
		End for 
	End if 
End if 