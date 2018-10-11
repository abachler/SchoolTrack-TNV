Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($size;$plErr;$pos;$i;$width)
		C_TEXT:C284($arrName)
		
		$size:=5
		$plErr:=PL_SetArraysNam (Self:C308->;1;1;"aQR_Text2")
		$pos:=1
		$indexArrayReal:=vl_noArreglosReal
		For ($i;1;4)
			$arrName:="aQR_Real"+String:C10($indexArrayReal+$i)
			$plErr:=PL_SetArraysNam (Self:C308->;$pos+$i;1;$arrName)
		End for 
		
		If ($plErr=0)
			PL_SetHdrOpts (Self:C308->;2;0)
			PL_SetHeaders (Self:C308->;1;5;"Año";"Monto";"50%";"40%";"10%")
			$width:=Trunc:C95(300/($size);0)
			For ($i;1;$size)
				PL_SetWidths (Self:C308->;$i;1;$width)
			End for 
			
			PL_SetFormat (Self:C308->;1;"";2;2)
			For ($i;2;$size)
				PL_SetFormat (Self:C308->;$i;"|Despliegue_ACT";3;2)
			End for 
			PL_SetHeight (Self:C308->;2;4;1;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
			
			PL_SetBrkText (Self:C308->;0;1;"Total";0;0)
			PL_SetBrkColor (Self:C308->;0;1;"";0;"";0)
			PL_SetBrkStyle (Self:C308->;0;1;"Arial";9;1)
			
			For ($i;2;$size)
				PL_SetBrkText (Self:C308->;0;$i;"\\Sum";0;0)
				PL_SetBrkColor (Self:C308->;0;$i;"";0;"";0)
				PL_SetBrkColOpt (Self:C308->;0;$i;1;0;"";"";0)
				PL_SetBrkStyle (Self:C308->;0;$i;"Arial";9;1)
				PL_SetBrkHeight (Self:C308->;0;1;1)
			End for 
			
		End if 
End case 