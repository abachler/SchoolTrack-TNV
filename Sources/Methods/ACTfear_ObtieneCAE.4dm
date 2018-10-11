//%attributes = {}
  //ACTfear_ObtieneCAE
C_LONGINT:C283($l_CantReg;$l_PtoVta;$l_CbteTipo;$l_Concepto)
C_LONGINT:C283($l_DocTipo)
C_REAL:C285($r_DocNro)  //20170811 RCH Se cambia tipo de datos que tenía problemas
C_TEXT:C284($t_idNac;$t_idNac)
C_LONGINT:C283($l_CbteDesde;$l_CbteHasta)
C_TEXT:C284($t_CbteFch)
C_DATE:C307($d_fechaMenor;$d_fechaMayor)
C_TEXT:C284($t_FchServDesde;$t_FchServHasta;$t_FchVtoPago;$t_MonId)
C_REAL:C285($r_MonCotiz)
C_LONGINT:C283($l_recNumBol;$l_Tipo;$l_PtoVtaDA;$l_Nro)
C_LONGINT:C283($l_Id)
C_TEXT:C284($t_Desc)
C_REAL:C285($r_BaseImpT;$r_Alic;$r_ImporteT)
C_REAL:C285($r_ImpTotal;$r_ImpTotConc;$r_ImpNeto;$r_ImpOpEx;$r_ImpTrib;$r_ImpIVA)

C_LONGINT:C283($l_IdIVA)
C_REAL:C285($r_BaseImp;$r_Importe)
C_TEXT:C284($t_Id;$t_Valor)
C_REAL:C285($r_CUIT)

C_LONGINT:C283($l_idBoleta;$1)
C_BOOLEAN:C305($b_done;$0)

$l_idBoleta:=$1

If (vtACT_errorPHPExec="")
	If (vtACT_workstation=Current machine:C483)
		
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)
		If (ok=1)
			
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_Terceros:138])
			READ ONLY:C145([ACT_RazonesSociales:279])
			
			  //QUERY([ACT_Boletas];[ACT_Boletas]ID=4)
			If ([ACT_Boletas:181]AR_CAEcodigo:48="")
				
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
				QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Boletas:181]ID_Tercero:21)
				
				$l_CantReg:=1
				$l_PtoVta:=[ACT_Boletas:181]AR_CodigoPtoVenta:47
				$l_CbteTipo:=Num:C11([ACT_Boletas:181]codigo_SII:33)
				$l_Concepto:=2
				Case of 
					: (([Personas:7]RUT:6#"") | ([ACT_Terceros:138]RUT:4#""))
						$l_DocTipo:=96  //DNI
						$r_DocNro:=Num:C11(Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]RUT:6;[ACT_Terceros:138]RUT:4))
						
					: (([Personas:7]Pasaporte:59#"") | ([ACT_Terceros:138]Pasaporte:25#""))
						$l_DocTipo:=94  //Pasaporte
						$r_DocNro:=Num:C11(Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Pasaporte:59;[ACT_Terceros:138]Pasaporte:25))
						
					: (([Personas:7]IDNacional_2:37#"") | ([ACT_Terceros:138]Identificador_Nacional2:20#""))
						  //$l_DocTipo:=99  //Se deja como otros
						$l_DocTipo:=80  //20160405 RCH Se deja como CUIT
						
						  //20160426 RCH Se reemplaza por si ingresan con guiones y/o espacios
						  //$r_DocNro:=Num(Choose([ACT_Boletas]ID_Apoderado#0;[Personas]IDNacional_2;[ACT_Terceros]Identificador_Nacional2))
						$t_idNac:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]IDNacional_2:37;[ACT_Terceros:138]Identificador_Nacional2:20)
						$t_idNac:=Replace string:C233(Replace string:C233($t_idNac;" ";"");"-";"")
						$r_DocNro:=Num:C11($t_idNac)
						
					: (([Personas:7]IDNacional_3:38#"") | ([ACT_Terceros:138]Identificador_Nacional3:21#""))
						$l_DocTipo:=99  //Se deja como otros
						$r_DocNro:=Num:C11(Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]IDNacional_3:38;[ACT_Terceros:138]Identificador_Nacional3:21))
						
					Else 
						$l_DocTipo:=99  //Se deja como otros
						  //$r_DocNro:=Num(Choose([ACT_Boletas]ID_Apoderado#0;[Personas]No;[ACT_Terceros]Id))
						If ([ACT_Boletas:181]Monto_Total:6<1000)  //20150812 RCH Se agrega validación
							$r_DocNro:=0
						Else 
							$r_DocNro:=Num:C11(Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]No:1;[ACT_Terceros:138]Id:1))
						End if 
				End case 
				$l_CbteDesde:=[ACT_Boletas:181]Numero:11
				$l_CbteHasta:=[ACT_Boletas:181]Numero:11
				If ($l_Concepto=1)
					If (([ACT_Boletas:181]FechaEmision:3<=Add to date:C393(Current date:C33(*);0;0;5)) | ([ACT_Boletas:181]FechaEmision:3>=Add to date:C393(Current date:C33(*);0;0;-5)))
						$t_CbteFch:=String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3);"0000")+String:C10(Month of:C24([ACT_Boletas:181]FechaEmision:3);"00")+String:C10(Day of:C23([ACT_Boletas:181]FechaEmision:3);"00")
					Else 
						$t_CbteFch:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
					End if 
				Else 
					If (([ACT_Boletas:181]FechaEmision:3<=Add to date:C393(Current date:C33(*);0;0;10)) | ([ACT_Boletas:181]FechaEmision:3>=Add to date:C393(Current date:C33(*);0;0;-10)))
						$t_CbteFch:=String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3);"0000")+String:C10(Month of:C24([ACT_Boletas:181]FechaEmision:3);"00")+String:C10(Day of:C23([ACT_Boletas:181]FechaEmision:3);"00")
					Else 
						$t_CbteFch:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
					End if 
				End if 
				$r_ImpTotal:=[ACT_Boletas:181]Monto_Total:6
				  //If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13))  //tipo C
				If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13) | ($l_CbteTipo=15))  //tipo C 20150708 RCH
					$r_ImpTotConc:=0
				Else 
					$r_ImpTotConc:=0
				End if 
				  //If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13))  //tipo C
				If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13) | ($l_CbteTipo=15))  //tipo C 20150708 RCH
					$r_ImpNeto:=[ACT_Boletas:181]Monto_Exento:30
				Else 
					$r_ImpNeto:=[ACT_Boletas:181]Monto_Afecto:4
				End if 
				  //If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13))  //tipo C
				If (($l_CbteTipo=11) | ($l_CbteTipo=12) | ($l_CbteTipo=13) | ($l_CbteTipo=15))  //tipo C 20150708 RCH
					$r_ImpOpEx:=0
				Else 
					$r_ImpOpEx:=[ACT_Boletas:181]Monto_Exento:30
				End if 
				$r_ImpTrib:=0
				$r_ImpIVA:=[ACT_Boletas:181]Monto_IVA:5
				
				C_DATE:C307($d_fechaMenor;$d_fechaMayor)
				  //READ ONLY([ACT_Transacciones])
				  //READ ONLY([ACT_Cargos])
				  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
				  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
				  //  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item>0) 20160803 ASM Ticket 165973 (Cuando hay nota de crédito con intereses se sacaban los cargos de selección) RECORDAR!!!!!!
				ACTbol_BuscaCargosCargaSet ("Transacciones";[ACT_Boletas:181]ID:1)  //20160914 RCH
				CLEAR SET:C117("Transacciones")
				
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
				$d_fechaMenor:=[ACT_Cargos:173]FechaEmision:22
				LAST RECORD:C200([ACT_Cargos:173])
				$d_fechaMayor:=[ACT_Cargos:173]FechaEmision:22
				$t_FchServDesde:=String:C10(Year of:C25($d_fechaMenor);"0000")+String:C10(Month of:C24($d_fechaMenor);"00")+String:C10(Day of:C23($d_fechaMenor);"00")
				$t_FchServHasta:=String:C10(Year of:C25($d_fechaMayor);"0000")+String:C10(Month of:C24($d_fechaMayor);"00")+String:C10(Day of:C23($d_fechaMayor);"00")
				$t_FchVtoPago:=String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3);"0000")+String:C10(Month of:C24([ACT_Boletas:181]FechaEmision:3);"00")+String:C10(Day of:C23([ACT_Boletas:181]FechaEmision:3);"00")
				$t_MonId:="PES"
				$r_MonCotiz:=1
				
				  //CbtesAsoc
				$l_recNumBol:=Record number:C243([ACT_Boletas:181])
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=[ACT_Boletas:181]ID_DctoAsociado:19)
				$l_Tipo:=Num:C11([ACT_Boletas:181]codigo_SII:33)
				$l_PtoVtaDA:=[ACT_Boletas:181]AR_CodigoPtoVenta:47
				$l_Nro:=[ACT_Boletas:181]Numero:11
				  //CbtesAsoc
				GOTO RECORD:C242([ACT_Boletas:181];$l_recNumBol)
				
				  //tributos
				$l_Id:=0
				$t_Desc:=""
				$r_BaseImpT:=0
				$r_Alic:=0
				$r_ImporteT:=0
				  //tributos
				
				  //IVA
				If ([ACT_Boletas:181]Monto_IVA:5>0)
					$l_IdIVA:=5
					$r_BaseImp:=[ACT_Boletas:181]Monto_Afecto:4
					$r_Importe:=[ACT_Boletas:181]Monto_IVA:5
				Else 
					$l_IdIVA:=0
					$r_BaseImp:=0
					$r_Importe:=0
				End if 
				  //IVA
				
				
				$t_Id:="0"
				$t_Valor:=""
				$r_CUIT:=Num:C11(vtACT_CUIT)
				  //[ACT_Boletas]AR_respuestaWS:=proxy_FECAESolicitar ($t_token;$t_sign;$r_CUIT;$l_CantReg;$l_PtoVta;$l_CbteTipo;$l_Concepto;$l_DocTipo;$r_DocNro;$l_CbteDesde;$l_CbteHasta;$t_CbteFch;$r_ImpTotal;$r_ImpTotConc;$r_ImpNeto;$r_ImpOpEx;$r_ImpTrib;$r_ImpIVA;$t_FchServDesde;$t_FchServHasta;$t_FchVtoPago;$t_MonId;$r_MonCotiz;$l_Tipo;$l_PtoVtaDA;$l_Nro;$l_Id;$t_Desc;$r_BaseImpT;$r_Alic;$r_ImporteT;$l_IdIVA;$r_BaseImp;$r_Importe;$t_Id;$t_Valor)
				[ACT_Boletas:181]AR_RespuestaWS:50:=ACTfear_FECAESolicitar ([ACT_Boletas:181]ID_RazonSocial:25;$l_CantReg;$l_PtoVta;$l_CbteTipo;$l_Concepto;$l_DocTipo;$r_DocNro;$l_CbteDesde;$l_CbteHasta;$t_CbteFch;$r_ImpTotal;$r_ImpTotConc;$r_ImpNeto;$r_ImpOpEx;$r_ImpTrib;$r_ImpIVA;$t_FchServDesde;$t_FchServHasta;$t_FchVtoPago;$t_MonId;$r_MonCotiz;$l_Tipo;$l_PtoVtaDA;$l_Nro;$l_Id;$t_Desc;$r_BaseImpT;$r_Alic;$r_ImporteT;$l_IdIVA;$r_BaseImp;$r_Importe;$t_Id;$t_Valor)
				[ACT_Boletas:181]AR_CAEcodigo:48:=t_ACT_codigoAUT
				[ACT_Boletas:181]AR_CAEvencimiento:49:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12(t_ACT_vencAUT;7;2));Num:C11(Substring:C12(t_ACT_vencAUT;5;2));Num:C11(Substring:C12(t_ACT_vencAUT;1;4)))
				SAVE RECORD:C53([ACT_Boletas:181])
				
				If ([ACT_Boletas:181]AR_CAEcodigo:48#"")  //20150627 RCH
					LOG_RegisterEvt ("Obtención de Código de Autorización Electrónico para documento tributario id: "+String:C10([ACT_Boletas:181]ID:1)+", tipo de documento: "+[ACT_Boletas:181]TipoDocumento:7+", folio: "+String:C10([ACT_Boletas:181]Numero:11)+".")
					$b_done:=True:C214
				Else 
					LOG_RegisterEvt ("Error en la obtención de Código de Autorización Electrónico para documento tributario id: "+String:C10([ACT_Boletas:181]ID:1)+", tipo de documento: "+[ACT_Boletas:181]TipoDocumento:7+", folio: "+String:C10([ACT_Boletas:181]Numero:11)+". Error: "+[ACT_Boletas:181]AR_RespuestaWS:50+".")
					CD_Dlog (0;"Error al obtener el CAE para el documento número: "+String:C10([ACT_Boletas:181]Numero:11)+".")
				End if 
				
			Else 
				$b_done:=True:C214
			End if 
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
		Else 
			$b_done:=False:C215
		End if 
	Else 
		CD_Dlog (0;"El nombre de la máquina no coincide con la estación de trabajo configurada para la emisión de las facturas electrónicas. La estación configurada es: "+ST_Qte (vtACT_workstation)+".")
	End if 
Else 
	CD_Dlog (0;"Error en la configuración de los documentos electrónicos. Error: "+vtACT_errorPHPExec)
End if 

$0:=$b_done