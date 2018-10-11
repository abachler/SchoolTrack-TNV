C_TEXT:C284($t_fechaDesde;$t_fechaHasta)

If (Form event:C388=On Clicked:K2:4)
	$y_lista:=OBJECT Get pointer:C1124(Object named:K67:5;"listaPeriodos")
	$l_itemSeleccionado:=Selected list items:C379($y_lista->)
	GET LIST ITEM PARAMETER:C985($y_lista->;*;"desde";$t_fechaDesde)
	GET LIST ITEM PARAMETER:C985($y_lista->;*;"hasta";$t_fechaHasta)
	
	$d_fechaDesde:=Date:C102($t_fechaDesde)
	$d_fechaHasta:=Date:C102($t_fechaHasta)
	$y_pctAsistencia:=OBJECT Get pointer:C1124(Object named:K67:5;"chkBox_IncidePctAsistencia")
	$b_pctAsistencia:=($y_pctAsistencia->=1)
	If ($l_itemSeleccionado<Count list items:C380($y_lista->))
		OBJECT SET VISIBLE:C603(*;"fechas@";False:C215)
		ASrs_SinRegistroAsistencia ($d_fechaDesde;$d_fechaHasta;$b_pctAsistencia)
	End if 
End if 