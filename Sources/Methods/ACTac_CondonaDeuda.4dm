//%attributes = {}
ARRAY LONGINT:C221($al_recNumAvisos2Recalc;0)
For ($i;Size of array:C274(abACT_AvisosCargoSel);1;-1)
	If ((Not:C34(abACT_AvisosCargoSel{$i})) | (alACT_AvisosMontoCondonacion{$i}=0))
		  //AT_Delete ($i;1;->alACT_AvisosRecNumCargo)
		AT_Delete ($i;1;->alACT_AvisosRecNumCargo;->abACT_AvisosCargoSel;->alACT_AvisosMontoCondonacion;->alACT_AvisosSaldo;->alACT_AvisosGlosaCargo;->apACT_AvisosCargoSel)
	End if 
End for 
If (Size of array:C274(alACT_AvisosRecNumCargo)>0)
	C_BOOLEAN:C305($continue)
	ACTcfg_OpcionesCondonacion ("LeeBlob")
	If (cbSolicitaMotivoCondonacion=0)
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];alACT_AvisosRecNumCargo;"")
		$resp:=CD_Dlog (0;__ ("Se condonará la deuda de ")+String:C10(Records in selection:C76([ACT_Cargos:173]))+__ (" ítem(s) de cargo(s).")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
		If ($resp=1)
			$continue:=True:C214
		End if 
	Else 
		vb_CondonaDesdeMenu:=True:C214
		$continue:=ACTcfg_OpcionesCondonacion ("Interfaz")
	End if 
	If ($continue)
		C_TEXT:C284($vt_monedaCargo)
		C_LONGINT:C283($proc;$vl_idCargoRelacionado)
		$proc:=IT_UThermometer (1;0;__ ("Condonando deuda..."))
		For ($i;1;Size of array:C274(alACT_AvisosRecNumCargo))
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];alACT_AvisosRecNumCargo{$i})
			$vl_idCargoRelacionado:=[ACT_Cargos:173]ID:1
			vdACT_FechaPago:=Current date:C33(*)
			vQR_Real1:=0
			vrACT_MontoDescto:=0
			vQR_Text1:=ST_Boolean2Str ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
			vQR_Long2:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->vQR_Text1))
			If (cs_Neto=0)
				vrACT_MontoDesctoExento:=0
				vrACT_MontoDesctoAfecto:=0
				If ([ACT_Cargos:173]TasaIVA:21=0)
					vrACT_MontoDesctoExento:=alACT_AvisosMontoCondonacion{$i}
					vrACT_MontoDesctoExento:=ACTut_retornaMontoEnMoneda (vrACT_MontoDesctoExento;vQR_Text1;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
					vQR_Real1:=vrACT_MontoDesctoExento
				Else 
					vrACT_MontoDesctoAfecto:=alACT_AvisosMontoCondonacion{$i}
					vrACT_MontoDesctoAfecto:=ACTut_retornaMontoEnMoneda (vrACT_MontoDesctoAfecto;vQR_Text1;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
					vQR_Real1:=vrACT_MontoDesctoAfecto
				End if 
				vrACT_MontoDescto:=vQR_Real1
				ACTpgs_LoadCargosIntoArrays (False:C215)
				ACTpgs_CreaCargoDesctoEspecial (17;16;$vl_idCargoRelacionado)
				vbACT_IngresandoPagos:=False:C215
				GOTO RECORD:C242([ACT_Cargos:173];alACT_AvisosRecNumCargo{$i})
			Else 
				vQR_Real1:=alACT_AvisosMontoCondonacion{$i}
				[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5-vQR_Real1;vQR_Long2)
				[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
				If ([ACT_Cargos:173]TasaIVA:21>0)
					$montonetodsctos:=[ACT_Cargos:173]Monto_Neto:5
					$afecto:=$montonetodsctos/<>vrACT_FactorIVA
					[ACT_Cargos:173]Monto_IVA:20:=Round:C94($afecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
				End if 
				[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
				[ACT_Cargos:173]Glosa:12:=[ACT_Cargos:173]Glosa:12+" Condonación de deuda por "+String:C10(Abs:C99(vQR_Real1))
				SAVE RECORD:C53([ACT_Cargos:173])
			End if 
			
			If (Find in array:C230($al_recNumAvisos2Recalc;vlACT_recNumAC)=-1)
				APPEND TO ARRAY:C911($al_recNumAvisos2Recalc;vlACT_recNumAC)
			End if 
			
			vQRLong1:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			vQR_Long3:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
			LOG_RegisterEvt ("Condonación de deuda para el cargo número "+String:C10([ACT_Cargos:173]ID:1)+", perteneciente al aviso de cobranza número "+String:C10(KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->vQR_Long3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15))+", para la cuenta asociada al alumno "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->vQRLong1;->[Alumnos:2]apellidos_y_nombres:40)+", por un monto de "+String:C10(Abs:C99(vQR_Real1);"|Despliegue_ACT_Pagos")+" en moneda "+vQR_Text1+".")
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End for 
		For ($i;1;Size of array:C274($al_recNumAvisos2Recalc))  //calcula los montos del aviso
			ACTac_Recalcular ($al_recNumAvisos2Recalc{$i})
		End for 
		ACTmnu_RecalcularSaldosAvisos (->$al_recNumAvisos2Recalc)
		ARRAY LONGINT:C221($al_recNumAvisos2Recalc;0)
		vlACT_recNumAC:=-1
		IT_UThermometer (-2;$proc)
		ACCEPT:C269
	Else 
		If (cbSolicitaMotivoCondonacion=1)
			$vt_dlog:=""
			ACTcfg_OpcionesCondonacion ("RetornaDlogNoContinuar";->$vt_dlog)
			CD_Dlog (0;$vt_dlog)
		End if 
	End if 
	ACTcfg_OpcionesCondonacion ("InitVars")
	  //End if 
End if 