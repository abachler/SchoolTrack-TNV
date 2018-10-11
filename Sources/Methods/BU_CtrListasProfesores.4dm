//%attributes = {}
  //BU_CtrListasProfesores

  //EMA --> Transporte Escolar
  //28/10/2005
  //Método para llenar las listas de profesores inscritos y no incritos en recorridos
  //Recibe 1 parámetro: ID del Recorrido
  //Llena los siguientes array:
  //xalp_BUFunc(alBU_PFID; atBU_PFNom; atBU_PFCargo)
  //xalp_BUListaFunc(alBU_PFIdGen; atBU_PFNomGen;
  //                                      atBU_PFCargoGen)


C_LONGINT:C283($1;$IDRecorrido)
$IDRecorrido:=$1

If ($IDRecorrido#0)
	  //1.- Busca los profesores inscritos en el recorrido y contruye arreglo de inscritos
	ARRAY TEXT:C222(at_observacion;0)
	
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=$IDRecorrido;*)
	QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Profesor:3#0)
	KRL_RelateSelection (->[Profesores:4]Numero:1;->[BU_Rutas_Inscripciones:35]Numero_Profesor:3;"")
	SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Profesor:3;alBU_PFID;[Profesores:4]Apellidos_y_nombres:28;atBU_PFNom;[Profesores:4]Cargo:19;atBU_PFCargo;[BU_Rutas_Inscripciones:35]Observacion_Inscripcion:10;at_observacion)
	QRY_QueryWithArray (->[Profesores:4]Numero:1;->alBU_PFID)
	CREATE SET:C116([Profesores:4];"PFinscritos")
	REDUCE SELECTION:C351([Profesores:4];0)
	
	  //2.- Busca los profesores activos
	READ ONLY:C145([Profesores:4])
	ALL RECORDS:C47([Profesores:4])
	  //QUERY([Profesores];[Profesores]Inactivo=False)
	CREATE SET:C116([Profesores:4];"PFNoInscritos")
	  //REDUCE SELECTION([Profesores];0)
	
	  //3.- Reduce la selección a no inscritos
	DIFFERENCE:C122("PFNoInscritos";"PFinscritos";"PFNoInscritos")
	
	  //4.- Construye los arreglos de No inscritos
	USE SET:C118("PFNoInscritos")
	SELECTION TO ARRAY:C260([Profesores:4]Numero:1;alBU_PFIdGen;[Profesores:4]Apellidos_y_nombres:28;atBU_PFNomGen;[Profesores:4]Cargo:19;atBU_PFCargoGen)
	SET_ClearSets ("PFinscritos";"PFNoInscritos")
	
End if 