C_LONGINT:C283($vl_records)

If ([ACT_Boletas:181]orden_interno:36>0)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]orden_interno:36=[ACT_Boletas:181]orden_interno:36)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($vl_records>0)
		BEEP:C151
		[ACT_Boletas:181]orden_interno:36:=Old:C35([ACT_Boletas:181]orden_interno:36)
	End if 
End if 