If (vProsApPaterno#"")
	$pos:=AL_GetLine (xALP_Prospectos)
	AL_UpdateArrays (xALP_Prospectos;0)
	If ($pos#0)
		aProsApPaterno{$pos}:=vProsApPaterno
		aProsApMaterno{$pos}:=vProsApMaterno
		aProsNombres{$pos}:=vProsNombres
		aProsNivel{$pos}:=vProsNivel
		aProsEdad{$pos}:=DT_ReturnAgeLongString (vProsFdeNac)
		aProsFechaNac{$pos}:=vProsFdeNac
		aProsNota{$pos}:=vProsNota
		aProsSexo{$pos}:=vProsSexo
		aProsNivelNum{$pos}:=vProsNivelNum
		aProsRelacion{$pos}:=vProsRelacion
		aProsMod{$pos}:=True:C214
	Else 
		AT_Insert (1;1;->aProsApPaterno;->aProsApMaterno;->aProsNombres;->aProsNivel;->aProsEdad;->aProsID;->aProsFechaNac;->aProsNota;->aProsSexo;->aProsNivelNum;->aProsMod;->aProsRelacion)
		aProsApPaterno{1}:=vProsApPaterno
		aProsApMaterno{1}:=vProsApMaterno
		aProsNombres{1}:=vProsNombres
		aProsNivel{1}:=vProsNivel
		aProsEdad{1}:=DT_ReturnAgeLongString (vProsFdeNac)
		aProsID{1}:=vProsID
		aProsFechaNac{1}:=vProsFdeNac
		aProsNota{1}:=vProsNota
		aProsSexo{1}:=vProsSexo
		aProsNivelNum{1}:=vProsNivelNum
		aProsRelacion{1}:=vProsRelacion
		aProsMod{1}:=True:C214
	End if 
	AL_UpdateArrays (xALP_Prospectos;-2)
	AL_SetLine (xALP_Prospectos;0)
	IT_SetButtonState (False:C215;->baADT;->bDelProspecto)
	vProsID:=-MAXLONG:K35:2
	vProsApPaterno:=""
	vProsApMaterno:=""
	vProsNombres:=""
	vProsNivel:=""
	vProsNivelNum:=-999
	vProsFdeNac:=!00-00-00!
	vProsNota:=""
	vProsSexo:=""
	vProsRelacion:=""
	vb_ProsModified:=True:C214
Else 
	CD_Dlog (0;__ ("Se necesita al menos el apellido paterno para ingresar un prospecto."))
End if 