  // [xxBBL_Preferencias].CFG_CodigosBarra.Casilla de selección()
  // Por: Alberto Bachler: 05/09/13, 17:41:44
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //READ ONLY([BBL_Registros])
  //SCAN INDEX([BBL_Registros]No_Registro;1;<)
  //Mti_BarCode:=[BBL_Registros]No_Registro+1
OBJECT SET ENTERABLE:C238(Mti_BarCode;True:C214)
HIGHLIGHT TEXT:C210(MTi_BarCode;MAXTEXTLENBEFOREV11:K35:3;MAXTEXTLENBEFOREV11:K35:3)
GOTO OBJECT:C206(Mti_BarCode)



