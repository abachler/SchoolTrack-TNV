//%attributes = {}
  // EV2_Examenes_LeeConfigExamenes()
  //
  //
  // creado por: Alberto Bachler Klein: 26-05-16, 12:28:35
  // -----------------------------------------------------------

  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_LONGINT:C283($1)

C_OBJECT:C1216($o_controlesYexamenes;$o_periodo)
C_LONGINT:C283($l_ConfigurarPorPeriodos;$l_periodo;$l_refObjetoPeriodo;$l_refObjetoRaiz)

If (False:C215)
	C_LONGINT:C283(EV2_Examenes_LeeConfigExamenes ;$1)
End if 

If (Count parameters:C259=1)
	$l_periodo:=$1
Else 
	$l_periodo:=-1
End if 

AS_Examenes_Inicializa 

$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)

  // examen anual ordinario
vi_UsarExamenes:=OB Get:C1224($o_controlesYexamenes;"vi_UsarExamenes")
vi_EX_Reprobacion:=OB Get:C1224($o_controlesYexamenes;"vi_EX_Reprobacion")
e1_PonderacionConstante:=OB Get:C1224($o_controlesYexamenes;"e1_PonderacionConstante")
e2_PonderacionVariable:=OB Get:C1224($o_controlesYexamenes;"e2_PonderacionVariable")
f1_EX_INF_Ponderado:=OB Get:C1224($o_controlesYexamenes;"f1_EX_INF_Ponderado")
f2_EX_INF_Control:=OB Get:C1224($o_controlesYexamenes;"f2_EX_INF_Control")
f3_EX_INF_Presentacion:=OB Get:C1224($o_controlesYexamenes;"f3_EX_INF_Presentacion")
f4_EX_INF_Especifico:=OB Get:C1224($o_controlesYexamenes;"f4_EX_INF_Especifico")
g1_EX_SUP_Ponderado:=OB Get:C1224($o_controlesYexamenes;"g1_EX_SUP_Ponderado")
g2_EX_SUP_Control:=OB Get:C1224($o_controlesYexamenes;"g2_EX_SUP_Control")
g3_EX_SUP_Presentacion:=OB Get:C1224($o_controlesYexamenes;"g3_EX_SUP_Presentacion")
g4_EX_SUP_Especifico:=OB Get:C1224($o_controlesYexamenes;"g4_EX_SUP_Especifico")
vr_EX_PonderacionConstante:=OB Get:C1224($o_controlesYexamenes;"vr_EX_PonderacionConstante")
vr_EX_INF_Ponderacion:=OB Get:C1224($o_controlesYexamenes;"vr_EX_INF_Ponderacion")
vr_EX_SUP_Ponderacion:=OB Get:C1224($o_controlesYexamenes;"vr_EX_SUP_Ponderacion")
vr_EX_INF_Especifico:=OB Get:C1224($o_controlesYexamenes;"vr_EX_INF_Especifico")
vr_EX_SUP_Especifico:=OB Get:C1224($o_controlesYexamenes;"vr_EX_SUP_Especifico")
e3_ResultadoFijo:=OB Get:C1224($o_controlesYexamenes;"e3_ResultadoFijo")
vr_CalificacionEX:=OB Get:C1224($o_controlesYexamenes;"vr_CalificacionEX")
a1_NF_igualEX_SUP:=OB Get:C1224($o_controlesYexamenes;"a1_NF_igualEX_SUP")
a2_NF_igualValorFijoSUP:=OB Get:C1224($o_controlesYexamenes;"a2_NF_igualValorFijoSUP")
vr_NF_igual_EX_SUP:=OB Get:C1224($o_controlesYexamenes;"vr_NF_igual_EX_SUP")
c1_NF_igualEX_INF:=OB Get:C1224($o_controlesYexamenes;"c1_NF_igualEX_INF")
c2_NF_igualValorFijoINF:=OB Get:C1224($o_controlesYexamenes;"c2_NF_igualValorFijoINF")
vr_NF_igual_EX_INF:=OB Get:C1224($o_controlesYexamenes;"vr_NF_igual_EX_INF")
vi_CorreccionNFEX:=OB Get:C1224($o_controlesYexamenes;"vi_CorreccionNFEX")
vr_CorreccionNFEX_minimo:=OB Get:C1224($o_controlesYexamenes;"vr_CorreccionNFEX_minimo")
vr_CorreccionNFEX_resultado:=OB Get:C1224($o_controlesYexamenes;"vr_CorreccionNFEX_resultado")


  // examen anual extraordinario
vi_UsarExamenExtra:=OB Get:C1224($o_controlesYexamenes;"vi_UsarExamenExtra";Is longint:K8:6)
vi_EXX_Reprobacion:=OB Get:C1224($o_controlesYexamenes;"vi_EXX_Reprobacion";Is longint:K8:6)
x1_PonderacionConstante:=OB Get:C1224($o_controlesYexamenes;"x1_PonderacionConstante")
x2_PonderacionVariable:=OB Get:C1224($o_controlesYexamenes;"x2_PonderacionVariable")
y1_EXX_INF_Ponderado:=OB Get:C1224($o_controlesYexamenes;"y1_EXX_INF_Ponderado")
y2_EXX_INF_Control:=OB Get:C1224($o_controlesYexamenes;"y2_EXX_INF_Control")
y3_EXX_INF_Presentacion:=OB Get:C1224($o_controlesYexamenes;"y3_EXX_INF_Presentacion")
y4_EXX_INF_Especifico:=OB Get:C1224($o_controlesYexamenes;"y4_EXX_INF_Especifico")
z1_EXX_SUP_Ponderado:=OB Get:C1224($o_controlesYexamenes;"z1_EXX_SUP_Ponderado")
z2_EXX_SUP_Control:=OB Get:C1224($o_controlesYexamenes;"z2_EXX_SUP_Control")
z3_EXX_SUP_Presentacion:=OB Get:C1224($o_controlesYexamenes;"z3_EXX_SUP_Presentacion")
z4_EXX_SUP_Especifico:=OB Get:C1224($o_controlesYexamenes;"z4_EXX_SUP_Especifico")
vr_EXX_PonderacionConstante:=OB Get:C1224($o_controlesYexamenes;"vr_EXX_PonderacionConstante")
vr_EXX_INF_Ponderacion:=OB Get:C1224($o_controlesYexamenes;"vr_EXX_INF_Ponderacion")
vr_EXX_SUP_Ponderacion:=OB Get:C1224($o_controlesYexamenes;"vr_EXX_SUP_Ponderacion")
vr_EXX_INF_Especifico:=OB Get:C1224($o_controlesYexamenes;"vr_EXX_INF_Especifico")
vr_EXX_SUP_Especifico:=OB Get:C1224($o_controlesYexamenes;"vr_EXX_SUP_Especifico")
x3_ResultadoFijo:=OB Get:C1224($o_controlesYexamenes;"x3_ResultadoFijo")
vr_CalificacionEXX:=OB Get:C1224($o_controlesYexamenes;"vr_CalificacionEXX")
m1_NF_igualEXX_SUP:=OB Get:C1224($o_controlesYexamenes;"m1_NF_igualEXX_SUP")
m2_NF_igualValorFijoSUP:=OB Get:C1224($o_controlesYexamenes;"m2_NF_igualValorFijoSUP")
vr_NF_igual_EXX_SUP:=OB Get:C1224($o_controlesYexamenes;"vr_NF_igual_EXX_SUP")
n1_NF_igualEXX_INF:=OB Get:C1224($o_controlesYexamenes;"n1_NF_igualEXX_INF")
n2_NF_igualValorFijoINF:=OB Get:C1224($o_controlesYexamenes;"n2_NF_igualValorFijoINF")
vr_NF_igual_EXX_INF:=OB Get:C1224($o_controlesYexamenes;"vr_NF_igual_EXX_INF")
vi_CorreccionNFEXX:=OB Get:C1224($o_controlesYexamenes;"vi_CorreccionNFEXX";Is real:K8:4)
vr_CorreccionNFEXX_minimo:=OB Get:C1224($o_controlesYexamenes;"vr_CorreccionNFEXX_minimo";Is real:K8:4)
vr_CorreccionNFEXX_resultado:=OB Get:C1224($o_controlesYexamenes;"vr_CorreccionNFEXX_resultado";Is real:K8:4)

  // uso de examen recuperatorio
vi_UsarEXRecuperatorio:=OB Get:C1224($o_controlesYexamenes;"vi_UsarEXRecuperatorio";Is real:K8:4)
vr_MinimoExRecuperatorio:=OB Get:C1224($o_controlesYexamenes;"vr_MinimoExRecuperatorio";Is real:K8:4)

vi_CorreccionNFEXX:=OB Get:C1224($o_controlesYexamenes;"vi_CorreccionNFEXX";Is real:K8:4)
vi_UsarControlesFinPeriodo:=OB Get:C1224($o_controlesYexamenes;"vi_UsarControlesFinPeriodo";Is longint:K8:6)

vi_UsarBonificacion:=OB Get:C1224($o_controlesYexamenes;"vi_UsarBonificacion";Is longint:K8:6)
vr_BonificacionPeriodo:=OB Get:C1224($o_controlesYexamenes;"bonificacionP"+String:C10($l_periodo);Is real:K8:4)

vi_bonificarAntesControl:=OB Get:C1224($o_controlesYexamenes;"bonificacion_AntesControl";Is longint:K8:6)

  //MONO ticket 187011
If ((x1_PonderacionConstante=0) & (x2_PonderacionVariable=0) & (x3_ResultadoFijo=0))
	x1_PonderacionConstante:=1
End if 
If ((e1_PonderacionConstante=0) & (e2_PonderacionVariable=0) & (e3_ResultadoFijo=0))
	e1_PonderacionConstante:=1
End if 
If (vi_usarExamenes=0)
	vi_UsarExamenExtra:=0
End if 


If (((vi_UsarBonificacion=1) | (vi_UsarControlesFinPeriodo=1)) & ($l_periodo>=0))
	
	If (Not:C34(OB Is defined:C1231($o_controlesYexamenes)) | (OB Is empty:C1297($o_controlesYexamenes)))
		$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
	End if 
	
	$l_ConfigurarPorPeriodos:=OB Get:C1224($o_controlesYexamenes;"EXP_ConfiguracionPorPeriodo")
	vl_ConfigExamenes_ultimoPeriodo:=Choose:C955($l_ConfigurarPorPeriodos=0;0;$l_periodo)
	
	If (($l_ConfigurarPorPeriodos=1) & ($l_periodo>0))
		$o_periodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodo"+String:C10($l_periodo);Is object:K8:27)
	Else 
		$o_periodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun";Is object:K8:27)
	End if 
	
	c1_PonderacionConstante:=OB Get:C1224($o_periodo;"c1_PonderacionConstante")
	c2_PonderacionVariable:=OB Get:C1224($o_periodo;"c2_PonderacionVariable")
	t1_CTRL_INF_Ponderado:=OB Get:C1224($o_periodo;"t1_CTRL_INF_Ponderado")
	t2_CTRL_INF_Control:=OB Get:C1224($o_periodo;"t2_CTRL_INF_Control")
	t3_CTRL_INF_Presentacion:=OB Get:C1224($o_periodo;"t3_CTRL_INF_Presentacion")
	t4_CTRL_INF_Especifico:=OB Get:C1224($o_periodo;"t4_CTRL_INF_Especifico")
	u1_CTRL_SUP_Ponderado:=OB Get:C1224($o_periodo;"u1_CTRL_SUP_Ponderado")
	u2_CTRL_SUP_Control:=OB Get:C1224($o_periodo;"u2_CTRL_SUP_Control")
	u3_CTRL_SUP_Presentacion:=OB Get:C1224($o_periodo;"u3_CTRL_SUP_Presentacion")
	u4_CTRL_SUP_Especifico:=OB Get:C1224($o_periodo;"u4_CTRL_SUP_Especifico")
	vr_CTRL_PonderacionConstante:=OB Get:C1224($o_periodo;"vr_CTRL_PonderacionConstante")
	vr_CTRL_INF_Ponderacion:=OB Get:C1224($o_periodo;"vr_CTRL_INF_Ponderacion")
	vr_CTRL_SUP_Ponderacion:=OB Get:C1224($o_periodo;"vr_CTRL_SUP_Ponderacion")
	vr_CTRL_INF_Especifico:=OB Get:C1224($o_periodo;"vr_CTRL_INF_Especifico")
	vr_CTRL_SUP_Especifico:=OB Get:C1224($o_periodo;"vr_CTRL_SUP_Especifico")
	vi_bonificarAntesControl:=OB Get:C1224($o_controlesYexamenes;"bonificacion_AntesControl";Is longint:K8:6)
	
	vl_ConfigExamenes_ultimoPeriodo:=$l_periodo
	  //MONO ticket 187011
	If ((c1_PonderacionConstante=0) & (c2_PonderacionVariable=0))
		c1_PonderacionConstante:=1
	End if 
	
End if 
