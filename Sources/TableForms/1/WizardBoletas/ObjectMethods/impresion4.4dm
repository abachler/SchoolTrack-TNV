$text:="Número;Fecha"
$choice:=Pop up menu:C542($text)
If ($choice>0)
	vtACT_WTipoBusqueda:=ST_GetWord ($text;$choice;";")
	Case of 
		: ($choice=1)
			  //If (vlACT_WTipoBusqueda=2) `al seleccionar de nuevo la misma opción el formato quedaba erróneo.
			vtACT_WDTDesde:="0"
			vtACT_WDTHasta:="0"
			  //Else 
			  //vtACT_WDTDesde:=dt_GetNullDateString 
			  //vtACT_WDTHasta:=dt_GetNullDateString 
			  //vdACT_WDTDesde:=!00-00-00!
			  //vdACT_WDTHasta:=!00-00-00!
			  //End if 
		: ($choice=2)
			  //If (vlACT_WTipoBusqueda=1)
			vtACT_WDTDesde:=dt_GetNullDateString 
			vtACT_WDTHasta:=dt_GetNullDateString 
			vdACT_WDTDesde:=!00-00-00!
			vdACT_WDTHasta:=!00-00-00!
			  //Else 
			  //vtACT_WDTDesde:="0"
			  //vtACT_WDTHasta:="0"
			  //End if 
	End case 
	vlACT_WTipoBusqueda:=$choice
End if 
OBJECT SET VISIBLE:C603(*;"fecha@";($choice=2))
OBJECT SET ENTERABLE:C238(*;"numero@";($choice=1))