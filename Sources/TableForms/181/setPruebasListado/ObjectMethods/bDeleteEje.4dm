ARRAY LONGINT:C221($DA_Return;0)
lb_listadoSet{0}:=True:C214
AT_SearchArray (->lb_listadoSet;"=";->$DA_Return)

$vl_resp:=CD_Dlog (0;"Se eliminarán "+String:C10(Size of array:C274($DA_Return))+" caso(s) de prueba sin verificación adicional."+"\r\r"+"¿Desea Continuar?";"";"Si";"No")
For ($i;Size of array:C274($DA_Return);1;-1)
	If (lb_listadoSet{$DA_Return{$i}})
		$vt_pref:=atACT_Text{$DA_Return{$i}}
		ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
		$vt_pref2:="ACT_DTE_IDBOL_CASO_"+vt_variableCaso
		ACTdte_setPruebasOpcionesGen ("EliminaElemento";->$vt_pref2)
		ACTdte_setPruebasOpcionesGen ("InitVars")
		ACTdte_setPruebasOpcionesGen ("EliminaElemento";->$vt_pref)
	End if 
End for 