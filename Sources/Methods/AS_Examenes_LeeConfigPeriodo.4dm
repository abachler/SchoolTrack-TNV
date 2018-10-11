//%attributes = {}
  // AS_Examenes_LeeConfigPeriodo()
  //
  //
  // creado por: Alberto Bachler Klein: 23-05-16, 14:53:13
  // -----------------------------------------------------------

  //  20181003 ASM Ticket 194524 Cambio general en el método por paso de opciones a objetos

C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_ConfigurarPorPeriodos;$l_objetoPeriodo;$l_periodo;$l_periodoSeleccionado;$l_refObjetoPeriodoComun;$l_refObjetoRaiz;$l_tipoItem;$l_tipoObjetoForm)
C_POINTER:C301($y_objeto;$y_periodoSeleccionado;$y_refObjetoPeriodo)
C_TEXT:C284($t_nombrePeriodo)

ARRAY LONGINT:C221($al_tipoItems;0)
ARRAY TEXT:C222($at_NombreItems;0)

C_OBJECT:C1216($o_controlesYexamenes;$o_refObjetoPeriodoComun;$o_periodo)


If (False:C215)
	C_LONGINT:C283(AS_Examenes_LeeConfigPeriodo ;$1)
End if 

If (Count parameters:C259=1)
	$l_periodo:=$1
Else 
	$l_periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
End if 

$o_controlesYexamenes:=OB Get:C1224([Asignaturas:18]Opciones:57;"controles_y_examenes";Is object:K8:27)
$l_ConfigurarPorPeriodos:=(OBJECT Get pointer:C1124(Object named:K67:5;"EXP_ConfiguracionPorPeriodo"))->
$o_refObjetoPeriodoComun:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun")

  // guardo la configuración del periodo actual antes de leer la configuración de la nueva seleccion
$y_periodoSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"periodoSeleccionado")
$l_periodoSeleccionado:=$y_periodoSeleccionado->
If (($l_periodoSeleccionado>0) & ($l_periodoSeleccionado#$l_periodo))
	AS_Examenes_GuardaConfigPeriodo ($l_periodoSeleccionado)
End if 

If (vi_UsarControlesFinPeriodo=1)  //ASM Ticket 216614
	If ($l_ConfigurarPorPeriodos>0)
		$o_periodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodo"+String:C10($l_periodo);Is object:K8:27)
		
		If (Not:C34(OB Is defined:C1231($o_periodo)))
			$o_periodo:=OB Get:C1224($o_controlesYexamenes;"EXP_ObjPeriodoComun";Is object:K8:27)
			OB SET:C1220($o_controlesYexamenes;"EXP_ObjPeriodo"+String:C10($l_periodo);$o_periodo)
		End if 
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
	$y_periodoSeleccionado->:=$l_periodo  // actualizo la seleccion de periodo en la variable dinamica
End if 
