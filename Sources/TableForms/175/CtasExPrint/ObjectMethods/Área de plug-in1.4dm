Case of 
	: (Form event:C388=On Load:K2:1)
		$plErr:=PL_SetArraysNam (Self:C308->;1;2;"aDeletedNames";"aMotivo")
		If ($plErr=0)
			PL_SetHdrOpts (Self:C308->;2;0)
			PL_SetHeaders (Self:C308->;1;2;"Cuenta Corriente";"Motivo")
			PL_SetWidths (Self:C308->;1;2;200;338)
			PL_SetFormat (Self:C308->;1;"";1;2)
			PL_SetFormat (Self:C308->;2;"";1;2)
			PL_SetHeight (Self:C308->;1;2;2;2)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";10;1)  //Apply to all headers: Geneva  10 point bold
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)  //Apply to all columns: Geneva 9  point plain
			PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
		End if 
End case 
