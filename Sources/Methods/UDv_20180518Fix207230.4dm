//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 18-05-18, 10:30:03
  // ----------------------------------------------------
  // Método: UDv_20180518Fix207230
  // Descripción
  // Eliminación de registros nuevos de [Alumnos_EvaluacionAprendizajes] que se crearon mal debido al error 
  //que ocasioné en el trigger de esta misma tabla en la versiones anteriores a esta de 12.04
  // ----------------------------------------------------

C_LONGINT:C283($proc)
$proc:=IT_UThermometer (1;0;__ ("Eliminando Evaluaciones de Aprendizajes nuevos mal generados con nivel 0..."))
READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Año:77=<>GYEAR;*)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Nivel_Numero:91=0)
DELETE SELECTION:C66([Alumnos_EvaluacionAprendizajes:203])
KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
IT_UThermometer (-2;$proc)