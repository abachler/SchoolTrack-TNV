  // GeneracionAplicacion.executeTasks()
  // 
  //
  // creado por: Alberto Bachler Klein: 18-08-16, 15:45:48
  // -----------------------------------------------------------



GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
OBJECT GET COORDINATES:C663(*;"tareas_listBox";$l_ignorar;$l_ignorar;$l_ignorar;$l_abajoObjeto)
SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_abajoObjeto)

BUILD_GetTasksList 
BUILD_ExecuteTask 



