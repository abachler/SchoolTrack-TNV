//%attributes = {}
  // Método: xALCB_EX_HObs_ProfesorJefe
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 02/11/09, 09:40:39
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
  //xALCB_EX_HObs_ProfesorJefe

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($col;$row)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_HNotasECursos)=1)
		AL_GetCurrCell (xALP_HNotasECursos;$col;$row)
		modObservaciones:=True:C214
		aPJObs{$row}:=ST_clearUnNecessaryCR (ST_ClrWildChars (aPJObs{$row}))
		AL_UpdateArrays (xALP_HNotasECursos;-2)
		
		KRL_ReloadInReadWriteMode (->[Alumnos_SintesisAnual:210])
		
		Case of 
			: (Size of array:C274(aPJObs)=3)
				Case of 
					: ($row=3)
						[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114:=aPJObs{$row}
					: ($row=2)
						[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143:=aPJObs{$row}
					: ($row=1)
						[Alumnos_SintesisAnual:210]Observaciones_Academicas:47:=aPJObs{$row}
				End case 
				
			: (Size of array:C274(aPJObs)=4)
				Case of 
					: ($row=4)
						[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114:=aPJObs{$row}
					: ($row=3)
						[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143:=aPJObs{$row}
					: ($row=2)
						[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172:=aPJObs{$row}
					: ($row=1)
						[Alumnos_SintesisAnual:210]Observaciones_Academicas:47:=aPJObs{$row}
				End case 
				
				
			: (Size of array:C274(aPJObs)=5)
				Case of 
					: ($row=5)
						[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114:=aPJObs{$row}
					: ($row=4)
						[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143:=aPJObs{$row}
					: ($row=3)
						[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172:=aPJObs{$row}
					: ($row=2)
						[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201:=aPJObs{$row}
					: ($row=1)
						[Alumnos_SintesisAnual:210]Observaciones_Academicas:47:=aPJObs{$row}
				End case 
				
				
			: (Size of array:C274(aPJObs)=6)
				Case of 
					: ($row=6)
						[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114:=aPJObs{$row}
					: ($row=5)
						[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143:=aPJObs{$row}
					: ($row=4)
						[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172:=aPJObs{$row}
					: ($row=3)
						[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201:=aPJObs{$row}
					: ($row=2)
						[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230:=aPJObs{$row}
					: ($row=1)
						[Alumnos_SintesisAnual:210]Observaciones_Academicas:47:=aPJObs{$row}
				End case 
				
		End case 
		
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
		
		$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year_Historico;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
		LOG_RegisterEvt ("Modificación en observaciones históricas del profesor jefe o tutor para "+[Alumnos:2]apellidos_y_nombres:40+" en el año "+$nombreAñoEscolar)
		
	End if 
End if 



