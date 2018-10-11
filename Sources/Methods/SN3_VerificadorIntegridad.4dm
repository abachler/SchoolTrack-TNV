//%attributes = {}
If (SN3_CheckNotColegium )
	If (LICENCIA_esModuloAutorizado (1;SchoolNet))
		$doIt:=False:C215
		$lastExec:=DTS_GetDate (PREF_fGet (0;"SN3LastVerify";"00000000000000"))
		$currDate:=Current date:C33(*)
		If ($lastExec<$currDate)
			If (DT_GetDayNumber_ISO8601 ($currDate)=6)
				$doIt:=True:C214
			Else 
				$prevSaturday:=$currDate-1
				While (DT_GetDayNumber_ISO8601 ($prevSaturday)#6)
					$prevSaturday:=$prevSaturday-1
				End while 
				If ($prevSaturday>$lastExec)
					$doIt:=True:C214
				End if 
			End if 
		End if 
		If ($doIt)
			SN3_VerificarIntegridadMarcasEl 
			SN3_SendVerificadorXML 
			PREF_Set (0;"SN3LastVerify";DTS_MakeFromDateTime )
		End if 
	End if 
End if 