Case of 
	: (Form event:C388=On Load:K2:1)
		
		$plErr:=PL_SetArraysNam (xPLP_Alumnos;1;1;"alBU_ALCodigo")
		$plErr:=PL_SetArraysNam (xPLP_Alumnos;2;1;"atBU_ALName")
		$plErr:=PL_SetArraysNam (xPLP_Alumnos;3;1;"alBU_ALRutaName")
		$plErr:=PL_SetArraysNam (xPLP_Alumnos;4;1;"atBU_ALTipoServicio")
		$plErr:=PL_SetArraysNam (xPLP_Alumnos;5;1;"atBU_ALAcomp")
		
		If ($plErr=0)
			PL_SetHdrOpts (xPLP_Alumnos;2;0)
			PL_SetHeaders (xPLP_Alumnos;1;5;"Código";"Nombre";"Ruta";"Servicio";"Acompañante")
			PL_SetWidths (xPLP_Alumnos;1;5;40;200;60;100;150)
			
			PL_SetFormat (xPLP_Alumnos;1;"";1;2)
			PL_SetFormat (xPLP_Alumnos;2;"";1;2)
			PL_SetFormat (xPLP_Alumnos;3;"";1;2)
			PL_SetFormat (xPLP_Alumnos;4;"";1;2)
			PL_SetFormat (xPLP_Alumnos;5;"";1;2)
			
			PL_SetHdrStyle (xPLP_Alumnos;0;"Tahoma";10;1)  //Apply to all headers: Geneva  10 point bold
			PL_SetStyle (xPLP_Alumnos;0;"Tahoma";9;0)  //Apply to all columns: Geneva 9  point plain
			PL_SetFrame (xPLP_Alumnos;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (xPLP_Alumnos;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
			
		End if 
		
		
End case 