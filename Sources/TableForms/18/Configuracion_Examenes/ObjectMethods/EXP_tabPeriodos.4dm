  // [Asignaturas].Configuracion_Examenes.EXP_tabPeriodos()
  //
  //
  // creado por: Alberto Bachler Klein: 16-05-16, 16:34:10
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_objetoPeriodo;$l_periodo;$l_periodoSeleccionado;$l_tipoItem;$l_tipoObjetoForm)
C_POINTER:C301($y_objeto;$y_periodoSeleccionado;$y_refObjetoPeriodo)
C_TEXT:C284($t_nombrePeriodo)

GET LIST ITEM:C378(*;"EXP_tabPeriodos";*;$l_periodo;$t_nombrePeriodo)
AS_Examenes_LeeConfigPeriodo ($l_periodo)

