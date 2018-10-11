Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALP_Set_CC_CuentasCbl 
		IT_SetButtonState (False:C215;->bClearCCCbl;->bDelLinea)
		SET BLOB SIZE:C606(xblob;0)
		_O_ARRAY STRING:C218(80;<>asACT_GlosaCta;0)
		_O_ARRAY STRING:C218(80;<>asACT_CuentaCta;0)
		_O_ARRAY STRING:C218(80;<>asACT_CodAuxCta;0)
		_O_ARRAY STRING:C218(80;<>asACT_Centro;0)
		ARRAY TEXT:C222(atACT_CtasEspecialesGlosa;0)
		_O_ARRAY STRING:C218(80;asACT_CtasEspecialesCta;0)
		_O_ARRAY STRING:C218(80;asACT_CtasEspecialesCentro;0)
		xBlob:=PREF_fGetBlob (0;"Contabilidad";xBlob)
		BLOB_Blob2Vars (->xBlob;0;-><>asACT_GlosaCta;-><>asACT_CuentaCta;-><>asACT_Centro;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro;-><>asACT_CodAuxCta)
		SET BLOB SIZE:C606(xBlob;0)
		If (cbFacturacion=1)
			If (Records in set:C195("desctos")>0)
				USE SET:C118("desctos")
				$montoneto:=Abs:C99(Sum:C1([ACT_Cargos:173]Monto_Neto:5))
				$montoiva:=Abs:C99(Sum:C1([ACT_Cargos:173]Monto_IVA:20))
				$monto:=$montoneto-$montoiva
				AT_Insert (1;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
				aCCID{1}:=vlNextCCID
				vlNextCCID:=vlNextCCID+1
				acampocc4{1}:="Descuentos"
				acampocc2{1}:=$monto
				acampocc3{1}:=0
				$ctaEsp:=Find in array:C230(atACT_CtasEspecialesGlosa;acampocc4{1})
				If ($ctaEsp#-1)
					acampocc1{1}:=asACT_CtasEspecialesCta{$ctaEsp}
					acampocc16{1}:=asACT_CtasEspecialesCentro{$ctaEsp}
				End if 
			End if 
			If (td1=1)
				USE SET:C118("todos")
				$monto:=Abs:C99(Sum:C1([ACT_Cargos:173]Monto_IVA:20))
			Else 
				USE SET:C118("boletas")
				$monto:=Abs:C99(Sum:C1([ACT_Boletas:181]Monto_IVA:5))
			End if 
			AT_Insert (1;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
			aCCID{1}:=vlNextCCID
			vlNextCCID:=vlNextCCID+1
			acampocc4{1}:="IVA Debito Fiscal"
			acampocc2{1}:=0
			acampocc3{1}:=$monto
			$ctaEsp:=Find in array:C230(atACT_CtasEspecialesGlosa;acampocc4{1})
			If ($ctaEsp#-1)
				acampocc1{1}:=asACT_CtasEspecialesCta{$ctaEsp}
				acampocc16{1}:=asACT_CtasEspecialesCentro{$ctaEsp}
			End if 
			AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
			GOTO OBJECT:C206(xALP_ContraCuentasCbl)
			AL_GotoCell (xALP_ContraCuentasCbl;1;1)
			cbFacturacion:=0
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1;*)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=vd_Fecha2;*)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Saldo:15>0)
			$monto:=Sum:C1([ACT_Pagos:172]Saldo:15)
			AT_Insert (1;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
			aCCID{1}:=vlNextCCID
			vlNextCCID:=vlNextCCID+1
			acampocc4{1}:="Saldos disponibles"
			acampocc2{1}:=$monto
			acampocc3{1}:=0
			$ctaEsp:=Find in array:C230(atACT_CtasEspecialesGlosa;acampocc4{1})
			If ($ctaEsp#-1)
				acampocc1{1}:=asACT_CtasEspecialesCta{$ctaEsp}
				acampocc16{1}:=asACT_CtasEspecialesCentro{$ctaEsp}
			End if 
		End if 
		ACTwiz_CuentasCblFooters 
End case 
