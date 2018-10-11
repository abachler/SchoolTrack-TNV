//%attributes = {}
  //ACTcar_CalculaInteres

If (False:C215)
	  //$1 -> id cargo a generar
	  //$2 -> fecha a considerar
	  //$0 <- retorna el record number del cargo generado
End if 
C_LONGINT:C283($vl_idCargo;$1;$daysSinceLast;$idCargo;$0)
C_BOOLEAN:C305($ctaAfecta;$afectoInt;$tipo;$go)
C_REAL:C285($tasaMensual;$months;$intereses;$porInt;$saldo)
C_DATE:C307($vd_fecha)
C_BOOLEAN:C305($b_afecto)

$vl_idCargo:=$1
Case of 
	: (Count parameters:C259=2)
		C_DATE:C307($2)
		$vd_fecha:=$2
	Else 
		$vd_fecha:=Current date:C33(*)
End case 

READ WRITE:C146([ACT_Cargos:173])
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$vl_idCargo)
  //If ($vd_fecha>[ACT_Cargos]LastInterestsUpdate)
If (($vd_fecha>[ACT_Cargos:173]LastInterestsUpdate:42) & ($vd_fecha>[ACT_Cargos:173]Fecha_de_Vencimiento:7))  //20140825 RCH Intereses
	$daysSinceLast:=$vd_fecha-[ACT_Cargos:173]LastInterestsUpdate:42
	[ACT_Cargos:173]LastInterestsUpdate:42:=$vd_fecha
	SAVE RECORD:C53([ACT_Cargos:173])
Else 
	$daysSinceLast:=0
End if 
If ([ACT_Cargos:173]ID_CuentaCorriente:2#0)  //para el caso de los cargos asociados solo al tercero
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
	$ctaAfecta:=[ACT_CuentasCorrientes:175]AfectoIntereses:28
Else 
	$ctaAfecta:=True:C214
End if 
QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
If (Records in selection:C76([xxACT_Items:179])=1)
	$afectoInt:=[xxACT_Items:179]AfectoInteres:26
	$tipo:=[xxACT_Items:179]TipoInteres:29
	$b_afecto:=([ACT_Cargos:173]TasaIVA:21#0)  //20170410 RCH
	
	$go:=True:C214
	If ($daysSinceLast>0)
		If (($afectoInt) & ($ctaAfecta))
			$tasaMensual:=[xxACT_Items:179]TasaInteresMensual:25/100
			$months:=$daysSinceLast/30
		Else 
			$go:=False:C215
		End if 
	Else 
		$go:=False:C215
	End if 
	If ($go)
		If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28))
			$vt_moneda:=[ACT_Cargos:173]Moneda:28
		Else 
			$vl_decimales:=<>vlACT_Decimales
			$vt_moneda:=<>vtACT_monedaPais
		End if 
		$idCargo:=[ACT_Cargos:173]ID:1
		$lastIntUpdate:=[ACT_Cargos:173]LastInterestsUpdate:42
		
		C_DATE:C307($d_fechaCalculo)
		If (<>b_usarFechaVencimiento=1)
			$d_fechaCalculo:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
		Else 
			$d_fechaCalculo:=$vd_fecha
		End if 
		
		If ($tipo)  //verdadero corresponde a interes simple
			  //20161011 RCH Se buscan los cargos asociados no intereses.
			  //$saldo:=[ACT_Cargos]Saldo*-1
			  //$intereses:=Round($saldo*$months*$tasaMensual;$vl_decimales)
			
			PUSH RECORD:C176([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-100)
			  //ASM 20161112 Problema con la variable de fecha
			  //$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;$fecha)
			  //$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$fecha;$vt_moneda)
			$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$vd_fecha)
			$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;<>vtACT_monedaPais;$vd_fecha;$vt_moneda)
			POP RECORD:C177([ACT_Cargos:173])
			$saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
			$intereses:=Round:C94($saldo*$months*$tasaMensual;$vl_decimales)
			
		Else 
			PUSH RECORD:C176([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			
			  //20161011 RCH Se comenta línea siguiente porque ahora se puede usar cualquier cargo para descuentos
			  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*)
			  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item<0)  //para incluir todos los cargos relacionados...
			
			  //$porInt:=Sum([ACT_Cargos]Saldo)
			  //POP RECORD([ACT_Cargos])
			  //$saldo:=([ACT_Cargos]Saldo+$porInt)*-1
			  //$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;$vd_fecha)
			  //$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$vd_fecha;$vt_moneda)
			$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_fechaCalculo)
			$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;<>vtACT_monedaPais;$d_fechaCalculo;$vt_moneda)
			
			POP RECORD:C177([ACT_Cargos:173])
			$saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
			$intereses:=Round:C94($saldo*(((1+$tasaMensual)^$months)-1);$vl_decimales)
			
		End if 
		  //$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
		
		  //$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$d_fechaCalculo;ST_GetWord (ACT_DivisaPais ;1;";"))
		
		  //$0:=ACTac_CreateCargoDocCargo4Int ($idCargo;$lastIntUpdate;$intereses)
		C_TEXT:C284($t_moneda)
		If (<>bint_CalculaEnMonedaPais=1)
			$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$d_fechaCalculo;<>vtACT_monedaPais)
		Else 
			$t_moneda:=$vt_moneda
		End if 
		$0:=ACTac_CreateCargoDocCargo4Int ($idCargo;$lastIntUpdate;$intereses;0;$t_moneda;$b_afecto)
		
	End if 
End if 