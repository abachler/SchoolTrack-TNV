//%attributes = {}
  //dbu_CNX_PersonasConProfesores

ALL RECORDS:C47([Personas:7])
ARRAY LONGINT:C221($aRecNums;Records in selection:C76([Personas:7]))
ARRAY BOOLEAN:C223($aBoolean;Records in selection:C76([Personas:7]))
$id:=0
$Boolean:=False:C215
AT_Populate (->$aRecNums;->$id)
AT_Populate (->$aBoolean;->$Boolean)
KRL_Array2Selection (->$aRecNums;->[Personas:7]ID_Profesor:78)

LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Conectando registros de padres y apoderados con registros de profesores..."))
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Personas:7])
	GOTO RECORD:C242([Personas:7];$aRecNums{$i})
	If ([Personas:7]RUT:6#"")
		QUERY:C277([Profesores:4];[Profesores:4]RUT:27=[Personas:7]RUT:6)
		If (Records in selection:C76([Profesores:4])=1)
			[Personas:7]ID_Profesor:78:=[Profesores:4]Numero:1
			SAVE RECORD:C53([Personas:7])
		End if 
	Else 
		QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=[Personas:7]Apellido_paterno:3;*)
		QUERY:C277([Profesores:4]; & [Profesores:4]Apellido_materno:4=[Personas:7]Apellido_materno:4;*)
		QUERY:C277([Profesores:4]; & ;[Profesores:4]Nombres:2;=;"@"+[Personas:7]Nombres:2+"@")
		If (Records in selection:C76([Profesores:4])>1)
			QUERY SELECTION:C341([Profesores:4];[Profesores:4]Nombres:2;=;[Personas:7]Nombres:2)
		End if 
		If (Records in selection:C76([Profesores:4])>1)
			If ([Personas:7]Direccion:14#"")
				QUERY SELECTION:C341([Profesores:4];[Profesores:4]Dirección:8=[Personas:7]Direccion:14)
			End if 
		End if 
		If (Records in selection:C76([Profesores:4])=1)
			[Personas:7]ID_Profesor:78:=[Profesores:4]Numero:1
			SAVE RECORD:C53([Personas:7])
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)



