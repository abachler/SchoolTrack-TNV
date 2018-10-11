//%attributes = {}
  // PF_HorasAsignadasEnHorario{(recnum:L; incluirProfesorFirmante:B)
  //  ---------------------------------------------
  // Busca las asignaciones de horario para el profesor actual(registro en memoria)
  // o para el profesor cuyo recnum puede pasarse opcionalmente en argumento
  // Si se pasa el parámetro incluirProfesorFirmante se consideran tambien asignaciones de horario de las asignaturas 
  // en las cuales el profesor es profesor firmante
  //  ---------------------------------------------
  // Por: Alberto Bachler: 18/03/13, 15:35:44

C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_incluirProfesorFirmante)
C_LONGINT:C283($l_idProfesor;$l_recNumProfesor)

If (False:C215)
	C_LONGINT:C283(PF_HorasAsignadasEnHorario ;$0)
	C_LONGINT:C283(PF_HorasAsignadasEnHorario ;$1)
	C_BOOLEAN:C305(PF_HorasAsignadasEnHorario ;$2)
End if 

Case of 
	: (Count parameters:C259=2)
		$l_recNumProfesor:=$1
		$b_incluirProfesorFirmante:=$2
	: (Count parameters:C259=1)
		$l_recNumProfesor:=$1
End case 

If (Count parameters:C259>=1)
	If ($l_recNumProfesor#Record number:C243([Profesores:4]))
		KRL_GotoRecord (->[Profesores:4];$l_recNumProfesor)
	End if 
End if 

$l_idProfesor:=[Profesores:4]Numero:1


READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([TMT_Horario:166])
SET FIELD RELATION:C919([TMT_Horario:166]ID_Asignatura:5;Automatic:K51:4;Do not modify:K51:1)
QUERY:C277([TMT_Horario:166];[Asignaturas:18]profesor_numero:4;=;$l_idProfesor;*)
If ($b_incluirProfesorFirmante)
	QUERY:C277([TMT_Horario:166]; | ;[Asignaturas:18]profesor_numero:4;=;$l_idProfesor;*)
End if 
QUERY:C277([TMT_Horario:166])
SET FIELD RELATION:C919([TMT_Horario:166]ID_Asignatura:5;Structure configuration:K51:2;Structure configuration:K51:2)

$0:=Records in selection:C76([TMT_Horario:166])

