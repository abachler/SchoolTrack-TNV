If (Self:C308->=1)
	OBJECT SET TITLE:C194(PWTrf_Pac1;__ ("Archivo para Contabilidad"))
	OBJECT SET TITLE:C194(WTrf_ac2;__ ("Nuevo modelo de archivo para contabilidad"))
	OBJECT SET TITLE:C194(WTrf_ac3;__ ("Modificar modelo de archivo de contabilidad"))
End if 
PWTrf_Ptb1:=1
PWTrf_Pac1:=0
WTrf_tb2:=1
WTrf_tb3:=0
WTrf_ac2:=0
WTrf_ac3:=0
vNombreOldModeloC:=""
OBJECT SET VISIBLE:C603(*;"bModeloC@";False:C215)
IT_SetButtonState (False:C215;->WTrf_ac2;->WTrf_ac3;->WTrf_ac1)
IT_SetButtonState (True:C214;->WTrf_tb2;->WTrf_tb3;->WTrf_tb1)

  //viTypeFile:=""  //Tipo archivo para mostrarlo en ultima pagina
viFormatFile:=""  //formato archivo para mostrarlo en ultima pagina