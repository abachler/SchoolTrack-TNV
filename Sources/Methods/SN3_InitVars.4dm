//%attributes = {}
  // Método: SN3_InitVars
  // 
  // 
  // por Roberto Catalan
  // creación 20170216, 17:36:45
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
  // Modificado por: Alberto Bachler Klein (27/4/17)
  // Eliminacion de variable interproceso para determinar si el arreglo fue declarado o no, se usa la función 4D Undefined



If (Undefined:C82(<>at_serviciosSN3Notificados))
	ARRAY TEXT:C222(<>at_serviciosSN3Notificados;0)
End if 