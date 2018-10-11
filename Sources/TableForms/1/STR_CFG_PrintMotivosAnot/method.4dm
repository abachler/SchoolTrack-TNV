Case of 
	: (Form event:C388=On Load:K2:1)
		$plErr:=PL_SetArraysNam (xPLP_MotivosAnot;1;1;"at_PrintCategoria")
		$plErr:=PL_SetArraysNam (xPLP_MotivosAnot;2;1;"al_PrintPuntajeCat")
		$plErr:=PL_SetArraysNam (xPLP_MotivosAnot;3;1;"at_PrintTipoCateg")
		$plErr:=PL_SetArraysNam (xPLP_MotivosAnot;4;1;"at_PrintMotivo")
		$plErr:=PL_SetArraysNam (xPLP_MotivosAnot;5;1;"al_PrintPuntajeMot")
		
		
		If ($plErr=0)
			PL_SetHdrOpts (xPLP_MotivosAnot;2;0)
			PL_SetHeight (xPLP_MotivosAnot;2;2;2;2)
			PL_SetHeaders (xPLP_MotivosAnot;1;5;"Categoria";"Puntaje\rCategoría";"Tipo";"Motivo";"Puntaje\rMotivo")
			PL_SetWidths (xPLP_MotivosAnot;1;5;80;55;50;310;55)
			PL_SetFormat (xPLP_MotivosAnot;1;"";1;2)
			  //PL_SetFormat (xPLP_MotivosAnot;2;"";1;2)
			PL_SetFormat (xPLP_MotivosAnot;2;"##0";1;2)  //20130410 ASM para solucionar problemas de formato - Mono: el formato es con 0 al fional
			PL_SetFormat (xPLP_MotivosAnot;3;"";1;2)
			PL_SetFormat (xPLP_MotivosAnot;4;"";1;2)
			  //PL_SetFormat (xPLP_MotivosAnot;5;"";1;2)
			PL_SetFormat (xPLP_MotivosAnot;5;"##0";1;2)  //20130410 ASM para solucionar problemas de formato
			
			PL_SetHdrStyle (xPLP_MotivosAnot;0;"Tahoma";10;1)  //Apply to all headers: Geneva  10 point bold
			PL_SetStyle (xPLP_MotivosAnot;0;"Tahoma";9;0)  //Apply to all columns: Geneva 9  point plain
			PL_SetFrame (xPLP_MotivosAnot;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (xPLP_MotivosAnot;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
			PL_SetSort (xPLP_MotivosAnot;1;2;3;4;5)
			PL_SetRepeatVal (xPLP_MotivosAnot;1;1)
			PL_SetRepeatVal (xPLP_MotivosAnot;2;1)
		End if 
End case 