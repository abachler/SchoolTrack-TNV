vt_cantidad2:=Replace string:C233(vt_cantidad2;".";<>tXS_RS_DecimalSeparator)
vt_cantidad2:=Replace string:C233(vt_cantidad2;",";<>tXS_RS_DecimalSeparator)
If (Num:C11(vt_cantidad2)#0)
	If (Num:C11(vt_cantidad2)<Num:C11(vt_cantidad1))
		vt_cantidad1:=vt_cantidad2
	End if 
End if 