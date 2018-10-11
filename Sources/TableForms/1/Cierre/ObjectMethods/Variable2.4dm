If (Self:C308->>=Year of:C25(Current date:C33(*)))
	  //$msg:="No es recomendable realizar el Cierre de Año para el período actual debido a que "+"lo"+"s meses se bloquearán y no será posible emitir Avisos de Cobranza para el período"+" cerrado."+◊cr+◊cr+"¿Desea continuar con el cierre para el períal?"
	  //$msg:=$msg+"¿Desea continuar con el cierre para el período actual?"
	$resp:=CD_Dlog (0;__ ("No es recomendable realizar el Cierre de Año para el período actual debido a que los meses se bloquearán y no será posible emitir Avisos de Cobranza para el período cerrado.\r\r¿Desea continuar con el cierre para el período actual?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
	If ($resp#1)
		Self:C308->:=Year of:C25(Current date:C33(*))-1
	End if 
End if 
vt_year:=ST_Uppercase ("Cierre: "+vs_Mes+" "+String:C10(vl_Año))

$vb_existeCierre:=ACTcae_CargaVarsCierre (vl_Año;vl_Mes)
If ($vb_existeCierre)
	vt_infoCierre:="Ya existe una configuración de Cierre para el período seleccionado. La útlima con"+"figuración utilizada para dicho cierre fue cargada."
Else 
	vt_infoCierre:=""
End if 