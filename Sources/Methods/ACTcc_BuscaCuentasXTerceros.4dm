//%attributes = {}
  //ACTcc_BuscaCuentasXTerceros

READ ONLY:C145([ACT_Terceros_Pactado:139])
READ ONLY:C145([ACT_CuentasCorrientes:175])
KRL_RelateSelection (->[ACT_Terceros_Pactado:139]Id_Tercero:2;->[ACT_Terceros:138]Id:1;"")
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3;"")