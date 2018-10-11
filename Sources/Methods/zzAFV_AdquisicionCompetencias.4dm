//%attributes = {}
  // zzAFV_AdquisicionCompetencias()
  // Por: Alberto Bachler K.: 04-03-15, 09:38:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_idTermometro;$l_periodosEvaluados)

ARRAY LONGINT:C221($al_RecNums;0)

READ WRITE:C146([MPA_DefinicionCompetencias:187])
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=5)
EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=EV2_Simbolo_a_Real ("A"))


QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=6)
EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=EV2_Simbolo_a_Real ("A"))


QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=25)
EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=EV2_Simbolo_a_Real ("T"))


QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=31)
EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=EV2_Simbolo_a_Real ("++++"))


QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=32)
EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=100)


QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7=34)
EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
APPLY TO SELECTION:C70([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=EV2_Simbolo_a_Real ("S"))



READ WRITE:C146([MPA_DefinicionDimensiones:188])
QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=5)
EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=EV2_Simbolo_a_Real ("A"))


QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=6)
EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=EV2_Simbolo_a_Real ("A"))


QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=25)
EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=EV2_Simbolo_a_Real ("T"))


QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=31)
EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=EV2_Simbolo_a_Real ("++++"))


QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=32)
EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=100)


QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11=34)
EVS_ReadStyleData ([MPA_DefinicionDimensiones:188]EstiloEvaluacion:11)
APPLY TO SELECTION:C70([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]PctParaAprobacion:14:=EV2_Simbolo_a_Real ("S"))



READ WRITE:C146([MPA_DefinicionEjes:185])
QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13=5)
EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]PctParaAprobacion:16:=EV2_Simbolo_a_Real ("A"))


QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13=6)
EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]PctParaAprobacion:16:=EV2_Simbolo_a_Real ("A"))


QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13=25)
EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]PctParaAprobacion:16:=EV2_Simbolo_a_Real ("T"))


QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13=31)
EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]PctParaAprobacion:16:=EV2_Simbolo_a_Real ("++++"))


QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13=32)
EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]PctParaAprobacion:16:=100)


QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13=34)
EVS_ReadStyleData ([MPA_DefinicionEjes:185]EstiloEvaluación:13)
APPLY TO SELECTION:C70([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]PctParaAprobacion:16:=EV2_Simbolo_a_Real ("S"))


QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=2014)
QUERY BY FORMULA:C48([Alumnos_EvaluacionAprendizajes:203];MPA_PeriodosEvaluados >0)
ORDER BY:C49([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77;>;[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91;>)


LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Asignando fecha de registro a evaluaciones de aprendizaje...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_RecNums{$i_registros})
	
	$l_periodosEvaluados:=MPA_PeriodosEvaluados 
	If ($l_periodosEvaluados>0)
		If ([Alumnos_EvaluacionAprendizajes:203]Año:77<<>GYEAR)
			PERIODOS_LeeDatosHistoricos ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91;[Alumnos_EvaluacionAprendizajes:203]Año:77)
		Else 
			PERIODOS_LoadData ([Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91)
		End if 
		
		If ($l_periodosEvaluados ?? 1)
			[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95:=adSTR_Periodos_Hasta{1}
		End if 
		
		If ($l_periodosEvaluados ?? 2)
			[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96:=adSTR_Periodos_Hasta{2}
		End if 
		
		If ($l_periodosEvaluados ?? 3)
			[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97:=adSTR_Periodos_Hasta{3}
		End if 
		
		If ($l_periodosEvaluados ?? 4)
			[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98:=adSTR_Periodos_Hasta{4}
		End if 
		
		If ($l_periodosEvaluados ?? 5)
			[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99:=adSTR_Periodos_Hasta{5}
		End if 
		
		If ($l_periodosEvaluados ?? 0)
			[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
		End if 
		
	End if 
	
	
	
	Case of 
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
			$l_idObjeto:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
			$r_minimoAdquisicion:=KRL_GetNumericFieldData (->[MPA_DefinicionCompetencias:187]ID:1;->$l_idObjeto;->[MPA_DefinicionCompetencias:187]PctParaAprobacion:22)
			
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
			$l_idObjeto:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
			$r_minimoAdquisicion:=KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->$l_idObjeto;->[MPA_DefinicionDimensiones:188]PctParaAprobacion:14)
			
		: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
			$l_idObjeto:=Abs:C99([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
			$r_minimoAdquisicion:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->$l_idObjeto;->[MPA_DefinicionEjes:185]PctParaAprobacion:16)
	End case 
	
	Case of 
		: (([Alumnos_EvaluacionAprendizajes:203]Final_Real:59>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 0))
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=[Alumnos_EvaluacionAprendizajes:203]Final_fechaRegistro:100
		: (([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 5))
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=[Alumnos_EvaluacionAprendizajes:203]Periodo5_fechaRegistro:99
		: (([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 4))
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=[Alumnos_EvaluacionAprendizajes:203]Periodo4_fechaRegistro:98
		: (([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 3))
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=[Alumnos_EvaluacionAprendizajes:203]Periodo3_fechaRegistro:97
		: (([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 2))
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=[Alumnos_EvaluacionAprendizajes:203]Periodo2_fechaRegistro:96
		: (([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11>=$r_minimoAdquisicion) & ($l_periodosEvaluados ?? 1))
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=[Alumnos_EvaluacionAprendizajes:203]Periodo1_fechaRegistro:95
		Else 
			[Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89:=!00-00-00!
	End case 
	
	
	SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])


QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77;=;<>gYear)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Reportando adquisición de competencias...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos_EvaluacionAprendizajes:203];$al_RecNums{$i_registros})
	MPA_RecuperaEvalCicloAnterior 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])


