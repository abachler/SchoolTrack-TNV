//%attributes = {}
  //dbuAS_InicializaEsfuerzo

MESSAGES OFF:C175
READ WRITE:C146([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
$Process:=IT_UThermometer (1;0;__ ("Inicializando característica de evaluación de esfuerzo en asignaturas..."))
APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Ingresa_Esfuerzo:40:=False:C215)
IT_UThermometer (-2;$Process)
MESSAGES ON:C181
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])