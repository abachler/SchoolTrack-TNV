//%attributes = {}
C_LONGINT:C283($1;$2)
C_LONGINT:C283($i;$idBoleta;$numVars;$rn;$vl_lineas;$bol)
C_REAL:C285($valorUf)
C_POINTER:C301($var1;$var2;$var3;$var4)

ARRAY LONGINT:C221($aPagosBoleta;0)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Documentos_de_Pago:176])

$idBoleta:=$1
$bol:=$2
$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
$valorUf:=ACTut_fValorUF ([ACT_Boletas:181]FechaEmision:3)

QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$idBoleta;*)
QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Pago:4;$aPagosBoleta)
If (Size of array:C274($aPagosBoleta)<=$vl_lineas)
	$numVars:=Size of array:C274($aPagosBoleta)
Else 
	$numVars:=$vl_lineas
End if 
For ($i;1;$numVars)
	$rn:=Find in field:C653([ACT_Pagos:172]ID:1;$aPagosBoleta{$i})
	If ($rn#-1)
		GOTO RECORD:C242([ACT_Pagos:172];$rn)
		$var1:=Get pointer:C304("vtACT_SRbolPGS_Forma"+String:C10($i)+String:C10($bol))
		$var2:=Get pointer:C304("vtACT_SRbolPGS_Fecha"+String:C10($i)+String:C10($bol))
		$var3:=Get pointer:C304("vrACT_SRbolPGS_Monto"+String:C10($i)+String:C10($bol))
		$var4:=Get pointer:C304("vrACT_SRbolPGS_MontoUF"+String:C10($i)+String:C10($bol))
		$var1->:=[ACT_Pagos:172]FormaDePago:7
		$var2->:=String:C10([ACT_Pagos:172]Fecha:2;Internal date short:K1:7)
		$var3->:=[ACT_Pagos:172]Monto_Pagado:5
		If ($valorUf>0)
			$var4->:=Round:C94([ACT_Pagos:172]Monto_Pagado:5/$valorUf;2)
		Else 
			$var4->:=0
		End if 
		Case of 
			: ([ACT_Pagos:172]FormaDePago:7="Efectivo")
				
			: ([ACT_Pagos:172]FormaDePago:7="Cheque")
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				$var1:=Get pointer:C304("vtACT_SRbolPGS_DatoPago1"+String:C10($i)+String:C10($bol))
				$var2:=Get pointer:C304("vtACT_SRbolPGS_DatoPago2"+String:C10($i)+String:C10($bol))
				$var3:=Get pointer:C304("vtACT_SRbolPGS_DatoPago3"+String:C10($i)+String:C10($bol))
				$var4:=Get pointer:C304("vtACT_SRbolPGS_DatoPago4"+String:C10($i)+String:C10($bol))
				$var1->:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
				$var2->:=[ACT_Documentos_de_Pago:176]NoSerie:12
				$var3->:=String:C10([ACT_Documentos_de_Pago:176]Fecha:13;Internal date short:K1:7)
				$var4->:=String:C10([ACT_Documentos_de_Pago:176]FechaVencimiento:27;Internal date short:K1:7)
			: ([ACT_Pagos:172]FormaDePago:7="Tarjeta de Crédito")
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				$var1:=Get pointer:C304("vtACT_SRbolPGS_DatoPago1"+String:C10($i)+String:C10($bol))
				$var2:=Get pointer:C304("vtACT_SRbolPGS_DatoPago2"+String:C10($i)+String:C10($bol))
				$var3:=Get pointer:C304("vtACT_SRbolPGS_DatoPago3"+String:C10($i)+String:C10($bol))
				$var1->:=[ACT_Documentos_de_Pago:176]TC_Tipo:16
				$var2->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago:176]TC_Numero:17)
				$var3->:=[ACT_Documentos_de_Pago:176]TC_BancoEmisor:23
			: ([ACT_Pagos:172]FormaDePago:7="Tarjeta de Débito")
				  //16.10.2014 - Saúl Ponce
				  //Ticket N° 135791 - Solicitan mostrar los datos (nombre banco, etc) para pagos con débito 
				
				  // //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]ID=[ACT_Pagos]ID_DocumentodePago)
				  // //$var1:=Get pointer("vtACT_SRbolPGS_DatoPago1"+String($i)+String($bol))
				  // //$var1->:=[ACT_Documentos_de_Pago]R_NoDocumento  
				
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				$var1:=Get pointer:C304("vtACT_SRbolPGS_DatoPago1"+String:C10($i)+String:C10($bol))
				$var2:=Get pointer:C304("vtACT_SRbolPGS_DatoPago2"+String:C10($i)+String:C10($bol))
				$var3:=Get pointer:C304("vtACT_SRbolPGS_DatoPago3"+String:C10($i)+String:C10($bol))
				$var1->:=[ACT_Documentos_de_Pago:176]R_NoDocumento:33
				$var2->:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago:176]TD_Numero:69)
				$var3->:=[ACT_Documentos_de_Pago:176]TD_BancoEmisor:66
				
				  //16.10.2014 - Saúl Ponce
			: ([ACT_Pagos:172]FormaDePago:7="Letra@")
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
				$var1:=Get pointer:C304("vtACT_SRbolPGS_DatoPago2"+String:C10($i)+String:C10($bol))
				$var2:=Get pointer:C304("vtACT_SRbolPGS_DatoPago3"+String:C10($i)+String:C10($bol))
				$var3:=Get pointer:C304("vtACT_SRbolPGS_DatoPago4"+String:C10($i)+String:C10($bol))
				$var1->:=[ACT_Documentos_de_Pago:176]NoSerie:12  //folio
				$var2->:=String:C10([ACT_Documentos_de_Pago:176]Fecha:13;7)  //fecha emsisión
				$var3->:=String:C10([ACT_Documentos_de_Pago:176]FechaVencimiento:27;7)  //fecha vencimiento
			: ([ACT_Pagos:172]FormaDePago:7="PAT")
				
			: ([ACT_Pagos:172]FormaDePago:7="PAC")
				
			: ([ACT_Pagos:172]FormaDePago:7="Cuponera")
				
			Else 
				
		End case 
	End if 
End for 