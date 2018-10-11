//%attributes = {}
  // AS_Examenes_GuardaConfiguracion()
  //
  //
  // creado por: Alberto Bachler Klein: 25-05-16, 11:50:14
  // -----------------------------------------------------------

  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_BLOB:C604($blob)
C_LONGINT:C283($l_periodo;$l_periodoSeleccionado)
C_OBJECT:C1216($o_controlesYexamenes;$o_objetoPeriodoComun;$o_objetoPeriodo)

$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)

OB SET:C1220($o_controlesYexamenes;"vi_UsarExamenes";vi_UsarExamenes)
OB SET:C1220($o_controlesYexamenes;"vi_EX_Reprobacion";vi_EX_Reprobacion)
OB SET:C1220($o_controlesYexamenes;"e1_PonderacionConstante";e1_PonderacionConstante)
OB SET:C1220($o_controlesYexamenes;"e2_PonderacionVariable";e2_PonderacionVariable)
OB SET:C1220($o_controlesYexamenes;"f1_EX_INF_Ponderado";f1_EX_INF_Ponderado)
OB SET:C1220($o_controlesYexamenes;"f2_EX_INF_Control";f2_EX_INF_Control)
OB SET:C1220($o_controlesYexamenes;"f3_EX_INF_Presentacion";f3_EX_INF_Presentacion)
OB SET:C1220($o_controlesYexamenes;"f4_EX_INF_Especifico";f4_EX_INF_Especifico)
OB SET:C1220($o_controlesYexamenes;"g1_EX_SUP_Ponderado";g1_EX_SUP_Ponderado)
OB SET:C1220($o_controlesYexamenes;"g2_EX_SUP_Control";g2_EX_SUP_Control)
OB SET:C1220($o_controlesYexamenes;"g3_EX_SUP_Presentacion";g3_EX_SUP_Presentacion)
OB SET:C1220($o_controlesYexamenes;"g4_EX_SUP_Especifico";g4_EX_SUP_Especifico)
OB SET:C1220($o_controlesYexamenes;"vr_EX_PonderacionConstante";vr_EX_PonderacionConstante)
OB SET:C1220($o_controlesYexamenes;"vr_EX_INF_Ponderacion";vr_EX_INF_Ponderacion)
OB SET:C1220($o_controlesYexamenes;"vr_EX_SUP_Ponderacion";vr_EX_SUP_Ponderacion)
OB SET:C1220($o_controlesYexamenes;"vr_EX_INF_Especifico";vr_EX_INF_Especifico)
OB SET:C1220($o_controlesYexamenes;"vr_EX_SUP_Especifico";vr_EX_SUP_Especifico)

OB SET:C1220($o_controlesYexamenes;"vi_UsarExamenExtra";vi_UsarExamenExtra)
OB SET:C1220($o_controlesYexamenes;"vi_EXX_Reprobacion";vi_EXX_Reprobacion)
OB SET:C1220($o_controlesYexamenes;"x1_PonderacionConstante";x1_PonderacionConstante)
OB SET:C1220($o_controlesYexamenes;"x2_PonderacionVariable";x2_PonderacionVariable)
OB SET:C1220($o_controlesYexamenes;"y1_EXX_INF_Ponderado";y1_EXX_INF_Ponderado)
OB SET:C1220($o_controlesYexamenes;"y2_EXX_INF_Control";y2_EXX_INF_Control)
OB SET:C1220($o_controlesYexamenes;"y3_EXX_INF_Presentacion";y3_EXX_INF_Presentacion)
OB SET:C1220($o_controlesYexamenes;"y4_EXX_INF_Especifico";y4_EXX_INF_Especifico)
OB SET:C1220($o_controlesYexamenes;"z1_EXX_SUP_Ponderado";z1_EXX_SUP_Ponderado)
OB SET:C1220($o_controlesYexamenes;"z2_EXX_SUP_Control";z2_EXX_SUP_Control)
OB SET:C1220($o_controlesYexamenes;"z3_EXX_SUP_Presentacion";z3_EXX_SUP_Presentacion)
OB SET:C1220($o_controlesYexamenes;"z4_EXX_SUP_Especifico";z4_EXX_SUP_Especifico)
OB SET:C1220($o_controlesYexamenes;"vr_EXX_PonderacionConstante";vr_EXX_PonderacionConstante)
OB SET:C1220($o_controlesYexamenes;"vr_EXX_INF_Ponderacion";vr_EXX_INF_Ponderacion)
OB SET:C1220($o_controlesYexamenes;"vr_EXX_SUP_Ponderacion";vr_EXX_SUP_Ponderacion)
OB SET:C1220($o_controlesYexamenes;"vr_EXX_INF_Especifico";vr_EXX_INF_Especifico)
OB SET:C1220($o_controlesYexamenes;"vr_EXX_SUP_Especifico";vr_EXX_SUP_Especifico)

OB SET:C1220($o_controlesYexamenes;"e3_ResultadoFijo";e3_ResultadoFijo)
OB SET:C1220($o_controlesYexamenes;"vr_CalificacionEX";vr_CalificacionEX)
OB SET:C1220($o_controlesYexamenes;"a1_NF_igualEX_SUP";a1_NF_igualEX_SUP)
OB SET:C1220($o_controlesYexamenes;"a2_NF_igualValorFijoSUP";a2_NF_igualValorFijoSUP)
OB SET:C1220($o_controlesYexamenes;"vr_NF_igual_EX_SUP";vr_NF_igual_EX_SUP)
OB SET:C1220($o_controlesYexamenes;"c1_NF_igualEX_INF";c1_NF_igualEX_INF)
OB SET:C1220($o_controlesYexamenes;"c2_NF_igualValorFijoINF";c2_NF_igualValorFijoINF)
OB SET:C1220($o_controlesYexamenes;"vr_NF_igual_EX_INF";vr_NF_igual_EX_INF)

OB SET:C1220($o_controlesYexamenes;"x3_ResultadoFijo";x3_ResultadoFijo)
OB SET:C1220($o_controlesYexamenes;"vr_CalificacionEXX";vr_CalificacionEXX)
OB SET:C1220($o_controlesYexamenes;"m1_NF_igualEXX_SUP";m1_NF_igualEXX_SUP)
OB SET:C1220($o_controlesYexamenes;"m2_NF_igualValorFijoSUP";m2_NF_igualValorFijoSUP)
OB SET:C1220($o_controlesYexamenes;"vr_NF_igual_EXX_SUP";vr_NF_igual_EXX_SUP)
OB SET:C1220($o_controlesYexamenes;"n1_NF_igualEXX_INF";n1_NF_igualEXX_INF)
OB SET:C1220($o_controlesYexamenes;"n2_NF_igualValorFijoINF";n2_NF_igualValorFijoINF)
OB SET:C1220($o_controlesYexamenes;"vr_NF_igual_EXX_INF";vr_NF_igual_EXX_INF)

OB SET:C1220($o_controlesYexamenes;"vi_CorreccionNFEX";vi_CorreccionNFEX)
OB SET:C1220($o_controlesYexamenes;"vi_CorreccionNFEXX";vi_CorreccionNFEXX)
OB SET:C1220($o_controlesYexamenes;"vr_CorreccionNFEX_minimo";vr_CorreccionNFEX_minimo)
OB SET:C1220($o_controlesYexamenes;"vr_CorreccionNFEX_resultado";vr_CorreccionNFEX_resultado)
OB SET:C1220($o_controlesYexamenes;"vr_CorreccionNFEXX_minimo";vr_CorreccionNFEXX_minimo)
OB SET:C1220($o_controlesYexamenes;"vr_CorreccionNFEXX_resultado";vr_CorreccionNFEXX_resultado)

OB SET:C1220($o_controlesYexamenes;"vi_UsarEXRecuperatorio";vi_UsarEXRecuperatorio)
OB SET:C1220($o_controlesYexamenes;"vr_MinimoExRecuperatorio";vr_MinimoExRecuperatorio)

OB SET:C1220($o_controlesYexamenes;"vi_UsarControlesFinPeriodo";vi_UsarControlesFinPeriodo)
OB SET:C1220($o_controlesYexamenes;"EXP_ConfiguracionPorPeriodo";EXP_ConfiguracionPorPeriodo)

  // ponderación bonificaciones
OB SET:C1220($o_controlesYexamenes;"vi_UsarBonificacion";vi_UsarBonificacion)
OB SET:C1220($o_controlesYexamenes;"bonificacionP1";vrBonificacionP1)
OB SET:C1220($o_controlesYexamenes;"bonificacionP2";vrBonificacionP2)
OB SET:C1220($o_controlesYexamenes;"bonificacionP3";vrBonificacionP3)
OB SET:C1220($o_controlesYexamenes;"bonificacionP4";vrBonificacionP4)
OB SET:C1220($o_controlesYexamenes;"bonificacionP5";vrBonificacionP5)
OB SET:C1220($o_controlesYexamenes;"bonificacion_AntesControl";vi_bonificarAntesControl)


$o_objetoPeriodoComun:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun";Is object:K8:27)
If (OB Is defined:C1231($o_objetoPeriodoComun))
	AS_Examenes_GuardaConfigPeriodo 
End if 

$l_periodoSeleccionado:=(OBJECT Get pointer:C1124(Object named:K67:5;"periodoSeleccionado"))->
If ($l_periodoSeleccionado>0)
	$o_objetoPeriodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodo"+String:C10($l_periodoSeleccionado);Is object:K8:27)
	If (OB Is defined:C1231($o_objetoPeriodo))
		AS_Examenes_GuardaConfigPeriodo ($l_periodoSeleccionado)
	End if 
End if 


$y_objetoOriginal:=OBJECT Get pointer:C1124(Object named:K67:5;"objOriginal")
$t_digestOriginal:=Generate digest:C1147(JSON Stringify:C1217($y_objetoOriginal->);0)
$t_digestModificado:=Generate digest:C1147(JSON Stringify:C1217($o_controlesYexamenes);0)
If ($t_digestOriginal#$t_digestModificado)
	OB SET:C1220([Asignaturas:18]Opciones:57;"controles_y_examenes";$o_controlesYexamenes)
	SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Asignaturas:18]Numero:1;SNT_Accion_Actualizar)
	SAVE RECORD:C53([Asignaturas:18])
End if 
