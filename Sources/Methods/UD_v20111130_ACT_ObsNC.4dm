//%attributes = {}
  //RCH solo lo deje en 11,0

  //  //UD_v20111130_ACT_ObsNC
  //If (ACT_AccountTrackInicializado )
  //C_LONGINT($i;$vl_numero;$vl_proc)
  //C_TEXT($vt_tipoDocumento;$vt_obs)
  //
  //ARRAY LONGINT($alACT_idsCargos;0)
  //
  //READ ONLY([ACT_Cargos])
  //READ ONLY([ACT_Transacciones])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //READ ONLY([ACT_Pagos])
  //
  //$vl_proc:=IT_UThermometer (1;0;"Actualizando referencias...")
  //QUERY([ACT_Cargos];[ACT_Cargos]Ref_Item=-129)
  //SELECTION TO ARRAY([ACT_Cargos]ID;$alACT_idsCargos)
  //
  //CD_THERMOMETREXSEC (1;0;"Actualizando campo observaciones en Pagos y Avisos de Cobranza...")
  //For ($i;1;Size of array($alACT_idsCargos))
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=$alACT_idsCargos{$i})
  //
  //READ WRITE([ACT_Avisos_de_Cobranza])
  //READ WRITE([ACT_Pagos])
  //
  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta#0)
  //KRL_RelateSelection (->[ACT_Boletas]ID;->[ACT_Transacciones]No_Boleta;"")
  //
  //FIRST RECORD([ACT_Boletas])
  //$vl_numero:=[ACT_Boletas]Numero
  //$vt_tipoDocumento:=[ACT_Boletas]TipoDocumento
  //$vt_obs:=__ ("Devolución asociada a Documento Tributario tipo ")+$vt_tipoDocumento+", "+__ ("número")+": "+String($vl_numero)+"."
  //
  //If (Records in selection([ACT_Boletas])>0)
  //[ACT_Avisos_de_Cobranza]Observaciones:=$vt_obs+ST_Boolean2Text ([ACT_Avisos_de_Cobranza]Observaciones#"";<>cr+[ACT_Avisos_de_Cobranza]Observaciones;"")
  //SAVE RECORD([ACT_Avisos_de_Cobranza])
  //
  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]FormaDePago="Nota de Crédito")
  //[ACT_Pagos]Observaciones:=$vt_obs+ST_Boolean2Text ([ACT_Pagos]Observaciones#"";<>cr+[ACT_Pagos]Observaciones;"")
  //SAVE RECORD([ACT_Pagos])
  //End if 
  //
  //KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza])
  //KRL_UnloadReadOnly (->[ACT_Pagos])
  //
  //CD_THERMOMETREXSEC (0;$i/Size of array($alACT_idsCargos)*100)
  //End for 
  //CD_THERMOMETREXSEC (-1)
  //IT_UThermometer (-2;$vl_proc)
  //End if 