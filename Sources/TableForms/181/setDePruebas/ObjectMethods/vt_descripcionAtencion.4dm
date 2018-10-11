If (Form event:C388=On Data Change:K2:15)
	
	$vt_descripcionAtencion:=Replace string:C233(vt_descripcionAtencion;"  ";" ")
	
	vt_numeroAtencion:=Replace string:C233($vt_descripcionAtencion;"CASO ";"")
	vt_numeroAtencion:=Substring:C12(vt_numeroAtencion;1;Position:C15("-";vt_numeroAtencion)-1)
	vt_variableCaso:=Replace string:C233($vt_descripcionAtencion;"CASO ";"")
	
End if 