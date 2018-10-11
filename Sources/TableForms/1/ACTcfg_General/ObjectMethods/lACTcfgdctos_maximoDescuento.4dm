If (Self:C308->>0)
	
	ARRAY LONGINT:C221($alACT_idCta;0)
	ARRAY LONGINT:C221($alACT_idCta2;0)
	
	C_LONGINT:C283($vl_numMax;$l_indice;$vl_numMax)
	
	READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
	ALL RECORDS:C47([ACT_DctosIndividuales_Cuentas:228])
	SELECTION TO ARRAY:C260([ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6;$alACT_idCta)
	
	COPY ARRAY:C226($alACT_idCta;$alACT_idCta2)
	AT_DistinctsArrayValues (->$alACT_idCta2)
	
	For ($l_indice;1;Size of array:C274($alACT_idCta2))
		$l_cuenta:=Count in array:C907($alACT_idCta;$alACT_idCta2{$l_indice})
		If ($l_cuenta>Self:C308->)
			$vl_numMax:=$vl_numMax+1
		End if 
	End for 
	If ($vl_numMax>0)
		CD_Dlog (0;__ ("Hay ")+String:C10($vl_numMax)+__ (" cuenta(s) corriente(s) que tiene(n) descuento(s) por cuenta superior(es) a ")+String:C10(Self:C308->)+__ ("%."))
	End if 
	
End if 