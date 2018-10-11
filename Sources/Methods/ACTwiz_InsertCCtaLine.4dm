//%attributes = {}
  //ACTwiz_InsertCCtaLine

C_POINTER:C301($ptr1)
AT_Insert (1;1;->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

If ($1="fact")
	If ((td1=1) | (td3=1))
		acampocc1{1}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
		PUSH RECORD:C176([ACT_Cargos:173])
		$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		If ($vr_montoNeto>=0)
			acampocc2{1}:=$vr_montoNeto
		Else 
			acampocc3{1}:=Abs:C99($vr_montoNeto)
		End if 
		$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampocc1{1})
		If ($nameIndex#-1)
			acampocc4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
		End if 
		POP RECORD:C177([ACT_Cargos:173])
		acampocc16{1}:=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8)
		acampocc19{1}:=Substring:C12([ACT_Cargos:173]CodAuxCCta:44;1;12)
		aCCID{1}:=vlNextCCID
		vlNextCCID:=vlNextCCID+1
		$0:=aCCID{1}
	Else 
		acampocc1{1}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
		$monto:=ACTbol_GetMontoLinea ("Transacciones")
		vrACT_ProcBoleta:=vrACT_ProcBoleta+$monto
		
		  //***** 20120113 RCH La exportacion no estaba cuadrando cuando habian dctos...
		  //If ($monto>=0)
		  //acampocc2{1}:=$monto
		  //Else 
		  //  //acampocc3{1}:=Abs($monto)
		  //APPEND TO ARRAY(arACT_Rebajas;Abs($monto))
		  //APPEND TO ARRAY(alACT_idsCarRebajas;[ACT_Cargos]ID)
		  //End if 
		acampocc2{1}:=$monto
		
		$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampocc1{1})
		If ($nameIndex#-1)
			acampocc4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
		End if 
		acampocc16{1}:=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8)
		acampocc19{1}:=Substring:C12([ACT_Cargos:173]CodAuxCCta:44;1;12)
		aCCID{1}:=vlNextCCID
		vlNextCCID:=vlNextCCID+1
		$0:=aCCID{1}
	End if 
End if 
If ($1="rec")
	acampocc1{1}:=Substring:C12([ACT_Pagos:172]No_CCta_Contable:19;1;18)
	acampocc3{1}:=[ACT_Pagos:172]Monto_Pagado:5
	$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampocc1{1})
	If ($nameIndex#-1)
		acampocc4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
	End if 
	acampocc16{1}:=Substring:C12([ACT_Pagos:172]CCentro_de_costos:20;1;8)
	acampocc19{1}:=Substring:C12([ACT_Pagos:172]CodAuxCCta:23;1;12)
	aCCID{1}:=vlNextCCID
	vlNextCCID:=vlNextCCID+1
	$0:=aCCID{1}
End if 
If ($1="recCargos")
	acampocc1{1}:=Substring:C12([ACT_Cargos:173]No_CCta_contable:39;1;18)
	$monto:=$ptr1->
	If ($monto>=0)
		acampocc3{1}:=$monto
	Else 
		acampocc2{1}:=Abs:C99($monto)
	End if 
	$nameIndex:=Find in array:C230(<>asACT_CuentaCta;acampocc1{1})
	If ($nameIndex#-1)
		acampocc4{1}:=Substring:C12(<>asACT_GlosaCta{$nameIndex};1;60)
	End if 
	acampocc16{1}:=Substring:C12([ACT_Cargos:173]CCentro_de_costos:40;1;8)
	acampocc19{1}:=Substring:C12([ACT_Cargos:173]CodAuxCCta:44;1;12)
	aCCID{1}:=vlNextCCID
	vlNextCCID:=vlNextCCID+1
	$0:=aCCID{1}
End if 
