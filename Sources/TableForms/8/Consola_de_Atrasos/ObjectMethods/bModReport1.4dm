$text:=AT_array2text (->atSTR_Modelos)
$choice:=Pop up menu:C542($text)

If ($choice#0)
	atSTR_Modelos:=$choice
	vtSTR_ReportModel:=atSTR_Modelos{atSTR_Modelos}
End if 