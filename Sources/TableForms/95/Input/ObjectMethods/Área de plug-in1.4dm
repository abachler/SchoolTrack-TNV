IT_SetButtonState (Not:C34(Is new record:C668([ADT_Contactos:95]));->baADT)
Case of 
	: ((alProEvt=2) | (alProEvt=1))
		
		$line:=AL_GetLine (xALP_Prospectos)
		
		If ($line>0)
			_O_ENABLE BUTTON:C192(bDelProspecto)
			vProsID:=aProsID{$line}
			vProsApPaterno:=aProsApPaterno{$line}
			vProsApMaterno:=aProsApMaterno{$line}
			vProsNombres:=aProsNombres{$line}
			vProsNivel:=aProsNivel{$line}
			vProsNivelNum:=aProsNivelNum{$line}
			vProsFdeNac:=aProsFechaNac{$line}
			vProsNota:=aProsNota{$line}
			vProsSexo:=aProsSexo{$line}
			vProsRelacion:=aProsRelacion{$line}
		End if 
		
	: ((alProevt=3) | (alProevt=-1))  //mono agrego -1 por que cuando ordenan por columna queda la primera linea seleccionada y eso afecta al agregar un usuario
		  //ADTcon_initProspecVars 
		AL_SetLine (xALP_Prospectos;0)
		_O_DISABLE BUTTON:C193(bDelProspecto)
		_O_DISABLE BUTTON:C193(baADT)
		
End case 
  //
  //$line:=AL_GetLine (Self->)
  //If (($line#0) & (alProevt#3))
  //vProsID:=aProsID{$line}
  //vProsApPaterno:=aProsApPaterno{$line}
  //vProsApMaterno:=aProsApMaterno{$line}
  //vProsNombres:=aProsNombres{$line}
  //vProsNivel:=aProsNivel{$line}
  //vProsNivelNum:=aProsNivelNum{$line}
  //vProsFdeNac:=aProsFechaNac{$line}
  //vProsNota:=aProsNota{$line}
  //vProsSexo:=aProsSexo{$line}
  //vProsRelacion:=aProsRelacion{$line}
  //ENABLE BUTTON(bDelProspecto)
  //If (Is new record([ADT_Contactos]))
  //DISABLE BUTTON(baADT)
  //Else 
  //ENABLE BUTTON(baADT)
  //End if 
  //Else 
  //vProsID:=-MAXLONG
  //vProsApPaterno:=""
  //vProsApMaterno:=""
  //vProsNombres:=""
  //vProsNivel:=""
  //vProsNivelNum:=-MAXLONG
  //vProsFdeNac:=!00/00/00!
  //vProsNota:=""
  //vProsSexo:=""
  //vProsRelacion:=""
  //DISABLE BUTTON(bDelProspecto)
  //DISABLE BUTTON(baADT)
  //AL_SetLine (Self->;0)
  //End if 