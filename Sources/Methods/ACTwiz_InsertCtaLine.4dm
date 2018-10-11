//%attributes = {}
  //ACTwiz_InsertCtaLine

$ccta:=$2
AT_Insert (1;1;->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
If ($1="fact")
	If ((td1=1) | (td3=1))
		acampo1{1}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
		  //acampo3{1}:=[ACT_Cargos]Monto_Neto-[ACT_Cargos]Monto_IVA    `MOD DSCTO POR CAJA 20070817
		PUSH RECORD:C176([ACT_Cargos:173])
		$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		$vr_montoIVA:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_IVA:20;->[ACT_Cargos:173]Monto_IVA:20;Current date:C33(*))
		If (($vr_montoNeto-$vr_montoIVA)>=0)
			acampo3{1}:=$vr_montoNeto-$vr_montoIVA
		Else 
			acampo2{1}:=Abs:C99($vr_montoNeto-$vr_montoIVA)
		End if 
		$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampo1{1})
		If ($nameIndex#-1)
			acampo4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
		End if 
		POP RECORD:C177([ACT_Cargos:173])
		acampo16{1}:=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8)
		acampo19{1}:=Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;12)
		aenccuenta{1}:=$ccta
		aID{1}:=[ACT_Cargos:173]ID:1
	Else 
		acampo1{1}:=Substring:C12([ACT_Cargos:173]No_de_Cuenta_contable:17;1;18)
		$monto:=ACTbol_GetMontoLinea ("Transacciones")
		If ([ACT_Cargos:173]TasaIVA:21>0)
			$factor:=1+([ACT_Cargos:173]TasaIVA:21/100)
			$monto:=Round:C94($monto/$factor;<>vlACT_Decimales)
		End if 
		  //***** 20120113 RCH La exportacion no estaba cuadrando cuando habian dctos...
		  //acampo3{1}:=$monto         `MOD DSCTO POR CAJA 20070817
		  //If ($monto>=0)
		  //acampo3{1}:=$monto
		  //Else 
		  //  `acampo2{1}:=Abs($monto)
		  //End if 
		acampo3{1}:=$monto
		$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampo1{1})
		If ($nameIndex#-1)
			acampo4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
		End if 
		acampo16{1}:=Substring:C12([ACT_Cargos:173]Centro_de_costos:15;1;8)
		acampo19{1}:=Substring:C12([ACT_Cargos:173]CodAuxCta:43;1;12)
		aenccuenta{1}:=$ccta
		aID{1}:=[ACT_Cargos:173]ID:1
	End if 
End if 
If ($1="rec")
	acampo1{1}:=Substring:C12([ACT_Pagos:172]No_Cuenta_Contable:16;1;18)
	acampo2{1}:=[ACT_Pagos:172]Monto_Pagado:5-[ACT_Pagos:172]Saldo:15
	$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampo1{1})
	If ($nameIndex#-1)
		acampo4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
	End if 
	acampo16{1}:=Substring:C12([ACT_Pagos:172]Centro_de_costos:17;1;8)
	acampo19{1}:=Substring:C12([ACT_Pagos:172]CodAuxCta:22;1;12)
	aenccuenta{1}:=$ccta
	aID{1}:=[ACT_Pagos:172]ID:1
End if 