Case of 
	: (Form event:C388=On Load:K2:1)
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;1;1;"atBU_ALNameGral")
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;2;1;"atBU_ALCursoGral")
		
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;3;1;"atBU_AsisLunes")
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;4;1;"atBU_AsisMartes")
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;5;1;"atBU_AsisMiercoles")
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;6;1;"atBU_AsisJueves")
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;7;1;"atBU_AsisViernes")
		$plErr:=PL_SetArraysNam (xPLP_ListaAsistencia;8;1;"atBU_AsisSabado")
		
		
		If ($plErr=0)
			PL_SetHdrOpts (xPLP_ListaAsistencia;2;0)
			PL_SetHeaders (xPLP_ListaAsistencia;1;8;"Nombre";"Curso";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes";"Sabado")
			PL_SetWidths (xPLP_ListaAsistencia;1;8;200;45;45;45;55;50;50;60)
			
			PL_SetFormat (xPLP_ListaAsistencia;1;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;2;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;3;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;4;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;5;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;6;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;7;"";1;2)
			PL_SetFormat (xPLP_ListaAsistencia;8;"";1;2)
			
			PL_SetHdrStyle (xPLP_ListaAsistencia;0;"Tahoma";10;1)  //Apply to all headers: Geneva  10 point bold
			PL_SetStyle (xPLP_ListaAsistencia;0;"Tahoma";9;0)  //Apply to all columns: Geneva 9  point plain
			PL_SetFrame (xPLP_ListaAsistencia;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (xPLP_ListaAsistencia;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
			
		End if 
		
End case 