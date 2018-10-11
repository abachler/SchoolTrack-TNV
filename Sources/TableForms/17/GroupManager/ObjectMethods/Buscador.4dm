
  //ABC
Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		C_TEXT:C284($t_texto)
		$t_texto:=Get edited text:C655
		If ($t_texto="")
			COPY ARRAY:C226(al_idUsuarios;<>ALUSR_USERIDS2)
			COPY ARRAY:C226(at_nombres;<>atUSR_UserNamesInterfaz)
			COPY ARRAY:C226(al_Recnum;<>alUSR_USERSRECNUMS2)
		Else 
			ARRAY LONGINT:C221(<>ALUSR_USERIDS2;0)
			ARRAY LONGINT:C221(<>alUSR_USERSRECNUMS2;0)
			ARRAY TEXT:C222(<>atUSR_UserNamesInterfaz;0)
			at_nombres{0}:=$t_texto
			ARRAY LONGINT:C221(da_return;0)
			AT_SearchArray (->at_nombres;"@";->da_return)
			For ($i;1;Size of array:C274(da_return))
				APPEND TO ARRAY:C911(<>ALUSR_USERIDS2;al_idUsuarios{da_return{$i}})
				APPEND TO ARRAY:C911(<>atUSR_UserNamesInterfaz;at_nombres{da_return{$i}})
				APPEND TO ARRAY:C911(<>alUSR_USERSRECNUMS2;al_Recnum{da_return{$i}})
			End for 
			at_nombres2{0}:=$t_texto
			ARRAY LONGINT:C221(da_return;0)
			AT_SearchArray (->at_nombres2;"@";->da_return)
			For ($i;1;Size of array:C274(da_return))
				$l_pos:=Find in array:C230(<>atUSR_UserNamesInterfaz;at_nombres{da_return{$i}})
				If ($l_pos=-1)
					APPEND TO ARRAY:C911(<>ALUSR_USERIDS2;al_idUsuarios{da_return{$i}})
					APPEND TO ARRAY:C911(<>atUSR_UserNamesInterfaz;at_nombres{da_return{$i}})
					APPEND TO ARRAY:C911(<>alUSR_USERSRECNUMS2;al_Recnum{da_return{$i}})
				End if 
			End for 
		End if 
End case 

