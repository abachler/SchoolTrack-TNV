  // [Asignaturas].Configuracion_Examenes.EXP_ConfiguracionPorPeriodo()
  // 
  //
  // creado por: Alberto Bachler Klein: 23-05-16, 11:35:31
  // -----------------------------------------------------------



$l_ConfigurarPorPeriodos:=(OBJECT Get pointer:C1124(Object named:K67:5;"EXP_ConfiguracionPorPeriodo"))->
$y_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"EXP_tabPeriodos")

If ($l_ConfigurarPorPeriodos=1)
	$l_periodoActual:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
	SELECT LIST ITEMS BY REFERENCE:C630($y_lista->;$l_periodoActual)
Else 
	$l_periodoActual:=0
End if 
AS_Examenes_LeeConfigPeriodo ($l_periodoActual)
