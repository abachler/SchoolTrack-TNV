$meses:=AT_array2text (-><>atXS_MonthNames)
$choice:=Pop up menu:C542($meses)
If ($choice>0)
	vlACTdte_MesIE:=$choice
	vtACTdte_MesIE:=<>atXS_MonthNames{vlACTdte_MesIE}
End if 

ACTdte_OpcionesGeneralesIE ("ValidaPeriodoLibroElectronico")