//%attributes = {}
  // AS_Examenes_GuardaConfigPeriodo()
  //
  //
  // creado por: Alberto Bachler Klein: 28-05-16, 12:29:17
  // -----------------------------------------------------------

  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_LONGINT:C283($1)

C_LONGINT:C283($l_ConfigurarPorPeriodos;$l_objetoPeriodo;$l_periodo)
C_POINTER:C301($y_refObjetoPeriodo;$y_refObjetoRaiz)
C_OBJECT:C1216($o_objetoPeriodo;$o_controlesYexamenes)

If (False:C215)
	C_LONGINT:C283(AS_Examenes_GuardaConfigPeriodo ;$1)
End if 

If (Count parameters:C259=1)
	$l_periodo:=$1
End if 

$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)


If ($l_periodo=0)
	$o_objetoPeriodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun";Is object:K8:27)
Else 
	$l_ConfigurarPorPeriodos:=(OBJECT Get pointer:C1124(Object named:K67:5;"EXP_ConfiguracionPorPeriodo"))->
	If ($l_ConfigurarPorPeriodos=1)
		If ($l_periodo>0)
			$o_objetoPeriodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodo"+String:C10($l_periodo);Is object:K8:27)
		Else 
			$o_objetoPeriodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun";Is object:K8:27)
		End if 
	Else 
		$o_objetoPeriodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun";Is object:K8:27)
	End if 
End if 


OB SET:C1220($o_objetoPeriodo;"c1_PonderacionConstante";c1_PonderacionConstante)
OB SET:C1220($o_objetoPeriodo;"c2_PonderacionVariable";c2_PonderacionVariable)
OB SET:C1220($o_objetoPeriodo;"t1_CTRL_INF_Ponderado";t1_CTRL_INF_Ponderado)
OB SET:C1220($o_objetoPeriodo;"t2_CTRL_INF_Control";t2_CTRL_INF_Control)
OB SET:C1220($o_objetoPeriodo;"t3_CTRL_INF_Presentacion";t3_CTRL_INF_Presentacion)
OB SET:C1220($o_objetoPeriodo;"t4_CTRL_INF_Especifico";t4_CTRL_INF_Especifico)
OB SET:C1220($o_objetoPeriodo;"u1_CTRL_SUP_Ponderado";u1_CTRL_SUP_Ponderado)
OB SET:C1220($o_objetoPeriodo;"u2_CTRL_SUP_Control";u2_CTRL_SUP_Control)
OB SET:C1220($o_objetoPeriodo;"u3_CTRL_SUP_Presentacion";u3_CTRL_SUP_Presentacion)
OB SET:C1220($o_objetoPeriodo;"u4_CTRL_SUP_Especifico";u4_CTRL_SUP_Especifico)
OB SET:C1220($o_objetoPeriodo;"vr_CTRL_PonderacionConstante";vr_CTRL_PonderacionConstante)
OB SET:C1220($o_objetoPeriodo;"vr_CTRL_INF_Ponderacion";vr_CTRL_INF_Ponderacion)
OB SET:C1220($o_objetoPeriodo;"vr_CTRL_SUP_Ponderacion";vr_CTRL_SUP_Ponderacion)
OB SET:C1220($o_objetoPeriodo;"vr_CTRL_INF_Especifico";vr_CTRL_INF_Especifico)
OB SET:C1220($o_objetoPeriodo;"vr_CTRL_SUP_Especifico";vr_CTRL_SUP_Especifico)



