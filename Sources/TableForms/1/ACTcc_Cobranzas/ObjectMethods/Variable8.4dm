vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		OBJECT SET ENABLED:C1123(bPrev;False:C215)
		OBJECT SET ENABLED:C1123(bNext;True:C214)
		vi_step:=1
	: (vi_PageNumber=2)
		vi_step:=2
		OBJECT SET ENABLED:C1123(bPrev;True:C214)
		OBJECT SET ENABLED:C1123(bNext;True:C214)
	: (vi_PageNumber=3)
		vi_step:=3
		OBJECT SET ENABLED:C1123(bPrev;True:C214)
		OBJECT SET ENABLED:C1123(bNext;True:C214)
	: (vi_PageNumber=4)
		vi_step:=4
		OBJECT SET ENABLED:C1123(bPrev;True:C214)
		$modSel:=Find in array:C230(abACT_ModeloSel;True:C214)
		IT_SetButtonStateObject (($modSel#-1);->bNext)
	: (vi_PageNumber=5)
		OBJECT SET ENABLED:C1123(bPrev;True:C214)
		OBJECT SET ENABLED:C1123(bNext;True:C214)
		If (b1=1)
			vi_step:=5
		Else 
			vi_Step:=4
		End if 
	: (vi_PageNumber=6)
		OBJECT SET ENABLED:C1123(bPrev;False:C215)
		OBJECT SET ENABLED:C1123(bNext;False:C215)
		OBJECT SET VISIBLE:C603(*;"b1l";(b1=1))
		OBJECT SET VISIBLE:C603(*;"b2l";(b2=1))
		Case of 
			: (b1=1)
				$t:="La emisión e impresión de avisos de cobranza se hará para <universo>. La impresió"+"n se realizará utilizando el modelo "+atACT_ModelosAviso{atACT_ModelosAviso}+"."+"\r\r"
			: (b2=1)
				$t:="La emisión (sin impresión) de avisos de cobranza se hará para <universo>."+"\r\r"
		End case 
		Case of 
			: (f1=1)
				$universo:=String:C10(viACT_Cuentas1)+" cuentas corrientes (cuentas seleccionadas en la lista) <periodo>"
			: (f2=1)
				$universo:=String:C10(viACT_Cuentas2)+" cuentas corrientes (todas las cuentas en la lista) <periodo>"
			: (f3=1)
				$universo:=String:C10(viACT_Cuentas3)+" cuentas corrientes (todas las cuentas activas) <periodo>"
		End case 
		If (vs1=vs2)
			If (vdACT_AñoAviso=vdACT_AñoAviso2)
				$periodo:="en el mes de "+vs1+" de "+String:C10(vdACT_AñoAviso)
			Else 
				$periodo:="entre los meses de "+vs1+" de "+String:C10(vdACT_AñoAviso)+" y "+vs2+" de "+String:C10(vdACT_AñoAviso2)
			End if 
		Else 
			$periodo:="desde el mes de "+vs1+" de "+String:C10(vdACT_AñoAviso)+" hasta el mes de "+vs2+" de "+String:C10(vdACT_AñoAviso2)
		End if 
		If (cbMontosEnMonedaPago=1)
			For ($i;1;Size of array:C274(atACT_NombreMonedaEm))
				$vl_idMoneda:=alACT_IdRegistroEm{$i}
				If (KRL_GetBooleanFieldData (->[xxACT_Monedas:146]Id_Moneda:1;->$vl_idMoneda;->[xxACT_Monedas:146]Genera_Tabla_Diaria:7))
					$t:=$t+"\r\r"+"Los cargos en la moneda "+ST_Qte (atACT_NombreMonedaEm{$i})+" serán calculados con el valor del día "+String:C10(adACT_fechasEm{$i};7)+" ("+String:C10(ACTut_fValorDivisa (atACT_NombreMonedaEm{$i};adACT_fechasEm{$i});"|Despliegue_ACT")+")."
				End if 
			End for 
		End if 
		If (cbVctoSegunConf=1)
			$t:=$t+"\r\r"+"Las fechas de emisión y vencimiento de los avisos de cobranza, para cada mes a em"+"itir, serán validadas para que no sean días Domingo."+"\r"+"- Si la fecha de emisión corre"+"sponde a un día Domingo, la fecha de emisión y vencimiento se moverán 1 día."+"\r"+"- Si l"+"a fecha de vencimiento del aviso a emitir corresponde a un día Domingo, dicha fec"+"ha también se moverá 1 día."
		Else 
			$t:=$t+"\r\r"+"Las fechas de emisión y vencimiento de los avisos de cobranza, para cada mes a em"+"itir, no serán validadas. Esto puede provocar que se generen avisos de cobranza c"+"on fecha de emisión y/o vencimiento un día Domingo."
		End if 
		$t:=Replace string:C233($t;"<universo>";$universo)
		$t:=Replace string:C233($t;"<periodo>";$periodo)
		vtACT_ResumenAsistente:=$t
End case 