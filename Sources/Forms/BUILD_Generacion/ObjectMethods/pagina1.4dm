  // GeneracionAplicacion.pagina1()
  // 
  //
  // creado por: Alberto Bachler Klein: 19-08-16, 10:40:28
  // -----------------------------------------------------------

GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
OBJECT GET COORDINATES:C663(*;"tareas_listBox";$l_ignorar;$l_ignorar;$l_ignorar;$l_abajoObjeto)
SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_abajoObjeto)

BUILD_GetTasksList 

FORM GOTO PAGE:C247(1)