//%attributes = {}
  // XCR_ContabilizaInscritos()
  // Por: Alberto Bachler K.: 02-06-14, 19:32:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_proceso)

ARRAY LONGINT:C221($aRNActividades;0)
If (False:C215)
	C_LONGINT:C283(XCR_ContabilizaInscritos ;$1)
End if 

READ WRITE:C146([Actividades:29])
If (Count parameters:C259=1)
	QUERY:C277([Actividades:29];[Actividades:29]ID:1=$1)
Else 
	ALL RECORDS:C47([Actividades:29])
End if 
LONGINT ARRAY FROM SELECTION:C647([Actividades:29];$aRNActividades;"")

If (Count parameters:C259=0)
	$l_proceso:=IT_Progress (1;0;0;__ ("Contabilizando alumnos inscritos en actividades extracurriculares..."))
End if 
For ($i;1;Size of array:C274($aRNActividades))
	KRL_GotoRecord (->[Actividades:29];$aRNActividades{$i};True:C214)
	READ ONLY:C145([Alumnos_Actividades:28])
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
	QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Año:3=<>gYear)
	CREATE SET:C116([Alumnos_Actividades:28];"Todos")
	[Actividades:29]NumeroAlumnosInscritos:14:=Records in selection:C76([Alumnos_Actividades:28])
	
	USE SET:C118("Todos")
	QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 1)))
	[Actividades:29]Inscritos_P1:15:=Records in selection:C76([Alumnos_Actividades:28])
	
	USE SET:C118("Todos")
	QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 2)))
	[Actividades:29]Inscritos_P2:16:=Records in selection:C76([Alumnos_Actividades:28])
	
	USE SET:C118("Todos")
	QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 3)))
	[Actividades:29]Inscritos_P3:17:=Records in selection:C76([Alumnos_Actividades:28])
	
	USE SET:C118("Todos")
	QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 4)))
	[Actividades:29]Inscritos_P4:18:=Records in selection:C76([Alumnos_Actividades:28])
	
	USE SET:C118("Todos")
	QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 5)))
	[Actividades:29]Inscritos_P5:19:=Records in selection:C76([Alumnos_Actividades:28])
	
	SAVE RECORD:C53([Actividades:29])
	If ($l_proceso#0)
		$l_proceso:=IT_Progress (0;$l_proceso;$i/Size of array:C274($aRNActividades))
	End if 
	CLEAR SET:C117("Todos")
End for 
If ($l_proceso#0)
	$l_proceso:=IT_Progress (-1;$l_proceso)
End if 

KRL_ReloadAsReadOnly (->[Actividades:29])
KRL_UnloadReadOnly (->[Alumnos_Actividades:28])