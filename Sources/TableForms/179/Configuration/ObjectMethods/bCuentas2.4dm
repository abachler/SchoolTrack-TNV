C_TEXT:C284($t_periodo)
C_LONGINT:C283($l_line;$l_idItem)

ACTcfg_SaveItemdeCargo 
$t_periodo:=ACTitems_BuscaAñoEnCargos ([xxACT_Items:179]ID:1)
Case of 
	: ($t_periodo="-1")  //nuevo año
		ACTitems_CreaNuevoPeriodo 
		
	: ($t_periodo#"")
		[xxACT_Items:179]Periodo:42:=$t_periodo
End case 
