//%attributes = {}
  //ACT_FiltroInformePagosAnticipad

C_BOOLEAN:C305(LlaveParaFechas)
LlaveParaFechas:=True:C214
WDW_OpenFormWindow (->[ACT_Cargos:173];"Filtro_de_Cargos";0;4;__ ("Seleccione Items y Fecha"))
DIALOG:C40([ACT_Cargos:173];"Filtro_de_Cargos")
CLOSE WINDOW:C154