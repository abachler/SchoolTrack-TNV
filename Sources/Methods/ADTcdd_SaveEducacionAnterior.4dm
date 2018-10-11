//%attributes = {}
  //ADTcdd_SaveEducacionAnterior

C_BOOLEAN:C305($entraFor)
$entraFor:=False:C215
AL_ExitCell (xALP_EducAnterior)
ARRAY TEXT:C222($atADT_ColAnt_Nombre;0)
ARRAY TEXT:C222($atADT_ColAnt_Pais;0)
ARRAY TEXT:C222($atADT_ColAnt_Nivel;0)
ARRAY LONGINT:C221($alADT_ColAnt_Año;0)
ARRAY LONGINT:C221($alADT_ColAnt_RecNums;0)
COPY ARRAY:C226(atADT_ColAnt_Nombre;$atADT_ColAnt_Nombre)
COPY ARRAY:C226(atADT_ColAnt_Pais;$atADT_ColAnt_Pais)
COPY ARRAY:C226(atADT_ColAnt_Nivel;$atADT_ColAnt_Nivel)
COPY ARRAY:C226(alADT_ColAnt_Año;$alADT_ColAnt_Año)
COPY ARRAY:C226(alADT_ColAnt_RecNums;$alADT_ColAnt_RecNums)
Case of 
	: (vsBWR_CurrentModule="AdmissionTrack")
		ADTcdd_LoadEducacionAnterior ([ADT_Candidatos:49]Candidato_numero:1;"al")
	: (vsBWR_CurrentModule="SchoolTrack")
		ADTcdd_LoadEducacionAnterior ([Personas:7]No:1;"pe")
End case 
For ($i;1;Size of array:C274($atADT_ColAnt_Nombre))
	If ($alADT_ColAnt_RecNums{$i}=-1)
		If (($atADT_ColAnt_Nombre{$i}#"") | ($atADT_ColAnt_Pais{$i}#"") | ($atADT_ColAnt_Nivel{$i}#"") | ($alADT_ColAnt_Año{$i}#0))
			CREATE RECORD:C68([STR_EducacionAnterior:87])
			[STR_EducacionAnterior:87]Nombre_Colegio:1:=$atADT_ColAnt_Nombre{$i}
			[STR_EducacionAnterior:87]País:2:=$atADT_ColAnt_Pais{$i}
			[STR_EducacionAnterior:87]Nivel:3:=$atADT_ColAnt_Nivel{$i}
			[STR_EducacionAnterior:87]Año:4:=$alADT_ColAnt_Año{$i}
			Case of 
				: (vsBWR_CurrentModule="AdmissionTrack")
					[STR_EducacionAnterior:87]ID_Alumno:5:=[ADT_Candidatos:49]Candidato_numero:1
					[STR_EducacionAnterior:87]Tipo_Persona:8:="al"
				: (vsBWR_CurrentModule="SchoolTrack")
					[STR_EducacionAnterior:87]ID_Persona:6:=[Personas:7]No:1
					[STR_EducacionAnterior:87]Tipo_Persona:8:="pe"
			End case 
			SAVE RECORD:C53([STR_EducacionAnterior:87])
		End if 
	Else 
		If (($atADT_ColAnt_Nombre{$i}#"") | ($atADT_ColAnt_Pais{$i}#"") | ($atADT_ColAnt_Nivel{$i}#"") | ($alADT_ColAnt_Año{$i}#0))
			READ WRITE:C146([STR_EducacionAnterior:87])
			GOTO RECORD:C242([STR_EducacionAnterior:87];$alADT_ColAnt_RecNums{$i})
			[STR_EducacionAnterior:87]Nombre_Colegio:1:=$atADT_ColAnt_Nombre{$i}
			[STR_EducacionAnterior:87]País:2:=$atADT_ColAnt_Pais{$i}
			[STR_EducacionAnterior:87]Nivel:3:=$atADT_ColAnt_Nivel{$i}
			[STR_EducacionAnterior:87]Año:4:=$alADT_ColAnt_Año{$i}
			Case of 
				: (vsBWR_CurrentModule="AdmissionTrack")
					[STR_EducacionAnterior:87]ID_Alumno:5:=[ADT_Candidatos:49]Candidato_numero:1
					[STR_EducacionAnterior:87]Tipo_Persona:8:="al"
				: (vsBWR_CurrentModule="SchoolTrack")
					[STR_EducacionAnterior:87]ID_Persona:6:=[Personas:7]No:1
					[STR_EducacionAnterior:87]Tipo_Persona:8:="pe"
			End case 
			SAVE RECORD:C53([STR_EducacionAnterior:87])
		End if 
		$el:=Find in array:C230(alADT_ColAnt_RecNums;$alADT_ColAnt_RecNums{$i})
		If ($el#-1)
			DELETE FROM ARRAY:C228(alADT_ColAnt_RecNums;$el;1)
			DELETE FROM ARRAY:C228(atADT_ColAnt_Nombre;$el;1)
			DELETE FROM ARRAY:C228(atADT_ColAnt_Pais;$el;1)
			DELETE FROM ARRAY:C228(atADT_ColAnt_Nivel;$el;1)
			DELETE FROM ARRAY:C228(alADT_ColAnt_Año;$el;1)
		End if 
	End if 
End for 
If ($entraFor=True:C214)
	For ($i;1;Size of array:C274(alADT_ColAnt_RecNums))
		READ WRITE:C146([STR_EducacionAnterior:87])
		GOTO RECORD:C242([STR_EducacionAnterior:87];alADT_ColAnt_RecNums{$i})
		DELETE RECORD:C58([STR_EducacionAnterior:87])
	End for 
End if 
KRL_UnloadReadOnly (->[STR_EducacionAnterior:87])
ARRAY TEXT:C222($atADT_ColAnt_Nombre;0)
ARRAY TEXT:C222($atADT_ColAnt_Pais;0)
ARRAY TEXT:C222($atADT_ColAnt_Nivel;0)
ARRAY LONGINT:C221($alADT_ColAnt_Año;0)
ARRAY LONGINT:C221($alADT_ColAnt_RecNums;0)