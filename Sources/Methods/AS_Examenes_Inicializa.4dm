//%attributes = {}
  // AS_Examenes_Inicializa()
  //
  //
  // creado por: Alberto Bachler Klein: 28-05-16, 12:27:47
  // -----------------------------------------------------------

  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_inicializar)
C_LONGINT:C283($l_otPeriodo;$l_otRef)

  //controles de fin de período
C_LONGINT:C283(vi_UsarControlesFinPeriodo;EXP_ConfiguracionPorPeriodo;c1_PonderacionConstante;c2_PonderacionVariable)
C_LONGINT:C283(t1_CTRL_INF_Ponderado;t2_CTRL_INF_Control;t3_CTRL_INF_Presentacion;t4_CTRL_INF_Especifico)
C_LONGINT:C283(u1_CTRL_SUP_Ponderado;u2_CTRL_SUP_Control;u3_CTRL_SUP_Presentacion;u4_CTRL_SUP_Especifico)
C_REAL:C285(vr_Ctrl_PonderacionConstante;vr_CTRL_INF_Ponderacion;vr_CTRL_SUP_Ponderacion;vr_CTRL_INF_Especifico;vr_CTRL_SUP_Especifico;vr_Ctrl_PonderacionConstant)


  //examen final del ciclo escolares
C_LONGINT:C283(vi_UsarExamenes;e1_PonderacionConstante;e2_PonderacionVariable;e3_ResultadoFijo;vi_EX_Reprobacion)
C_LONGINT:C283(f1_EX_INF_Ponderado;f2_EX_INF_Control;f3_EX_INF_Presentacion;f4_EX_INF_Especifico)
C_LONGINT:C283(g1_EX_SUP_Ponderado;g2_EX_SUP_Control;g3_EX_SUP_Presentacion;g4_EX_SUP_Especifico)
C_REAL:C285(vr_EX_PonderacionConstante;vr_EX_INF_Ponderacion;vr_EX_SUP_Ponderacion;vr_EX_INF_Especifico;vr_EX_SUP_Especifico)
C_REAL:C285(vr_CalificacionEX;vr_NF_igual_EX_SUP;vr_NF_igual_EX_INF)
C_LONGINT:C283(a1_NF_igualEX_SUP;a2_NF_igualValorFijoSUP;c1_NF_igualEX_INF;c2_NF_igualValorFijoINF)

  //examen extraordinario
C_LONGINT:C283(vi_UsarExamenExtra;x1_PonderacionConstante;x2_PonderacionVariable;x3_ResultadoFijo;vi_EXX_Reprobacion)
C_LONGINT:C283(y1_EXX_INF_Ponderado;y2_EXX_INF_Control;y3_EXX_INF_Presentacion;y4_EXX_INF_Especifico)
C_LONGINT:C283(z1_EXX_SUP_Ponderado;z2_EXX_SUP_Control;z3_EXX_SUP_Presentacion;z4_EXX_SUP_Especifico)
C_REAL:C285(vr_EXX_PonderacionConstante;vr_EXX_INF_Ponderacion;vr_EXX_SUP_Ponderacion;vr_EXX_INF_Especifico;vr_EXX_SUP_Especifico)
C_REAL:C285(vr_CalificacionEXX;vr_NF_igual_EXX_SUP;vr_NF_igual_EXX_INF)
C_LONGINT:C283(m1_NF_igualEXX_SUP;m2_NF_igualValorFijoSUP;n1_NF_igualEXX_INF;n2_NF_igualValorFijoINF)

  // corrección resultado
C_LONGINT:C283(vi_CorreccionNF_EX;vi_CorreccionNF_EXX)
C_REAL:C285(vr_CorreccionNFEX_minimo;vr_CorreccionNFEX_resultado;vr_CorreccionNFEXX_minimo;vr_CorreccionNFEXX_resultado)

  //examen recuperatorio
C_REAL:C285(vr_MinimoExRecuperatorio)

  // bonificación extra-académica
C_LONGINT:C283(vi_UsarBonificacion;vi_bonificarAntesControl)
C_REAL:C285(vrBonificacionP1;vrBonificacionP2;vrBonificacionP3;vrBonificacionP4;vrBonificacionP5)

  //declaro Objeto
C_OBJECT:C1216($o_controlesYexamenes;$o_periodo)

$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
If ((OB Is defined:C1231($o_controlesYexamenes)=False:C215) | (OB Is empty:C1297($o_controlesYexamenes)))
	$b_inicializar:=True:C214
End if 


If ($b_inicializar)
	vs_CTRL_INF_Especifico:=""
	vs_CTRL_SUP_Especifico:=""
	vs_EX_INF_Especifico:=""
	vs_EX_SUP_Especifico:=""
	vs_EXX_INF_Especifico:=""
	vs_EXX_SUP_Especifico:=""
	vs_MinimoExRecuperatorio:=""
	
	vi_UsarControlesFinPeriodo:=0
	EXP_ConfiguracionPorPeriodo:=0
	
	c1_PonderacionConstante:=0
	c2_PonderacionVariable:=0
	t1_CTRL_INF_Ponderado:=0
	t2_CTRL_INF_Control:=0
	t3_CTRL_INF_Presentacion:=0
	t4_CTRL_INF_Especifico:=0
	u1_CTRL_INF_Ponderado:=0
	u2_CTRL_INF_Control:=0
	u3_CTRL_INF_Presentacion:=0
	u4_CTRL_INF_Especifico:=0
	vr_CTRL_PonderacionConstante:=0
	vr_CTRL_INF_Ponderacion:=0
	vr_CTRL_SUP_Ponderacion:=0
	vr_CTRL_INF_Especifico:=0
	vr_CTRL_SUP_Especifico:=0
	
	vi_UsarExamenes:=0
	e1_PonderacionConstante:=0
	e2_PonderacionVariable:=0
	e3_ResultadoFijo:=0
	f1_EX_INF_Ponderado:=0
	f2_EX_INF_Control:=0
	f3_EX_INF_Presentacion:=0
	f4_EX_INF_Especifico:=0
	g1_EX_INF_Ponderado:=0
	g2_EX_INF_Control:=0
	g3_EX_INF_Presentacion:=0
	g4_EX_INF_Especifico:=0
	vr_EX_PonderacionConstante:=0
	vr_EX_INF_Ponderacion:=0
	vr_EX_SUP_Ponderacion:=0
	vr_EX_INF_Especifico:=0
	vr_EX_SUP_Especifico:=0
	vr_MinimoExRecuperatorio:=0
	
	
	vi_UsarExamenExtra:=0
	x1_PonderacionConstante:=0
	x2_PonderacionVariable:=0
	y1_EXX_INF_Ponderado:=0
	y2_EXX_INF_Control:=0
	y3_EXX_INF_Presentacion:=0
	y4_EXX_INF_Especifico:=0
	z1_EXX_INF_Ponderado:=0
	z2_EXX_INF_Control:=0
	z3_EXX_INF_Presentacion:=0
	z4_EXX_INF_Especifico:=0
	vr_EXX_PonderacionConstante:=0
	vr_EXX_INF_Ponderacion:=0
	vr_EXX_SUP_Ponderacion:=0
	vr_EXX_INF_Especifico:=0
	vr_EXX_SUP_Especifico:=0
	
	vr_CalificacionEX:=-10
	a1_NF_igualEX_SUP:=0
	a2_NF_igualValorFijoSUP:=0
	vr_NF_igual_EX_SUP:=-10
	c1_NF_igualEX_INF:=0
	c2_NF_igualValorFijoINF:=0
	vr_NF_igual_EX_INF:=-10
	
	vr_CalificacionEXX:=-10
	m1_NF_igualEXX_SUP:=0
	m2_NF_igualValorFijoSUP:=0
	vr_NF_igual_EXX_SUP:=-10
	n1_NF_igualEXX_INF:=0
	n2_NF_igualValorFijoINF:=0
	vr_NF_igual_EXX_INF:=-10
	
	vi_CorreccionNF_EX:=0
	vr_CorreccionNFEX_minimo:=-10
	vr_CorreccionNFEX_resultado:=-10
	vi_CorreccionNF_EXX:=0
	vr_CorreccionNFEXX_minimo:=-10
	vr_CorreccionNFEXX_resultado:=-10
	
	EXP_ConfiguracionPorPeriodo:=0
	
	CLEAR VARIABLE:C89($o_controlesYexamenes)
	OB SET:C1220($o_controlesYexamenes;"vi_UsarControlesFinPeriodo";vi_UsarControlesFinPeriodo)
	OB SET:C1220($o_controlesYexamenes;"EXP_ConfiguracionPorPeriodo";EXP_ConfiguracionPorPeriodo)
	OB SET:C1220($o_controlesYexamenes;"vi_UsarExamenes";vi_UsarExamenes)
	OB SET:C1220($o_controlesYexamenes;"vi_EX_Reprobacion";vi_EX_Reprobacion)
	OB SET:C1220($o_controlesYexamenes;"e1_PonderacionConstante";e1_PonderacionConstante)
	
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
	
	OB SET:C1220($o_controlesYexamenes;"vi_UsarBonificacion";vi_UsarBonificacion)
	OB SET:C1220($o_controlesYexamenes;"bonificacionP1";vrBonificacionP1)
	OB SET:C1220($o_controlesYexamenes;"bonificacionP2";vrBonificacionP2)
	OB SET:C1220($o_controlesYexamenes;"bonificacionP3";vrBonificacionP3)
	OB SET:C1220($o_controlesYexamenes;"bonificacionP4";vrBonificacionP4)
	OB SET:C1220($o_controlesYexamenes;"bonificacionP5";vrBonificacionP5)
	
	OB SET:C1220($o_controlesYexamenes;"EXP_ConfiguracionPorPeriodo";0)
	
	  //Para los periodo
	OB SET:C1220($o_periodo;"c1_PonderacionConstante";c1_PonderacionConstante)
	OB SET:C1220($o_periodo;"c2_PonderacionVariable";c2_PonderacionVariable)
	OB SET:C1220($o_periodo;"t1_CTRL_INF_Ponderado";t1_CTRL_INF_Ponderado)
	OB SET:C1220($o_periodo;"t2_CTRL_INF_Control";t2_CTRL_INF_Control)
	OB SET:C1220($o_periodo;"t3_CTRL_INF_Presentacion";t3_CTRL_INF_Presentacion)
	OB SET:C1220($o_periodo;"t4_CTRL_INF_Especifico";t4_CTRL_INF_Especifico)
	OB SET:C1220($o_periodo;"u1_CTRL_SUP_Ponderado";u1_CTRL_SUP_Ponderado)
	OB SET:C1220($o_periodo;"u2_CTRL_SUP_Control";u2_CTRL_SUP_Control)
	OB SET:C1220($o_periodo;"u3_CTRL_SUP_Presentacion";u3_CTRL_SUP_Presentacion)
	OB SET:C1220($o_periodo;"u4_CTRL_SUP_Especifico";u4_CTRL_SUP_Especifico)
	OB SET:C1220($o_periodo;"vr_CTRL_PonderacionConstante";vr_CTRL_PonderacionConstante)
	OB SET:C1220($o_periodo;"vr_CTRL_INF_Ponderacion";vr_CTRL_INF_Ponderacion)
	OB SET:C1220($o_periodo;"vr_CTRL_SUP_Ponderacion";vr_CTRL_SUP_Ponderacion)
	OB SET:C1220($o_periodo;"vr_CTRL_INF_Especifico";vr_CTRL_INF_Especifico)
	OB SET:C1220($o_periodo;"vr_CTRL_SUP_Especifico";vr_CTRL_SUP_Especifico)
	
	OB SET:C1220($o_controlesYexamenes;"EXP_ObjPeriodoComun";$o_periodo)
	
	OB SET:C1220([Asignaturas:18]Opciones:57;"controles_y_examenes";$o_controlesYexamenes)
	SAVE RECORD:C53([Asignaturas:18])
	CLEAR VARIABLE:C89($o_controlesYexamenes)
	CLEAR VARIABLE:C89($o_periodo)
End if 


