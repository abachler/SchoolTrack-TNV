  //ACTcfg_LoadBancos 
  //ARRAY TEXT(atACT_LugaresBancos;0)
  //
  //APPEND TO ARRAY(atACT_LugaresBancos;"Ninguno")
  //APPEND TO ARRAY(atACT_LugaresBancos;"-")
  //For ($i;1;Size of array(<>atACT_LugaresPago))
  //APPEND TO ARRAY(atACT_LugaresBancos;<>atACT_LugaresPago{$i})
  //End for 
  //APPEND TO ARRAY(atACT_LugaresBancos;"-")
  //For ($i;1;Size of array(atACT_BankName))
  //APPEND TO ARRAY(atACT_LugaresBancos;atACT_BankName{$i})
  //End for 
  //$choice:=ACTKRL_PopUp (->atACT_LugaresBancos;"Seleccione el lugar de pago...")
  //If ($choice#0)
  //If ($choice=1)
  //[ACT_Pagos]Lugar_de_Pago:=""
  //Else 
  //[ACT_Pagos]Lugar_de_Pago:=atACT_LugaresBancos{$choice}
  //End if 
  //End if 
  //ARRAY TEXT(atACT_LugaresBancos;0)
[ACT_Pagos:172]Lugar_de_Pago:18:=ACTpgs_CargaLugarPagoBanco 
