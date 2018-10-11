Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY BOOLEAN:C223(ab_asigSelected;0)
		ARRAY TEXT:C222(at_nomAsig;0)
		ARRAY TEXT:C222(at_nomEstilo;0)
		ARRAY TEXT:C222(at_Estilo;0)
		ARRAY TEXT:C222(at_curso;0)
		C_LONGINT:C283($proc)
		$proc:=IT_UThermometer (1;0;__ ("Recopilando Información..."))
		ARRAY LONGINT:C221(al_numAsignatura;0)
		ARRAY LONGINT:C221(al_numEstilo;0)
		ARRAY LONGINT:C221(al_numEstiloEvaluacion;0)
		
		AS_SinEstiloDeEvaluacion ("AsignaturasSinEstilo")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]Asignatura:3;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;al_numAsignatura;[Asignaturas:18]Asignatura:3;at_nomAsig;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;al_numEstilo;[Asignaturas:18]Curso:5;at_curso)
		ARRAY TEXT:C222(at_nomEstilo;Size of array:C274(al_numEstilo))
		
		ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
		SELECTION TO ARRAY:C260([xxSTR_EstilosEvaluacion:44]ID:1;al_numEstiloEvaluacion;[xxSTR_EstilosEvaluacion:44]Name:2;at_Estilo)
		IT_UThermometer (-2;$proc)
		
End case 