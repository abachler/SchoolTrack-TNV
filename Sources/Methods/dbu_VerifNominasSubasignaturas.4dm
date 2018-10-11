//%attributes = {}
  // MÉTODO: dbu_VerifNominasSubasignaturas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 17:03:34
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // dbu_VerifNominasSubasignaturas()
  // ----------------------------------------------------
C_BLOB:C604($x_recNumArray)
C_LONGINT:C283($l_itemEncontrado;$i_Asignaturas;$i_Notas;$k;$l_ProgressProcID;$l_periodo;$l_recNumSubasignatura)

ARRAY LONGINT:C221($al_recNumsAsignatura;0)
ARRAY LONGINT:C221($al_recNumsAsignatura_Recalculo;0)




  // CODIGO PRINCIPAL
ARRAY LONGINT:C221(aSubEvalID;0)

PERIODOS_Init 
ALL RECORDS:C47([Asignaturas:18])

CREATE EMPTY SET:C140([Asignaturas:18];"$recalcular")
EVS_LoadStyles 

LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumsAsignatura;"")
$l_ProgressProcID:=IT_Progress (1;$l_ProgressProcID;0;__ ("Verificando nóminas de alumnos en subasignaturas..."))
For ($i_Asignaturas;1;Size of array:C274($al_recNumsAsignatura))
	GOTO RECORD:C242([Asignaturas:18];$al_recNumsAsignatura{$i_Asignaturas})
	
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		For ($l_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
			EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$l_periodo)
			AS_PropEval_Lectura ("";$l_periodo)
			For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
				If (alAS_EvalPropSourceID{$k}<0)
					atSTR_Periodos_Nombre:=$l_periodo
					$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$l_periodo;$k)
					If ($l_recNumSubasignatura>=0)
						ASsev_UpdateList ($l_recNumSubasignatura)
						For ($i_Notas;Size of array:C274(aSubEvalID);1;-1)
							$l_itemEncontrado:=Find in array:C230(aNtaIDAlumno;aSubEvalID{$i_Notas})
							If ($l_itemEncontrado>0)
								aNtaRealArrPointers{$k}->{$l_itemEncontrado}:=aRealSubEvalP1{$i_Notas}
							End if 
						End for 
						ASsev_GuardaNomina ($l_recNumSubasignatura)
						APPEND TO ARRAY:C911($al_recNumsAsignatura_Recalculo;$al_recNumsAsignatura{$i_Asignaturas})
					End if 
				End if 
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_Asignaturas/Size of array:C274($al_recNumsAsignatura);__ ("Verificando nóminas de alumnos en subasignaturas...");$l_periodo/Size of array:C274(atSTR_Periodos_Nombre);[Asignaturas:18]denominacion_interna:16)
		End for 
	Else 
		AS_PropEval_Lectura 
		For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$k}<0)
				For ($l_periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
					EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$l_periodo)
					atSTR_Periodos_Nombre:=$l_periodo
					$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$l_periodo;$k;False:C215)
					If ($l_recNumSubasignatura>=0)
						ASsev_UpdateList ($l_recNumSubasignatura)
						For ($i_Notas;Size of array:C274(aSubEvalID);1;-1)
							$l_itemEncontrado:=Find in array:C230(aNtaIDAlumno;aSubEvalID{$i_Notas})
							If ($l_itemEncontrado>0)
								aNtaRealArrPointers{$k}->{$l_itemEncontrado}:=aRealSubEvalP1{$i_Notas}
							End if 
						End for 
						ASsev_GuardaNomina ($l_recNumSubasignatura)
						APPEND TO ARRAY:C911($al_recNumsAsignatura_Recalculo;$al_recNumsAsignatura{$i_Asignaturas})
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_Asignaturas/Size of array:C274($al_recNumsAsignatura);__ ("Verificando nóminas de alumnos en subasignaturas...");$l_periodo/Size of array:C274(atSTR_Periodos_Nombre);[Asignaturas:18]denominacion_interna:16)
				End for 
			End if 
		End for 
	End if 
	
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274($al_recNumsAsignatura_Recalculo)>0)
	CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_recNumsAsignatura_Recalculo)
	BLOB_Variables2Blob (->$x_recNumArray;0;->$al_recNumsAsignatura_Recalculo)
	EV2dbu_Recalculos ($x_recNumArraY)
End if 
