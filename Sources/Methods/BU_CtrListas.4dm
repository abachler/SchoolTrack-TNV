//%attributes = {}
  //BU_CtrListas

  //EMA --> Transporte Escolar
  //27/10/2005
  //Método para llenar las listas de alumnos inscritos y no incritos en recorridos
  //Recibe 2 parámetros: Nombre del Curso, ID del Recorrido
  //Llena los siguientes array:
  //Area: xalp_Inscritos (alBU_ALID; atBU_ALNom; atBU_ALCurso; atBU_ALTipoServ;
  //                                       atBU_ALDesciende; atBU_ALAcompañado)
  //Area: xALP_Trans1(<>aStdWhNme; <>aStdld)

C_TEXT:C284($1)
C_LONGINT:C283($2;$IDRecorrido)

If (Count parameters:C259=2)
	$IDRecorrido:=$2
Else 
	$IDRecorrido:=0
End if 

If ($IDRecorrido#0)
	  //1.- Busca los alumnos inscritos en el recorrido y contruye arreglo de inscritos
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=$IDRecorrido;*)
	QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2#0)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ARRAY PICTURE:C279(ap_Acompañado;0)
	ARRAY TEXT:C222(at_observacion;0)
	SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Alumno:2;alBU_ALID;[Alumnos:2]apellidos_y_nombres:40;atBU_ALNom;[Alumnos:2]curso:20;atBU_ALCurso;[BU_Rutas_Inscripciones:35]Tipo_Servicio:6;atBU_ALTipoServ;[BU_Rutas_Inscripciones:35]solo_o_acompañado:5;atBU_ALDesciende;[BU_Rutas_Inscripciones:35]Acompañado_por:7;atBU_ALAcompañado;[BU_Rutas_Inscripciones:35]Observacion_Inscripcion:10;at_observacion)
	ARRAY PICTURE:C279(ap_Acompañado;Size of array:C274(alBU_ALID))
	For ($i;1;Size of array:C274(atBU_ALDesciende))
		If (atBU_ALDesciende{$i})
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";ap_Acompañado{$i})
		Else 
			GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";ap_Acompañado{$i})
		End if 
	End for 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	QRY_QueryWithArray (->[Alumnos:2]numero:1;->alBU_ALID)
	CREATE SET:C116([Alumnos:2];"ALinscritos")
	REDUCE SELECTION:C351([Alumnos:2];0)
	
	  //2.- Busca los alumnos del curso seleccionado
	READ ONLY:C145(*)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$1)
	CREATE SET:C116([Alumnos:2];"ALNoInscritos")
	REDUCE SELECTION:C351([Alumnos:2];0)
	
	  //3.- Reduce la selección a no inscritos
	DIFFERENCE:C122("ALNoInscritos";"ALinscritos";"ALNoInscritos")
	
	  //4.- Construye los arreglos de No inscritos
	USE SET:C118("ALNoInscritos")
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]numero:1;<>aStdID)
	SET_ClearSets ("ALinscritos";"ALNoInscritos")
End if 