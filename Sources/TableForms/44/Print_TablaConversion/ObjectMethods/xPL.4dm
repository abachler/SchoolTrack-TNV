Case of 
	: (Form event:C388=On Load:K2:1)
		
		$err:=PL_SetArraysNam (Self:C308->;1;3;"arEVS_ConvGrades";"arEVS_convPoints";"arEVS_convgradesofficial")
		
		PL_SetHeaders (Self:C308->;1;3;"Notas";"Puntajes";"Bonificación")
		PL_SetWidths (Self:C308->;1;3;100;100;100)
		PL_SetHdrOpts (Self:C308->;2)
		PL_SetHeight (Self:C308->;1;1;0;0)
		PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
		PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
		PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetBrkRowDiv (Self:C308->;0.25;"Black";"Black";0)
		PL_SetBrkHeight (Self:C308->;0;1;2)
		PL_SetBrkColOpt (Self:C308->;0;0;0;1;"Black";"Black";0)
		PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";9;1)
		
		PL_SetFormat (Self:C308->;1;vs_GradesFormat;0;2)
		PL_SetFormat (Self:C308->;2;vs_PointsFormat;0;2)
		PL_SetFormat (Self:C308->;3;vs_GradesFormat;0;2)
		
End case 