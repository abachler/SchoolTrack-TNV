//%attributes = {}
  //ACTimp_CheckPercentages

C_TEXT:C284($1;$2;$monto;$textoMotivo;$0)

$monto:=$1
$textoMotivo:=$2

If ($monto#"")
	$monto:=Replace string:C233($monto;"-";"")
	$coma:=Position:C15(",";$monto)
	$punto:=Position:C15(".";$monto)
	Case of 
		: (($coma#0) & ($punto#0))
			aMotivo{$i}:=__ ("El ")+$textoMotivo+__ (" no puede contener separador de miles. ")
			aAprobado{$i}:=False:C215
		: ($coma#0)
			$monto:=Replace string:C233($monto;",";<>tXS_RS_DecimalSeparator;1)
			$coma:=ST_CharOcurr (",";$monto)
			If ($coma>1)
				aMotivo{$i}:=__ ("El ")+$textoMotivo+__ (" no puede contener separador de miles. ")
				aAprobado{$i}:=False:C215
			Else 
				$monto:=String:C10(Round:C94(Num:C11($monto);4);"|Real_4DecIfNec")
			End if 
		: ($punto#0)
			$monto:=Replace string:C233($monto;".";<>tXS_RS_DecimalSeparator;1)
			$punto:=ST_CharOcurr (".";$monto)
			If ($punto>1)
				aMotivo{$i}:=__ ("El ")+$textoMotivo+__ (" no puede contener separador de miles. ")
				aAprobado{$i}:=False:C215
			Else 
				$monto:=String:C10(Round:C94(Num:C11($monto);4);"|Real_4DecIfNec")
			End if 
		Else 
			If (Num:C11($monto)>100)
				aMotivo{$i}:=__ ("El ")+$textoMotivo+__ (" no puede ser superior a 100%. ")
				aAprobado{$i}:=False:C215
			End if 
	End case 
	$0:=$monto
End if 