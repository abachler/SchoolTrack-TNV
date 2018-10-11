//%attributes = {}
READ ONLY:C145([Personas:7])
READ ONLY:C145([Profesores:4])
C_LONGINT:C283($i;$l_idTermometro;$l_recnumper;$l_rn)
ARRAY LONGINT:C221($al_recnum;0)
ALL RECORDS:C47([Personas:7])
LONGINT ARRAY FROM SELECTION:C647([Personas:7];aQR_longint1;"")

$l_idTermometro:=IT_Progress (1;0;0;"Revisando personas ...")
For ($i;1;Size of array:C274($al_recnum))
	
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnum))
	READ WRITE:C146([Personas:7])
	GOTO RECORD:C242([Personas:7];$al_recnum{$i})
	
	If ([Personas:7]ID_Profesor:78>0)
		READ WRITE:C146([Profesores:4])
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Personas:7]ID_Profesor:78)
		
		If ([Profesores:4]RUT:27#[Personas:7]RUT:6) & ([Profesores:4]RUT:27#"") & ([Personas:7]RUT:6#"")
			$l_recnumper:=Record number:C243([Personas:7])
			$l_rn:=Find in field:C653([Personas:7]RUT:6;[Profesores:4]RUT:27)
			
			If ($l_rn=-1)
				[Profesores:4]ID_Persona:65:=0
			Else 
				[Profesores:4]ID_Persona:65:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->[Profesores:4]RUT:27;->[Personas:7]No:1)
			End if 
			SAVE RECORD:C53([Profesores:4])
			
			GOTO RECORD:C242([Personas:7];$l_recnumper)
			$l_rn:=Find in field:C653([Profesores:4]RUT:27;[Personas:7]RUT:6)
			If ($l_rn=-1)
				[Personas:7]ID_Profesor:78:=0
				[Personas:7]Es_ProfesorActivo:77:=False:C215
			Else 
				[Personas:7]ID_Profesor:78:=KRL_GetNumericFieldData (->[Profesores:4]RUT:27;->[Personas:7]RUT:6;->[Profesores:4]Numero:1)
				[Personas:7]Es_ProfesorActivo:77:=True:C214
			End if 
			SAVE RECORD:C53([Personas:7])
			
		End if 
		KRL_UnloadReadOnly (->[Profesores:4])
	End if 
	KRL_UnloadReadOnly (->[Personas:7])
	
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

ARRAY LONGINT:C221($al_recnum;0)
ALL RECORDS:C47([Profesores:4])
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$al_recnum;"")

$l_idTermometro:=IT_Progress (1;0;0;"Revisando Profesores ...")
For ($i;1;Size of array:C274($al_recnum))
	
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnum))
	READ WRITE:C146([Profesores:4])
	GOTO RECORD:C242([Profesores:4];$al_recnum{$i})
	
	If ([Profesores:4]ID_Persona:65>0)
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]No:1=[Profesores:4]ID_Persona:65)
		
		If ([Profesores:4]RUT:27#[Personas:7]RUT:6) & ([Profesores:4]RUT:27#"") & ([Personas:7]RUT:6#"")
			$l_recnumper:=Record number:C243([Profesores:4])
			
			$l_rn:=Find in field:C653([Profesores:4]RUT:27;[Personas:7]RUT:6)
			If ($l_rn=-1)
				[Personas:7]ID_Profesor:78:=0
				[Personas:7]Es_ProfesorActivo:77:=False:C215
			Else 
				[Personas:7]ID_Profesor:78:=KRL_GetNumericFieldData (->[Profesores:4]RUT:27;->[Personas:7]RUT:6;->[Profesores:4]Numero:1)
				[Personas:7]Es_ProfesorActivo:77:=True:C214
			End if 
			SAVE RECORD:C53([Personas:7])
			
			GOTO RECORD:C242([Profesores:4];$l_recnumper)
			$l_rn:=Find in field:C653([Personas:7]RUT:6;[Profesores:4]RUT:27)
			If ($l_rn=-1)
				[Profesores:4]ID_Persona:65:=0
			Else 
				[Profesores:4]ID_Persona:65:=KRL_GetNumericFieldData (->[Personas:7]RUT:6;->[Profesores:4]RUT:27;->[Personas:7]No:1)
			End if 
			SAVE RECORD:C53([Profesores:4])
			
		End if 
		KRL_UnloadReadOnly (->[Profesores:4])
	End if 
	KRL_UnloadReadOnly (->[Personas:7])
	
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
