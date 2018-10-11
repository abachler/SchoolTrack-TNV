  // [Alumnos_ComplementoEvaluacion].Observaciones.eliminaObservacion()
  //
  //
  // creado por: Alberto Bachler Klein: 28-12-15, 13:59:38
  // -----------------------------------------------------------
C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_asignadas_Categoria;$y_asignadas_observacion;$y_asignadas_recNum)

$y_asignadas_Categoria:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_categoria")
$y_asignadas_observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_observacion")
$y_asignadas_recNum:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_recnum")
$l_recNum:=$y_asignadas_recNum->{$y_asignadas_recNum->}

KRL_GotoRecord (->[Alumnos_ObservacionesEvaluacion:30];$l_recNum;True:C214)
KRL_DeleteRecord (->[Alumnos_ObservacionesEvaluacion:30];$l_recNum)
AT_Delete ($y_asignadas_Categoria->;1;$y_asignadas_Categoria;$y_asignadas_observacion;$y_asignadas_recNum)


