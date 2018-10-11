//%attributes = {}
  //ACTimp_AnalizeData

C_LONGINT:C283($i;$1)
C_TEXT:C284($monto)

$i:=$1
$tablePtr:=Table:C252(Table:C252(aIDFieldPointers{aIdentificadores}))
$fieldPtr:=aIDFieldPointers{aIdentificadores}
$neg:=Position:C15("-";aMontotxt{$i})
aCargoDescto{$i}:=ST_Boolean2Str (($neg=0);"cargo";"descuento")
If (aPareo{$i}#"")
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145($tablePtr->)
	QUERY:C277($tablePtr->;$fieldPtr->=aPareo{$i})
	
	  //20120528 RCH Se soporta nuevo identificador numero de letra...
	Case of 
		: (KRL_isSameField (->[ACT_Documentos_de_Pago:176]NoSerie:12;$fieldPtr))
			QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8)  //letra
			
	End case 
	
	If (Records in selection:C76($tablePtr->)=1)
		Case of 
			: (Table:C252($tablePtr)=Table:C252(->[Alumnos:2]))
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
				
			: (KRL_isSameField (->[ACT_Documentos_de_Pago:176]NoSerie:12;$fieldPtr))
				READ ONLY:C145([ACT_Pagos:172])
				READ ONLY:C145([ACT_Transacciones:178])
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
				
				  //20120723 RCH Se ordena para asignar el cargo a la cuenta menor...
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>1)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];1)
				End if 
				
		End case 
		aIDCta{$i}:=[ACT_CuentasCorrientes:175]ID:1
		aAprobado{$i}:=True:C214
		
		Case of 
			: (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
				aMotivo{$i}:=__ ("Ninguna Cuenta Corriente fue encontrada.")
				aAprobado{$i}:=False:C215
			: (Records in selection:C76([ACT_CuentasCorrientes:175])>1)
				aMotivo{$i}:=__ ("Fue encontrada más de una Cuenta Corriente para el identificador ingresado.")
				aAprobado{$i}:=False:C215
			: ([ACT_CuentasCorrientes:175]ID_Apoderado:9=0)
				aMotivo{$i}:=__ ("La cuenta corriente no tiene asociado un apoderado de cuentas.")
				aAprobado{$i}:=False:C215
		End case 
		
		If (aAprobado{$i})
			$monto:=aMontotxt{$i}
			$coma:=Position:C15(",";$monto)
			$punto:=Position:C15(".";$monto)
			$vt_moneda:=aMoneda{$i}
			$vr_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
			$vt_formatoDespliegue:=ACTcar_OpcionesGenerales ("retornaFormatoXDecimales";->$vr_decimales)
			Case of 
				: (($coma#0) & ($punto#0))
					aMotivo{$i}:=__ ("El monto no puede contener separador de miles.")
					aAprobado{$i}:=False:C215
				: ($coma#0)
					$monto:=Replace string:C233($monto;",";<>tXS_RS_DecimalSeparator;1)
					$coma:=ST_CharOcurr (",";$monto)
					If ($coma>1)
						aMotivo{$i}:=__ ("El monto no puede contener separador de miles.")
						aAprobado{$i}:=False:C215
					Else 
						aMontotxt{$i}:=String:C10(Round:C94(Num:C11($monto);$vr_decimales);$vt_formatoDespliegue)
						  //If (aMoneda{$i}=<>vsACT_MonedaColegio)
						  //aMontotxt{$i}:=String(Round(Num($monto);<>vlACT_Decimales);"|Despliegue_ACT")
						  //Else 
						  //aMontotxt{$i}:=String(Round(Num($monto);4);"|Despliegue_UF")
						  //End if 
					End if 
				: ($punto#0)
					$monto:=Replace string:C233($monto;".";<>tXS_RS_DecimalSeparator;1)
					$punto:=ST_CharOcurr (".";$monto)
					If ($punto>1)
						aMotivo{$i}:=__ ("El monto no puede contener separador de miles.")
						aAprobado{$i}:=False:C215
					Else 
						aMontotxt{$i}:=String:C10(Round:C94(Num:C11($monto);$vr_decimales);$vt_formatoDespliegue)
						  //If (aMoneda{$i}=<>vsACT_MonedaColegio)
						  //aMontotxt{$i}:=String(Round(Num($monto);<>vlACT_Decimales);"|Despliegue_ACT")
						  //Else 
						  //aMontotxt{$i}:=String(Round(Num($monto);4);"|Despliegue_UF")
						  //End if 
					End if 
			End case 
		End if 
		If (aAprobado{$i})
			aMotivo{$i}:=__ ("El ")+aCargoDescto{$i}+__ (" puede ser importado.")
			If (aIDItem{$i}#"0")
				READ ONLY:C145([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=Num:C11(aIDItem{$i}))
				If (Records in selection:C76([xxACT_Items:179])=0)
					aAprobado{$i}:=False:C215
					aMotivo{$i}:=__ ("No existe ninguna definición de item de cargo con ese ID.")
				Else 
					If (Records in selection:C76([xxACT_Items:179])>1)
						aAprobado{$i}:=False:C215
						aMotivo{$i}:=__ ("Existe más de una definición de item de cargo con ese ID.")
					Else 
						aGlosa{$i}:=[xxACT_Items:179]Glosa:2
						aAfectoaDxCta{$i}:="N/A"
						aAfectoaDesctos{$i}:="N/A"
						aPctInteres{$i}:="N/A"
						aTipoInteres{$i}:="N/A"
						aImpUnica{$i}:="N/A"
						aDesctoH2{$i}:="N/A"
						aDesctoH3{$i}:="N/A"
						aDesctoH4{$i}:="N/A"
						aDesctoH5{$i}:="N/A"
						aDesctoH6{$i}:="N/A"
						aDesctoH7{$i}:="N/A"
						aDesctoH8{$i}:="N/A"
						aDesctoH9{$i}:="N/A"
						aDesctoH10{$i}:="N/A"
						aDesctoH11{$i}:="N/A"
						aDesctoH12{$i}:="N/A"
						aDesctoH13{$i}:="N/A"
						aDesctoH14{$i}:="N/A"
						aDesctoH15{$i}:="N/A"
						aDesctoH16{$i}:="N/A"
						aDesctoH17{$i}:="N/A"
						  //para el codigo de barra  JVP 20160222
						aCodigo_interno{$i}:=[xxACT_Items:179]Codigo_interno:48
						aBloqueadas{$i}:=True:C214
						aMotivo{$i}:=aMotivo{$i}+__ ("Los valores para cargos nuevos no aplican ya que el item existe en el sistema.")
					End if 
				End if 
			Else 
				If (aGlosa{$i}="")
					aAprobado{$i}:=False:C215
					aMotivo{$i}:=__ ("No se ha indicado una glosa para el ")+aCargoDescto{$i}+__ (" o un ID de item de cargo.")
				Else 
					READ ONLY:C145([xxACT_Items:179])
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Glosa:2=aGlosa{$i})
					If (Records in selection:C76([xxACT_Items:179])=1)
						aIDItem{$i}:=String:C10([xxACT_Items:179]ID:1)
						aAfectoaDxCta{$i}:="N/A"
						aAfectoaDesctos{$i}:="N/A"
						aPctInteres{$i}:="N/A"
						aTipoInteres{$i}:="N/A"
						aImpUnica{$i}:="N/A"
						aDesctoH2{$i}:="N/A"
						aDesctoH3{$i}:="N/A"
						aDesctoH4{$i}:="N/A"
						aDesctoH5{$i}:="N/A"
						aDesctoH6{$i}:="N/A"
						aDesctoH7{$i}:="N/A"
						aDesctoH8{$i}:="N/A"
						aDesctoH9{$i}:="N/A"
						aDesctoH10{$i}:="N/A"
						aDesctoH11{$i}:="N/A"
						aDesctoH12{$i}:="N/A"
						aDesctoH13{$i}:="N/A"
						aDesctoH14{$i}:="N/A"
						aDesctoH15{$i}:="N/A"
						aDesctoH16{$i}:="N/A"
						aDesctoH17{$i}:="N/A"
						  //para el codigo de barra  JVP 20160222
						aCodigo_interno{$i}:=[xxACT_Items:179]Codigo_interno:48
						aBloqueadas{$i}:=True:C214
						aMotivo{$i}:=aMotivo{$i}+__ ("Los valores para cargos nuevos no aplican ya que el item existe en el sistema.")
					Else 
						If (Records in selection:C76([xxACT_Items:179])=0)
							aPctInteres{$i}:=ACTimp_CheckPercentages (aPctInteres{$i};__ ("porcentaje de interés"))
							aDesctoH2{$i}:=ACTimp_CheckPercentages (aDesctoH2{$i};__ ("porcentaje de descuento por hijo 2"))
							aDesctoH3{$i}:=ACTimp_CheckPercentages (aDesctoH3{$i};__ ("porcentaje de descuento por hijo 3"))
							aDesctoH4{$i}:=ACTimp_CheckPercentages (aDesctoH4{$i};__ ("porcentaje de descuento por hijo 4"))
							aDesctoH5{$i}:=ACTimp_CheckPercentages (aDesctoH5{$i};__ ("porcentaje de descuento por hijo 5"))
							aDesctoH6{$i}:=ACTimp_CheckPercentages (aDesctoH6{$i};__ ("porcentaje de descuento por hijo 6"))
							aDesctoH7{$i}:=ACTimp_CheckPercentages (aDesctoH7{$i};__ ("porcentaje de descuento por hijo 7"))
							aDesctoH8{$i}:=ACTimp_CheckPercentages (aDesctoH8{$i};__ ("porcentaje de descuento por hijo 8"))
							aDesctoH9{$i}:=ACTimp_CheckPercentages (aDesctoH9{$i};__ ("porcentaje de descuento por hijo 9"))
							aDesctoH10{$i}:=ACTimp_CheckPercentages (aDesctoH10{$i};__ ("porcentaje de descuento por hijo 10"))
							aDesctoH11{$i}:=ACTimp_CheckPercentages (aDesctoH11{$i};__ ("porcentaje de descuento por hijo 11"))
							aDesctoH12{$i}:=ACTimp_CheckPercentages (aDesctoH12{$i};__ ("porcentaje de descuento por hijo 12"))
							aDesctoH13{$i}:=ACTimp_CheckPercentages (aDesctoH13{$i};__ ("porcentaje de descuento por hijo 13"))
							aDesctoH14{$i}:=ACTimp_CheckPercentages (aDesctoH14{$i};__ ("porcentaje de descuento por hijo 14"))
							aDesctoH15{$i}:=ACTimp_CheckPercentages (aDesctoH15{$i};__ ("porcentaje de descuento por hijo 15"))
							aDesctoH16{$i}:=ACTimp_CheckPercentages (aDesctoH16{$i};__ ("porcentaje de descuento por hijo 16"))
							aDesctoH17{$i}:=ACTimp_CheckPercentages (aDesctoH17{$i};__ ("porcentaje de descuento por hijo 17"))
						Else 
							aAprobado{$i}:=False:C215
							aMotivo{$i}:=__ ("Existe más de un item de cargo con esa glosa.")
						End if 
					End if 
				End if 
			End if 
			If (aAprobado{$i})
				If (Find in array:C230(atACT_NombreMoneda;aMoneda{$i})>0)
					aMontotxt{$i}:=String:C10(Round:C94(Num:C11($monto);$vr_decimales);$vt_formatoDespliegue)
					  //If (aMoneda{$i}=<>vsACT_MonedaColegio)
					  //aMontotxt{$i}:=String(Round(Num($monto);<>vlACT_Decimales);"|Despliegue_ACT")
					  //Else 
					  //aMontotxt{$i}:=String(Round(Num($monto);4);"|Despliegue_UF")
					  //End if 
				Else 
					aMoneda{$i}:=<>vsACT_MonedaColegio
					  //aMontotxt{$i}:=String(Round(Num($monto);<>vlACT_Decimales);"|Despliegue_ACT")
					aMontotxt{$i}:=String:C10(Round:C94(Num:C11($monto);$vr_decimales);$vt_formatoDespliegue)
				End if 
				If ((Num:C11(aMesDesde{$i})>=1) & (Num:C11(aMesDesde{$i})<=12))
					If (Length:C16(aAño{$i})=4)
						If ((Num:C11(aMesHasta{$i})>=1) & (Num:C11(aMesHasta{$i})<=12))
							If (Length:C16(aAño2{$i})=4)
								$fechaIni:=DT_GetDateFromDayMonthYear (1;Num:C11(aMesDesde{$i});Num:C11(aAño{$i}))
								$fechaFin:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Num:C11(aMesHasta{$i});Num:C11(aAño2{$i}));Num:C11(aMesHasta{$i});Num:C11(aAño2{$i}))
								If ($fechaIni<$fechaFin)
									If (aCargoDescto{$i}="Descuento")
										If (aAfectoIVA{$i}="SI")
											QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
											QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
											QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21#0;*)
											QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
											CREATE SET:C116([ACT_Cargos:173];"Cargos")
											$fromMonth:=Num:C11(aMesDesde{$i})
											$toMonth:=Num:C11(aMesHasta{$i})
											$year:=Num:C11(aAño{$i})
											$year2:=Num:C11(aAño2{$i})
											If ($year#$year2)
												$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
											Else 
												$toMonth:=$toMonth-$fromMonth+1
											End if 
											$indexPrev:=0
											For ($j;1;$toMonth)  //Loop por los meses a generar
												If (Int:C8(($j+$fromMonth+$indexPrev-1)/13)>$indexPrev)
													$indexPrev:=Int:C8(($j+$fromMonth+$indexPrev-1)/13)
													$month:=$j-(12*$indexPrev)+$fromMonth-1
													$year:=$year+1
												Else 
													$month:=$j-(12*$indexPrev)+$fromMonth-1
												End if 
												USE SET:C118("Cargos")
												QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$month;*)
												QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
												$montoAfecto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
												  //164299 JVP 05072016
												$montoAfecto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
												$r_monto:=Num:C11(aMontotxt{$i})
												$r_monto:=_ACT_monto_a_pesos ($r_monto;aMoneda{$i};Current date:C33(*))
												
												  //If ($montoAfecto<Num(aMontotxt{$i}))
												If ($montoAfecto<$r_monto)
													aMotivo{$i}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")
													aAprobado{$i}:=False:C215
													$j:=$toMonth+1
												End if 
											End for 
											CLEAR SET:C117("Cargos")
										Else 
											aAfectoIVA{$i}:="NO"
											QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
											QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
											QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21=0;*)
											QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
											CREATE SET:C116([ACT_Cargos:173];"Cargos")
											$fromMonth:=Num:C11(aMesDesde{$i})
											$toMonth:=Num:C11(aMesHasta{$i})
											$year:=Num:C11(aAño{$i})
											$year2:=Num:C11(aAño2{$i})
											If ($year#$year2)
												$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
											Else 
												$toMonth:=$toMonth-$fromMonth+1
											End if 
											$indexPrev:=0
											For ($j;1;$toMonth)  //Loop por los meses a generar
												If (Int:C8(($j+$fromMonth+$indexPrev-1)/13)>$indexPrev)
													$indexPrev:=Int:C8(($j+$fromMonth+$indexPrev-1)/13)
													$month:=$j-(12*$indexPrev)+$fromMonth-1
													$year:=$year+1
												Else 
													$month:=$j-(12*$indexPrev)+$fromMonth-1
												End if 
												USE SET:C118("Cargos")
												QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$j;*)
												QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=Num:C11(aAño{$i}))
												$montoExento:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
												$montoExento:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
												$r_monto:=Num:C11(aMontotxt{$i})
												$r_monto:=_ACT_monto_a_pesos ($r_monto;aMoneda{$i};Current date:C33(*))
												  //If ($montoExento<Num(aMontotxt{$i}))
												If ($montoExento<$r_monto)
													aMotivo{$i}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuent"+"o es superior a los montos cargados.")
													aAprobado{$i}:=False:C215
													$j:=$toMonth+1
												End if 
											End for 
											CLEAR SET:C117("Cargos")
										End if 
									End if 
								Else 
									aMotivo{$i}:=__ ("El rango de fechas de generación del ")+aCargoDescto{$i}+__ (" no parece ser correcto.")
									aAprobado{$i}:=False:C215
								End if 
							Else 
								aMotivo{$i}:=__ ("El año final de generación del ")+aCargoDescto{$i}+__ (" no parece ser correcto (AAAA).")
								aAprobado{$i}:=False:C215
							End if 
						Else 
							aMotivo{$i}:=__ ("El mes final de generación del ")+aCargoDescto{$i}+__ (" no está dentro del rango válido (1 a 12).")
							aAprobado{$i}:=False:C215
						End if 
					Else 
						aMotivo{$i}:=__ ("El año inicial de generación del ")+aCargoDescto{$i}+__ (" no parece ser correcto (AAAA).")
						aAprobado{$i}:=False:C215
					End if 
				Else 
					aMotivo{$i}:=__ ("El mes inicial de generación del ")+aCargoDescto{$i}+__ (" no está dentro del rango válido (1 a 12).")
					aAprobado{$i}:=False:C215
				End if 
			End if 
		End if 
		
		
		  //ASM 20150303 Para validar los cargos que no son descuentos y van con saldo negativo.
		If (aAprobado{$i})
			QUERY:C277($tablePtr->;$fieldPtr->=aPareo{$i})
			  //Genero ciclo para los meses
			$l_mesDesde:=Num:C11(aMesDesde{$i})
			$l_mesHasta:=Num:C11(aMesHasta{$i})
			$l_agnoDesde:=Num:C11(aAño{$i})
			$l_agnoHasta:=Num:C11(aAño2{$i})
			$r_monto:=Num:C11(aMontotxt{$i})
			  //164299 JVP 05072016
			  //cambio moneda siempre se maneja peso chileno para la validacion de ingreso
			$r_monto:=_ACT_monto_a_pesos ($r_monto;aMoneda{$i};Current date:C33(*))
			
			If ((Length:C16(aAño{$i})=4) & (Length:C16(aAño2{$i})=4))
				If (($l_mesDesde>=1) & ($l_mesDesde<=12) & ($l_mesHasta>=1) & ($l_mesHasta<=12))
					For ($l_contadorMeses;$l_mesDesde;$l_mesHasta)
						For ($l_contadorAgno;$l_agnoDesde;$l_agnoHasta)
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$l_contadorMeses;*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$l_contadorAgno)
							  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision#!00/00/0000!)
							$montoAfecto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
							$montoAfecto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							  //comento esta linea 164299 JVP
							  //siempre se hace la comparacion en pesos
							  //$montoAfecto:=Round(ACTut_retornaMontoEnMoneda ($montoAfecto;ST_GetWord (ACT_DivisaPais ;1;";");Current date(*);[xxACT_Items]Moneda);4)
							If ($r_monto<0)
								$r_montoTotal:=$montoAfecto-Abs:C99($r_monto)
								If ($r_montoTotal<0)
									aAprobado{$i}:=False:C215
									aMotivo{$i}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")
									$l_contadorAgno:=$l_agnoHasta+1
									$l_contadorMeses:=$l_mesHasta+1
								End if 
							End if 
						End for 
					End for 
				Else 
					aMotivo{$i}:=__ ("El mes final de generación del ")+aCargoDescto{$i}+__ (" no está dentro del rango válido (1 a 12).")
					aAprobado{$i}:=False:C215
				End if 
			Else 
				aMotivo{$i}:=__ ("El año inicial de generación del ")+aCargoDescto{$i}+__ (" no parece ser correcto (AAAA).")
				aAprobado{$i}:=False:C215
			End if 
		End if 
		
		
	Else 
		If (Records in selection:C76($tablePtr->)=0)
			  //aMotivo{$i}:=__ ("No se ha encontrado la cuenta corriente.")
			aMotivo{$i}:=__ ("No se ha encontrado ni un registro para el identificador ")+ST_Qte (aIdentificadores{aIdentificadores})+__ (", para el valor ")+aPareo{$i}+"."
		Else 
			  //aMotivo{$i}:=__ ("Se ha encontrado más de una cuenta corriente.")
			aMotivo{$i}:=__ ("Se ha encontrado más de un registro para el identificador ")+ST_Qte (aIdentificadores{aIdentificadores})+__ (" para el valor ")+aPareo{$i}+"."
		End if 
		aAprobado{$i}:=False:C215
	End if 
Else 
	aMotivo{$i}:=__ ("No se ha indicado un identificador para la cuenta corriente.")
	aAprobado{$i}:=False:C215
End if 