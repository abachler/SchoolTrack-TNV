$line:=AL_GetLine (xALP_Prospectos)
If ($line#0)
	$r:=CD_Dlog (0;__ ("El prospecto será borrado inmediatamente sin posibilidad de deshacer. ¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		If (aProsID{$line}#-MAXLONG:K35:2)
			$rn:=Find in field:C653([ADT_Prospectos:163]ID:1;aProsID{$line})
			If ($rn#-1)
				READ WRITE:C146([ADT_Prospectos:163])
				GOTO RECORD:C242([ADT_Prospectos:163];$rn)
				DELETE RECORD:C58([ADT_Prospectos:163])
				If ([ADT_Contactos:95]Numero_de_Prospectos:17>0)
					[ADT_Contactos:95]Numero_de_Prospectos:17:=[ADT_Contactos:95]Numero_de_Prospectos:17-1
				End if 
				SAVE RECORD:C53([ADT_Contactos:95])
			End if 
		End if 
		AL_UpdateArrays (xALP_Prospectos;0)
		AT_Delete ($line;1;->aProsApPaterno;->aProsApMaterno;->aProsNombres;->aProsNivel;->aProsEdad;->aProsID;->aProsFechaNac;->aProsNota;->aProsSexo;->aProsNivelNum;->aProsMod;->aProsRelacion)
		AL_UpdateArrays (xALP_Prospectos;-2)
		AL_SetLine (xALP_Prospectos;0)
		IT_SetButtonState (False:C215;->baADT;->bDelProspecto)
		ADTcon_initProspecVars 
		  //vProsID:=-MAXLONG
		  //vProsApPaterno:=""
		  //vProsApMaterno:=""
		  //vProsNombres:=""
		  //vProsNivel:=""
		  //vProsNivelNum:=-999
		  //vProsFdeNac:=!00/00/00!
		  //vProsNota:=""
		  //vProsSexo:=""
		  //vProsRelacion:=""
	End if 
End if 