//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): jbelmar
  // Date and time: 04-06-10, 12:20:34
  // ----------------------------------------------------
  // Method: ADT_HermanosEnColegio
  // Description: Buscar los hermanos de un candidato
  // 
  //
  // Parameters
  // ----------------------------------------------------
xALPSet_ADT_HermanosColegio 
C_LONGINT:C283($1;$idFamilia;$rec;$idAlumno)
ARRAY LONGINT:C221($idHermanos;0)
ARRAY LONGINT:C221($idPadres;0)
ARRAY LONGINT:C221($numeroFamilia;0)
ARRAY LONGINT:C221($idTemp;0)



Case of 
	: ($1=1)  //`alumnos que pertenecen a la misma familia
		
		READ ONLY:C145([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		$idAlumno:=[Alumnos:2]numero:1
		SAVE RECORD:C53([Alumnos:2])
		$rec:=Record number:C243([Alumnos:2])
		
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$idAlumno)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atNombreHemanos;[Alumnos:2]curso:20;atCursoHermanos)
		GOTO RECORD:C242([Alumnos:2];$rec)
		
		AL_UpdateArrays (xALP_HermanosEnColegio;-2)
		
	: ($1=2)  //alumnos que tienen papa o mama en comun
		
		  //madre en comun
		AT_Initialize (->$idHermanos)
		AT_Initialize (->atNombreHemanos;->atCursoHermanos)
		$idAlumno:=[Alumnos:2]numero:1
		SAVE RECORD:C53([Alumnos:2])
		$rec:=Record number:C243([Alumnos:2])
		READ ONLY:C145([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		$idFamilia:=[Familia:78]Numero:1
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
		QUERY SELECTION:C341([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Parentesco:6="Padre";*)
		QUERY SELECTION:C341([Familia_RelacionesFamiliares:77]; | ;[Familia_RelacionesFamiliares:77]Parentesco:6="Madre")
		SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;$idPadres)
		
		QRY_QueryWithArray (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->$idPadres)
		  //QUERY SELECTION([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Familia#$idFamilia)
		SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Familia:2;$numeroFamilia)
		
		For ($i;1;Size of array:C274($numeroFamilia))
			
			QUERY:C277([Familia:78];[Familia:78]Numero:1=$numeroFamilia{$i})
			
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1;*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$idAlumno)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$idTemp)
			
			For ($j;1;Size of array:C274($idTemp))
				APPEND TO ARRAY:C911($idHermanos;$idTemp{$j})
			End for 
			
		End for 
		
		AT_DistinctsArrayValues (->$idHermanos)
		
		  //fnalmente con los id's de alumnos, crgo la  informacion de éstos
		
		For ($i;1;Size of array:C274($idHermanos))
			
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$idHermanos{$i})
			APPEND TO ARRAY:C911(atNombreHemanos;[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911(atCursoHermanos;[Alumnos:2]curso:20)
		End for 
		AL_UpdateArrays (xALP_HermanosEnColegio;-2)
		GOTO RECORD:C242([Alumnos:2];$rec)
End case 

AL_SetLine (xALP_HermanosEnColegio;0)
