//%attributes = {}
  //xALP_ACT_CB_Cuentas

  //C_LONGINT($1;$2;$3)
  //
  //AL_GetCurrCell (xALP_Cuentas;$col;$line)
  //$found:=False
  //Case of 
  //: ($col=2)
  //$temp:=◊asACT_CuentaCta{0}
  //◊asACT_CuentaCta{0}:=◊asACT_CuentaCta{$line}
  //AT_SearchArray (->◊asACT_CuentaCta;"=")
  //For ($i;1;Size of array(DA_Return))
  //If (DA_REturn{$i}#$line)
  //If (◊asACT_CodAuxCta{DA_Return{$i}}=◊asACT_CodAuxCta{$line})
  //$found:=True
  //End if 
  //End if 
  //End for 
  //If ($found)
  //CD_Dlog (0;"Esta combinación de Cuenta y Código ya existe.")
  //◊asACT_CuentaCta{$line}:=$temp
  //End if 
  //: ($col=3)
  //$temp:=◊asACT_CodAuxCta{0}
  //◊asACT_CodAuxCta{0}:=◊asACT_CodAuxCta{$line}
  //AT_SearchArray (->◊asACT_CodAuxCta;"=")
  //For ($i;1;Size of array(DA_Return))
  //If (DA_REturn{$i}#$line)
  //If (◊asACT_CuentaCta{DA_Return{$i}}=◊asACT_CuentaCta{$line})
  //$found:=True
  //End if 
  //End if 
  //End for 
  //If ($found)
  //CD_Dlog (0;"Esta combinación de Cuenta y Código ya existe.")
  //◊asACT_CodAuxCta{$line}:=$temp
  //End if 
  //End case 