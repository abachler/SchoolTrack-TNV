AL_UpdateArrays (xALP_JornadasVisita;0)
READ ONLY:C145([ADT_JornadasVisita:144])
ALL RECORDS:C47([ADT_JornadasVisita:144])
SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Section:5;atPST_SeccionJornada;[ADT_JornadasVisita:144]Date_Jornada:2;adPST_DateJornada;[ADT_JornadasVisita:144]Hora_Jornada:3;aiPST_HoraJornada)
SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Total:8;aiPST_AsistentesJornada;[ADT_JornadasVisita:144]Place:4;atPST_LugarJornada;[ADT_JornadasVisita:144]ID:1;aiPST_IDJornada)

Case of 
	: (viPST_NumJornadasVisita<Size of array:C274(atPST_SeccionJornada))
		$elementsTodelete:=Size of array:C274(atPST_SeccionJornada)-viPST_NumJornadasVisita
		$el:=Find in array:C230(aiPST_AsistentesJornada;0)
		
		If ($el>0)
			OK:=CD_Dlog (0;__ ("El número ingresado es inferior a las presentaciones actualmente programadas. \r¿Desea eliminar las presentaciones sin asistentes registrados?");__ ("");__ ("Sí");__ ("No"))
			If (ok=1)
				For ($i;Size of array:C274(atPST_SeccionJornada);1;-1)
					If (aiPST_AsistentesJornada{$i}=0)
						
						READ WRITE:C146([ADT_JornadasVisita:144])
						QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=aiPST_IDJornada{$i})
						DELETE SELECTION:C66([ADT_JornadasVisita:144])
						SAVE RECORD:C53([ADT_JornadasVisita:144])
						KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
						
						$elementsTodelete:=$elementsTodelete-1
						If ($elementsTodelete=0)
							$i:=0
						End if 
					End if 
				End for 
			End if 
		Else 
			OK:=CD_Dlog (0;__ ("El número ingresado es inferior a las presentaciones actualmente programadas, algunas de ellas tienen asistentes registrados.\rSi elimina la presentación perderá la las fechas actualmente asignadas.\r¿Desea realmente eliminar estas presentaciones?");__ ("");__ ("No");__ ("Sí"))
			If (OK=2)
				$elementsTodelete:=Size of array:C274(atPST_SeccionJornada)-viPST_NumJornadasVisita
				For ($i;Size of array:C274(atPST_SeccionJornada);1;-1)
					READ WRITE:C146([ADT_JornadasVisita:144])
					QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=aiPST_IDJornada{$i})
					DELETE SELECTION:C66([ADT_JornadasVisita:144])
					SAVE RECORD:C53([ADT_JornadasVisita:144])
					KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
					$elementsTodelete:=$elementsTodelete-1
					If ($elementsTodelete=0)
						$i:=0
					End if 
				End for 
			End if 
		End if 
	: (viPST_NumJornadasVisita>Size of array:C274(atPST_SeccionJornada))
		C_LONGINT:C283($lugar;$k)
		$k:=1
		$rowsToInsert:=viPST_NumJornadasVisita-Size of array:C274(atPST_SeccionJornada)
		$lugar:=Size of array:C274(atPST_SeccionJornada)+1
		  //AT_Insert (Size of array(atPST_SeccionJornada)+1;$rowsToInsert;->atPST_SeccionJornada;->adPST_DateJornada;->aiPST_HoraJornada;->aiPST_AsistentesJornada;->atPST_LugarJornada;->aiPST_IDJornada)
		
		While ($rowsToInsert#0)
			  //AT_Insert ($lugar;1;->atPST_SeccionJornada;->adPST_DateJornada;->aiPST_HoraJornada;->aiPST_AsistentesJornada;->atPST_LugarJornada;->aiPST_IDJornada)
			READ WRITE:C146([ADT_JornadasVisita:144])
			CREATE RECORD:C68([ADT_JornadasVisita:144])
			[ADT_JornadasVisita:144]ID:1:=SQ_SeqNumber (->[ADT_JornadasVisita:144]ID:1)
			[ADT_JornadasVisita:144]Date_Jornada:2:=!00-00-00!
			[ADT_JornadasVisita:144]Hora_Jornada:3:=?00:00:00?
			[ADT_JornadasVisita:144]Section:5:=Char:C90(64+$lugar)
			SAVE RECORD:C53([ADT_JornadasVisita:144])
			$rowsToInsert:=$rowsToInsert-1
			$lugar:=$lugar+1
			KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
		End while 
End case 

READ ONLY:C145([ADT_JornadasVisita:144])
ALL RECORDS:C47([ADT_JornadasVisita:144])
SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Section:5;atPST_SeccionJornada;[ADT_JornadasVisita:144]Date_Jornada:2;adPST_DateJornada;[ADT_JornadasVisita:144]Hora_Jornada:3;aiPST_HoraJornada)
SELECTION TO ARRAY:C260([ADT_JornadasVisita:144]Total:8;aiPST_AsistentesJornada;[ADT_JornadasVisita:144]Place:4;atPST_LugarJornada;[ADT_JornadasVisita:144]ID:1;aiPST_IDJornada)

AL_SetLine (xALP_JornadasVisita;0)
AL_UpdateArrays (xALP_JornadasVisita;Size of array:C274(atPST_SeccionJornada))