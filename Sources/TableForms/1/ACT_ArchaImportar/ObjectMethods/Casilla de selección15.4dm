
If (Self:C308->)
	
	$t_msj:=__ ("Al parecer el modelo de importación de archivo de pago no tiene configurada la fecha de pago")
	
	READ ONLY:C145([xxACT_ArchivosBancarios:118])
	QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=vlACT_ImportadorID)
	If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9)
		C_LONGINT:C283(PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2;WTrf_s3;cs_IEncabezado;cs_IPie)
		C_LONGINT:C283(WTrf_s4)
		C_TEXT:C284(WTrf_s4_CaracterOtro)
		C_TEXT:C284(vt_ICodApr;vIIdentificador;vIFormatoCA)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=[xxACT_ArchivosBancarios:118]xData:2
		BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH
		SET BLOB SIZE:C606(xBlob;0)
		$l_pos:=Find in array:C230(at_idsTextos;"7")
		If ($l_pos>0)
			Case of 
				: (PWTrf_h1=1)
					If (al_Numero{$l_pos}>0)
						vb_fechaPago:=True:C214
					Else 
						CD_Dlog (0;$t_msj)
						If (Not:C34(Shift down:C543))
							vb_fechaPago:=False:C215
						End if 
					End if 
				: (PWTrf_h2=1)
					If (al_PosIni{$l_pos}>0)
						vb_fechaPago:=True:C214
					Else 
						CD_Dlog (0;$t_msj)
						If (Not:C34(Shift down:C543))
							vb_fechaPago:=False:C215
						End if 
					End if 
			End case 
		End if 
	Else 
		
		C_TEXT:C284($t_code)
		C_LONGINT:C283($l_offSet)
		$t_code:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$l_offSet;32000)
		If (Position:C15("aFechaPagos";$t_code)=0)
			CD_Dlog (0;$t_msj)
			If (Not:C34(Shift down:C543))
				vb_fechaPago:=False:C215
			End if 
		End if 
	End if 
End if 