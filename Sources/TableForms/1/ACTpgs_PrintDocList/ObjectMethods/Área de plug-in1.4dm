Case of 
	: (Form event:C388=On Load:K2:1)
		Case of 
			: (rCheques=1)
				$plErr:=PL_SetArraysNam (Self:C308->;1;6;"atACT_BancoNombre";"atACT_Cuenta";"atACT_Titular";"atACT_Serie";"adACT_Fecha";"arACT_MontoCheque")
				If ($plErr=0)
					PL_SetHdrOpts (Self:C308->;2;0)
					PL_SetHeaders (Self:C308->;1;6;"Banco";"N° Cuenta";"Titular";"N° Serie";"Fecha";"Monto")
					PL_SetWidths (Self:C308->;1;6;115;105;150;60;60;60)
					PL_SetFormat (Self:C308->;6;"|Despliegue_ACT";0;0)
					PL_SetHdrStyle (Self:C308->;0;"Tahoma";10;1)
					PL_SetStyle (Self:C308->;0;"Tahoma";10;0)
					PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
					PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
				End if 
			: (rLetras=1)
				$plErr:=PL_SetArraysNam (Self:C308->;1;6;"arACT_LCFolio";"atACT_LCAceptante";"adACT_LCEmision";"adACT_LCVencimiento";"arACT_LCMonto";"arACT_LCImpuesto")
				If ($plErr=0)
					PL_SetHdrOpts (Self:C308->;2;0)
					PL_SetHeaders (Self:C308->;1;6;"Folio";"Aceptante";"Fecha emisión";"Fecha vencimiento";"Monto";"Impuesto")
					PL_SetWidths (Self:C308->;1;6;75;135;95;95;70;70)
					PL_SetFormat (Self:C308->;1;"#######0";0;0)
					PL_SetFormat (Self:C308->;5;"|Despliegue_ACT";0;0)
					PL_SetFormat (Self:C308->;6;"|Despliegue_ACT";0;0)
					PL_SetHdrStyle (Self:C308->;0;"Tahoma";10;1)
					PL_SetStyle (Self:C308->;0;"Tahoma";10;0)
					PL_SetFrame (Self:C308->;1;"Black";"Black";0;1;"Black";"Black";0)
					PL_SetDividers (Self:C308->;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
				End if 
		End case 
End case 