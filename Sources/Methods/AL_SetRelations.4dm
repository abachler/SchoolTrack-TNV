//%attributes = {}
  //AL_SetRelations

C_TEXT:C284($setName)

MESSAGES OFF:C175
READ WRITE:C146([Alumnos:2])
Case of 
	: (Count parameters:C259=1)
		$setname:=$1
		USE SET:C118($setName)
	: (Count parameters:C259=0)
		ALL RECORDS:C47([Alumnos:2])
End case 

SELECTION TO ARRAY:C260([Alumnos:2];$recNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Estableciendo relaciones familiares de los alumnos..."))

For ($i;1;Size of array:C274($recNum))
	GOTO RECORD:C242([Alumnos:2];$recNum{$i})
	If ([Alumnos:2]Familia_Número:24#0)
		$FamID:=[Alumnos:2]Familia_Número:24
		$id:=[Alumnos:2]numero:1
		
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=$famID;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]numero:1#$id;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1};*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>)
		GOTO RECORD:C242([Alumnos:2];$recNum{$i})
		
		If (Records in selection:C76([Alumnos:2])>0)
			  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
			  //If (Records in subselection([Alumnos]Conexiones)=0)
			  //CREATE SUBRECORD([Alumnos]Conexiones)
			  //[Alumnos]Conexiones'Conexion:="Hermano en el colegio"
			  //End if 
			QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
			QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano en el colegio")
			If (Records in selection:C76([Alumnos_Conexiones:212])=0)
				READ WRITE:C146([Alumnos_Conexiones:212])
				CREATE RECORD:C68([Alumnos_Conexiones:212])
				[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
				[Alumnos_Conexiones:212]Conexion:1:="Hermano en el colegio"
				SAVE RECORD:C53([Alumnos_Conexiones:212])
				KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
			End if 
			
		Else 
			  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
			  //While (Records in subselection([Alumnos]Conexiones)>0)
			  //DELETE SUBRECORD([Alumnos]Conexiones)
			  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
			  //End while 
			READ WRITE:C146([Alumnos_Conexiones:212])
			QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
			QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano en el colegio")
			DELETE SELECTION:C66([Alumnos_Conexiones:212])
			KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
		End if 
		
		GOTO RECORD:C242([Alumnos:2];$recNum{$i})
		
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=Nivel_Egresados)
		If (Records in selection:C76([Alumnos:2])>0)
			  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano de ex alumno")
			  //If (Records in subselection([Alumnos]Conexiones)=0)
			  //CREATE SUBRECORD([Alumnos]Conexiones)
			  //[Alumnos]Conexiones'Conexion:="Hermano de ex alumno"
			  //End if 
			  //SAVE RECORD([Alumnos])
			
			QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
			QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano de ex alumno")
			If (Records in selection:C76([Alumnos_Conexiones:212])=0)
				READ WRITE:C146([Alumnos_Conexiones:212])
				CREATE RECORD:C68([Alumnos_Conexiones:212])
				[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
				[Alumnos_Conexiones:212]Conexion:1:="Hermano de ex alumno"
				SAVE RECORD:C53([Alumnos_Conexiones:212])
				KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
			End if 
			
		End if 
		GOTO RECORD:C242([Alumnos:2];$recNum{$i})
		
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		If (Records in selection:C76([Familia:78])>0)
			QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5;*)
			QUERY:C277([Personas:7]; | [Personas:7]No:1=[Familia:78]Madre_Número:6)
			QUERY SELECTION:C341([Personas:7];[Personas:7]Es_ExAlumno:12=True:C214)
			If (Records in selection:C76([Personas:7])>0)
				  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hijo de ex alumno")
				  //If (Records in subselection([Alumnos]Conexiones)=0)
				  //CREATE SUBRECORD([Alumnos]Conexiones)
				  //[Alumnos]Conexiones'Conexion:="Hijo de ex alumno"
				  //End if 
				QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
				QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hijo de ex alumno")
				If (Records in selection:C76([Alumnos_Conexiones:212])=0)
					READ WRITE:C146([Alumnos_Conexiones:212])
					CREATE RECORD:C68([Alumnos_Conexiones:212])
					[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
					[Alumnos_Conexiones:212]Conexion:1:="Hijo de ex alumno"
					SAVE RECORD:C53([Alumnos_Conexiones:212])
					KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
				End if 
				
			End if 
		End if 
	End if 
	
	SAVE RECORD:C53([Alumnos:2])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($recNum);__ ("Estableciendo relaciones familiares de los alumnos..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212([Alumnos:2])
READ ONLY:C145([Alumnos:2])
