  //tenemos que testear si esta todo ok para generar archivo...
  //(1): Codigos de plan de cuetas
  //(2): Descripcion del movimiento
  //(3): Codigos Centros de costos
  //(4): Blanceo debe-haber

$generar:=False:C215
$cpc:=False:C215
$desc:=False:C215
$ccc:=False:C215
$dd:=False:C215
$dh:=False:C215
$msgcpc:=""
$msgdesc:=""
$msgccc:=""
$msgdd:=""
$msgdh:=""

ACTwiz_CuentasCblFooters 
acampo1{0}:=""
If (AT_SearchArray (->acampo1;"=")>0)
	$cpc:=True:C214
	$msgcpc:=__ ("- Existen líneas que no tienen Código Plan de Cuentas.")+"\r"
Else 
	acampocc1{0}:=""
	If (AT_SearchArray (->acampocc1;"=")>0)
		$cpc:=True:C214
		$msgcpc:=__ ("- Existen líneas que no tienen Código Plan de Cuentas.")+"\r"
	End if 
End if 
acampo4{0}:=""
If (AT_SearchArray (->acampo4;"=")>0)
	$desc:=True:C214
	$msgdesc:=__ ("- Existen líneas sin Descripción Movimiento")+"\r"
Else 
	acampocc4{0}:=""
	If (AT_SearchArray (->acampocc4;"=")>0)
		$desc:=True:C214
		$msgdesc:=__ ("- Existen líneas sin Descripción Movimiento")+"\r"
	End if 
End if 
acampo16{0}:=""
If (AT_SearchArray (->acampo16;"=")>0)
	$ccc:=True:C214
	$msgccc:=__ ("- Existen líneas que no tienen Código Centro de Costo.")+"\r"
Else 
	acampo16{0}:=""
	If (AT_SearchArray (->acampocc16;"=")>0)
		$ccc:=True:C214
		$msgccc:=__ ("- Existen líneas que no tienen Código Centro de Costo.")+"\r"
	End if 
End if 
If (vrACT_Descuadre#0)
	If (vrACT_Descuadre>0)
		$dd:=True:C214
		$msgdd:=__ ("- Existe un descuadre en el archivo. Montos al debe superan montos al haber.")
	Else 
		$dh:=True:C214
		$msgdh:=__ ("- Existe un descuadre en el archivo. Montos al haber superan montos al debe.")
	End if 
End if 

  //$msg:=__ ("Existen detalles por revisar antes de generar el archivo:")+<>cr+<>cr
  //$msg:=$msg+($msgcpc*Num($cpc))
  //$msg:=$msg+($msgdesc*Num($desc))
  //$msg:=$msg+($msgccc*Num($ccc))
  //$msg:=$msg+($msgdd*Num($dd))
  //$msg:=$msg+($msgdh*Num($dh))
  //$r:=CD_Dlog (0;$msg;__ ("");__ ("Revisar");__ ("Generar de todas maneras"))
  //
  //If ($r=2)
  //ACCEPT
  //End if 

  //20130801 RCH No aparece mensaje si no hay datos que revisar...
If (($cpc) | ($desc) | ($ccc) | ($dd) | ($dh))
	
	$msg:=__ ("Existen detalles por revisar antes de generar el archivo:")+"\r\r"
	$msg:=$msg+($msgcpc*Num:C11($cpc))
	$msg:=$msg+($msgdesc*Num:C11($desc))
	$msg:=$msg+($msgccc*Num:C11($ccc))
	$msg:=$msg+($msgdd*Num:C11($dd))
	$msg:=$msg+($msgdh*Num:C11($dh))
	$r:=CD_Dlog (0;$msg;__ ("");__ ("Revisar");__ ("Generar de todas maneras"))
	
Else 
	
	$r:=2
	
End if 

If ($r=2)
	ACCEPT:C269
End if 
