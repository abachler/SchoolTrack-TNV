If (Form event:C388=On Clicked:K2:4)
	$selected:=Count in array:C907(lb_AlumnosABS;True:C214)
	OBJECT SET ENABLED:C1123(bDelLines;($selected>0))
End if 