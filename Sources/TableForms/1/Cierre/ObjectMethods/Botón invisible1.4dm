$text:=AT_array2text (->aMeses)
$choice:=Pop up menu:C542($text;Month of:C24(Current date:C33(*)))
If ($choice>0)
	vs_Mes:=aMeses{$choice}
	vl_Mes:=$choice
End if 
vt_year:=ST_Uppercase ("Cierre: "+vs_Mes+" "+String:C10(vl_Año))

$vb_existeCierre:=ACTcae_CargaVarsCierre (vl_Año;vl_Mes)
If ($vb_existeCierre)
	vt_infoCierre:="Ya existe una configuración de Cierre para el período seleccionado. La útlima con"+"figuración utilizada para dicho cierre fue cargada."
Else 
	vt_infoCierre:=""
End if 