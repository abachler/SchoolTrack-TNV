IT_SetButtonState (True:C214;->WTrf_s1;->WTrf_s2;->WTrf_s3;->WTrf_s4)
If ((WTrf_s1=0) & (WTrf_s2=0) & (WTrf_s3=0) & (WTrf_s4=0))
	WTrf_s1:=1
End if 
  //viFormatFile:="Delimitado por "+ST_Boolean2Str (WTrf_s1=1;"Tabulación.";ST_Boolean2Str (WTrf_s2=1;"Punto y Coma.";ST_Boolean2Str (WTrf_s3=1;"Coma";"")))