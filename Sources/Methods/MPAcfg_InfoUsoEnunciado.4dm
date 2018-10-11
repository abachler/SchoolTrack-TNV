//%attributes = {}
  // MPAcfg_InfoUsoEnunciado()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/08/12, 09:19:18
  // ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_muestraVerbosa)
C_LONGINT:C283($l_recNum;$l_recNumDim;$l_recNumEje;$l_tipoObjeto)
If (False:C215)
	C_LONGINT:C283(MPAcfg_InfoUsoEnunciado ;$1)
	C_LONGINT:C283(MPAcfg_InfoUsoEnunciado ;$2)
End if 

  // CÓDIGO
$l_tipoObjeto:=$1
$l_recNum:=$2
If (Count parameters:C259=3)
	$b_muestraVerbosa:=$3
End if 

Case of 
	: ($l_tipoObjeto=Logro_Aprendizaje)
		If ($l_recnum=No current record:K29:2)
			OBJECT SET VISIBLE:C603(bInfoMatrizComp;False:C215)
			OBJECT SET VISIBLE:C603(bInfoEvalComp;False:C215)
			OBJECT SET VISIBLE:C603(bCompetencia;False:C215)
		Else 
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNum)
			vt_Competencia:=[MPA_DefinicionCompetencias:187]Competencia:6
			OBJECT SET TITLE:C194(bCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			OBJECT SET VISIBLE:C603(bCompetencia;True:C214)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_competenciasEnMatrices)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_DefinicionCompetencias:187]ID:1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_competenciasEvaluados)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (vl_competenciasEnMatrices>0)
				If ($b_muestraVerbosa)
					OBJECT SET TITLE:C194(bInfoMatrizComp;String:C10(vl_competenciasEnMatrices)+__ (" asignaciones a matrices"))
				Else 
					OBJECT SET TITLE:C194(bInfoMatrizComp;String:C10(vl_competenciasEnMatrices))
				End if 
				OBJECT SET VISIBLE:C603(bInfoMatrizComp;True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bInfoMatrizComp;False:C215)
			End if 
			If (vl_competenciasEvaluados>0)
				If ($b_muestraVerbosa)
					OBJECT SET TITLE:C194(bInfoEvalComp;String:C10(vl_competenciasEvaluados)+__ (" evaluaciones registradas"))
				Else 
					OBJECT SET TITLE:C194(bInfoEvalComp;String:C10(vl_competenciasEvaluados))
				End if 
				OBJECT SET VISIBLE:C603(bInfoEvalComp;True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bInfoEvalComp;False:C215)
			End if 
			
			$l_recNumEje:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[MPA_DefinicionCompetencias:187]ID_Eje:2)
			If ($l_recNumEje>=0)
				MPAcfg_InfoUsoEnunciado (Eje_Aprendizaje;$l_recNumEje)
			End if 
			$l_recNumDim:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[MPA_DefinicionCompetencias:187]ID_Dimension:23)
			If ($l_recNumDim>=0)
				MPAcfg_InfoUsoEnunciado (Dimension_Aprendizaje;$l_recNumDim)
			End if 
		End if 
		
	: ($l_tipoObjeto=Dimension_Aprendizaje)
		If ($l_recnum=No current record:K29:2)
			OBJECT SET VISIBLE:C603(bInfoMatrizDim;False:C215)
			OBJECT SET VISIBLE:C603(bInfoEvalDim;False:C215)
			OBJECT SET VISIBLE:C603(bSelectDim;False:C215)
		Else 
			KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNum)
			vt_Dimension:=[MPA_DefinicionDimensiones:188]Dimensión:4
			OBJECT SET TITLE:C194(bselectDim;[MPA_DefinicionDimensiones:188]Dimensión:4)
			OBJECT SET VISIBLE:C603(bselectDim;True:C214)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_dimEnMatrices)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_DefinicionDimensiones:188]ID:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_dimEnMatrices_asociados)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_DefinicionDimensiones:188]ID:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_dimEvaluados)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=[MPA_DefinicionDimensiones:188]ID:1;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_dimEvaluados_Asociados)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=[MPA_DefinicionDimensiones:188]ID:1;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ((vl_dimEnMatrices+vl_dimEnMatrices_asociados)>0)
				If ($b_muestraVerbosa)
					OBJECT SET TITLE:C194(bInfoMatrizDim;String:C10(vl_dimEnMatrices+vl_dimEnMatrices_asociados)+__ (" asignaciones a matrices"))
				Else 
					OBJECT SET TITLE:C194(bInfoMatrizDim;String:C10(vl_dimEnMatrices+vl_dimEnMatrices_asociados))
				End if 
				OBJECT SET VISIBLE:C603(bInfoMatrizDim;True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bInfoMatrizDim;False:C215)
			End if 
			If ((vl_dimEvaluados+vl_dimEvaluados_Asociados)>0)
				If ($b_muestraVerbosa)
					OBJECT SET TITLE:C194(bInfoEvalDim;String:C10(vl_dimEvaluados+vl_dimEvaluados_Asociados)+__ (" evaluaciones registradas"))
				Else 
					OBJECT SET TITLE:C194(bInfoEvalDim;String:C10(vl_dimEvaluados+vl_dimEvaluados_Asociados))
				End if 
				OBJECT SET VISIBLE:C603(bInfoEvalDim;True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bInfoEvalDim;False:C215)
			End if 
			
			$l_recNumEje:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[MPA_DefinicionDimensiones:188]ID_Eje:3)
			If ($l_recNumEje>=0)
				MPAcfg_InfoUsoEnunciado (Eje_Aprendizaje;$l_recNumEje)
			End if 
		End if 
		
	: ($l_tipoObjeto=Eje_Aprendizaje)
		If ($l_recNum=No current record:K29:2)
			OBJECT SET VISIBLE:C603(bInfoMatrizEje;False:C215)
			OBJECT SET VISIBLE:C603(bInfoEvalEje;False:C215)
			OBJECT SET VISIBLE:C603(bSelectEje;False:C215)
		Else 
			KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNum)
			vt_Eje:=[MPA_DefinicionEjes:185]Nombre:3
			OBJECT SET TITLE:C194(bselectEje;[MPA_DefinicionEjes:185]Nombre:3)
			OBJECT SET VISIBLE:C603(bselectEje;True:C214)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_ejeEnMatrices_asociados)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_DefinicionEjes:185]ID:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2>Eje_Aprendizaje)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_ejeEnMatrices)
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_DefinicionEjes:185]ID:1;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_ejeEvaluados_asociados)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=[MPA_DefinicionEjes:185]ID:1;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4>Eje_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vl_ejeEvaluados)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=[MPA_DefinicionEjes:185]ID:1;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje;*)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ((vl_ejeEnMatrices_asociados+vl_ejeEnMatrices)>0)
				If ($b_muestraVerbosa)
					OBJECT SET TITLE:C194(bInfoMatrizEje;String:C10(vl_ejeEnMatrices+vl_ejeEnMatrices_asociados)+__ (" asignaciones a matrices"))
				Else 
					OBJECT SET TITLE:C194(bInfoMatrizEje;String:C10(vl_ejeEnMatrices+vl_ejeEnMatrices_asociados))
				End if 
				OBJECT SET VISIBLE:C603(bInfoMatrizEje;True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bInfoMatrizEje;False:C215)
			End if 
			If ((vl_ejeEvaluados+vl_ejeEvaluados_asociados)>0)
				If ($b_muestraVerbosa)
					OBJECT SET TITLE:C194(bInfoEvalEje;String:C10(vl_ejeEvaluados+vl_ejeEvaluados_asociados)+__ (" evaluaciones registradas"))
				Else 
					OBJECT SET TITLE:C194(bInfoEvalEje;String:C10(vl_ejeEvaluados+vl_ejeEvaluados_asociados))
				End if 
				OBJECT SET VISIBLE:C603(bInfoEvalEje;True:C214)
			Else 
				OBJECT SET VISIBLE:C603(bInfoEvalEje;False:C215)
			End if 
		End if 
End case 

