  // [xShell_BatchRequests].TareasProgramadas.actualizar()
  // Por: Alberto Bachler K.: 14-12-13, 15:50:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
READ ONLY:C145([xShell_BatchRequests:48])  //20140404 RCH Al abrir la ventana quedaba una tarea tomada por el proceso.
ALL RECORDS:C47([xShell_BatchRequests:48])
ORDER BY:C49([xShell_BatchRequests:48];[xShell_BatchRequests:48]DTS:10;>)
If (Records in set:C195("tareasSeleccionadas")=0)
	OBJECT SET TITLE:C194(*;"textoCola";__ ("Tareas en cola: ")+String:C10(Records in selection:C76([xShell_BatchRequests:48])))
Else 
	OBJECT SET TITLE:C194(*;"textoCola";String:C10(Records in set:C195("tareasSeleccionadas"))+__ (" sobre ")+String:C10(Records in selection:C76([xShell_BatchRequests:48]))+__ (" tareas en cola:"))
End if 
