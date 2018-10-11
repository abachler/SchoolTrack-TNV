Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		For ($i;1;Size of array:C274(al_Numero))
			$err:=AL_SetArraysNam (xALP_CuentasCbl;$i;1;"at_ContabilidadTrf"+String:C10($i))
		End for 
		$err:=AL_SetArraysNam (xALP_CuentasCbl;al_Numero{Size of array:C274(al_Numero)}+1;1;"aenccuenta")
		$err:=AL_SetArraysNam (xALP_CuentasCbl;al_Numero{Size of array:C274(al_Numero)}+2;1;"aID")
		For ($i;1;Size of array:C274(al_Numero))
			AL_SetHeaders (xALP_CuentasCbl;$i;1;at_titulosAreaContabilidad{$i})
			AL_SetFormat (xALP_CuentasCbl;$i;"";0;0;0;0)
			AL_SetHdrStyle (xALP_CuentasCbl;$i;"Tahoma";9;1)
			AL_SetFtrStyle (xALP_CuentasCbl;$i;"Tahoma";9;0)
			AL_SetStyle (xALP_CuentasCbl;$i;"Tahoma";9;0)
			AL_SetForeColor (xALP_CuentasCbl;$i;"Black";0;"Black";0;"Black";0)
			AL_SetBackColor (xALP_CuentasCbl;$i;"White";0;"White";0;"White";0)
			AL_SetEnterable (xALP_CuentasCbl;$i;1)
			AL_SetEntryCtls (xALP_CuentasCbl;$i;0)
		End for 
		ALP_SetDefaultAppareance (xALP_CuentasCbl;9;1;6;1;8;2;2)
		AL_SetColOpts (xALP_CuentasCbl;1;1;1;2;0)
		AL_SetRowOpts (xALP_CuentasCbl;1;1;0;0;1;0)
		AL_SetCellOpts (xALP_CuentasCbl;0;1;1)
		AL_SetMiscOpts (xALP_CuentasCbl;0;0;"\\";1;1)
		AL_SetMainCalls (xALP_CuentasCbl;"";"")
		  //AL_SetCallbacks (xALP_CuentasCbl;"";"xALP_ACT_CB_CuentasCbl")
		AL_SetCallbacks (xALP_CuentasCbl;"";"")
		AL_SetEntryOpts (xALP_CuentasCbl;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_CuentasCbl;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xALP_CuentasCbl;1;"";"";"")
		AL_SetDrgSrc (xALP_CuentasCbl;2;"";"";"")
		AL_SetDrgSrc (xALP_CuentasCbl;3;"";"";"")
		AL_SetDrgDst (xALP_CuentasCbl;1;"";"";"")
		AL_SetDrgDst (xALP_CuentasCbl;1;"";"";"")
		AL_SetDrgDst (xALP_CuentasCbl;1;"";"";"")
		
		  //contra cuentas
		For ($i;1;Size of array:C274(al_Numero))
			$err:=AL_SetArraysNam (xALP_ContraCuentasCbl;$i;1;"at_contabilidadTrfCC"+String:C10($i))
		End for 
		$err:=AL_SetArraysNam (xALP_ContraCuentasCbl;$i;1;"aCCID")
		For ($i;1;Size of array:C274(al_Numero))
			AL_SetHeaders (xALP_ContraCuentasCbl;$i;1;at_titulosAreaContabilidad{$i})
			AL_SetFormat (xALP_ContraCuentasCbl;$i;"";0;0;0;0)
			AL_SetHdrStyle (xALP_ContraCuentasCbl;$i;"Tahoma";9;1)
			AL_SetFtrStyle (xALP_ContraCuentasCbl;$i;"Tahoma";9;0)
			AL_SetStyle (xALP_ContraCuentasCbl;$i;"Tahoma";9;0)
			AL_SetForeColor (xALP_ContraCuentasCbl;$i;"Black";0;"Black";0;"Black";0)
			AL_SetBackColor (xALP_ContraCuentasCbl;$i;"White";0;"White";0;"White";0)
			AL_SetEnterable (xALP_ContraCuentasCbl;$i;1)
			AL_SetEntryCtls (xALP_ContraCuentasCbl;$i;0)
		End for 
		  //general options
		ALP_SetDefaultAppareance (xALP_ContraCuentasCbl;9;1;6;1;8;1;2)
		AL_SetColOpts (xALP_ContraCuentasCbl;1;1;1;1;0)
		AL_SetRowOpts (xALP_ContraCuentasCbl;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_ContraCuentasCbl;0;1;1)
		AL_SetMiscOpts (xALP_ContraCuentasCbl;0;0;"\\";1;1)
		AL_SetMainCalls (xALP_ContraCuentasCbl;"";"")
		  //AL_SetCallbacks (xALP_ContraCuentasCbl;"";"xALP_ACT_CB_CCuentasCbl")
		AL_SetCallbacks (xALP_ContraCuentasCbl;"";"")
		AL_SetEntryOpts (xALP_ContraCuentasCbl;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_ContraCuentasCbl;0;30;0)
		
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
				For ($r;1;Size of array:C274(al_Numero))
					$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
					AT_Insert (1;1;$ptr)
					$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
					$ptr->{1}:=ACTtrf_Master (4;String:C10($r);"1")
					  //Case of 
					  //: (at_Descripcion{$r}="Texto Fijo")
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=at_TextoFijo{$r}
					  //: (at_Descripcion{$r}="Código Plan de Cuentas")
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //If ($ctaEsp#-1)
					  //$ptr->{1}:=acampocc1{1}
					  //End if 
					  //: (at_Descripcion{$r}="Monto al haber moneda Base")  `test
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=String(acampocc3{1})
					  //: (at_Descripcion{$r}="Monto al debe moneda Base")  `test
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=String(acampocc2{1};"|Despliegue_ACT")
					  //: (at_Descripcion{$r}="Descripción de Movimiento")
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=acampocc4{1}
					  //: (at_Descripcion{$r}="Código centro de costos")
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //If ($ctaEsp#-1)
					  //$ptr->{1}:=acampocc16{1}
					  //End if 
					  //: (at_Descripcion{$r}="Código Auxiliar")
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=""
					  //: (at_Descripcion{$r}="Monto del concepto")
					  //If (acampocc2{1}#0)
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=String(acampocc2{1};"|Despliegue_ACT")
					  //Else 
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=String(acampocc3{1};"|Despliegue_ACT")
					  //End if 
					  //: (at_Descripcion{$r}="Tipo de movimiento")
					  //If (acampocc2{1}#0)
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:="1"
					  //Else 
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:="2"
					  //End if 
					  //: (at_Descripcion{$r}="Código Forma de Pago")
					  //$ptr:=Get pointer("at_contabilidadTrfCC"+String($r))
					  //$ptr->{1}:=""
					  //Else 
					  //End case 
				End for 
			End if 
			If ((td1=1) | (td3=1))
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
			
			For ($r;1;Size of array:C274(al_Numero))
				$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
				AT_Insert (1;1;$ptr)
				Case of 
					: (at_Descripcion{$r}="Texto Fijo")
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						$ptr->{1}:=at_TextoFijo{$r}
					: (at_Descripcion{$r}="Código Plan de Cuentas")
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						If ($ctaEsp#-1)
							$ptr->{1}:=acampocc1{1}
						End if 
					: (at_Descripcion{$r}="Monto al haber moneda Base")  //test
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						$ptr->{1}:=String:C10($monto;"|Despliegue_ACT")
					: (at_Descripcion{$r}="Monto al debe moneda Base")  //test
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						$ptr->{1}:="0"
					: (at_Descripcion{$r}="Descripción de Movimiento")
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						$ptr->{1}:=acampocc4{1}
					: (at_Descripcion{$r}="Código centro de costos")
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						If ($ctaEsp#-1)
							$ptr->{1}:=acampocc16{1}
						End if 
					: (at_Descripcion{$r}="Código Auxiliar")
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						$ptr->{1}:=""
					: (at_Descripcion{$r}="Monto del concepto")
						If (acampocc2{1}#0)
							$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
							$ptr->{1}:=String:C10(acampocc2{1};"|Despliegue_ACT")
						Else 
							$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
							$ptr->{1}:=String:C10(acampocc3{1};"|Despliegue_ACT")
						End if 
					: (at_Descripcion{$r}="Tipo de movimiento")
						If (acampocc2{1}#0)
							$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
							$ptr->{1}:="1"
						Else 
							$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
							$ptr->{1}:="2"
						End if 
					: (at_Descripcion{$r}="Código Forma de Pago")
						$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
						$ptr->{1}:=""
					Else 
				End case 
			End for 
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
			For ($r;1;Size of array:C274(al_Numero))
				$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
				AT_Insert (1;1;$ptr)
				$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($r))
				$ptr->{1}:=ACTtrf_Master (4;String:C10($r);"1")
			End for 
		End if 
		ACTwiz_CuentasCblFootersTrf 
		AL_UpdateArrays (xALP_ContraCuentasCbl;-2)
		AL_UpdateArrays (xALP_CuentasCbl;-2)
End case 