Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($size;$plErr;$pos;$i;$width)
		C_TEXT:C284($arrName)
		
		$size:=1+2+vl_noArreglosReal+1
		$plErr:=PL_SetArraysNam (Self:C308->;1;3;"aQR_Integer1";"aQR_Longint1";"aQR_Longint2")
		$pos:=3
		For ($i;1;vl_noArreglosReal)
			$arrName:="aQR_Real"+String:C10($i)
			$plErr:=PL_SetArraysNam (Self:C308->;$pos+$i;1;$arrName)
		End for 
		$pos:=$pos+vl_noArreglosReal+1
		$plErr:=PL_SetArraysNam (Self:C308->;$pos;1;"aQR_Text1")
		
		If ($plErr=0)
			PL_SetHdrOpts (Self:C308->;2;0)
			PL_SetHeaders (Self:C308->;1;3;"Día";"Desde";"Hasta")
			$pos:=3
			For ($i;1;Size of array:C274(aQR_Longint100))
				PL_SetHeaders (Self:C308->;$pos+$i;1;String:C10(aQR_Longint100{$i}))
			End for 
			$pos:=$pos+Size of array:C274(aQR_Longint100)+1
			PL_SetHeaders (Self:C308->;$pos;1;"Total IFC")
			If (vl_desglosar=1)
				ARRAY TEXT:C222($at_temp;0)
				AT_Text2Array (->$at_temp;vt_ItemsIE;"\r")
				For ($i;1;Size of array:C274($at_temp))
					PL_SetHeaders (Self:C308->;$pos+$i;1;Substring:C12($at_temp{$i};3;Length:C16($at_temp{$i})))
				End for 
				$pos:=$pos+Size of array:C274($at_temp)+1
			Else 
				$pos:=$pos+1
			End if 
			PL_SetHeaders (Self:C308->;$pos;3;"Total ingresos colegio";"Total venta diaria";"Folio boletas nulas")
			$width:=Trunc:C95(516/($size-4);0)
			PL_SetWidths (Self:C308->;1;3;20;50;50)
			$pos:=3
			For ($i;1;$size-4)
				PL_SetWidths (Self:C308->;$pos+$i;1;$width)
			End for 
			PL_SetWidths (Self:C308->;$size;1;100)
			
			PL_SetFormat (Self:C308->;1;"";1;2)
			For ($i;2;$size-1)
				PL_SetFormat (Self:C308->;$i;"|Despliegue_ACT";3;2)
			End for 
			PL_SetFormat (Self:C308->;$size;"";3;2)
			PL_SetHeight (Self:C308->;2;4;1;0)
			PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
			PL_SetStyle (Self:C308->;0;"Tahoma";9;0)
			PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
			PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
			
			PL_SetBrkText (Self:C308->;0;2;"Total ingresos";2;3)
			PL_SetBrkColor (Self:C308->;0;2;"";0;"";0)
			PL_SetBrkStyle (Self:C308->;0;2;"Arial";9;1)
			
			For ($i;4;$size-1)
				PL_SetBrkText (Self:C308->;0;$i;"\\Sum";0;0)
				PL_SetBrkColor (Self:C308->;0;$i;"";0;"";0)
				PL_SetBrkColOpt (Self:C308->;0;$i;1;0;"";"";0)
				PL_SetBrkStyle (Self:C308->;0;$i;"Arial";9;1)
				PL_SetBrkHeight (Self:C308->;0;1;1)
			End for 
			
		End if 
End case 