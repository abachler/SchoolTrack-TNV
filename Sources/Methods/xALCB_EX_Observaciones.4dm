//%attributes = {}
  //xALCB_EX_Observaciones


C_BOOLEAN:C305($0)
If (False:C215)
	<>ST_v461:=False:C215  //10/8/98 at 16:53:36 by: Alberto Bachler
	  //implementación de bimestres
End if 


C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)


If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_ComentariosAlumno)=1)
		AL_GetCurrCell (xALP_ComentariosAlumno;vcol;vRow)
		aPJObs{vRow}:=ST_clearUnNecessaryCR (ST_ClrWildChars (aPJObs{vRow}))
		Case of 
			: (Size of array:C274(aObsPJTerm)=6)
				Case of 
					: (vRow=1)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					: (vRow=2)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					: (vRow=3)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
					: (vRow=4)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
					: (vRow=5)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
					: (vRow=6)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				End case 
			: (Size of array:C274(aObsPJTerm)=5)
				Case of 
					: (vRow=1)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					: (vRow=2)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					: (vRow=3)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
					: (vRow=4)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
					: (vRow=5)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				End case 
				
			: (Size of array:C274(aObsPJTerm)=4)
				Case of 
					: (vRow=1)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					: (vRow=2)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					: (vRow=3)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
					: (vRow=4)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				End case 
				
			: (Size of array:C274(aObsPJTerm)=3)
				Case of 
					: (vRow=1)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					: (vRow=2)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					: (vRow=3)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				End case 
			: (Size of array:C274(aObsPJTerm)=2)
				Case of 
					: (vRow=1)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					: (vRow=2)
						$fieldPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				End case 
		End case 
		$value:=aPJObs{vRow}
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
		AL_EscribeSintesisAnual ($key;$fieldPointer;->$value;True:C214)
	End if 
End if 