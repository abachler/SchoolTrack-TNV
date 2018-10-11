Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_TEXT:C284($vt_motivo)
		ARRAY TEXT:C222($at_motivos;Count list items:C380(Self:C308->))
		For ($i;1;Count list items:C380(Self:C308->))
			GET LIST ITEM:C378(Self:C308->;$i;$itermRef;$itemText)
			$at_motivos{$i}:=$itemText
		End for 
		$vt_motivo:=$at_motivos{Selected list items:C379(Self:C308->)}
		
		READ WRITE:C146([xxADT_LogCambioEstado:162])
		If ((Records in selection:C76([xxADT_LogCambioEstado:162])#1) | ([ADT_Candidatos:49]Candidato_numero:1#[xxADT_LogCambioEstado:162]ID_Candidato:1) | ([xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4#[ADT_Candidatos:49]ID_Estado:49))
			ADTcdd_CargaLogCambioEstado 
			REDUCE SELECTION:C351([xxADT_LogCambioEstado:162];1)
			FIRST RECORD:C50([xxADT_LogCambioEstado:162])
		End if 
		[xxADT_LogCambioEstado:162]Motivo:8:=$vt_motivo
		SAVE RECORD:C53([xxADT_LogCambioEstado:162])
		  //UNLOAD RECORD([xxADT_LogCambioEstado])
		READ ONLY:C145([xxADT_LogCambioEstado:162])
End case 



  //C_TEXT(referencia)
  //C_INTEGER($i)
  //Case of 
  //: (Form event=On Load )
  //
  //hl_motivos:=New list
  //For ($i;1;Size of array(<>aMotivosEstados))
  //APPEND TO LIST(hl_motivos;<>aMotivosEstados{$i};$i)
  //End for 
  //SELECT LIST ITEMS BY POSITION(*;"mMotivos2";1)
  //$item:=Selected list items(Self->)
  //End case 

