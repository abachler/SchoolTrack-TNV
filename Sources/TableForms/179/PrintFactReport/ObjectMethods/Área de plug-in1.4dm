Case of 
	: (Form event:C388=On Load:K2:1)
		$size:=Size of array:C274(aQR_Text1)+3
		$plErr:=PL_SetArraysNam (Self:C308->;1;2;"aQR_Longint2";"atACT_Glosas")
		For ($i;1;Size of array:C274(aQR_Text1))
			$arrName:="aQR_Real"+String:C10($i)
			$plErr:=PL_SetArraysNam (Self:C308->;$i+2;1;$arrName)
		End for 
		$plErr:=PL_SetArraysNam (Self:C308->;$size;1;"arACT_Montos")
		If ($plErr=0)
			PL_SetHdrOpts (Self:C308->;2;0)
			PL_SetHeaders (Self:C308->;1;2;"#";"Glosa")
			For ($i;1;Size of array:C274(aQR_Text1))
				$arrName:=aQR_Text1{$i}
				PL_SetHeaders (Self:C308->;$i+2;1;$arrName)
			End for 
			PL_SetHeaders (Self:C308->;$size;1;"Monto Emitido")
			$width:=Trunc:C95(306/($size-2);0)
			PL_SetWidths (Self:C308->;1;2;25;205)
			For ($i;1;$size-2)
				PL_SetWidths (Self:C308->;$i+2;1;$width)
			End for 
			PL_SetFormat (Self:C308->;1;"#####0";2;2)
			PL_SetFormat (Self:C308->;2;"";1;2)
			For ($i;1;Size of array:C274(aQR_Text1))
				If (aQR_Text1{$i}="UF@")
					PL_SetFormat (Self:C308->;$i+2;"###.###.##0,####";3;2)
				Else 
					PL_SetFormat (Self:C308->;$i+2;"|Despliegue_ACT";3;2)
				End if 
			End for 
			PL_SetFormat (Self:C308->;$size;"|Despliegue_ACT";3;2)
			PL_SetHeight (Self:C308->;2;4;1;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";10;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
		End if 
End case 