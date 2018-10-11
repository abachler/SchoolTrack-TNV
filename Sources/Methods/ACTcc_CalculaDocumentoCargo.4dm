//%attributes = {}
  //ACTcc_CalculaDocumentoCargo

  //20080509 RCH Se considera el descuento máximo en los descuentos relativos

C_LONGINT:C283($1;$recNumDocumentoCargo)
C_REAL:C285($0;$vr_descuento;$vr_descuentoMaximo)

ACTutl_GetDecimalFormat   //20110411 RCH Para validar la variable con los decimales

Case of 
	: (Count parameters:C259=2)
		$vd_fecha:=$2
	Else 
		$vd_fecha:=Current date:C33(*)
End case 

  //Variables totalizadoras

$MontoIVA:=0
$MontoTotal:=0  //En este momento [ACT_Documentos_de_Cargo]Monto_Total esta totalizando los montos afectos a descuentos. ¿Esta bien eso?
$Descuentos:=0
$DescuentosMoneda:=0
$Recargos:=0
$RecargosMoneda:=0
$MontoNeto:=0
$MontoAfecto:=0
$Saldo:=0
$Pagos:=0
$PorcentajeRecargo:=0
$PorcentajeDescuento:=0

$recNumDocumentoCargo:=$1
If ((Record number:C243([ACT_Documentos_de_Cargo:174])#$recNumDocumentoCargo) | (Read only state:C362([ACT_Documentos_de_Cargo:174])))
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$recNumDocumentoCargo)
End if 

If ([ACT_Documentos_de_Cargo:174]ID_Matriz:2>-1)
	QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=[ACT_Documentos_de_Cargo:174]ID_Matriz:2)
Else 
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
End if 
[ACT_Documentos_de_Cargo:174]Moneda:23:=ST_GetWord (ACT_DivisaPais ;1;";")
SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
READ WRITE:C146([ACT_Cargos:173])  //Permito lectura y escritura de cargos porque voy a modificarlos con los nuevos montos calculados aqui

  //Busco todos los cargos correspondientes al documento

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
  //QUERY([ACT_Cargos];[ACT_Cargos]FechaEmision=!00/00/00!)

If (Records in selection:C76([ACT_Cargos:173])>0)
	CREATE SET:C116([ACT_Cargos:173];"TodoslosCargos")
	
	  //Busco todos los cargos afectos a descuentos y no a IVA
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Afecto_a_Descuentos:19=True:C214;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]TasaIVA:21=0;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	$setAfectosDsctos:="AfectosDsctos"
	CREATE SET:C116([ACT_Cargos:173];$setAfectosDsctos)
	$Pagos:=$Pagos+Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
	$MontoTotal:=$MontoTotal+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosDsctos;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
	$Saldo:=$Saldo+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosDsctos;->[ACT_Cargos:173]Saldo:23;$vd_fecha)
	  //Busco los cargos Relativos
	USE SET:C118("TodoslosCargos")
	
	ARRAY REAL:C219($alACT_DctoRelativo;0)
	ARRAY REAL:C219($alACT_CargoRelativo;0)
	ARRAY LONGINT:C221($al_recNumDctoRelativo;0)
	ARRAY LONGINT:C221($al_recNumDctoRelativo2;0)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=True:C214)
	If (Records in selection:C76([ACT_Cargos:173])>0)
		CREATE SET:C116([ACT_Cargos:173];"Relativos")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_relativo:6;aReal1;[ACT_Cargos:173];$al_recNumDctoRelativo2)
		For ($i;1;Size of array:C274(aReal1))
			Case of 
				: (aReal1{$i}>0)
					If (cbCrearDctosEnLineasSeparadas=1)
						APPEND TO ARRAY:C911($alACT_CargoRelativo;aReal1{$i})
						APPEND TO ARRAY:C911($alACT_DctoRelativo;0)
						APPEND TO ARRAY:C911($al_recNumDctoRelativo;$al_recNumDctoRelativo2{$i})
					End if 
					$PorcentajeRecargo:=$PorcentajeRecargo+aReal1{$i}
				: (aReal1{$i}<0)
					If (cbCrearDctosEnLineasSeparadas=1)
						APPEND TO ARRAY:C911($alACT_CargoRelativo;0)
						APPEND TO ARRAY:C911($alACT_DctoRelativo;aReal1{$i})
						APPEND TO ARRAY:C911($al_recNumDctoRelativo;$al_recNumDctoRelativo2{$i})
					End if 
					$PorcentajeDescuento:=$PorcentajeDescuento+aReal1{$i}
			End case 
		End for 
		If ($PorcentajeRecargo>100)
			  //ubicar aqui el maximo porcenta(de momento puede ser más de 100%)
		End if 
		If (Abs:C99($PorcentajeDescuento)>100)
			$PorcentajeDescuento:=-100
		End if 
		If (cbCrearDctosEnLineasSeparadas=0)
			APPEND TO ARRAY:C911($alACT_DctoRelativo;$PorcentajeDescuento)
			APPEND TO ARRAY:C911($alACT_CargoRelativo;$PorcentajeRecargo)
		End if 
		AT_Initialize (->aReal1)
	End if 
	
	  //Busco los cargos que no estan afectos a IVA ni a descuentos 
	USE SET:C118("TodoslosCargos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Afecto_a_Descuentos:19=False:C215;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	$setAfectosNada:="AfectosNada"
	CREATE SET:C116([ACT_Cargos:173];$setAfectosNada)
	$Pagos:=$Pagos+Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
	$Saldo:=$Saldo+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosNada;->[ACT_Cargos:173]Saldo:23;$vd_fecha)
	
	  //Busco los cargos afectos a IVA pero no a descuentos
	USE SET:C118("TodoslosCargos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Afecto_a_Descuentos:19=False:C215;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	$setAfectosIVA:="AfectosIVA"
	CREATE SET:C116([ACT_Cargos:173];$setAfectosIVA)
	  //$Pagos:=$Pagos+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosIVA;->[ACT_Cargos]MontosPagados;$vd_fecha)
	$Pagos:=$Pagos+Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
	$Saldo:=$Saldo+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosIVA;->[ACT_Cargos:173]Saldo:23;$vd_fecha)
	
	USE SET:C118("TodoslosCargos")
	
	  //Busco los cargos afectos a descuentos e IVA
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Afecto_a_Descuentos:19=True:C214;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
	$setIVAyDsctos:="IVAyDsctos"
	CREATE SET:C116([ACT_Cargos:173];$setIVAyDsctos)
	  //$MontoTotal:=$MontoTotal+Sum([ACT_Cargos]Monto_Neto)
	$Pagos:=$Pagos+Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
	$MontoTotal:=$MontoTotal+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setIVAyDsctos;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
	$Saldo:=$Saldo+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setIVAyDsctos;->[ACT_Cargos:173]Saldo:23;$vd_fecha)
	
	  //Calculo para cargos afectos a IVA
	
	USE SET:C118($setAfectosIVA)
	If (Records in set:C195($setAfectosIVA)>0)
		$MontoNeto:=$MontoNeto+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosIVA;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
		$MontoIVA:=$MontoIVA+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosIVA;->[ACT_Cargos:173]Monto_IVA:20;$vd_fecha)
		$MontoAfecto:=$MontoAfecto+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosIVA;->[ACT_Cargos:173]Monto_Afecto:27;$vd_fecha)
	End if 
	CLEAR SET:C117($setAfectosIVA)
	
	  //Calculo para cargos no afectos a nada
	
	USE SET:C118($setAfectosNada)
	If (Records in set:C195($setAfectosNada)>0)
		$MontoNeto:=$MontoNeto+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosNada;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
	End if 
	CLEAR SET:C117($setAfectosNada)
	
	  //Calculo para cargos afectos a descuentos
	If (($PorcentajeDescuento<0) | ($PorcentajeRecargo>0))
		If (Records in set:C195($setAfectosDsctos)>0)
			  //eliminamos los descuentos en lineas separadas para los cargos relativos
			READ WRITE:C146([ACT_Cargos:173])
			USE SET:C118($setAfectosDsctos)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-134;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-135)
			DELETE SELECTION:C66([ACT_Cargos:173])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			ARRAY REAL:C219($arACT_MontosDctosRelF;0)
			ARRAY LONGINT:C221($alACT_recNumsCargosF;0)
			For ($j;1;Size of array:C274($alACT_DctoRelativo))
				USE SET:C118($setAfectosDsctos)
				$PorcentajeDescuento:=$alACT_DctoRelativo{$j}
				$PorcentajeRecargo:=$alACT_CargoRelativo{$j}
				
				ARRAY LONGINT:C221($alACT_recNumCargoDcto;0)
				ARRAY REAL:C219($arACT_MontoDcto;0)
				ARRAY REAL:C219(aReal3;0)
				
				ARRAY TEXT:C222($at_monedasCargos;0)
				ARRAY BOOLEAN:C223($ab_emitidoEnMoneda;0)
				ARRAY LONGINT:C221($alACT_recNumCargo;0)
				ARRAY LONGINT:C221($al_dctoAplicado;0)
				READ WRITE:C146([ACT_Cargos:173])
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-134;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-135)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Neto:5;aReal1;[ACT_Cargos:173]Total_Desctos:45;aReal3;[ACT_Cargos:173]Moneda:28;$at_monedasCargos;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;$ab_emitidoEnMoneda;[ACT_Cargos:173];$alACT_recNumCargo;[ACT_Cargos:173]PctDescuentoAplicado:58;$al_dctoAplicado)
				
				  //20110416 RCH El descuento porcentual se calculaba sobre el total de la deuda, no considerando los descuentos que podian estar separados...
				If ((cbCrearDctosEnLineasSeparadas=1) & (cbUsarDescuentosXSeparado=1))
					For ($i;1;Size of array:C274($alACT_recNumCargo))
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargo{$i})
						$vl_idCargo:=[ACT_Cargos:173]ID:1
						$vt_moneda:=ST_Boolean2Str ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
						$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-130;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-131;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-131;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-133)
						aReal1{$i}:=Round:C94(aReal1{$i}+Sum:C1([ACT_Cargos:173]Monto_Neto:5);$vl_decimales)
					End for 
				End if 
				
				ARRAY REAL:C219(arConDscto;Size of array:C274(aReal1))
				For ($i;1;Size of array:C274(aReal1))
					If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
						$vr_descuento:=0
						$vr_descuentoMaximo:=vr_descuentoMaximo
						If ($al_dctoAplicado{$i}=0)
							$vr_descuento:=Round:C94((aReal3{$i}*100/(aReal1{$i}+aReal3{$i}));<>vlACT_Decimales)
							$al_dctoAplicado{$i}:=$vr_descuento
						Else 
							$vr_descuento:=$al_dctoAplicado{$i}
						End if 
						$vr_descuentoMaximo:=$vr_descuentoMaximo-$vr_descuento
						If ($vr_descuentoMaximo<0)
							$vr_descuentoMaximo:=0
						End if 
						If ($vr_descuentoMaximo-Abs:C99($PorcentajeDescuento)<=0)
							$PorcentajeDescuento:=$vr_descuentoMaximo*-1
						End if 
						If (aReal3{$i}>0)
							$al_dctoAplicado{$i}:=$al_dctoAplicado{$i}+Abs:C99($PorcentajeDescuento)
						End if 
					End if 
					If ($ab_emitidoEnMoneda{$i})
						$vt_moneda:=$at_monedasCargos{$i}
					Else 
						$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
					End if 
					$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
					  //$descuentos:=$descuentos+ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					  //$recargos:=$recargos+ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					
					  //$descuentos:=ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					  //$recargos:=ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					
					$descuentos:=Round:C94(aReal1{$i}*$PorcentajeDescuento/100;4)
					$recargos:=Round:C94(aReal1{$i}*$PorcentajeRecargo/100;4)
					
					If (cbCrearDctosEnLineasSeparadas=0)
						arConDscto{$i}:=aReal1{$i}+Round:C94(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales)+Round:C94(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales)
					Else 
						If ($descuentos#0)
							APPEND TO ARRAY:C911($alACT_recNumCargoDcto;$alACT_recNumCargo{$i})
							APPEND TO ARRAY:C911($arACT_MontoDcto;$descuentos)
						End if 
						If ($recargos#0)
							APPEND TO ARRAY:C911($alACT_recNumCargoDcto;$alACT_recNumCargo{$i})
							APPEND TO ARRAY:C911($arACT_MontoDcto;$recargos)
						End if 
					End if 
					
					$descuentos:=ACTut_retornaMontoEnMoneda (Round:C94(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					$recargos:=ACTut_retornaMontoEnMoneda (Round:C94(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					
				End for 
				If (cbCrearDctosEnLineasSeparadas=0)
					ARRAY TO SELECTION:C261(arConDscto;[ACT_Cargos:173]Monto_Neto:5)
				Else 
					  //ARRAY TO SELECTION($al_dctoAplicado;[ACT_Cargos]PctDescuentoAplicado)//20150224 RCH Estaba generando cargos sin datos. Ticket 141203
					For ($i;1;Size of array:C274($alACT_recNumCargoDcto))
						READ ONLY:C145([ACT_Cargos:173])
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargoDcto{$i})
						If ([ACT_Cargos:173]Monto_Neto:5<0)
							$el:=Find in array:C230($alACT_recNumsCargosF;$alACT_recNumCargoDcto{$i})
							If ($el=-1)
								APPEND TO ARRAY:C911($arACT_MontosDctosRelF;$arACT_MontoDcto{$i})
								APPEND TO ARRAY:C911($alACT_recNumsCargosF;$alACT_recNumCargoDcto{$i})
							Else 
								$arACT_MontosDctosRelF{$el}:=$arACT_MontosDctosRelF{$el}+$arACT_MontoDcto{$i}
							End if 
						Else 
							If ($arACT_MontoDcto{$i}<0)
								$vl_tipoItem:=14
							Else 
								$vl_tipoItem:=15
							End if 
							
							GOTO RECORD:C242([ACT_Cargos:173];$al_recNumDctoRelativo{$j})
							$vt_glosa:=[ACT_Cargos:173]Glosa:12
							ACTcc_DuplicaCargoDcto ($vl_tipoItem;$alACT_recNumCargoDcto{$i};$arACT_MontoDcto{$i};True:C214;$vt_glosa)
						End if 
					End for 
				End if 
				AT_Initialize (->aReal1;->arConDscto)
				AT_Initialize (->aReal3)
			End for 
			
			For ($i;1;Size of array:C274($alACT_recNumsCargosF))
				READ ONLY:C145([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumsCargosF{$i})
				If ([ACT_Cargos:173]Monto_Neto:5<0)
					KRL_ReloadInReadWriteMode (->[ACT_Cargos:173])
					[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5+$arACT_MontosDctosRelF{$i}
					SAVE RECORD:C53([ACT_Cargos:173])
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
				End if 
			End for 
			
			$MontoNeto:=$MontoNeto+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setAfectosDsctos;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			
		End if 
	End if 
	  //End if 
	CLEAR SET:C117($setAfectosDsctos)
	
	  //Calculo para cargos afectos a descuentos o recargos ademas de afectos a IVA
	If (($PorcentajeDescuento<0) | ($PorcentajeRecargo>0))
		If (Records in set:C195($setIVAyDsctos)>0)
			
			  //eliminamos los descuentos en lineas separadas para los cargos relativos
			READ WRITE:C146([ACT_Cargos:173])
			USE SET:C118($setIVAyDsctos)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-134;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-135)
			DELETE SELECTION:C66([ACT_Cargos:173])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			ARRAY REAL:C219($arACT_MontosDctosRelF;0)
			ARRAY LONGINT:C221($alACT_recNumsCargosF;0)
			For ($j;1;Size of array:C274($alACT_DctoRelativo))
				USE SET:C118($setIVAyDsctos)
				$PorcentajeDescuento:=$alACT_DctoRelativo{$j}
				$PorcentajeRecargo:=$alACT_CargoRelativo{$j}
				ARRAY LONGINT:C221($alACT_recNumCargoDcto;0)
				ARRAY REAL:C219($arACT_MontoDcto;0)
				
				ARRAY REAL:C219(aReal3;0)
				
				ARRAY TEXT:C222($at_monedasCargos;0)
				ARRAY BOOLEAN:C223($ab_emitidoEnMoneda;0)
				ARRAY LONGINT:C221($alACT_recNumCargo;0)
				ARRAY LONGINT:C221($al_dctoAplicado;0)
				READ WRITE:C146([ACT_Cargos:173])
				  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]FechaEmision=!00-00-00!)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-134;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-135)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Neto:5;aReal1;[ACT_Cargos:173]Total_Desctos:45;aReal3;[ACT_Cargos:173]Moneda:28;$at_monedasCargos;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;$ab_emitidoEnMoneda;[ACT_Cargos:173];$alACT_recNumCargo;[ACT_Cargos:173]PctDescuentoAplicado:58;$al_dctoAplicado)
				
				  //20110416 RCH El descuento porcentual se calculaba sobre el total de la deuda, no considerando los descuentos que podian estar separados...
				If ((cbCrearDctosEnLineasSeparadas=1) & (cbUsarDescuentosXSeparado=1))
					For ($i;1;Size of array:C274($alACT_recNumCargo))
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargo{$i})
						$vl_idCargo:=[ACT_Cargos:173]ID:1
						$vt_moneda:=ST_Boolean2Str ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
						$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargo)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-130;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-131;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-131;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-133)
						aReal1{$i}:=Round:C94(aReal1{$i}+Sum:C1([ACT_Cargos:173]Monto_Neto:5);$vl_decimales)
					End for 
				End if 
				
				ARRAY REAL:C219(arConDscto;Size of array:C274(aReal1))
				ARRAY REAL:C219(arConDsctoIVA;Size of array:C274(aReal1))
				ARRAY REAL:C219(arConDsctoAfecto;Size of array:C274(aReal1))
				For ($i;1;Size of array:C274(aReal1))
					If ((cbConsiderarDctoMaximo=1) & (vr_descuentoMaximo#0) & Not:C34([ACT_CuentasCorrientes:175]NoAplicaMaxDcto:30))
						$vr_descuento:=0
						$vr_descuentoMaximo:=vr_descuentoMaximo
						If ($al_dctoAplicado{$i}=0)
							$vr_descuento:=Round:C94((aReal3{$i}*100/(aReal1{$i}+aReal3{$i}));<>vlACT_Decimales)
							$al_dctoAplicado{$i}:=$vr_descuento
						Else 
							$vr_descuento:=$al_dctoAplicado{$i}
						End if 
						$vr_descuentoMaximo:=$vr_descuentoMaximo-$vr_descuento
						If ($vr_descuentoMaximo<0)
							$vr_descuentoMaximo:=0
						End if 
						If ($vr_descuentoMaximo-Abs:C99($PorcentajeDescuento)<=0)
							$PorcentajeDescuento:=$vr_descuentoMaximo*-1
						End if 
						If (aReal3{$i}>0)
							$al_dctoAplicado{$i}:=$al_dctoAplicado{$i}+Abs:C99($PorcentajeDescuento)
						End if 
					End if 
					If ($ab_emitidoEnMoneda{$i})
						$vt_moneda:=$at_monedasCargos{$i}
					Else 
						$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
					End if 
					$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
					
					  //$descuentos:=$descuentos+ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					  //$recargos:=$recargos+ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					
					  //$descuentos:=ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					  //$recargos:=ACTut_retornaMontoEnMoneda (Round(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					
					$descuentos:=Round:C94(aReal1{$i}*$PorcentajeDescuento/100;4)
					$recargos:=Round:C94(aReal1{$i}*$PorcentajeRecargo/100;4)
					
					If (cbCrearDctosEnLineasSeparadas=0)
						arConDscto{$i}:=aReal1{$i}+Round:C94(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales)+Round:C94(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales)
						arConDsctoAfecto{$i}:=Round:C94(arConDscto{$i}/<>vrACT_FactorIVA;$vl_decimales)
						arConDsctoIVA{$i}:=arConDscto{$i}-arConDsctoAfecto{$i}
					Else 
						If ($descuentos#0)
							APPEND TO ARRAY:C911($alACT_recNumCargoDcto;$alACT_recNumCargo{$i})
							APPEND TO ARRAY:C911($arACT_MontoDcto;$descuentos)
						End if 
						If ($recargos#0)
							APPEND TO ARRAY:C911($alACT_recNumCargoDcto;$alACT_recNumCargo{$i})
							APPEND TO ARRAY:C911($arACT_MontoDcto;$recargos)
						End if 
					End if 
					
					$descuentos:=ACTut_retornaMontoEnMoneda (Round:C94(aReal1{$i}*$PorcentajeDescuento/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					$recargos:=ACTut_retornaMontoEnMoneda (Round:C94(aReal1{$i}*$PorcentajeRecargo/100;$vl_decimales);$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
					
				End for 
				
				If (cbCrearDctosEnLineasSeparadas=0)
					ARRAY TO SELECTION:C261(arConDscto;[ACT_Cargos:173]Monto_Neto:5;arConDsctoAfecto;[ACT_Cargos:173]Monto_Afecto:27;arConDsctoIVA;[ACT_Cargos:173]Monto_IVA:20;$al_dctoAplicado;[ACT_Cargos:173]PctDescuentoAplicado:58)
				Else 
					  //ARRAY TO SELECTION($al_dctoAplicado;[ACT_Cargos]PctDescuentoAplicado) //20150224 RCH Estaba generando cargos sin datos. Ticket 141203
					For ($i;1;Size of array:C274($alACT_recNumCargoDcto))
						READ ONLY:C145([ACT_Cargos:173])
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargoDcto{$i})
						If ([ACT_Cargos:173]Monto_Neto:5<0)
							$el:=Find in array:C230($alACT_recNumsCargosF;$alACT_recNumCargoDcto{$i})
							If ($el=-1)
								APPEND TO ARRAY:C911($arACT_MontosDctosRelF;$arACT_MontoDcto{$i})
								APPEND TO ARRAY:C911($alACT_recNumsCargosF;$alACT_recNumCargoDcto{$i})
							Else 
								$arACT_MontosDctosRelF{$el}:=$arACT_MontosDctosRelF{$el}+$arACT_MontoDcto{$i}
							End if 
						Else 
							If ($arACT_MontoDcto{$i}<0)
								$vl_tipoItem:=14
							Else 
								$vl_tipoItem:=15
							End if 
							GOTO RECORD:C242([ACT_Cargos:173];$al_recNumDctoRelativo{$j})
							$vt_glosa:=[ACT_Cargos:173]Glosa:12
							ACTcc_DuplicaCargoDcto ($vl_tipoItem;$alACT_recNumCargoDcto{$i};$arACT_MontoDcto{$i};True:C214;$vt_glosa)
						End if 
					End for 
				End if 
				AT_Initialize (->aReal1;->arConDscto;->arConDsctoAfecto;->arConDsctoIVA)
				UNLOAD RECORD:C212([ACT_Cargos:173])
				AT_Initialize (->aReal3)
			End for 
			For ($i;1;Size of array:C274($alACT_recNumsCargosF))
				READ ONLY:C145([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumsCargosF{$i})
				If ([ACT_Cargos:173]Monto_Neto:5<0)
					KRL_ReloadInReadWriteMode (->[ACT_Cargos:173])
					[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5+$arACT_MontosDctosRelF{$i}
					[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
					[ACT_Cargos:173]Monto_Afecto:27:=Round:C94([ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28)))
					[ACT_Cargos:173]Monto_IVA:20:=Round:C94([ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_Afecto:27;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28)))
					SAVE RECORD:C53([ACT_Cargos:173])
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
				End if 
			End for 
			
			$MontoNeto:=$MontoNeto+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setIVAyDsctos;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
			$MontoIVA:=$MontoIVA+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setIVAyDsctos;->[ACT_Cargos:173]Monto_IVA:20;$vd_fecha)
			$MontoAfecto:=$MontoAfecto+ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setIVAyDsctos;->[ACT_Cargos:173]Monto_Afecto:27;$vd_fecha)
		End if 
	End if 
	CLEAR SET:C117($setIVAyDsctos)
	
	
	CLEAR SET:C117("Relativos")
	CLEAR SET:C117("TodoslosCargos")
	[ACT_Documentos_de_Cargo:174]Monto_total:19:=$MontoTotal
	[ACT_Documentos_de_Cargo:174]Monto_Afecto:16:=$MontoAfecto
	[ACT_Documentos_de_Cargo:174]Monto_IVA:22:=$MontoIVA
	[ACT_Documentos_de_Cargo:174]Monto_Neto:4:=$MontoNeto
	[ACT_Documentos_de_Cargo:174]Descuentos:17:=Abs:C99($descuentos)
	[ACT_Documentos_de_Cargo:174]Recargos:18:=$recargos
	[ACT_Documentos_de_Cargo:174]Saldo:10:=$Saldo
	[ACT_Documentos_de_Cargo:174]Pagos:9:=$Pagos
	SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
	$0:=$MontoNeto
Else 
	$0:=0
End if 
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
KRL_UnloadReadOnly (->[ACT_Cargos:173])