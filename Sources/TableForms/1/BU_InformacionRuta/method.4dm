Case of 
	: (Form event:C388=On Load:K2:1)
		$plErr:=PL_SetArraysNam (xPLP_Comunas;1;1;"atBU_ListaComunas")
		If ($plErr=0)
			PL_SetHdrOpts (xPLP_Comunas;1;0)
			PL_SetHeaders (xPLP_Comunas;1;1;"Comunas/Barrios")
			PL_SetWidths (xPLP_Comunas;1;150)
			PL_SetFormat (xPLP_Comunas;1;"";1;2)
			PL_SetHdrStyle (xPLP_Comunas;0;"Tahoma";10;1)  //Apply to all headers: Geneva  10 point bold
			PL_SetStyle (xPLP_Comunas;0;"Tahoma";9;0)  //Apply to all columns: Geneva 9  point plain
			PL_SetFrame (xPLP_Comunas;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (xPLP_Comunas;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
		End if 
		
		$plErr:=PL_SetArraysNam (xPLP_Recorridos;1;1;"alBU_ListaCodRec")
		$plErr:=PL_SetArraysNam (xPLP_Recorridos;2;1;"atBU_ListaJorRec")
		$plErr:=PL_SetArraysNam (xPLP_Recorridos;3;1;"alBU_ListaHoraRec")
		$plErr:=PL_SetArraysNam (xPLP_Recorridos;4;1;"atBU_ListaDiaRec")
		$plErr:=PL_SetArraysNam (xPLP_Recorridos;5;1;"abBU_ListaSentRec")
		If ($plErr=0)
			PL_SetHdrOpts (xPLP_Recorridos;2;0)
			PL_SetHeaders (xPLP_Recorridos;1;5;"Nº";"Jornada";"Hora";"Dia";"Sentido")
			PL_SetWidths (xPLP_Recorridos;1;5;106;106;106;106;106)
			PL_SetFormat (xPLP_Recorridos;1;"";1;2)
			PL_SetFormat (xPLP_Recorridos;2;"";1;2)
			PL_SetFormat (xPLP_Recorridos;3;"&/2";1;2)
			PL_SetFormat (xPLP_Recorridos;4;"";1;2)
			PL_SetFormat (xPLP_Recorridos;5;"Llegada;Salida";1;2)
			PL_SetHdrStyle (xPLP_Recorridos;0;"Tahoma";10;1)  //Apply to all headers: Geneva  10 point bold
			PL_SetStyle (xPLP_Recorridos;0;"Tahoma";9;0)  //Apply to all columns: Geneva 9  point plain
			PL_SetFrame (xPLP_Recorridos;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (xPLP_Recorridos;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
			
		End if 
		
End case 