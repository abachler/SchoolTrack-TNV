

$plErr:=PL_SetArraysNam (Self:C308->;1;8;"atACT_NoPago";"adACT_FechaPago";"atACT_FormaDePago";"atACT_MontoDePago";"atACT_GlosaCargo";"atACT_NomApoderado";"atACT_NomAlumno";"atACT_Curso")
If ($plErr=0)
	PL_SetHdrOpts (Self:C308->;2;0)
	PL_SetHeaders (Self:C308->;1;8;"Nº";"Fecha";"F.Pago";"Monto";"Glosa";"Apoderado";"Alumnos";"Curso")
	  //Saúl Ponce 25.07.2014 - Se modifica el ancho de algunas columnas como fecha y monto Ticket Nº 134914
	  //PL_SetWidths (Self->;1;8;30;30;40;40;120;120;120;30)
	  //PL_SetWidths (Self->;1;8;30;35;40;50;120;120;110;30)
	  //ASM 20141210 Modifico el ancho de la columna para la fecha Ticket 139682
	PL_SetWidths (Self:C308->;1;8;30;45;40;60;110;115;110;25)
	PL_SetHdrStyle (Self:C308->;0;"Tahoma";8;1)
	PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
	PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
	PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
	PL_SetFormat (Self:C308->;2;"0";0;0;0)
	  //ASM 20141210 para alinear a la derecha los montos Ticket 139682
	PL_SetFormat (Self:C308->;4;"0";3;2;0)
End if 

