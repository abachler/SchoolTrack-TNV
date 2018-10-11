//%attributes = {}
  // AS_Examenes_Inicializa_OLD()
  //
  //
  //  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos
  // -----------------------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_inicializar)
C_LONGINT:C283($l_otPeriodo;$l_otRef)
C_POINTER:C301($y_refObjetoRaiz)

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

If (BLOB size:C605([Asignaturas:18]OpcionesControles_y_Examenes:106)=0)
	$b_inicializar:=True:C214
Else 
	$x_blob:=[Asignaturas:18]OpcionesControles_y_Examenes:106
	$l_otRef:=OT BLOBToObject ($x_blob)
	If (OT IsObject ($l_otRef)=0)
		$b_inicializar:=True:C214
	End if 
	OT Clear ($l_otRef)
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
	
	$l_otRef:=OT New 
	
	OT PutLong ($l_otRef;"vi_UsarControlesFinPeriodo";vi_UsarControlesFinPeriodo)
	OT PutLong ($l_otRef;"EXP_ConfiguracionPorPeriodo";EXP_ConfiguracionPorPeriodo)
	
	
	OT PutLong ($l_otRef;"vi_UsarExamenes";vi_UsarExamenes)
	OT PutLong ($l_otRef;"vi_EX_Reprobacion";vi_EX_Reprobacion)
	OT PutLong ($l_otRef;"e1_PonderacionConstante";e1_PonderacionConstante)
	OT PutLong ($l_otRef;"e2_PonderacionVariable";e2_PonderacionVariable)
	OT PutLong ($l_otRef;"f1_EX_INF_Ponderado";f1_EX_INF_Ponderado)
	OT PutLong ($l_otRef;"f2_EX_INF_Control";f2_EX_INF_Control)
	OT PutLong ($l_otRef;"f3_EX_INF_Presentacion";f3_EX_INF_Presentacion)
	OT PutLong ($l_otRef;"f4_EX_INF_Especifico";f4_EX_INF_Especifico)
	OT PutLong ($l_otRef;"g1_EX_SUP_Ponderado";g1_EX_SUP_Ponderado)
	OT PutLong ($l_otRef;"g2_EX_SUP_Control";g2_EX_SUP_Control)
	OT PutLong ($l_otRef;"g3_EX_SUP_Presentacion";g3_EX_SUP_Presentacion)
	OT PutLong ($l_otRef;"g4_EX_SUP_Especifico";g4_EX_SUP_Especifico)
	OT PutReal ($l_otRef;"vr_EX_PonderacionConstante";vr_EX_PonderacionConstante)
	OT PutReal ($l_otRef;"vr_EX_INF_Ponderacion";vr_EX_INF_Ponderacion)
	OT PutReal ($l_otRef;"vr_EX_SUP_Ponderacion";vr_EX_SUP_Ponderacion)
	OT PutReal ($l_otRef;"vr_EX_INF_Especifico";vr_EX_INF_Especifico)
	OT PutReal ($l_otRef;"vr_EX_SUP_Especifico";vr_EX_SUP_Especifico)
	
	OT PutLong ($l_otRef;"vi_UsarExamenExtra";vi_UsarExamenExtra)
	OT PutLong ($l_otRef;"vi_EXX_Reprobacion";vi_EXX_Reprobacion)
	OT PutLong ($l_otRef;"x1_PonderacionConstante";x1_PonderacionConstante)
	OT PutLong ($l_otRef;"x2_PonderacionVariable";x2_PonderacionVariable)
	OT PutLong ($l_otRef;"y1_EXX_INF_Ponderado";y1_EXX_INF_Ponderado)
	OT PutLong ($l_otRef;"y2_EXX_INF_Control";y2_EXX_INF_Control)
	OT PutLong ($l_otRef;"y3_EXX_INF_Presentacion";y3_EXX_INF_Presentacion)
	OT PutLong ($l_otRef;"y4_EXX_INF_Especifico";y4_EXX_INF_Especifico)
	OT PutLong ($l_otRef;"z1_EXX_SUP_Ponderado";z1_EXX_SUP_Ponderado)
	OT PutLong ($l_otRef;"z2_EXX_SUP_Control";z2_EXX_SUP_Control)
	OT PutLong ($l_otRef;"z3_EXX_SUP_Presentacion";z3_EXX_SUP_Presentacion)
	OT PutLong ($l_otRef;"z4_EXX_SUP_Especifico";z4_EXX_SUP_Especifico)
	OT PutReal ($l_otRef;"vr_EXX_PonderacionConstante";vr_EXX_PonderacionConstante)
	OT PutReal ($l_otRef;"vr_EXX_INF_Ponderacion";vr_EXX_INF_Ponderacion)
	OT PutReal ($l_otRef;"vr_EXX_SUP_Ponderacion";vr_EXX_SUP_Ponderacion)
	OT PutReal ($l_otRef;"vr_EXX_INF_Especifico";vr_EXX_INF_Especifico)
	OT PutReal ($l_otRef;"vr_EXX_SUP_Especifico";vr_EXX_SUP_Especifico)
	
	OT PutLong ($l_otRef;"e3_ResultadoFijo";e3_ResultadoFijo)
	OT PutReal ($l_otRef;"vr_CalificacionEX";vr_CalificacionEX)
	OT PutLong ($l_otRef;"a1_NF_igualEX_SUP";a1_NF_igualEX_SUP)
	OT PutLong ($l_otRef;"a2_NF_igualValorFijoSUP";a2_NF_igualValorFijoSUP)
	OT PutReal ($l_otRef;"vr_NF_igual_EX_SUP";vr_NF_igual_EX_SUP)
	OT PutLong ($l_otRef;"c1_NF_igualEX_INF";c1_NF_igualEX_INF)
	OT PutLong ($l_otRef;"c2_NF_igualValorFijoINF";c2_NF_igualValorFijoINF)
	OT PutReal ($l_otRef;"vr_NF_igual_EX_INF";vr_NF_igual_EX_INF)
	
	OT PutLong ($l_otRef;"x3_ResultadoFijo";x3_ResultadoFijo)
	OT PutReal ($l_otRef;"vr_CalificacionEXX";vr_CalificacionEXX)
	OT PutLong ($l_otRef;"m1_NF_igualEXX_SUP";m1_NF_igualEXX_SUP)
	OT PutLong ($l_otRef;"m2_NF_igualValorFijoSUP";m2_NF_igualValorFijoSUP)
	OT PutReal ($l_otRef;"vr_NF_igual_EXX_SUP";vr_NF_igual_EXX_SUP)
	OT PutLong ($l_otRef;"n1_NF_igualEXX_INF";n1_NF_igualEXX_INF)
	OT PutLong ($l_otRef;"n2_NF_igualValorFijoINF";n2_NF_igualValorFijoINF)
	OT PutReal ($l_otRef;"vr_NF_igual_EXX_INF";vr_NF_igual_EXX_INF)
	
	OT PutLong ($l_otRef;"vi_CorreccionNFEX";vi_CorreccionNFEX)
	OT PutLong ($l_otRef;"vi_CorreccionNFEXX";vi_CorreccionNFEXX)
	OT PutReal ($l_otRef;"vr_CorreccionNFEX_minimo";vr_CorreccionNFEX_minimo)
	OT PutReal ($l_otRef;"vr_CorreccionNFEX_resultado";vr_CorreccionNFEX_resultado)
	OT PutReal ($l_otRef;"vr_CorreccionNFEXX_minimo";vr_CorreccionNFEXX_minimo)
	OT PutReal ($l_otRef;"vr_CorreccionNFEXX_resultado";vr_CorreccionNFEXX_resultado)
	
	OT PutLong ($l_otRef;"vi_UsarEXRecuperatorio";vi_UsarEXRecuperatorio)
	OT PutReal ($l_otRef;"vr_MinimoExRecuperatorio";vr_MinimoExRecuperatorio)
	
	  // ponderación bonificaciones
	  //OT PutLong ($y_refObjetoRaiz->;"vi_UsarBonificacion";vi_UsarBonificacion)
	  //OT PutReal ($y_refObjetoRaiz->;"bonificacionP1";vrBonificacionP1)
	  //OT PutReal ($y_refObjetoRaiz->;"bonificacionP2";vrBonificacionP2)
	  //OT PutReal ($y_refObjetoRaiz->;"bonificacionP3";vrBonificacionP3)
	  //OT PutReal ($y_refObjetoRaiz->;"bonificacionP4";vrBonificacionP4)
	  //OT PutReal ($y_refObjetoRaiz->;"bonificacionP5";vrBonificacionP5)
	OT PutLong ($l_otRef;"vi_UsarBonificacion";vi_UsarBonificacion)
	OT PutReal ($l_otRef;"bonificacionP1";vrBonificacionP1)
	OT PutReal ($l_otRef;"bonificacionP2";vrBonificacionP2)
	OT PutReal ($l_otRef;"bonificacionP3";vrBonificacionP3)
	OT PutReal ($l_otRef;"bonificacionP4";vrBonificacionP4)
	OT PutReal ($l_otRef;"bonificacionP5";vrBonificacionP5)
	
	OT PutLong ($l_otRef;"EXP_ConfiguracionPorPeriodo";0)
	
	
	$l_otPeriodo:=OT New 
	OT PutLong ($l_otPeriodo;"c1_PonderacionConstante";c1_PonderacionConstante)
	OT PutLong ($l_otPeriodo;"c2_PonderacionVariable";c2_PonderacionVariable)
	OT PutLong ($l_otPeriodo;"t1_CTRL_INF_Ponderado";t1_CTRL_INF_Ponderado)
	OT PutLong ($l_otPeriodo;"t2_CTRL_INF_Control";t2_CTRL_INF_Control)
	OT PutLong ($l_otPeriodo;"t3_CTRL_INF_Presentacion";t3_CTRL_INF_Presentacion)
	OT PutLong ($l_otPeriodo;"t4_CTRL_INF_Especifico";t4_CTRL_INF_Especifico)
	OT PutLong ($l_otPeriodo;"u1_CTRL_SUP_Ponderado";u1_CTRL_SUP_Ponderado)
	OT PutLong ($l_otPeriodo;"u2_CTRL_SUP_Control";u2_CTRL_SUP_Control)
	OT PutLong ($l_otPeriodo;"u3_CTRL_SUP_Presentacion";u3_CTRL_SUP_Presentacion)
	OT PutLong ($l_otPeriodo;"u4_CTRL_SUP_Especifico";u4_CTRL_SUP_Especifico)
	OT PutReal ($l_otPeriodo;"vr_CTRL_PonderacionConstante";vr_CTRL_PonderacionConstante)
	OT PutReal ($l_otPeriodo;"vr_CTRL_INF_Ponderacion";vr_CTRL_INF_Ponderacion)
	OT PutReal ($l_otPeriodo;"vr_CTRL_SUP_Ponderacion";vr_CTRL_SUP_Ponderacion)
	OT PutReal ($l_otPeriodo;"vr_CTRL_INF_Especifico";vr_CTRL_INF_Especifico)
	OT PutReal ($l_otPeriodo;"vr_CTRL_SUP_Especifico";vr_CTRL_SUP_Especifico)
	
	OT PutObject ($l_otRef;"EXP_ObjPeriodoComun";$l_otPeriodo)
	
	$x_blob:=OT ObjectToNewBLOB ($l_otRef)
	OT Clear ($l_otRef)
	OT Clear ($l_otPeriodo)
	
	[Asignaturas:18]OpcionesControles_y_Examenes:106:=$x_blob
	SAVE RECORD:C53([Asignaturas:18])
End if 


