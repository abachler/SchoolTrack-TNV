  //Método de Objeto: [xShell_Dialogs].XS_InputFormReportList.hl_reportslist

C_LONGINT:C283(vl_choice)
If (Form event:C388=On Double Clicked:K2:5)
	$choice:=Selected list items:C379(hl_reportsList)
	atQR_FormReportNames:=$choice
	alQR_FormReportRecNums:=$choice
	vl_choice:=$choice
	ACCEPT:C269
End if 