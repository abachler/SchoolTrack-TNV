Case of 
	: (Form event:C388=On Load:K2:1)
		Case of 
			: (vl_modeloInforme=1)
				For ($i;1;Size of array:C274(at_nombresArreglosACT))
					$plErr:=PL_SetArraysNam (Self:C308->;$i;1;at_nombresArreglosACT{$i})
				End for 
				If ($plErr=0)
					PL_SetHdrOpts (Self:C308->;2;0)
					For ($r;1;Size of array:C274(at_encabezadosACT))
						PL_SetHeaders (Self:C308->;$r;1;at_encabezadosACT{$r})
					End for 
					For ($r;1;Size of array:C274(at_encabezadosACT))
						PL_SetFormat (Self:C308->;$r+1;"";2;2)
					End for 
					
					PL_SetWidths (Self:C308->;1;13;110;17;27;27;19;28;27;28;27;28;27;28;27)
					PL_SetWidths (Self:C308->;14;12;28;27;28;27;28;27;28;27;28;27;28;27)
					PL_SetHeight (Self:C308->;2;2)
					PL_SetHdrStyle (Self:C308->;0;"Tahoma";7;1)
					PL_SetStyle (Self:C308->;0;"Tahoma";6;0)
					PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
					PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
				End if 
			Else 
				For ($i;1;Size of array:C274(at_nombresArreglosACT)/2)
					$plErr:=PL_SetArraysNam (Self:C308->;$i;1;at_nombresArreglosACT{$i})
				End for 
				If ($plErr=0)
					PL_SetHdrOpts (Self:C308->;2;0)
					For ($r;1;Size of array:C274(at_encabezadosACT)/2)
						PL_SetHeaders (Self:C308->;$r;1;at_encabezadosACT{$r})
					End for 
					PL_SetWidths (Self:C308->;1;1;110)
					PL_SetFormat (Self:C308->;1;"";1;2)
					For ($r;1;19;4)
						PL_SetWidths (Self:C308->;$r+1;1;35)
						PL_SetFormat (Self:C308->;$r+1;"";2;2)
						PL_SetWidths (Self:C308->;$r+2;1;35)
						PL_SetFormat (Self:C308->;$r+2;"";2;2)
						PL_SetWidths (Self:C308->;$r+3;1;19)
						PL_SetFormat (Self:C308->;$r+3;"";2;1)
						PL_SetWidths (Self:C308->;$r+4;1;39)
						PL_SetFormat (Self:C308->;$r+4;"|Despliegue_ACT";2;2)
					End for 
					PL_SetHeight (Self:C308->;2;2)
					PL_SetHdrStyle (Self:C308->;0;"Tahoma";7;1)
					PL_SetStyle (Self:C308->;0;"Tahoma";6;0)
					PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
					PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
				End if 
		End case 
End case 