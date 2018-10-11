If (USR_GetUserID >0)  //20150912 RCH Para dtenet
	[xxACT_Items:179]Glosa:2:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa:2;"(";"[");")";"]");"/";"_");"\\";"_")
End if 
[xxACT_Items:179]Glosa_de_Impresión:20:=[xxACT_Items:179]Glosa:2

  // 20111215 RCH Se limpia cadena por posibles copy paste...
Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (USR_GetUserID >0)  //20150912 RCH Para dtenet
			[xxACT_Items:179]Glosa:2:=ST_CleanString ([xxACT_Items:179]Glosa:2)
			[xxACT_Items:179]Glosa_de_Impresión:20:=ST_CleanString ([xxACT_Items:179]Glosa_de_Impresión:20)
		End if 
End case 

atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
AL_UpdateArrays (xALP_items;-1)