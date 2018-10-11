//%attributes = {}
  //xALCB_EX_EvEsfuerzo

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($i;vCol;vRow)
C_BLOB:C604($xBlob)

$0:=True:C214
AL_GetCurrCell (xALP_Esfuerzo;vCol;vRow)
$go:=True:C214
Case of 
	: (vCol=1)  //Indicador
		If ((aIndEsfuerzo{vRow}#OldIndicador) | (aIndEsfuerzo{vRow}=""))
			If (aIndEsfuerzo{vRow}#"")
				If (Length:C16(aIndEsfuerzo{vRow})>5)
					aIndEsfuerzo{vRow}:=Substring:C12(aIndEsfuerzo{vRow};1;5)
					BEEP:C151
					AL_GotoCell (xALP_Esfuerzo;vCol;vRow)
					$go:=False:C215
				End if 
				aIndEsfuerzo{0}:=aIndEsfuerzo{vRow}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aIndEsfuerzo;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)=2)
					CD_Dlog (0;__ ("Este indicador ya existe."))
					aIndEsfuerzo{vRow}:=OldIndicador
					AL_GotoCell (xALP_Esfuerzo;vCol;vRow)
					$go:=False:C215
				End if 
				If ($go)
					EVS_WriteStyleData 
					EVS_ActualizaNombreIndEsfuerzo 
				End if 
			Else 
				CD_Dlog (0;__ ("Por favor ingrese un indicador."))
				AL_GotoCell (xALP_Esfuerzo;vCol;vRow)
			End if 
			EVS_SetModified 
		End if 
	: (vCol=3)  //Factor
		If (aFactorEsfuerzo{vRow}#OldFactorEsfuerzo)
			$nvalue:=aFactorEsfuerzo{vRow}
			If (($nvalue<0) | ($nvalue>100))
				BEEP:C151
				aFactorEsfuerzo{vRow}:=0
				AL_GotoCell (xALP_Esfuerzo;vCol;vRow)
			Else 
				EVS_WriteStyleData 
				
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39=[xxSTR_EstilosEvaluacion:44]ID:1)
				KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;->[Asignaturas:18]Numero:1)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16=aIndEsfuerzo{vRow};*)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21=aIndEsfuerzo{vRow};*)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26=aIndEsfuerzo{vRow};*)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31=aIndEsfuerzo{vRow};*)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; | [Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36=aIndEsfuerzo{vRow})
				If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])>0)
					EvStyleID:=[xxSTR_EstilosEvaluacion:44]ID:1
					SET BLOB SIZE:C606($xBlob;0)
					BLOB_Variables2Blob (->$xBlob;0;->OldIndicador;->EvStyleID)
				End if 
				
			End if 
			EVS_SetModified 
		End if 
End case 
AL_UpdateArrays (xALP_Esfuerzo;-2)