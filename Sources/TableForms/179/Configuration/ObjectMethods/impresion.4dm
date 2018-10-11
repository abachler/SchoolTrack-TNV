[xxACT_Items:179]Glosa_de_Impresión:20:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa_de_Impresión:20;"(";"[");")";"]");"/";"_");"\\";"_")

  // 20111215 RCH Se limpia cadena por posibles copy paste...
Case of 
	: (Form event:C388=On Data Change:K2:15)
		[xxACT_Items:179]Glosa_de_Impresión:20:=ST_CleanString ([xxACT_Items:179]Glosa_de_Impresión:20)
End case 
