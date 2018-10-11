$choice:=IT_PopUpMenu (-><>atXS_MonthNames;->vtACTp_AvisoMes)
If ($choice>0)
	vtACTp_AvisoMes:=<>atXS_MonthNames{$choice}
End if 