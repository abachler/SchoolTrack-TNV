Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY LONGINT:C221($al_recnumAsig;0)
		ARRAY LONGINT:C221($al_recnumAsigHist;0)
		DBU_AsignaUUIDdeMateria (True:C214;->$al_recnumAsig;->$al_recnumAsigHist)
		
		  //subsectores
		ARRAY TEXT:C222(at_subsectoresUUID;0)
		ARRAY TEXT:C222(at_subsectores;0)
		READ ONLY:C145([xxSTR_Materias:20])
		ALL RECORDS:C47([xxSTR_Materias:20])
		ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;>)
		SELECTION TO ARRAY:C260([xxSTR_Materias:20]Area:12;at_subsectores;[xxSTR_Materias:20]Auto_UUID:21;at_subsectoresUUID)
		OBJECT SET VISIBLE:C603(at_subsectoresUUID;False:C215)
		
		  //asignaturas  
		READ ONLY:C145([Asignaturas:18])
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$al_recnumAsig;"")
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Asignatura:3;>;[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>)
		ARRAY TEXT:C222(at_asignaturas;0)
		ARRAY TEXT:C222(at_curso;0)
		ARRAY TEXT:C222(at_nivel;0)
		ARRAY TEXT:C222(at_asigUUID;0)
		
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;at_asignaturas;[Asignaturas:18]Curso:5;at_curso;[Asignaturas:18]Nivel:30;at_nivel;[Asignaturas:18]auto_uuid:12;at_asigUUID)
		OBJECT SET VISIBLE:C603(at_asigUUID;False:C215)
		
		OBJECT SET TITLE:C194(lb_Asig_T1;__ ("Nombre Oficial"))
		OBJECT SET TITLE:C194(lb_Asig_T2;__ ("Curso"))
		OBJECT SET TITLE:C194(lb_Asig_T3;__ ("Nivel"))
		
		
		  //asignaturas historicas
		
		ARRAY TEXT:C222(at_asignaturasHist;0)
		ARRAY TEXT:C222(at_cursoHist;0)
		ARRAY TEXT:C222(at_nivelHist;0)
		ARRAY TEXT:C222(at_asigHistUUID;0)
		ARRAY INTEGER:C220(al_añoHist;0)
		
		READ ONLY:C145([Asignaturas_Historico:84])
		CREATE SELECTION FROM ARRAY:C640([Asignaturas_Historico:84];$al_recnumAsigHist;"")
		ORDER BY:C49([Asignaturas_Historico:84];[Asignaturas_Historico:84]Asignatura:2;>;[Asignaturas_Historico:84]Año:5;>;[Asignaturas_Historico:84]Nivel:4;>;[Asignaturas_Historico:84]Curso:14;>)
		SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Asignatura:2;at_asignaturasHist;*)
		SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Año:5;al_añoHist;*)
		SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Nivel_Nombre:41;at_nivelHist;*)
		SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Curso:14;at_cursoHist;*)
		SELECTION TO ARRAY:C260([Asignaturas_Historico:84]Auto_UUID:44;at_asigHistUUID;*)
		SELECTION TO ARRAY:C260
		
		OBJECT SET VISIBLE:C603(at_asigHistUUID;False:C215)
		OBJECT SET TITLE:C194(lb_AsigH_T1;__ ("Denominación Oficial"))
		OBJECT SET TITLE:C194(lb_AsigH_T2;__ ("Curso"))
		OBJECT SET TITLE:C194(lb_AsigH_T3;__ ("Nivel"))
		OBJECT SET TITLE:C194(lb_AsigH_T4;__ ("Año"))
		
End case 