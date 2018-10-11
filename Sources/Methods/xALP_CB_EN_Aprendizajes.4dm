//%attributes = {}
  //xALP_CB_EN_Aprendizajes

C_LONGINT:C283($1;$2;$area;$entryMethod)
C_LONGINT:C283($l_columna;$l_fila)
$area:=$1
$entryMethod:=$2

AL_GetCurrCell ($area;$l_columna;$l_fila)


KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila};False:C215)
Case of 
	: (([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Promovido@"))
		IT_MuestraTip (aNtaStdNme{vRow}+__ (" tiene el estatus de ")+[Alumnos:2]Status:50+".";20;True:C214)
		AL_SkipCell (xALP_Aprendizajes)
		
	: (([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>!00-00-00!) & ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>=vdSTR_Periodos_InicioEjercicio))
		
		
	: (([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89>!00-00-00!) & ([Alumnos_EvaluacionAprendizajes:203]FechaAprobacion:89<vdSTR_Periodos_InicioEjercicio))
		If ($entryMethod#AL Click action)
			AL_SkipCell (xALP_Aprendizajes)
		End if 
		
		
	: (alEVLG_TipoEvaluación{$l_fila}=3)  //estilo de evaluación para competencias, escala numerica para ejes y dimensiones
		Case of 
			: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
				$estilo:=alEVLG_RefEstiloEvaluacion{$l_fila}
				EVS_ReadStyleData ($estilo)
			: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
				$recNum:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$recNum)
				
			: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
				$recNum:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				KRL_GotoRecord (->[MPA_DefinicionEjes:185];$recNum)
				
		End case 
		
		
	: (alEVLG_TipoEvaluación{$l_fila}=2)  //binario
		Case of 
			: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
				$recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$recNum)
				
			: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
				$recNum:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
				KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$recNum)
				
			: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
				$recNum:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
				KRL_GotoRecord (->[MPA_DefinicionEjes:185];$recNum)
				
		End case 
		
		
	: (alEVLG_TipoEvaluación{$l_fila}=1)  //indicadores de logro para competencias, estilo de evaluación en caso de dimensiones y ejes
		Case of 
			: (alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje)
				KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
				$recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
				KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$recNum)
				BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
				
			: (alEVLG_TipoObjeto{$l_fila}=Dimension_Aprendizaje)
				$estilo:=alEVLG_RefEstiloEvaluacion{$l_fila}
				EVS_ReadStyleData ($estilo)
				
			: (alEVLG_TipoObjeto{$l_fila}=Eje_Aprendizaje)
				$estilo:=alEVLG_RefEstiloEvaluacion{$l_fila}
				EVS_ReadStyleData ($estilo)
				
		End case 
		
End case 


