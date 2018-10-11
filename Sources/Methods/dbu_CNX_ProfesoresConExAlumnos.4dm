//%attributes = {}
  //dbu_CNX_ProfesoresConExAlumnos

ALL RECORDS:C47([Profesores:4])
ARRAY LONGINT:C221($aRecNums;Records in selection:C76([Profesores:4]))
ARRAY BOOLEAN:C223($aBoolean;Records in selection:C76([Profesores:4]))
$id:=0
$Boolean:=False:C215
AT_Populate (->$aRecNums;->$id)
AT_Populate (->$aBoolean;->$Boolean)
KRL_Array2Selection (->$aRecNums;->[Profesores:4]ID_ExAlumno:69;->$aBoolean;->[Profesores:4]Es_ExAlumno:68)

LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Conectando registros de profesores con registros de ex-alumnos..."))
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Profesores:4])
	GOTO RECORD:C242([Profesores:4];$aRecNums{$i})
	If ([Profesores:4]RUT:27#"")
		QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[Profesores:4]RUT:27)
		If (Records in selection:C76([Alumnos:2])=1)
			[Profesores:4]ID_ExAlumno:69:=[Alumnos:2]numero:1
			[Profesores:4]Es_ExAlumno:68:=True:C214
			SAVE RECORD:C53([Profesores:4])
		End if 
	Else 
		QUERY:C277([Alumnos:2];[Alumnos:2]Apellido_paterno:3=[Profesores:4]Apellido_paterno:3;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Apellido_materno:4;=;[Personas:7]Apellido_materno:4;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Nombres:2;=;"@"+[Profesores:4]Nombres:2+"@";*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>=1000)
		If (Records in selection:C76([Alumnos:2])>1)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Nombres:2;=;[Profesores:4]Nombres:2)
		End if 
		If (Records in selection:C76([Alumnos:2])>1)
			If ([Profesores:4]Dirección:8#"")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Direccion:12=[Profesores:4]Dirección:8)
			End if 
		End if 
		If (Records in selection:C76([Alumnos:2])=1)
			If ([Alumnos:2]nivel_numero:29>=1000)
				[Profesores:4]ID_ExAlumno:69:=[Alumnos:2]numero:1
				[Profesores:4]Es_ExAlumno:68:=True:C214
				SAVE RECORD:C53([Profesores:4])
			End if 
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)






