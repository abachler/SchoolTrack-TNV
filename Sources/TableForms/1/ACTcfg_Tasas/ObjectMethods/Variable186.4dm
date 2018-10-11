Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (xALP_Divisas)
		IT_SetButtonState (($line>0);->bDeleteMoneda)
		
		$col:=AL_GetColumn (xALP_Divisas)
		$vl_idMoneda:=alACT_IdRegistro{$line}
		AL_UpdateArrays (xALP_Divisas;0)
		Case of 
			: ($col=4)
				If ((Not:C34((KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Es_Moneda_Oficial:5)))) & ($vl_idMoneda#-6))
					KRL_FindAndLoadRecordByIndex (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;True:C214)
					If (ok=1)
						
						If (abACT_GeneraTabla{$line})
							$resp:=CD_Dlog (0;__ ("Se eliminará la tabla diaria con las paridades para esta moneda\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
							If ($resp=1)
								[xxACT_Monedas:146]Genera_Tabla_Diaria:7:=False:C215
								SAVE RECORD:C53([xxACT_Monedas:146])
								abACT_GeneraTabla{$line}:=False:C215
								READ WRITE:C146([xxACT_MonedaParidad:147])
								QUERY:C277([xxACT_MonedaParidad:147];[xxACT_MonedaParidad:147]Id_Moneda:2=[xxACT_Monedas:146]Id_Moneda:1)
								DELETE SELECTION:C66([xxACT_MonedaParidad:147])
								KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
								LOG_RegisterEvt ("Eliminación de tabla de paridades para la moneda "+atACT_NombreMoneda{$line})
								  //ACTcfg_ColorUndelDivisas 
							End if 
						Else 
							$resp:=CD_Dlog (0;__ ("Se generará una tabla diaria con las paridades para esta moneda para cada día\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
							If ($resp=1)
								[xxACT_Monedas:146]Genera_Tabla_Diaria:7:=True:C214
								SAVE RECORD:C53([xxACT_Monedas:146])
								abACT_GeneraTabla{$line}:=True:C214
								ACTmon_CreaTablaDiaria (String:C10(Year of:C25(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")+String:C10([xxACT_Monedas:146]Id_Moneda:1))
								LOG_RegisterEvt ("Generación de tabla de paridades para la moneda "+atACT_NombreMoneda{$line})
								  // ACTcfg_ColorUndelDivisas
							End if 
						End if 
						
						ACTat_LLenaArregloPict (->abACT_GeneraTabla;->apACT_GeneraTabla)
						
						KRL_UnloadReadOnly (->[xxACT_Monedas:146])
					Else 
						CD_Dlog (0;__ ("El registro está siendo actualmente utilizado. Por favor intente más tarde."))
					End if 
				Else 
					BEEP:C151
				End if 
				
			: ($col=5)
				If (Not:C34((KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Es_Moneda_Oficial:5))))
					KRL_FindAndLoadRecordByIndex (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;True:C214)
					[xxACT_Monedas:146]Permite_Pago:12:=Not:C34(abACT_PermitePago{$line})
					SAVE RECORD:C53([xxACT_Monedas:146])
					abACT_PermitePago{$line}:=[xxACT_Monedas:146]Permite_Pago:12
					ACTat_LLenaArregloPict (->abACT_PermitePago;->apACT_PermitePago)
					KRL_UnloadReadOnly (->[xxACT_Monedas:146])
				Else 
					BEEP:C151
				End if 
				
		End case 
		ACTcfg_ColorUndelDivisas 
		AL_UpdateArrays (xALP_Divisas;-2)
		AL_SetLine (xALP_Divisas;$line)
		ACTcfgmyt_OpcionesGenerales ("SeleccionaLineaForm";->$vl_idMoneda)
		
	: (alProEvt=5)
		$line:=AL_GetLine (xALP_Divisas)
		If ($line#0)
			C_LONGINT:C283($vl_decimales;$vl_idMoneda;$vl_decimalesOrg)
			$vl_idMoneda:=alACT_IdRegistro{$line}
			$vl_decimales:=KRL_GetNumericFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Numero_Decimales:8)
			$text:="Establecer como moneda por defecto"
			  //If (alACT_IdRegistro{$line}>0)
			$text:=$text+";-;Establecer número de decimales para pago ["+String:C10($vl_decimales)+"]"
			  //Else 
			  //$text:=$text+";-;(Establecer número de decimales para pago ["+String($vl_decimales)+"]"
			  //End if 
			$choice:=Pop up menu:C542($text)
			If ($choice>0)
				Case of 
					: ($choice=1)
						$defDivisa:=atACT_NombreMoneda{$line}+";"+atACT_SimboloMoneda{$line}
						<>vsACT_MonedaColegio:=atACT_NombreMoneda{$line}
						<>vsACT_simbMonColegio:=atACT_SimboloMoneda{$line}
						AL_UpdateArrays (xALP_Divisas;0)
						
						$vl_idMoneda:=alACT_IdRegistro{$line}
						READ WRITE:C146([xxACT_Monedas:146])
						QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Moneda_X_Defecto_Base:11=True:C214)
						APPLY TO SELECTION:C70([xxACT_Monedas:146];[xxACT_Monedas:146]Moneda_X_Defecto_Base:11:=False:C215)
						
						QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Id_Moneda:1=$vl_idMoneda)
						[xxACT_Monedas:146]Moneda_X_Defecto_Base:11:=True:C214
						SAVE RECORD:C53([xxACT_Monedas:146])
						KRL_UnloadReadOnly (->[xxACT_Monedas:146])
						ACTcfgmyt_OpcionesGenerales ("LeeMonedas")
						  //SET BLOB SIZE(xBlob;0)
						READ WRITE:C146([Colegio:31])
						ALL RECORDS:C47([Colegio:31])
						FIRST RECORD:C50([Colegio:31])
						
						If ([Colegio:31]Moneda:49#$defDivisa)  //20160505 RCH
							LOG_RegisterEvt ("Cambio manual en moneda por defecto de la base de datos. La moneda cambió de: "+[Colegio:31]Moneda:49+" a: "+$defDivisa+".")
						End if 
						
						[Colegio:31]Moneda:49:=$defDivisa
						SAVE RECORD:C53([Colegio:31])
						UNLOAD RECORD:C212([Colegio:31])
						READ ONLY:C145([Colegio:31])
						AL_UpdateArrays (xALP_Divisas;-2)
						ACTcfg_ColorUndelDivisas 
						AL_SetLine (xALP_Divisas;0)
						AL_UpdateArrays (xALP_UF;-1)
						AL_UpdateArrays (xALP_IPC;-1)
						AL_UpdateArrays (xALP_Impuesto;-1)
						AL_UpdateArrays (xALP_Divisas;-1)
						IT_SetButtonState (False:C215;->bDeleteMoneda)
						
					: ($choice=3)
						$vl_decimalesOrg:=$vl_decimales
						$vl_decimales:=Num:C11(CD_Request (__ ("Ingrese número de decimales entre 0 y 2 para el cáclulo del pago para la moneda ")+ST_Qte (atACT_NombreMoneda{$line})+__ (".");__ ("OK");__ ("Cancelar");__ ("");String:C10($vl_decimalesOrg)))
						If (Ok=1)
							If (($vl_decimales>=0) & ($vl_decimales<=2))
								ACTcfgmyt_OpcionesGenerales ("ModificaCampoMoneda";->$vl_idMoneda;->[xxACT_Monedas:146]Numero_Decimales:8;->$vl_decimales)
								If ($vl_decimalesOrg#$vl_decimales)
									LOG_RegisterEvt ("Cambio en número de decimales para pago en moneda "+ST_Qte (atACT_NombreMoneda{$line})+", cambió de "+String:C10($vl_decimalesOrg)+" a "+String:C10($vl_decimales)+".")
								End if 
							Else 
								BEEP:C151
							End if 
						End if 
				End case 
			End if 
		End if 
End case 
ACTcfg_ColorUndelDivisas 