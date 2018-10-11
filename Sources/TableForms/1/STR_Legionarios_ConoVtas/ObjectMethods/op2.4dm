
PREF_Set (-555;"ConodeVentasStatus";"Manual "+String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*)))
$vt_statusCono:=PREF_fGet (-555;"ConodeVentasStatus")

$vl_pos:=Position:C15("\r";vt_lastconfiggenCV)
vt_lastconfiggenCV:=Substring:C12(vt_lastconfiggenCV;$vl_pos+1)
vt_lastconfiggenCV:="Estado del Cono de Ventas: "+$vt_statusCono+"\r"+vt_lastconfiggenCV