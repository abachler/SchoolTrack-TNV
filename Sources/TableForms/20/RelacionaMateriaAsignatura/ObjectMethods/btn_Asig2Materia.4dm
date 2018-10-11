If (Form event:C388=On Clicked:K2:4)
	
	C_LONGINT:C283($i;$resp;$line_A;$col_A;$line_M;$col_M;$proc)
	LISTBOX GET CELL POSITION:C971(LB_Asignaturas;$col_A;$line_A)
	LISTBOX GET CELL POSITION:C971(LB_subsectores;$col_M;$line_M)
	
	If ($line_A>0) & ($line_M>0)
		$msg:="¿Desea vincular la asignatura "+at_asignaturas{$line_A}+" al subsector "+at_subsectores{$line_M}+" ?"
		$resp:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
		
		If ($resp=1)
			
			ARRAY LONGINT:C221($DA_Return;0)
			at_asignaturas{0}:=at_asignaturas{$line_A}
			AT_SearchArray (->at_asignaturas;"=";->$DA_Return)
			
			If (Size of array:C274($DA_Return)>1)
				$msg:="Existen "+String:C10(Size of array:C274($DA_Return))+" asignaturas "+at_asignaturas{$line_A}+" en el listado ¿Desea vincularlas todas al subsector "+at_subsectores{$line_M}+"?"
				$resp:=CD_Dlog (0;$msg;"";__ ("Todas");__ ("Selecionada"))
				
				ARRAY TEXT:C222($uuid_asig;0)
				
				If ($resp=1)
					For ($i;1;Size of array:C274($DA_Return))
						APPEND TO ARRAY:C911($uuid_asig;at_asigUUID{$DA_Return{$i}})
					End for 
				Else 
					APPEND TO ARRAY:C911($uuid_asig;at_asigUUID{$line_A})
				End if 
				
				$proc:=IT_UThermometer (1;0;__ ("Vinculando asignatura ... ")+at_asignaturas{$line_A}+" a "+at_subsectores{$line_M})
				READ WRITE:C146([Asignaturas:18])
				QUERY WITH ARRAY:C644([Asignaturas:18]auto_uuid:12;$uuid_asig)
				APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Materia_UUID:46:=at_subsectoresUUID{$line_M})
				KRL_UnloadReadOnly (->[Asignaturas:18])
				If ($resp=1)
					For ($i;Size of array:C274($DA_Return);1;-1)
						DELETE FROM ARRAY:C228(at_asignaturas;$DA_Return{$i})
						DELETE FROM ARRAY:C228(at_curso;$DA_Return{$i})
						DELETE FROM ARRAY:C228(at_nivel;$DA_Return{$i})
						DELETE FROM ARRAY:C228(at_asigUUID;$DA_Return{$i})
					End for 
				Else 
					DELETE FROM ARRAY:C228(at_asignaturas;$line_A)
					DELETE FROM ARRAY:C228(at_curso;$line_A)
					DELETE FROM ARRAY:C228(at_nivel;$line_A)
					DELETE FROM ARRAY:C228(at_asigUUID;$line_A)
				End if 
				
				IT_UThermometer (-2;$proc)
				
			End if 
			
		End if 
		
	End if 
	
End if 
