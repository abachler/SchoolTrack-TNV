If (Form event:C388=On Load:K2:1)
	ARRAY TEXT:C222(aQR_text1;0)
	APPEND TO ARRAY:C911(aQR_text1;"III. Alumnos con notas pendientes o no evaluados")
	$err:=PL_SetArraysNam (xPL_Disp2;1;1;"aQR_text1")
	PL_SetWidths (xPL_Disp2;1;1;150;80)
	PL_SetHeaders (xPL_Disp2;1;1;"TEXTODE PRUEBA")
	PL_SetHeight (xPL_Disp2;1;1;0;0)
	PL_SetHdrStyle (xPL_Disp2;0;"Arial";8;1)
	  // MOD Ticket N° 205157 20180717 Patricio Aliaga
	PL_SetStyle (xPL_Disp2;0;"Arial";8;1)
	  //PL_SetStyle (xPL_Disp2;9;"Arial";8;1)
	PL_SetFormat (xPL_Disp2;1;"";1;2)
	PL_SetDividers (xPL_Disp2;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	  //PL_SetFrame (xPL_Disp2;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetSort (xPL_Disp2;1)
End if 
