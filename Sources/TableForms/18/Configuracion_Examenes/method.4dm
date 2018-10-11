  // [Asignaturas].Configuracion_Examenes()
  //
  // creado por: Alberto Bachler Klein: 16-05-16, 11:25:37
  // -----------------------------------------------------------


  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_promediosBasadosEnAprendizaje)
C_LONGINT:C283($i;$l_objetoPeriodo;$l_otRef)
C_POINTER:C301($y_ObjetoRaiz;$y_pestañasPeriodos;$y_refObjeto;$y_refObjetoPeriodo)
C_TEXT:C284($t_nombreItem)
C_OBJECT:C1216($o_controlesYexamenes)

ARRAY LONGINT:C221($al_objetos;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		
		  //copio el objeto original para no guardar los cambios al cancelar
		$y_objetoOriginal:=OBJECT Get pointer:C1124(Object named:K67:5;"objOriginal")
		$o_objetoOriginal:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
		$y_objetoOriginal->:=OB Copy:C1225($o_objetoOriginal;True:C214)
		
		AS_Examenes_Inicializa 
		
		  //Cargo el objeto raiz en memoria y asigno su referencia a un variable dinamica en pagina 0 del formulario
		$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
		$y_pestañasPeriodos:=OBJECT Get pointer:C1124(Object named:K67:5;"EXP_tabPeriodos")
		$y_pestañasPeriodos->:=New list:C375
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			APPEND TO LIST:C376($y_pestañasPeriodos->;atSTR_Periodos_Nombre{$i};$i)
		End for 
		
		AS_Examenes_CargaConfiguracion 
		
		vs_CTRL_INF_Especifico:=NTA_PercentValue2StringValue (vr_CTRL_INF_Especifico)
		vs_CTRL_SUP_Especifico:=NTA_PercentValue2StringValue (vr_CTRL_SUP_Especifico)
		vs_EX_INF_Especifico:=NTA_PercentValue2StringValue (vr_EX_INF_Especifico)
		vs_EX_SUP_Especifico:=NTA_PercentValue2StringValue (vr_EX_SUP_Especifico)
		vs_EXX_INF_Especifico:=NTA_PercentValue2StringValue (vr_EXX_INF_Especifico)
		vs_EXX_SUP_Especifico:=NTA_PercentValue2StringValue (vr_EXX_SUP_Especifico)
		vs_MinimoExRecuperatorio:=NTA_PercentValue2StringValue (vr_MinimoExRecuperatorio)
		
		vs_CalificacionEX:=Choose:C955(vr_CalificacionEX>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CalificacionEX);"")
		vs_NF_igual_EX_SUP:=Choose:C955(vr_NF_igual_EX_SUP>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EX_SUP);"")
		vs_NF_igual_EX_INF:=Choose:C955(vr_NF_igual_EX_INF>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EX_INF);"")
		vs_CalificacionEXX:=Choose:C955(vr_CalificacionEXX>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CalificacionEXX);"")
		vs_NF_igual_EXX_SUP:=Choose:C955(vr_NF_igual_EXX_SUP>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EXX_SUP);"")
		vs_NF_igual_EXX_INF:=Choose:C955(vr_NF_igual_EXX_INF>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_NF_igual_EXX_INF);"")
		
		
		vs_CorreccionNFEX_minimo:=Choose:C955(vr_CorreccionNFEX_minimo>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CorreccionNFEX_minimo);"")
		vs_CorreccionNFEX_resultado:=Choose:C955(vr_CorreccionNFEX_resultado>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CorreccionNFEX_resultado);"")
		vs_CorreccionNFEXX_minimo:=Choose:C955(vr_CorreccionNFEXX_minimo>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CorreccionNFEXX_minimo);"")
		vs_CorreccionNFEXX_resultado:=Choose:C955(vr_CorreccionNFEXX_resultado>=vrNTA_MinimoEscalaReferencia;NTA_PercentValue2StringValue (vr_CorreccionNFEXX_resultado);"")
		
		
		
		If (vi_usarExamenes=0)
			vi_UsarExamenExtra:=0
		End if 
		If ((c1_PonderacionConstante=0) & (c2_PonderacionVariable=0))
			c1_PonderacionConstante:=1
		End if 
		If ((x1_PonderacionConstante=0) & (x2_PonderacionVariable=0) & (x3_ResultadoFijo=0))
			x1_PonderacionConstante:=1
		End if 
		If ((e1_PonderacionConstante=0) & (e2_PonderacionVariable=0) & (e3_ResultadoFijo=0))
			e1_PonderacionConstante:=1
		End if 
		
		
		$b_promediosBasadosEnAprendizaje:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
		If ($b_promediosBasadosEnAprendizaje)
			vi_UsarControlesFinPeriodo:=0
			OBJECT SET ENTERABLE:C238(vi_UsarControlesFinPeriodo;Not:C34($b_promediosBasadosEnAprendizaje))
		End if 
		
		
		If (EXP_ConfiguracionPorPeriodo=1)
			$l_periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
			If ($l_periodo>0)
				$y_refTabPeriodos:=OBJECT Get pointer:C1124(Object named:K67:5;"EXP_tabPeriodos")
				SELECT LIST ITEMS BY REFERENCE:C630($y_refTabPeriodos->;$l_periodo)
			End if 
		End if 
		
		
		
		
	: (Form event:C388=On Unload:K2:2)
		  // elimino de la memoria los objetos referenciados cuyas referencias fueron asignadas a  variables dinámicas en el formulario
		$y_objetoOriginal:=OBJECT Get pointer:C1124(Object named:K67:5;"objOriginal")
		CLEAR VARIABLE:C89($y_objetoOriginal->)
		
End case 



  // PROPIEDADES DE LOS OBJETOS DE FORMULARIO
  // gestion de objetos CONTROL DE FIN DE PERIODO
OBJECT SET ENABLED:C1123(*;"c1_PonderacionConstante";vi_UsarControlesFinPeriodo=1)
OBJECT SET ENABLED:C1123(*;"c2_PonderacionVariable";vi_UsarControlesFinPeriodo=1)

OBJECT SET ENTERABLE:C238(*;"vr_Ctrl_PonderacionConstante";(c1_PonderacionConstante=1) & (vi_UsarControlesFinPeriodo=1))

OBJECT SET ENABLED:C1123(*;"@CTRL_INF_@";(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1))
OBJECT SET ENABLED:C1123(*;"@CTRL_SUP_@";(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1))
OBJECT SET COLOR:C271(*;"@CTRL_INF_@";Choose:C955((c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1);-15;-(16*16)+9))
OBJECT SET COLOR:C271(*;"@CTRL_SUP_@";Choose:C955((c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1);-15;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vr_CTRL_INF_Ponderacion;(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (t1_CTRL_INF_Ponderado=1))
OBJECT SET COLOR:C271(vr_CTRL_INF_Ponderacion;Choose:C955((c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (t1_CTRL_INF_Ponderado=1);-6;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vr_CTRL_SUP_Ponderacion;(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (u1_CTRL_SUP_Ponderado=1))
OBJECT SET COLOR:C271(vr_CTRL_SUP_Ponderacion;Choose:C955((c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (u1_CTRL_SUP_Ponderado=1);-6;-(16*16)+9))

OBJECT SET ENTERABLE:C238(vs_CTRL_INF_Especifico;(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (t4_CTRL_INF_Especifico=1))
OBJECT SET COLOR:C271(vs_CTRL_INF_Especifico;Choose:C955((c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (t4_CTRL_INF_Especifico=1);-6;-(16*16)+9))
OBJECT SET ENABLED:C1123(vs_CTRL_INF_Especifico;(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (t4_CTRL_INF_Especifico=1))
OBJECT SET ENTERABLE:C238(vs_CTRL_SUP_Especifico;(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (u4_CTRL_SUP_Especifico=1))
OBJECT SET COLOR:C271(vs_CTRL_SUP_Especifico;Choose:C955((c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (u4_CTRL_SUP_Especifico=1);-6;-(16*16)+9))
OBJECT SET ENABLED:C1123(vs_CTRL_SUP_Especifico;(c2_PonderacionVariable=1) & (vi_UsarControlesFinPeriodo=1) & (u4_CTRL_SUP_Especifico=1))
  //


  // gestion de objetos EXAMEN FINAL ANUAL
OBJECT SET ENABLED:C1123(*;"e1_PonderacionConstante";vi_UsarExamenes=1)
OBJECT SET ENABLED:C1123(*;"e2_PonderacionVariable";vi_UsarExamenes=1)
OBJECT SET ENABLED:C1123(*;"e3_ResultadoFijo";vi_UsarExamenes=1)
OBJECT SET ENABLED:C1123(*;"EX_Reprobacion";vi_UsarExamenes=1)
OBJECT SET COLOR:C271(*;"EX_Reprobacion";Choose:C955(vi_UsarExamenes=1;-15;-(16*16)+9))

OBJECT SET ENTERABLE:C238(*;"vr_EX_PonderacionConstante";(e1_PonderacionConstante=1))

OBJECT SET ENABLED:C1123(*;"@EX_INF_@";(e2_PonderacionVariable=1) & (vi_UsarExamenes=1))
OBJECT SET ENABLED:C1123(*;"@EX_SUP_@";(e2_PonderacionVariable=1) & (vi_UsarExamenes=1))
OBJECT SET COLOR:C271(*;"@EX_INF_@";Choose:C955((e2_PonderacionVariable=1) & (vi_UsarExamenes=1);-15;-(16*16)+9))
OBJECT SET COLOR:C271(*;"@EX_SUP_@";Choose:C955((e2_PonderacionVariable=1) & (vi_UsarExamenes=1);-15;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vs_EX_INF_Especifico;(e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (f4_EX_INF_Especifico=1))
OBJECT SET COLOR:C271(*;"EX_Minimo_INF@";Choose:C955((e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (f4_EX_INF_Especifico=1);-6;-(16*16)+9))
OBJECT SET ENABLED:C1123(*;"EX_Minimo_INF";(e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (f4_EX_INF_Especifico=1))
OBJECT SET ENTERABLE:C238(vs_EX_SUP_Especifico;(e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (g4_EX_SUP_Especifico=1))
OBJECT SET COLOR:C271(*;"EX_Minimo_SUP@";Choose:C955((e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (g4_EX_SUP_Especifico=1);-6;-(16*16)+9))
OBJECT SET ENABLED:C1123(*;"EX_Minimo_SUP";(e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (g4_EX_SUP_Especifico=1))

OBJECT SET ENTERABLE:C238(vr_EX_INF_Ponderacion;(e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (f1_EX_INF_Ponderado=1))
OBJECT SET COLOR:C271(vr_EX_INF_Ponderacion;Choose:C955((e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (f1_EX_INF_Ponderado=1);-6;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vr_EX_SUP_Ponderacion;(e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (g1_EX_SUP_Ponderado=1))
OBJECT SET COLOR:C271(vr_EX_SUP_Ponderacion;Choose:C955((e2_PonderacionVariable=1) & (vi_UsarExamenes=1) & (g1_EX_SUP_Ponderado=1);-6;-(16*16)+9))

OBJECT SET ENABLED:C1123(*;"ResultadoFijoEX_@";(e3_ResultadoFijo=1) & (vi_UsarExamenes=1))
OBJECT SET ENTERABLE:C238(*;"ResultadoFijoEX_@";(e3_ResultadoFijo=1) & (vi_UsarExamenes=1))
OBJECT SET COLOR:C271(*;"ResultadoFijoEX_@";Choose:C955((e3_ResultadoFijo=1) & (vi_UsarExamenes=1);-15;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vs_NF_igual_EX_SUP;(e3_ResultadoFijo=1) & (vi_UsarExamenes=1) & (a2_NF_igualValorFijoSUP=1))
OBJECT SET ENTERABLE:C238(vs_NF_igual_EX_INF;(e3_ResultadoFijo=1) & (vi_UsarExamenes=1) & (c2_NF_igualValorFijoINF=1))

OBJECT SET ENABLED:C1123(*;"CorreccionNFEX_@";((e1_PonderacionConstante=1) & (vi_UsarExamenes=1) & (vi_EX_Reprobacion=0)) | ((e2_PonderacionVariable=1) & (g1_EX_SUP_Ponderado=1) & (f1_EX_INF_Ponderado=1) & (vi_UsarExamenes=1)))
OBJECT SET COLOR:C271(*;"CorreccionNFEX_@";Choose:C955(((e1_PonderacionConstante=1) & (vi_UsarExamenes=1) & (vi_EX_Reprobacion=0)) | ((e2_PonderacionVariable=1) & (g1_EX_SUP_Ponderado=1) & (f1_EX_INF_Ponderado=1) & (vi_UsarExamenes=1));-15;-(16*16)+9))
OBJECT SET ENTERABLE:C238(*;"CorreccionNFEX_@";((e1_PonderacionConstante=1) & (vi_UsarExamenes=1) & (vi_EX_Reprobacion=0)) | ((e2_PonderacionVariable=1) & (g1_EX_SUP_Ponderado=1) & (f1_EX_INF_Ponderado=1) & (vi_UsarExamenes=1)))

OBJECT SET ENABLED:C1123(vi_EX_Reprobacion;e1_PonderacionConstante=1)
OBJECT SET COLOR:C271(vi_EX_Reprobacion;Choose:C955(e1_PonderacionConstante=1;-15;-(16*16)+9))
  //


  // gestion de objetos EXAMEN EXTRAORDINARIO
OBJECT SET ENABLED:C1123(*;"EXX_Reprobacion";vi_UsarExamenExtra=1)
OBJECT SET COLOR:C271(*;"EXX_Reprobacion";Choose:C955(vi_UsarExamenExtra=1;-15;-(16*16)+9))
OBJECT SET ENABLED:C1123(*;"x1_PonderacionConstante";vi_UsarExamenExtra=1)
OBJECT SET ENABLED:C1123(*;"x2_PonderacionVariable";vi_UsarExamenExtra=1)
OBJECT SET ENABLED:C1123(*;"x3_ResultadoFijo";vi_UsarExamenExtra=1)

OBJECT SET ENTERABLE:C238(*;"vr_EXX_PonderacionConstante";(x1_PonderacionConstante=1))

  ///ABC 188311 //01062017
  //MONO TICKET 195631
OBJECT SET ENABLED:C1123(*;"@EXX_INF@";(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1))
OBJECT SET COLOR:C271(*;"@EXX_INF@";Choose:C955((x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1);-15;-(16*16)+9))
OBJECT SET ENABLED:C1123(*;"@EXX_SUP@";(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1))
OBJECT SET COLOR:C271(*;"@EXX_SUP@";Choose:C955((x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1);-15;-(16*16)+9))
  //ABC


OBJECT SET ENTERABLE:C238(vs_EXX_INF_Especifico;(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (y4_EXX_INF_Especifico=1))
OBJECT SET COLOR:C271(*;"EXX_Minimo_INF@";Choose:C955((x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (y4_EXX_INF_Especifico=1);-6;-(16*16)+9))
OBJECT SET ENABLED:C1123(*;"EXX_Minimo_INF";(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (y4_EXX_INF_Especifico=1))
OBJECT SET ENTERABLE:C238(vs_EXX_SUP_Especifico;(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (z4_EXX_SUP_Especifico=1))
OBJECT SET COLOR:C271(*;"EXX_Minimo_SUP@";Choose:C955((x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (z4_EXX_SUP_Especifico=1);-6;-(16*16)+9))
OBJECT SET ENABLED:C1123(*;"EXX_Minimo_SUP";(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (z4_EXX_SUP_Especifico=1))

OBJECT SET ENTERABLE:C238(vr_EXX_INF_Ponderacion;(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (y1_EXX_INF_Ponderado=1))
OBJECT SET COLOR:C271(vr_EXX_INF_Ponderacion;Choose:C955((x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (y1_EXX_INF_Ponderado=1);-6;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vr_EXX_SUP_Ponderacion;(x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (z1_EXX_SUP_Ponderado=1))
OBJECT SET COLOR:C271(vr_EXX_SUP_Ponderacion;Choose:C955((x2_PonderacionVariable=1) & (vi_UsarExamenExtra=1) & (z1_EXX_SUP_Ponderado=1);-6;-(16*16)+9))

OBJECT SET ENABLED:C1123(*;"ResultadoFijoEXX_@";(x3_ResultadoFijo=1) & (vi_UsarExamenExtra=1))
OBJECT SET ENTERABLE:C238(*;"ResultadoFijoEXX_@";(x3_ResultadoFijo=1) & (vi_UsarExamenExtra=1))
OBJECT SET COLOR:C271(*;"ResultadoFijoEXX_@";Choose:C955((x3_ResultadoFijo=1) & (vi_UsarExamenExtra=1);-15;-(16*16)+9))
OBJECT SET ENTERABLE:C238(vs_NF_igual_EXX_SUP;(x3_ResultadoFijo=1) & (vi_UsarExamenExtra=1) & (m2_NF_igualValorFijoSUP=1))
OBJECT SET ENTERABLE:C238(vs_NF_igual_EXX_INF;(x3_ResultadoFijo=1) & (vi_UsarExamenExtra=1) & (n2_NF_igualValorFijoINF=1))

OBJECT SET ENABLED:C1123(*;"CorreccionNFEXX_@";((x1_PonderacionConstante=1) & (vi_UsarExamenExtra=1) & (vi_EXX_Reprobacion=0)) | ((e2_PonderacionVariable=1) & (z1_EXX_SUP_Ponderado=1) & (y1_EXX_INF_Ponderado=1) & (vi_UsarExamenExtra=1)))
OBJECT SET COLOR:C271(*;"CorreccionNFEXX_@";Choose:C955(((x1_PonderacionConstante=1) & (vi_UsarExamenExtra=1) & (vi_EXX_Reprobacion=0)) | ((e2_PonderacionVariable=1) & (z1_EXX_SUP_Ponderado=1) & (y1_EXX_INF_Ponderado=1) & (vi_UsarExamenExtra=1));-15;-(16*16)+9))
OBJECT SET ENTERABLE:C238(*;"CorreccionNFEXX_@";((x1_PonderacionConstante=1) & (vi_UsarExamenExtra=1) & (vi_EXX_Reprobacion=0)) | ((e2_PonderacionVariable=1) & (z1_EXX_SUP_Ponderado=1) & (y1_EXX_INF_Ponderado=1) & (vi_UsarExamenExtra=1)))

OBJECT SET ENABLED:C1123(vi_EX_Reprobacion;e1_PonderacionConstante=1)
OBJECT SET COLOR:C271(vi_EX_Reprobacion;Choose:C955(e1_PonderacionConstante=1;-15;-(16*16)+9))
OBJECT SET ENABLED:C1123(vi_EXX_Reprobacion;x1_PonderacionConstante=1)
OBJECT SET COLOR:C271(vi_EXX_Reprobacion;Choose:C955(x1_PonderacionConstante=1;-15;-(16*16)+9))

OBJECT SET VISIBLE:C603(*;"vi_UsarEXRecuperatorio";FORM Get current page:C276>2)
OBJECT SET VISIBLE:C603(*;"vs_MinimoExRecuperatorio@";FORM Get current page:C276>2)
OBJECT SET ENTERABLE:C238(*;"vs_MinimoExRecuperatorio@";(FORM Get current page:C276>2) & (vi_UsarEXRecuperatorio=1))
OBJECT SET COLOR:C271(*;"@Recuperatorio@";-15)
  //

OBJECT SET ENABLED:C1123(bOK;Not:C34(<>vb_BloquearModifSituacionFinal))


OBJECT SET VISIBLE:C603(*;"EXP_ConfiguracionPorPeriodo";vi_UsarControlesFinPeriodo=1)
OBJECT SET VISIBLE:C603(*;"EXP_tabPeriodos";(vi_UsarControlesFinPeriodo=1) & (EXP_ConfiguracionPorPeriodo=1))

OBJECT SET VISIBLE:C603(*;"bonificacion@";vi_UsarBonificacion=1)
OBJECT SET VISIBLE:C603(*;"bonificacionP1@";(vi_UsarBonificacion=1) & (Size of array:C274(atSTR_Periodos_Nombre)>=1))
OBJECT SET VISIBLE:C603(*;"bonificacionP2@";(vi_UsarBonificacion=1) & (Size of array:C274(atSTR_Periodos_Nombre)>=2))
OBJECT SET VISIBLE:C603(*;"bonificacionP3@";(vi_UsarBonificacion=1) & (Size of array:C274(atSTR_Periodos_Nombre)>=3))
OBJECT SET VISIBLE:C603(*;"bonificacionP4@";(vi_UsarBonificacion=1) & (Size of array:C274(atSTR_Periodos_Nombre)>=4))
OBJECT SET VISIBLE:C603(*;"bonificacionP5@";(vi_UsarBonificacion=1) & (Size of array:C274(atSTR_Periodos_Nombre)>=5))



If ((c1_PonderacionConstante=0) | (vr_Ctrl_PonderacionConstante=0) | (vi_UsarControlesFinPeriodo=0))
	vi_bonificarAntesControl:=0
End if 
OBJECT SET ENABLED:C1123(vi_bonificarAntesControl;(c1_PonderacionConstante=1) & (vr_Ctrl_PonderacionConstante>0) & (vi_UsarControlesFinPeriodo=1))
