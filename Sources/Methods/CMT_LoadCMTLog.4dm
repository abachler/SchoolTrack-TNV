//%attributes = {}
  //CMT_LoadCMTLog

ARRAY DATE:C224(adCMT_Log_FechaCMT;0)
ARRAY TEXT:C222(atCMT_Log_EventoCMT;0)
ARRAY LONGINT:C221(alCMT_Log_HoraCMT;0)

C_TEXT:C284($rolBD;$codPais;$vt_fecha)
C_DATE:C307($vd_fecha)
$rolBD:=<>gRolBD
$codPais:=<>gCountryCode
$vd_fecha:=Add to date:C393(Current date:C33(*);0;0;-14)
$vt_fecha:=String:C10(Year of:C25($vd_fecha);"0000")+"-"+String:C10(Month of:C24($vd_fecha);"00")+"-"+String:C10(Day of:C23($vd_fecha);"00")
WEB SERVICE SET PARAMETER:C777("cod_pais";$codPais)
WEB SERVICE SET PARAMETER:C777("rolbd";$rolBD)
WEB SERVICE SET PARAMETER:C777("fecha";$vt_fecha)
$err:=WS_CallCommTrackWebService ("send_log_recepcion_commtrack")
If ($err="")
	ARRAY TEXT:C222($at_result;0)
	WEB SERVICE GET RESULT:C779($at_result;"return";*)
	For ($i;1;Size of array:C274($at_result))
		C_TEXT:C284($vt_DTS)
		$vt_DTS:=Replace string:C233(Replace string:C233(Replace string:C233(ST_GetWord ($at_result{$i};1;"|");"-";"");" ";"");":";"")
		APPEND TO ARRAY:C911(adCMT_Log_FechaCMT;DTS_GetDate ($vt_DTS))
		APPEND TO ARRAY:C911(atCMT_Log_EventoCMT;ST_GetWord ($at_result{$i};2;"|"))
		APPEND TO ARRAY:C911(alCMT_Log_HoraCMT;DTS_GetTime ($vt_DTS))
	End for 
	SORT ARRAY:C229(adCMT_Log_FechaCMT;alCMT_Log_HoraCMT;atCMT_Log_EventoCMT;<)
End if 
vbCMT_LoadedSNLog:=True:C214