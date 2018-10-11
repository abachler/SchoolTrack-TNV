//%attributes = {}
  //EVS_SetFormats

$l:=Length:C16(String:C10(rGradesTo))
Case of 
	: (iGradesDec=0)
		If (rGradesFrom=0)
			vs_GradesFormat:="####0"
		Else 
			vs_GradesFormat:="#####"
		End if 
	: (iGradesDec=1)
		vs_GradesFormat:="##0"+<>tXS_RS_DecimalSeparator+"0"
	: (iGradesDec=2)
		vs_GradesFormat:="#0"+<>tXS_RS_DecimalSeparator+"00"
	: (iGradesDec=3)
		vs_GradesFormat:="#"+<>tXS_RS_DecimalSeparator+"###"
End case 
$l:=Length:C16(String:C10(rPointsTo))
Case of 
	: (iPointsDec=0)
		If (rPointsFrom=0)
			vs_PointsFormat:="####0"
		Else 
			vs_PointsFormat:="#####"
		End if 
		$width:=$l*9
	: (iPointsDec=1)
		vs_PointsFormat:="##0"+<>tXS_RS_DecimalSeparator+"0"
		$width:=($l+2)*9
	: (iPointsDec=2)
		vs_PointsFormat:="#0"+<>tXS_RS_DecimalSeparator+"00"
		$width:=($l+3)*9
	: (iPointsDec=3)
		$width:=($l+4)*9
		vs_PointsFormat:="0"+<>tXS_RS_DecimalSeparator+"000"
End case 
vs_PercentFormat:="##0"+<>tXS_RS_DecimalSeparator+"0"