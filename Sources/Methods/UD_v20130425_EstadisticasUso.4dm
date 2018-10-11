//%attributes = {"executedOnServer":true}
  // UD_v20130425_EstadisticasUso()
  // Por: Alberto Bachler: 25/04/13, 11:08:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_forzarParaPruebas)

  //$b_forzarParaPruebas:=True

XSstat_Mensuales_out (!2013-02-01!;$b_forzarParaPruebas)  // envio estadisticas enero
XSstat_Mensuales_out (!2013-03-01!;$b_forzarParaPruebas)  // envio estadisticas febrero
XSstat_Mensuales_out (!2013-04-01!;$b_forzarParaPruebas)  // envio estadisticas marzo
XSstat_Mensuales_out (!2013-05-01!;$b_forzarParaPruebas)  // envio estadisticas abril
XSstat_Mensuales_out   // envio estadisticas mes actual

XSstat_Anuales_out (!2012-01-01!;$b_forzarParaPruebas)  // envio estadisticas 2011
XSstat_Anuales_out (!2013-01-01!;$b_forzarParaPruebas)  // envio estadisticas 2012
XSstat_Anuales_out   // envio estadisticas año actual

QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3<="2012@")
KRL_DeleteSelection (->[xShell_UserEvents:282])


