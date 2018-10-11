//%attributes = {}
  //ACTdxt_CalculaDesdeIDAC

C_OBJECT:C1216($ob_objeto;$ob_opciones)
C_BOOLEAN:C305($b_cargosCreados)
C_LONGINT:C283($l_recs;$l_idAC)
C_DATE:C307($d_fecha)
C_OBJECT:C1216($0;$ob_retorno)

$ob_objeto:=$1
$d_fecha:=$2
$l_idAC:=$3

C_LONGINT:C283($l_refItemRXTA;$l_refItemRXTE)
$l_refItemRXTA:=-140
$l_refItemRXTE:=-141

If ((Find in field:C653([xxACT_Items:179]ID:1;$l_refItemRXTA)=-1) | (Find in field:C653([xxACT_Items:179]ID:1;$l_refItemRXTE)=-1))
	ACTcfg_LoadCargosEspeciales (20)  //Lee item y crea si no existe
	ACTcfg_LoadCargosEspeciales (21)  //Lee item y crea si no existe
End if 


$ob_opciones:=OB Get:C1224($ob_objeto;"opciones")
If (OB Get:C1224($ob_opciones;"generar_descuentos")=1)
	$ob_arrays:=OB Get:C1224($ob_objeto;"arreglos")
	
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Cargos:173])
	
	KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$l_idAC)
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-140;*)  //id descuento por tramo afecto
	QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-141)  //id descuento por tramo exento
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	CREATE SET:C116([ACT_Cargos:173];"$cargosAC")
	If ($l_recs=0)  //Solo se continua si no hay cargos de descuento ya generado
		
		
		  //calcula los tramos para el mes de emisión del AC
		If ((Year of:C25($d_fecha)<Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)) | ((Month of:C24($d_fecha)<=Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)) & (Year of:C25($d_fecha)<=Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4))))
			  //If ([ACT_Avisos_de_Cobranza]Fecha_Vencimiento>=$d_fecha)
			$b_todosCargos:=(OB Get:C1224($ob_opciones;"calcular_todos")=1)
			$b_soloCargosAfectos:=(OB Get:C1224($ob_opciones;"calcular_solo_afectos")=1)
			$b_generaDescuentosSeparados:=(OB Get:C1224($ob_opciones;"generar_descuentos_separados")=1)
			
			ARRAY LONGINT:C221($al_desde;0)
			ARRAY LONGINT:C221($al_hasta;0)
			ARRAY BOOLEAN:C223($ab_tipo;0)
			ARRAY REAL:C219($ar_valor;0)
			
			OB GET ARRAY:C1229($ob_arrays;"desde";$al_desde)
			OB GET ARRAY:C1229($ob_arrays;"hasta";$al_hasta)
			OB GET ARRAY:C1229($ob_arrays;"tipo_monto";$ab_tipo)
			OB GET ARRAY:C1229($ob_arrays;"valor";$ar_valor)
			
			If ((Size of array:C274($al_desde)>0) & (AT_GetSumArray (->$ar_valor)>0))
				CREATE EMPTY SET:C140([ACT_Cargos:173];"$cargosACAfectos")
				CREATE EMPTY SET:C140([ACT_Cargos:173];"$cargosACExento")
				
				USE SET:C118("$cargosAC")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Monto_Neto:5>0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
				If (Records in selection:C76([ACT_Cargos:173])>0)
					If ($b_soloCargosAfectos)
						SET FIELD RELATION:C919([ACT_Cargos:173]Ref_Item:16;Automatic:K51:4;Do not modify:K51:1)
						QUERY SELECTION:C341([ACT_Cargos:173];[xxACT_Items:179]Afecto_a_descuentos:4=True:C214)
						SET FIELD RELATION:C919([ACT_Cargos:173]Ref_Item:16;Structure configuration:K51:2;Structure configuration:K51:2)
					End if 
					CREATE SET:C116([ACT_Cargos:173];"$cargosACAfectos")
				End if 
				
				  //considera cargos relacionados
				ARRAY LONGINT:C221($al_idCargos;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idCargos)
				USE SET:C118("$cargosAC")
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idCargos)
				CREATE SET:C116([ACT_Cargos:173];"$cargosRelacionado")
				UNION:C120("$cargosACAfectos";"$cargosRelacionado";"$cargosACAfectos")
				SET_ClearSets ("$cargosRelacionado")
				
				USE SET:C118("$cargosAC")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Monto_Neto:5>0;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
				If (Records in selection:C76([ACT_Cargos:173])>0)
					If ($b_soloCargosAfectos)
						SET FIELD RELATION:C919([ACT_Cargos:173]Ref_Item:16;Automatic:K51:4;Do not modify:K51:1)
						QUERY SELECTION:C341([ACT_Cargos:173];[xxACT_Items:179]Afecto_a_descuentos:4=True:C214)
						SET FIELD RELATION:C919([ACT_Cargos:173]Ref_Item:16;Structure configuration:K51:2;Structure configuration:K51:2)
					End if 
					
					CREATE SET:C116([ACT_Cargos:173];"$cargosACExento")
					
					  //considera cargos relacionados
					ARRAY LONGINT:C221($al_idCargos;0)
					SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idCargos)
					USE SET:C118("$cargosAC")
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idCargos)
					CREATE SET:C116([ACT_Cargos:173];"$cargosRelacionado")
					UNION:C120("$cargosACExento";"$cargosRelacionado";"$cargosACExento")
					SET_ClearSets ("$cargosRelacionado")
					
				End if 
				
				$b_fijo:=False:C215
				$r_valor:=0
				
				$r_montoAfectoDescuento:=0
				$r_montoExentoDescuento:=0
				
				  //si el mes de la fecha del pago es el mes del aviso, valido el tramo.
				  //de lo contrario creo con el primer tramo
				If ((Month of:C24($d_fecha)=Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)) & (Year of:C25($d_fecha)=Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)))
					For ($l_indiceTramo;1;Size of array:C274($ab_tipo))
						If ((Day of:C23($d_fecha)>=$al_desde{$l_indiceTramo}) & (Day of:C23($d_fecha)<=$al_hasta{$l_indiceTramo}))
							$b_fijo:=$ab_tipo{$l_indiceTramo}
							$r_valor:=$ar_valor{$l_indiceTramo}
							$l_indiceTramo:=Size of array:C274($ab_tipo)
						End if 
					End for 
				Else 
					$b_fijo:=$ab_tipo{1}
					$r_valor:=$ar_valor{1}
				End if 
				
				C_OBJECT:C1216($ob_descuentoA;$ob_descuentoE)
				
				If ($r_valor>0)
					Case of 
						: ((Records in set:C195("$cargosACAfectos")=0) & (Records in set:C195("$cargosACExento")=0))
							  //nada
							
						: ((Records in set:C195("$cargosACAfectos")>0) & (Records in set:C195("$cargosACExento")=0))  //solo cargos afectos
							  //genera descuento afecto
							$ob_descuentoA:=ACTdxt_ObtieneMontosDesdeSetCar ("$cargosACAfectos";$b_fijo;$r_valor;$d_fecha;$b_generaDescuentosSeparados;False:C215)
							
							
						: ((Records in set:C195("$cargosACAfectos")=0) & (Records in set:C195("$cargosACExento")>0))  //solo cargos exentos
							  //genera descuento exento
							$ob_descuentoE:=ACTdxt_ObtieneMontosDesdeSetCar ("$cargosACExento";$b_fijo;$r_valor;$d_fecha;$b_generaDescuentosSeparados;False:C215)
							
						: ((Records in set:C195("$cargosACAfectos")>0) & (Records in set:C195("$cargosACExento")>0))  //ambos
							  //genera ambos descuentos
							  //$r_montoAfectoDescuento:=0
							  //$r_montoExentoDescuento:=0
							
							$ob_descuentoA:=ACTdxt_ObtieneMontosDesdeSetCar ("$cargosACAfectos";$b_fijo;$r_valor;$d_fecha;$b_generaDescuentosSeparados;True:C214)
							$ob_descuentoE:=ACTdxt_ObtieneMontosDesdeSetCar ("$cargosACExento";$b_fijo;$r_valor;$d_fecha;$b_generaDescuentosSeparados;True:C214)
							
					End case 
				End if 
				
				ARRAY LONGINT:C221($al_idCtaT;0)
				ARRAY REAL:C219($ar_montoT;0)
				ARRAY LONGINT:C221($al_idCta;0)
				ARRAY REAL:C219($ar_monto;0)
				ARRAY BOOLEAN:C223($ab_exento;0)
				
				If (OB Is defined:C1231($ob_descuentoA;"ids_cuentas"))
					OB GET ARRAY:C1229($ob_descuentoA;"ids_cuentas";$al_idCtaT)
					OB GET ARRAY:C1229($ob_descuentoA;"montos_cuentas";$ar_montoT)
					COPY ARRAY:C226($al_idCtaT;$al_idCta)
					COPY ARRAY:C226($ar_montoT;$ar_monto)
					AT_RedimArrays (Size of array:C274($ar_monto);->$ab_exento)
				End if 
				
				If (OB Is defined:C1231($ob_descuentoE;"ids_cuentas"))
					OB GET ARRAY:C1229($ob_descuentoE;"ids_cuentas";$al_idCtaT)
					OB GET ARRAY:C1229($ob_descuentoE;"montos_cuentas";$ar_montoT)
					For ($i;1;Size of array:C274($al_idCtaT))
						APPEND TO ARRAY:C911($al_idCta;$al_idCtaT{$i})
					End for 
					For ($i;1;Size of array:C274($ar_montoT))
						APPEND TO ARRAY:C911($ar_monto;$ar_montoT{$i})
						APPEND TO ARRAY:C911($ab_exento;True:C214)
					End for 
				End if 
				
				OB SET ARRAY:C1227($ob_retorno;"id_cuenta";$al_idCta)
				OB SET ARRAY:C1227($ob_retorno;"montos";$ar_monto)
				OB SET ARRAY:C1227($ob_retorno;"montos_exentos";$ab_exento)
				
			End if 
		End if 
		
		
	End if 
	SET_ClearSets ("$cargosAC")
	SET_ClearSets ("$cargosACAfectos";"$cargosACExento")
End if 

$0:=$ob_retorno