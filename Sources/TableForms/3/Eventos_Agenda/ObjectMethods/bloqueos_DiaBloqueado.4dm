  // [Cursos].Eventos_Agenda.bloqueos_DiaBloqueado()
  // 
  //
  // creado por: Alberto Bachler Klein: 05-08-16, 11:21:20
  // -----------------------------------------------------------

OBJECT SET ENTERABLE:C238(*;"bloqueos_MotivoDia";(OBJECT Get pointer:C1124(Object current:K67:2))->=1)
If ((OBJECT Get pointer:C1124(Object current:K67:2))->=1)
	GOTO OBJECT:C206(*;"bloqueos_MotivoDia")
	LISTBOX DELETE ROWS:C914(*;"LB_bloqueos";1;LISTBOX Get number of rows:C915(*;"LB_bloqueos"))
Else 
	(OBJECT Get pointer:C1124(Object named:K67:5;"bloqueos_MotivoDia"))->:=""
End if 


